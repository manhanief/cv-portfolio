import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../l10n/gen/app_localizations.dart';
import '../settings/settings_providers.dart';
import 'editable_frame.dart';

/// Formats a stored `yyyy` or `yyyy-MM` value for display in [locale].
/// Year-only values stay year-only, so no month is ever invented.
String formatMonth(String? value, String locale) {
  final date = parseMonth(value);
  if (date == null) return '';
  return value!.length == 4
      ? '${date.year}'
      : DateFormat.yMMM(locale).format(date);
}

DateTime? parseMonth(String? value) {
  if (value == null || value.isEmpty) return null;
  return DateTime.tryParse(value.length == 4 ? '$value-01-01' : '$value-01');
}

/// "2023 – Present", "Mar 2022 – Jun 2024", or just "2025" when both ends match.
String formatRange(String start, String? end, String locale, String present) {
  final s = formatMonth(start, locale);
  if (s.isEmpty && end == null) return '';
  final e = end == null ? present : formatMonth(end, locale);
  if (s.isEmpty) return e;
  return s == e ? s : '$s – $e';
}

String toMonth(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}';

/// "Mar 2022 – Present", with each end editable via a date picker.
class InlineDateRange extends ConsumerWidget {
  const InlineDateRange({
    super.key,
    required this.start,
    required this.end,
    required this.onChanged,
    this.style,
  });

  final String start;

  /// Null means "Present".
  final String? end;
  final void Function(String start, String? end) onChanged;
  final TextStyle? style;

  Future<DateTime?> _pick(BuildContext context, String? current) =>
      showDatePicker(
        context: context,
        initialDate: parseMonth(current) ?? DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDatePickerMode: DatePickerMode.year,
      );

  Future<void> _editEnd(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 'present'),
            child: Text(l10n.present),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 'pick'),
            child: Text(l10n.chooseDate),
          ),
        ],
      ),
    );
    if (choice == 'present') return onChanged(start, null);
    if (choice == 'pick' && context.mounted) {
      final d = await _pick(context, end);
      if (d != null) onChanged(start, toMonth(d));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(contentLanguageProvider);
    final l10n = AppLocalizations.of(context);
    final s = formatMonth(start, lang);
    final e = end == null ? l10n.present : formatMonth(end, lang);

    if (!ref.watch(isEditingProvider)) {
      final text = formatRange(start, end, lang, l10n.present);
      return text.isEmpty ? const SizedBox.shrink() : Text(text, style: style);
    }
    return Wrap(
      spacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        EditableFrame(
          onTap: () async {
            final d = await _pick(context, start);
            if (d != null) onChanged(toMonth(d), end);
          },
          child: Text(s.isEmpty ? '—' : s, style: style),
        ),
        Text('–', style: style),
        EditableFrame(
          onTap: () => _editEnd(context),
          child: Text(e, style: style),
        ),
      ],
    );
  }
}

/// A row of tags (e.g. a project's tech stack) with add/remove in edit mode.
class InlineTags extends ConsumerStatefulWidget {
  const InlineTags({super.key, required this.values, required this.onChanged});

  final List<String> values;
  final ValueChanged<List<String>> onChanged;

  @override
  ConsumerState<InlineTags> createState() => _InlineTagsState();
}

class _InlineTagsState extends ConsumerState<InlineTags> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add(String raw) {
    final tag = raw.trim();
    _controller.clear();
    if (tag.isEmpty || widget.values.contains(tag)) return;
    widget.onChanged([...widget.values, tag]);
  }

  @override
  Widget build(BuildContext context) {
    final editing = ref.watch(isEditingProvider);
    final l10n = AppLocalizations.of(context);
    final textStyle = Theme.of(context).textTheme.labelSmall;

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final tag in widget.values)
          editing
              ? InputChip(
                  label: Text(tag, style: textStyle),
                  visualDensity: VisualDensity.compact,
                  onDeleted: () => widget.onChanged(
                      widget.values.where((t) => t != tag).toList()),
                )
              : Chip(
                  label: Text(tag, style: textStyle),
                  visualDensity: VisualDensity.compact,
                ),
        if (editing)
          SizedBox(
            width: 110,
            child: TextField(
              controller: _controller,
              style: textStyle,
              onSubmitted: _add,
              decoration: InputDecoration(
                isDense: true,
                hintText: l10n.addTag,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
          ),
      ],
    );
  }
}
