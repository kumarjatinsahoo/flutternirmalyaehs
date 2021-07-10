class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();
  final List<String> supportedLanguages = [
    "English",
    "ଓଡିଆ",
  ];

  final List<String> supportedLanguagesCodes = [
    "en",
    "hi",
  ];

  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(String locale);
