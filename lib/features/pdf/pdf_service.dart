import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../data/models/cv_data.dart';
import '../../data/models/localized_text.dart';
import '../../l10n/gen/app_localizations.dart';
import '../editing/inline_fields.dart' show formatRange;

/// Builds the CV PDF and hands it to the platform (download on web,
/// share sheet on mobile).
Future<void> sharePdf(CvData cv, String lang, AppLocalizations l10n) async {
  final bytes = await buildCvPdf(cv, lang, l10n);
  final safeName = cv.profile.name.replaceAll(RegExp(r'[^\w]+'), '_');
  await Printing.sharePdf(bytes: bytes, filename: 'CV_${safeName}_$lang.pdf');
}

/// Single-column layout with real text, so applicant tracking systems
/// can parse it.
Future<Uint8List> buildCvPdf(
    CvData cv, String lang, AppLocalizations l10n) async {
  final theme = await _theme();
  final photo = await _photo(cv.profile.photoUrl);
  final accent = PdfColor.fromInt(0xFF2B5F8E);
  final muted = PdfColors.grey700;
  final p = cv.profile;

  String range(String start, String? end) =>
      formatRange(start, end, lang, l10n.present);

  pw.Widget heading(String text) => pw.Container(
        margin: const pw.EdgeInsets.only(top: 14, bottom: 6),
        padding: const pw.EdgeInsets.only(bottom: 3),
        decoration: pw.BoxDecoration(
          border: pw.Border(bottom: pw.BorderSide(color: accent, width: 1)),
        ),
        child: pw.Text(text.toUpperCase(),
            style: pw.TextStyle(
                color: accent,
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
                letterSpacing: 1)),
      );

  List<pw.Widget> bullets(String text) => [
        for (final line in text.split('\n').where((l) => l.trim().isNotEmpty))
          pw.Bullet(
            text: line.trim(),
            style: const pw.TextStyle(fontSize: 10),
            bulletSize: 3,
            bulletMargin: const pw.EdgeInsets.only(top: 4, right: 6),
          ),
      ];

  pw.Widget entry({
    required String title,
    required String subtitle,
    required String date,
    String description = '',
  }) =>
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(children: [
              pw.Expanded(
                child: pw.Text(title,
                    style: pw.TextStyle(
                        fontSize: 11, fontWeight: pw.FontWeight.bold)),
              ),
              pw.Text(date, style: pw.TextStyle(fontSize: 9, color: muted)),
            ]),
            if (subtitle.isNotEmpty)
              pw.Text(subtitle, style: pw.TextStyle(fontSize: 10, color: accent)),
            pw.SizedBox(height: 3),
            ...bullets(description),
          ],
        ),
      );

  final contacts = [
    p.location,
    p.email,
    p.phone,
    ...cv.links.map((l) => l.url),
  ].where((c) => c.isNotEmpty);

  final doc = pw.Document(title: 'CV – ${p.name}', author: p.name);
  doc.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    theme: theme,
    margin: const pw.EdgeInsets.all(36),
    build: (context) => [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          if (photo != null) ...[
            pw.ClipOval(
                child: pw.Image(photo, width: 64, height: 64, fit: pw.BoxFit.cover)),
            pw.SizedBox(width: 16),
          ],
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(p.name,
                    style: pw.TextStyle(
                        fontSize: 22, fontWeight: pw.FontWeight.bold)),
                pw.Text(p.title.tr(lang),
                    style: pw.TextStyle(fontSize: 13, color: accent)),
                pw.SizedBox(height: 4),
                pw.Text(contacts.join('  |  '),
                    style: pw.TextStyle(fontSize: 9, color: muted)),
              ],
            ),
          ),
        ],
      ),
      if (p.summary.tr(lang).isNotEmpty) ...[
        heading(l10n.about),
        pw.Text(p.summary.tr(lang),
            style: const pw.TextStyle(fontSize: 10, lineSpacing: 2)),
      ],
      if (cv.experience.isNotEmpty) ...[
        heading(l10n.experience),
        for (final e in cv.experience)
          entry(
            title: e.role.tr(lang),
            subtitle: [e.company, e.location].where((s) => s.isNotEmpty).join(' · '),
            date: range(e.start, e.end),
            description: e.description.tr(lang),
          ),
      ],
      if (cv.projects.isNotEmpty) ...[
        heading(l10n.projects),
        for (final pr in cv.projects)
          entry(
            title: pr.name,
            subtitle: [pr.techStack.join(' · '), pr.url]
                .where((s) => s.isNotEmpty)
                .join(' · '),
            date: range(pr.start, pr.end),
            description: pr.description.tr(lang),
          ),
      ],
      if (cv.education.isNotEmpty) ...[
        heading(l10n.education),
        for (final e in cv.education)
          entry(
            title: e.degree.tr(lang),
            subtitle: e.school,
            date: range(e.start, e.end),
            description: e.description.tr(lang),
          ),
      ],
      if (cv.skills.isNotEmpty) ...[
        heading(l10n.skills),
        for (final g in cv.skills)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.RichText(
              text: pw.TextSpan(
                style: const pw.TextStyle(fontSize: 10),
                children: [
                  pw.TextSpan(
                      text: '${g.category.tr(lang)}: ',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.TextSpan(text: g.items.join(', ')),
                ],
              ),
            ),
          ),
      ],
      if (cv.certifications.isNotEmpty) ...[
        heading(l10n.certifications),
        for (final c in cv.certifications)
          pw.Text(
            [c.name, c.issuer, c.year].where((s) => s.isNotEmpty).join(' · '),
            style: const pw.TextStyle(fontSize: 10),
          ),
      ],
      if (cv.languages.isNotEmpty) ...[
        heading(l10n.languages),
        pw.Text(
          cv.languages
              .map((l) => '${l.name.tr(lang)} (${l.proficiency.tr(lang)})')
              .join('  ·  '),
          style: const pw.TextStyle(fontSize: 10),
        ),
      ],
    ],
  ));
  return doc.save();
}

Future<pw.ThemeData> _theme() async {
  try {
    return pw.ThemeData.withFont(
      base: await PdfGoogleFonts.interRegular(),
      bold: await PdfGoogleFonts.interBold(),
    );
  } catch (_) {
    // Offline: fall back to the built-in Helvetica.
    return pw.ThemeData();
  }
}

Future<pw.ImageProvider?> _photo(String? url) async {
  if (url == null || url.isEmpty) return null;
  try {
    if (url.startsWith('data:')) {
      return pw.MemoryImage(UriData.parse(url).contentAsBytes());
    }
    return await networkImage(url);
  } catch (_) {
    return null;
  }
}
