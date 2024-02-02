class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  const Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      const Language(1, "🇦🇫", "فارسی", "fa"),
      const Language(2, "🇺🇸", "English", "en"),
      const Language(3, "🇸🇦", "اَلْعَرَبِيَّةُ", "ar"),
      const Language(4, "🇮🇳", "Hindi", "hi"),
    ];
  }
}
