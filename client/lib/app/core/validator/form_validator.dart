import 'package:titan/app/core/extension/string_extension.dart';

class FormValidator {
  static String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return "default.required-field".translate();
    }
    return null;
  }
}
