/// Content that can be translated: a map of language code -> text,
/// e.g. `{'en': 'Software Engineer', 'ms': 'Jurutera Perisian'}`.
typedef LText = Map<String, String>;

const fallbackLanguage = 'en';

extension LTextX on LText {
  /// Text for [lang], falling back to English, then to any non-empty value.
  String tr(String lang) {
    final own = this[lang];
    if (own != null && own.isNotEmpty) return own;
    final fallback = this[fallbackLanguage];
    if (fallback != null && fallback.isNotEmpty) return fallback;
    return values.firstWhere((v) => v.isNotEmpty, orElse: () => '');
  }

  /// True when [lang] has no own value but another language does.
  bool isFallbackFor(String lang) =>
      (this[lang] ?? '').isEmpty && tr(lang).isNotEmpty;

  LText put(String lang, String value) => {...this, lang: value};
}
