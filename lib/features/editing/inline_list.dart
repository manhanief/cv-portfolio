import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../l10n/gen/app_localizations.dart';

/// Applies [change] to the *latest* list, so callbacks captured earlier
/// (e.g. an Undo action) never overwrite edits made in the meantime.
typedef ListUpdate<T> = void Function(List<T> Function(List<T> list) change);

/// A list section with inline create / update / delete (with undo) / reorder.
class InlineList<T> extends ConsumerWidget {
  const InlineList({
    super.key,
    required this.items,
    required this.idOf,
    required this.itemBuilder,
    required this.onUpdate,
    required this.create,
    this.spacing = 16,
  });

  final List<T> items;
  final String Function(T item) idOf;
  final Widget Function(BuildContext context, T item, ValueChanged<T> onChanged)
      itemBuilder;
  final ListUpdate<T> onUpdate;
  final T Function() create;
  final double spacing;

  void _replace(T updated) => onUpdate((list) => [
        for (final x in list) idOf(x) == idOf(updated) ? updated : x,
      ]);

  void _delete(BuildContext context, int index, T item) {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    onUpdate((list) => list.where((x) => idOf(x) != idOf(item)).toList());
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(l10n.itemDeleted),
        action: SnackBarAction(
          label: l10n.undo,
          onPressed: () => onUpdate(
              (list) => [...list]..insert(math.min(index, list.length), item)),
        ),
      ));
  }

  void _reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    onUpdate((list) {
      final copy = [...list];
      copy.insert(newIndex, copy.removeAt(oldIndex));
      return copy;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editing = ref.watch(isEditingProvider);

    if (!editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) SizedBox(height: spacing),
            itemBuilder(context, items[i], _replace),
          ],
        ],
      );
    }

    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          itemCount: items.length,
          onReorder: _reorder,
          itemBuilder: (context, i) {
            final item = items[i];
            return Padding(
              key: ValueKey(idOf(item)),
              padding: EdgeInsets.only(bottom: spacing / 2),
              child: _EditableItem(
                index: i,
                onDelete: () => _delete(context, i, item),
                child: itemBuilder(context, item, _replace),
              ),
            );
          },
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: () => onUpdate((list) => [...list, create()]),
            icon: const Icon(Icons.add),
            label: Text(l10n.add),
          ),
        ),
      ],
    );
  }
}

class _EditableItem extends StatelessWidget {
  const _EditableItem({
    required this.index,
    required this.onDelete,
    required this.child,
  });

  final int index;
  final VoidCallback onDelete;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 0, 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: child),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ReorderableDragStartListener(
                  index: index,
                  child: Tooltip(
                    message: l10n.dragToReorder,
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.grab,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.drag_indicator, size: 20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: l10n.delete,
                  visualDensity: VisualDensity.compact,
                  iconSize: 20,
                  icon: Icon(Icons.delete_outline, color: scheme.error),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
