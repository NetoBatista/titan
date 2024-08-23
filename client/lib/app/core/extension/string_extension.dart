import 'package:localization/localization.dart';

extension CustomLocalizationExtension on String {
  String translate() {
    return i18n();
  }
}
