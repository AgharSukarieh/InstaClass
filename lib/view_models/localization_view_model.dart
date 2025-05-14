import 'package:flutter/foundation.dart';
import 'package:insta_class/models/localization_model.dart';

class LocalizationViewModel extends ChangeNotifier {
  bool _isLoaded = false;
  late LocalizationService localizationService;
  String currentLocale = 'en';
  Future<void> loadTranslations() async {
    localizationService = LocalizationService(currentLocale);
    await localizationService.Load();
    _isLoaded = true;
    notifyListeners();
  }

  String translate(String key) {
    if (!_isLoaded) {
      return key;
    }
    return localizationService.translate(key);
  }

  chingeLacale(String locale) async {
    currentLocale = locale;
    await loadTranslations();
  }
}
