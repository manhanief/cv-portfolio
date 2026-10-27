import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/breakpoints.dart';
import '../../core/providers.dart';
import '../../l10n/gen/app_localizations.dart';
import '../pdf/pdf_service.dart';
import '../settings/settings_providers.dart';
import 'cv_controller.dart';

/// Visitor actions (language, theme, PDF) plus, for the admin,
/// edit status, preview toggle and sign out.
class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final isAdmin = ref.watch(isAdminProvider);
    final preview = ref.watch(previewModeProvider);
    final lang = ref.watch(contentLanguageProvider);
    final compact = context.isMobile;

    return AppBar(
      backgroundColor: isAdmin ? scheme.primaryContainer : null,
      scrolledUnderElevation: 1,
      titleSpacing: 16,
      title: isAdmin
          ? Row(
              children: [
                Icon(preview ? Icons.visibility : Icons.edit,
                    size: 18, color: scheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    preview
                        ? l10n.preview
                        : compact
                            ? '${l10n.editing} · ${lang.toUpperCase()}'
                            : l10n.editingLanguage(supportedLanguages[lang]!),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(width: 12),
                const _SaveIndicator(),
              ],
            )
          : null,
      actions: [
        TextButton(
          onPressed: () => ref.read(localeProvider.notifier).cycle(),
          child: Tooltip(
            message: l10n.switchLanguage,
            child: Text(lang == 'en' ? 'BM' : 'EN'),
          ),
        ),
        IconButton(
          tooltip: l10n.toggleTheme,
          icon: Icon(Theme.of(context).brightness == Brightness.dark
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined),
          onPressed: () => ref
              .read(themeModeProvider.notifier)
              .toggle(Theme.of(context).brightness),
        ),
        IconButton(
          tooltip: l10n.downloadPdf,
          icon: const Icon(Icons.picture_as_pdf_outlined),
          onPressed: () => _downloadPdf(context, ref),
        ),
        if (isAdmin) ...[
          IconButton(
            tooltip: preview ? l10n.editing : l10n.preview,
            icon: Icon(preview ? Icons.edit_outlined : Icons.visibility_outlined),
            onPressed: () =>
                ref.read(previewModeProvider.notifier).state = !preview,
          ),
          IconButton(
            tooltip: l10n.signOut,
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(previewModeProvider.notifier).state = false;
              ref.read(authRepositoryProvider).signOut();
            },
          ),
        ],
        const SizedBox(width: 8),
      ],
    );
  }

  Future<void> _downloadPdf(BuildContext context, WidgetRef ref) async {
    final cv = ref.read(cvControllerProvider).valueOrNull;
    if (cv == null) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await sharePdf(cv, ref.read(contentLanguageProvider), l10n);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.pdfFailed)));
    }
  }
}

class _SaveIndicator extends ConsumerWidget {
  const _SaveIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final status = ref.watch(saveStatusProvider);
    final style = Theme.of(context).textTheme.labelSmall;
    final (Widget icon, String? text) = switch (status.state) {
      SaveState.idle => (const SizedBox.shrink(), null),
      SaveState.saving => (
          const SizedBox.square(
              dimension: 12, child: CircularProgressIndicator(strokeWidth: 2)),
          l10n.saving
        ),
      SaveState.saved => (const Icon(Icons.check_circle, size: 14), l10n.saved),
      SaveState.error => (
          Icon(Icons.error, size: 14, color: Theme.of(context).colorScheme.error),
          null
        ),
    };
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Row(
        key: ValueKey(status.state),
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          if (text != null && !context.isMobile) ...[
            const SizedBox(width: 4),
            Text(text, style: style),
          ],
        ],
      ),
    );
  }
}
