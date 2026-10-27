import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/breakpoints.dart';
import '../../core/providers.dart';
import '../../data/models/cv_data.dart';
import '../../data/seed_data.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/login_dialog.dart';
import 'cv_controller.dart';
import 'sections/content_sections.dart';
import 'sections/header_section.dart';
import 'sections/sidebar_sections.dart';
import 'top_bar.dart';

/// The single page: visitors read it, the admin edits it in place.
class CvPage extends ConsumerWidget {
  const CvPage({super.key});

  Future<void> _openLogin(BuildContext context, WidgetRef ref) async {
    if (ref.read(isAdminProvider)) return;
    await showLoginDialog(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cv = ref.watch(cvControllerProvider);

    ref.listen(saveStatusProvider, (_, next) {
      if (next.state == SaveState.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.saveFailed(next.error ?? '')),
        ));
      }
    });
    // Make sure the document exists before the admin's first edit.
    ref.listen(isAdminProvider, (was, isAdmin) {
      if (isAdmin && was != true) {
        ref.read(cvRepositoryProvider).ensureExists(seedCv);
      }
    });

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyE,
            control: true, shift: true): () => _openLogin(context, ref),
        const SingleActivator(LogicalKeyboardKey.keyE,
            meta: true, shift: true): () => _openLogin(context, ref),
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: const TopBar(),
          body: switch (cv) {
            AsyncData(:final value) => _CvBody(
                cv: value,
                onLogin: () => _openLogin(context, ref),
              ),
            AsyncError(:final error) => Center(child: Text('$error')),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      ),
    );
  }
}

class _CvBody extends ConsumerWidget {
  const _CvBody({required this.cv, required this.onLogin});

  final CvData cv;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demo = ref.watch(backendProvider) == Backend.demo;
    return LayoutBuilder(builder: (context, constraints) {
      final size = Breakpoints.of(constraints.maxWidth);
      final gutter = size == ScreenSize.mobile ? 12.0 : 24.0;

      final content = switch (size) {
        ScreenSize.desktop => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Breakpoints.sidebarWidth,
                child: Column(children: [
                  HeaderSection(cv: cv, centered: true),
                  SkillsSection(cv: cv),
                  LanguagesSection(cv: cv),
                  CertificationsSection(cv: cv),
                ]),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(children: [
                  AboutSection(cv: cv),
                  ExperienceSection(cv: cv),
                  ProjectsSection(cv: cv),
                  EducationSection(cv: cv),
                ]),
              ),
            ],
          ),
        _ => Column(children: [
            HeaderSection(cv: cv, centered: size == ScreenSize.mobile),
            AboutSection(cv: cv),
            ExperienceSection(cv: cv),
            ProjectsSection(cv: cv),
            SkillsSection(cv: cv),
            EducationSection(cv: cv),
            CertificationsSection(cv: cv),
            LanguagesSection(cv: cv),
          ]),
      };

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: gutter, vertical: gutter),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: size == ScreenSize.desktop
                  ? Breakpoints.maxContentWidth
                  : Breakpoints.maxSingleColumnWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (demo) const _DemoBanner(),
                content,
                _Footer(name: cv.profile.name, onLogin: onLogin),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _DemoBanner extends StatelessWidget {
  const _DemoBanner();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            AppLocalizations.of(context).demoMode,
            style: TextStyle(color: scheme.onTertiaryContainer),
          ),
        ),
      ),
    );
  }
}

class _Footer extends ConsumerWidget {
  const _Footer({required this.name, required this.onLogin});

  final String name;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('© ${DateTime.now().year} $name · ${l10n.builtWith}',
              style: style),
          if (!ref.watch(isAdminProvider))
            IconButton(
              tooltip: l10n.adminLogin,
              iconSize: 16,
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.lock_outline, color: style?.color),
              onPressed: onLogin,
            ),
        ],
      ),
    );
  }
}
