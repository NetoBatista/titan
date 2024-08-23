import 'package:flutter_modular/flutter_modular.dart';
import 'package:titan/app/core/interface/ievent_service.dart';
import 'package:titan/app/core/interface/iexecution_service.dart';
import 'package:titan/app/core/service/event_service.dart';
import 'package:titan/app/core/service/execution_service.dart';
import 'package:titan/app/module/core/core_module.dart';
import 'package:titan/app/module/home/controller/home_controller.dart';
import 'package:titan/app/module/home/page/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports {
    return [
      CoreModule(),
    ];
  }

  @override
  void binds(i) {
    i.addLazySingleton(HomeController.new);
    i.addLazySingleton<IEventService>(EventService.new);
    i.addLazySingleton<IExecutionService>(ExecutionService.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
