import 'package:cv_portfolio/core/providers.dart';
import 'package:cv_portfolio/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pumps [child] inside the app's localizations and a demo-backed scope.
/// Uses a plain theme so tests never fetch Google Fonts.
Future<ProviderContainer> pumpApp(
  WidgetTester tester,
  Widget child, {
  Size size = const Size(1280, 900),
  List<Override> overrides = const [],
}) async {
  await initializeDateFormatting();
  SharedPreferences.setMockInitialValues({'language': 'en'});
  final prefs = await SharedPreferences.getInstance();

  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final container = ProviderContainer(overrides: [
    sharedPrefsProvider.overrideWithValue(prefs),
    ...overrides,
  ]);
  addTearDown(container.dispose);

  await tester.pumpWidget(UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      locale: const Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: child,
    ),
  ));
  await tester.pumpAndSettle();
  return container;
}
