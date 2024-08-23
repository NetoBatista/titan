import 'package:flutter/material.dart';
import 'package:titan/app/core/constant/event_method_constant.dart';
import 'package:titan/app/core/extension/context_extension.dart';
import 'package:titan/app/core/model/event/event_request_model.dart';
import 'package:titan/app/core/provider/dependency_provider.dart';
import 'package:titan/app/module/event/component/event_header_component.dart';
import 'package:titan/app/module/event/component/event_response_item_component.dart';
import 'package:titan/app/module/event/controller/event_controller.dart';
import 'package:titan/app/module/event/state/event_state.dart';
import 'package:titan/app/shared/component/app_header/app_header_component.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final EventRequestModel request = EventRequestModel(
    name: '',
    url: '',
    method: EventMethodConstant.get,
    interval: 0,
  );

  late EventController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var controller = DependencyProvider.get<EventController>();
      controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = context.watchContext();
    var isLoading = _controller.value is EventLoadingate;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AppHeaderComponent(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EventHeaderComponent(
                  request: request,
                  controller: _controller,
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: isLoading,
                  child: const LinearProgressIndicator(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      spacing: 16,
                      children: List.generate(
                        _controller.events.length,
                        (int index) {
                          var item = _controller.events.elementAt(index);
                          return EventResponseItemComponent(response: item);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
