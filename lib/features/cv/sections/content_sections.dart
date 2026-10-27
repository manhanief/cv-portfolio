import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';

import '../../../data/models/cv_data.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../editing/inline_fields.dart';
import '../../editing/inline_list.dart';
import '../../editing/inline_text.dart';
import 'section_card.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key, required this.cv});
  final CvData cv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SectionCard(
      title: l10n.about,
      icon: Icons.person_outline,
      isEmpty: isBlank(cv.profile.summary),
      child: InlineLText(
        value: cv.profile.summary,
        placeholder: l10n.hSummary,
        multiline: true,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
        onSave: (v) => ref.updateProfile((p) => p.copyWith(summary: v)),
      ),
    );
  }
}

class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key, required this.cv});
  final CvData cv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium
        ?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return SectionCard(
      title: l10n.experience,
      icon: Icons.work_outline,
      isEmpty: cv.experience.isEmpty,
      child: InlineList<Experience>(
        items: cv.experience,
        idOf: (e) => e.id,
        spacing: 24,
        create: () => Experience(id: uuid.v4(), start: toMonth(DateTime.now())),
        onUpdate: (f) => ref.cv.edit(CvField.experience,
            (d) => d.copyWith(experience: f(d.experience))),
        itemBuilder: (context, e, onChanged) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InlineLText(
              value: e.role,
              placeholder: l10n.hRole,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
              onSave: (v) => onChanged(e.copyWith(role: v)),
            ),
            _CompanyLine(
              company: e.company,
              location: e.location,
              onCompany: (v) => onChanged(e.copyWith(company: v)),
              onLocation: (v) => onChanged(e.copyWith(location: v)),
            ),
            const SizedBox(height: 2),
            InlineDateRange(
              start: e.start,
              end: e.end,
              style: muted,
              onChanged: (s, end) =>
                  onChanged(e.copyWith(start: s, end: end)),
            ),
            const SizedBox(height: 8),
            InlineLText(
              value: e.description,
              placeholder: l10n.hDescription,
              multiline: true,
              viewBuilder: bulletList,
              onSave: (v) => onChanged(e.copyWith(description: v)),
            ),
          ],
        ),
      ),
    );
  }
}

class EducationSection extends ConsumerWidget {
  const EducationSection({super.key, required this.cv});
  final CvData cv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium
        ?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return SectionCard(
      title: l10n.education,
      icon: Icons.school_outlined,
      isEmpty: cv.education.isEmpty,
      child: InlineList<Education>(
        items: cv.education,
        idOf: (e) => e.id,
        create: () => Education(id: uuid.v4(), start: toMonth(DateTime.now())),
        onUpdate: (f) => ref.cv.edit(CvField.education,
            (d) => d.copyWith(education: f(d.education))),
        itemBuilder: (context, e, onChanged) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InlineLText(
              value: e.degree,
              placeholder: l10n.hDegree,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
              onSave: (v) => onChanged(e.copyWith(degree: v)),
            ),
            InlineText(
              value: e.school,
              placeholder: l10n.hSchool,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.primary),
              onSave: (v) => onChanged(e.copyWith(school: v)),
            ),
            InlineDateRange(
              start: e.start,
              end: e.end,
              style: muted,
              onChanged: (s, end) => onChanged(e.copyWith(start: s, end: end)),
            ),
            const SizedBox(height: 4),
            InlineLText(
              value: e.description,
              placeholder: l10n.hDescription,
              multiline: true,
              viewBuilder: bulletList,
              onSave: (v) => onChanged(e.copyWith(description: v)),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key, required this.cv});
  final CvData cv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SectionCard(
      title: l10n.projects,
      icon: Icons.rocket_launch_outlined,
      isEmpty: cv.projects.isEmpty,
      child: InlineList<Project>(
        items: cv.projects,
        idOf: (p) => p.id,
        spacing: 20,
        create: () => Project(id: uuid.v4(), start: '${DateTime.now().year}'),
        onUpdate: (f) => ref.cv.edit(
            CvField.projects, (d) => d.copyWith(projects: f(d.projects))),
        itemBuilder: (context, p, onChanged) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InlineText(
              value: p.name,
              placeholder: l10n.hProject,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
              onSave: (v) => onChanged(p.copyWith(name: v)),
            ),
            InlineDateRange(
              start: p.start,
              end: p.end,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              onChanged: (s, end) => onChanged(p.copyWith(start: s, end: end)),
            ),
            InlineText(
              value: p.url,
              placeholder: l10n.hUrl,
              keyboardType: TextInputType.url,
              validator: Validators.url(l10n),
              viewBuilder: (context, v) => Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact),
                  onPressed: () => openUrl(v),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: Text(Uri.tryParse(v)?.host ?? v),
                ),
              ),
              onSave: (v) => onChanged(p.copyWith(url: v)),
            ),
            const SizedBox(height: 4),
            InlineLText(
              value: p.description,
              placeholder: l10n.hDescription,
              multiline: true,
              viewBuilder: bulletList,
              onSave: (v) => onChanged(p.copyWith(description: v)),
            ),
            const SizedBox(height: 8),
            InlineTags(
              values: p.techStack,
              onChanged: (v) => onChanged(p.copyWith(techStack: v)),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Company · Location" for visitors; two separate fields while editing.
class _CompanyLine extends ConsumerWidget {
  const _CompanyLine({
    required this.company,
    required this.location,
    required this.onCompany,
    required this.onLocation,
  });

  final String company;
  final String location;
  final ValueChanged<String> onCompany;
  final ValueChanged<String> onLocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final companyStyle = theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.w600);
    final muted = theme.textTheme.bodyMedium
        ?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    if (!ref.watch(isEditingProvider)) {
      return Text.rich(TextSpan(children: [
        TextSpan(text: company, style: companyStyle),
        if (company.isNotEmpty && location.isNotEmpty)
          TextSpan(text: '  ·  ', style: muted),
        TextSpan(text: location, style: muted),
      ]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InlineText(
          value: company,
          placeholder: l10n.hCompany,
          style: companyStyle,
          onSave: onCompany,
        ),
        const SizedBox(height: 4),
        InlineText(
          value: location,
          placeholder: l10n.hLocation,
          style: muted,
          onSave: onLocation,
        ),
      ],
    );
  }
}
