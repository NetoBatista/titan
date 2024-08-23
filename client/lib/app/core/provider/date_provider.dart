import 'package:titan/app/core/constant/language_constant.dart';
import 'package:titan/app/core/provider/language_provider.dart';

class DateProvider {
  final LanguageProvider _languageProvider;
  DateProvider(this._languageProvider);

  String formatDateTime(String value, {String? defaultValue}) {
    if (value.isEmpty) {
      return defaultValue ?? '';
    }
    var dateSplitted = value.split('T')[0].split('-');
    var timeSplitted = value.split('T')[1].split('.')[0].split(':');
    var year = dateSplitted[0];
    var month = dateSplitted[1].padLeft(2, '0');
    var day = dateSplitted[2].padLeft(2, '0');
    var hour = timeSplitted[0];
    var minute = timeSplitted[1].padLeft(2, '0');
    var second = timeSplitted[2].padLeft(2, '0');
    if (_languageProvider.currentLanguage() == LanguageConstant.ptBR) {
      return '$day/$month/$year $hour:$minute:$second';
    }
    return '$month/$day/$year';
  }

  String formatDateTimeFromJson(String value) {
    if (value.isEmpty) {
      return '';
    }
    var splitted = value.split('.')[0];
    return formatDateTime(splitted);
  }
}
