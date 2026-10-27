import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/cv_data.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../editing/inline_fields.dart';
import '../../editing/inline_list.dart';
import '../../editing/inline_text.dart';
import 'section_card.dart';

class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key, required this.cv});
  final CvData cv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SectionCard(
      title: l10n.skills,
      icon: Icons.bolt_outlined,
      isEmpty: cv.skills.isEmpty,
      child: InlineList<SkillGroup>(
        items: cv.skills,
        idOf: (g) => g.id,
        spacing: 14,
        create: () => SkillGroup(id: uuid.v4()),
        onUpdate: (f) =>
            ref.cv.edit(CvField.skills, (d) => d.copyWith(skills: f(d.skills))),
        itemBuilder: (context, g, onChanged) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InlineLText(
              value: g.category,
              placeholder: l10n.hSkillCategory,
              style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary, fontWeight: FontWeight.w700),
              onSave: (v) => onChanged(g.copyWith(category: v)),
            ),
            const SizedBox(height: 6),
            InlineTags(
              values: g.items,
              onChanged: (v) => onChanged(g.copyWith(items: v)),
            ),
          ],
        ),
      ),
    );
  }
}

class CertificationsSection extends ConsumerWidget {
  const CertificationsSection({super.key, required this.cv});
  final CvData cv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall
        ?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return SectionCard(
      title: l10n.certifications,
      icon: Icons.verified_outlined,
      isEmpty: cv.certifications.isEmpty,
      child: InlineList<Certification>(
        items: cv.certifications,
        idOf: (c) => c.id,
        spacing: 12,
        create: () => Certification(id: uuid.v4()),
        onUpdate: (f) => ref.cv.edit(CvField.certifications,
            (d) => d.copyWith(certifications: f(d.certifications))),
        itemBuilder: (context, c, onChanged) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InlineText(
              value: c.name,
              placeholder: l10n.hCertification,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
              onSave: (v) => onChanged(c.copyWith(name: v)),
            ),
            Row(
              children: [
                Expanded(
                  child: InlineText(
                    value: c.issuer,
                    placeholder: l10n.hIssuer,
                    style: muted,
                    onSave: (v) => onChanged(c.copyWith(issuer: v)),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 72,
                  child: InlineText(
                    value: c.year,
                    placeholder: l10n.hYear,
                    style: muted,
                    textAlign: TextAlign.end,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    onSave: (v) => onChanged(c.copyWith(year: v)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LanguagesSection extends ConsumerWidget {
  const LanguagesSection({super.key, required this.cv});
  final CvData cv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SectionCard(
      title: l10n.languages,
      icon: Icons.translate,
      isEmpty: cv.languages.isEmpty,
      child: InlineList<LanguageSkill>(
        items: cv.languages,
        idOf: (l) => l.id,
        spacing: 8,
        create: () => LanguageSkill(id: uuid.v4()),
        onUpdate: (f) => ref.cv.edit(
            CvField.languages, (d) => d.copyWith(languages: f(d.languages))),
        itemBuilder: (context, lang, onChanged) => Row(
          children: [
            Expanded(
              child: InlineLText(
                value: lang.name,
                placeholder: l10n.hLanguage,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
                onSave: (v) => onChanged(lang.copyWith(name: v)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: InlineLText(
                value: lang.proficiency,
                placeholder: l10n.hProficiency,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                onSave: (v) => onChanged(lang.copyWith(proficiency: v)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
