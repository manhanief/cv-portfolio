import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers.dart';
import '../../../data/models/cv_data.dart';
import '../../../data/models/localized_text.dart';
import '../cv_controller.dart';

const uuid = Uuid();

/// Titled card wrapping a CV section. Empty sections are hidden from
/// visitors but stay visible to the admin so content can be added.
class SectionCard extends ConsumerWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isEmpty,
    required this.child,
  });

  final String title;
  final IconData icon;
  final bool isEmpty;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isEmpty && !ref.watch(isEditingProvider)) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Renders multi-line text as a bulleted list.
Widget bulletList(BuildContext context, String text) {
  final style = Theme.of(context).textTheme.bodyMedium;
  final lines = text.split('\n').where((l) => l.trim().isNotEmpty);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final line in lines)
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•  ', style: style),
              Expanded(child: Text(line.trim(), style: style)),
            ],
          ),
        ),
    ],
  );
}

Future<void> openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri != null) await launchUrl(uri, mode: LaunchMode.externalApplication);
}

extension CvEdits on WidgetRef {
  CvController get cv => read(cvControllerProvider.notifier);

  void updateProfile(Profile Function(Profile p) change) => cv.edit(
      CvField.profile, (d) => d.copyWith(profile: change(d.profile)));
}

/// True when every language value is empty.
bool isBlank(LText t) => t.values.every((v) => v.isEmpty);
