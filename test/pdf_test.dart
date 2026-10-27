import 'dart:io';

import 'package:cv_portfolio/data/seed_data.dart';
import 'package:cv_portfolio/features/pdf/pdf_service.dart';
import 'package:cv_portfolio/l10n/gen/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initializeDateFormatting);

  for (final lang in ['en', 'ms']) {
    test('builds a valid PDF in $lang', () async {
      final l10n = lookupAppLocalizations(Locale(lang));
      final bytes = await buildCvPdf(seedCv, lang, l10n);
      expect(String.fromCharCodes(bytes.take(5)), '%PDF-');

      // Set PDF_OUT to inspect the result manually.
      final out = Platform.environment['PDF_OUT'];
      if (out != null) File('$out/cv_$lang.pdf').writeAsBytesSync(bytes);
    });
  }
}
