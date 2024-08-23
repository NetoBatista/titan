import 'package:flutter_modular/flutter_modular.dart';
import 'package:titan/app/module/core/core_module.dart';
import 'package:titan/app/module/event/event_module.dart';
import 'package:titan/app/module/home/home_module.dart';

class MainModule extends Module {
  @override
  List<Module> get imports {
    return [
      CoreModule(),
    ];
  }

  @override
  void routes(r) {
    r.module(
      '/',
      module: HomeModule(),
      transition: TransitionType.noTransition,
    );
    r.module(
      '/event',
      module: EventModule(),
      transition: TransitionType.noTransition,
    );
  }
}
