import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/providers.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final prefs = await SharedPreferences.getInstance();

  var backend = Backend.demo;
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    backend = Backend.firebase;
  } catch (e) {
    debugPrint('Firebase unavailable, running in demo mode: $e');
  }

  runApp(ProviderScope(
    overrides: [
      backendProvider.overrideWithValue(backend),
      sharedPrefsProvider.overrideWithValue(prefs),
    ],
    child: const CvApp(),
  ));
}
