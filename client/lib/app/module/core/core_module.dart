import 'package:flutter_modular/flutter_modular.dart';
import 'package:titan/app/core/interface/irequest_service.dart';
import 'package:titan/app/core/provider/date_provider.dart';
import 'package:titan/app/core/provider/language_provider.dart';
import 'package:titan/app/core/service/request_service.dart';

class CoreModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<IRequestService>(RequestService.new);
    i.addLazySingleton(DateProvider.new);
    i.addLazySingleton(LanguageProvider.new);
  }
}
