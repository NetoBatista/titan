import 'package:flutter_modular/flutter_modular.dart';
import 'package:titan/app/core/interface/ievent_service.dart';
import 'package:titan/app/core/service/event_service.dart';
import 'package:titan/app/module/core/core_module.dart';
import 'package:titan/app/module/event/controller/event_controller.dart';
import 'package:titan/app/module/event/page/event_page.dart';

class EventModule extends Module {
  @override
  List<Module> get imports {
    return [
      CoreModule(),
    ];
  }

  @override
  void binds(i) {
    i.addLazySingleton(EventController.new);
    i.addLazySingleton<IEventService>(EventService.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const EventPage());
  }
}
