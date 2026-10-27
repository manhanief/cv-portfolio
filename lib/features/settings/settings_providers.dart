import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';

const supportedLanguages = {'en': 'English', 'ms': 'Bahasa Melayu'};

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'themeMode';

  @override
  ThemeMode build() {
    final saved = ref.read(sharedPrefsProvider).getString(_key);
    return ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system;
  }

  /// Toggles between light and dark, resolving "system" to its current value.
  void toggle(Brightness current) {
    state = current == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    ref.read(sharedPrefsProvider).setString(_key, state.name);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

class LocaleNotifier extends Notifier<Locale> {
  static const _key = 'language';

  @override
  Locale build() {
    final saved = ref.read(sharedPrefsProvider).getString(_key);
    final system = PlatformDispatcher.instance.locale.languageCode;
    final code = saved ??
        (supportedLanguages.containsKey(system) ? system : 'en');
    return Locale(code);
  }

  void set(String code) {
    state = Locale(code);
    ref.read(sharedPrefsProvider).setString(_key, code);
  }

  void cycle() {
    final codes = supportedLanguages.keys.toList();
    set(codes[(codes.indexOf(state.languageCode) + 1) % codes.length]);
  }
}

/// Language of the content being shown and edited.
final contentLanguageProvider =
    Provider<String>((ref) => ref.watch(localeProvider).languageCode);
