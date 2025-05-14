import 'dart:convert';

import 'package:flutter/services.dart';

class LocalizationService {
  final String locale;
  late Map<String, String> _localizedStrings;
  LocalizationService(this.locale);
  Future<bool> Load() async {
    String jsonMap = await rootBundle.loadString(
      'lib/translations/${locale}.json',
    );
    final Map<String, dynamic> jsonMapDecoded = json.decode(jsonMap);
    _localizedStrings = jsonMapDecoded.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
