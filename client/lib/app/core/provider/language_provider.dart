import 'package:flutter/material.dart';

class LanguageProvider {
  String currentLanguage() {
    return WidgetsBinding.instance.platformDispatcher.locale.toString();
  }
}
