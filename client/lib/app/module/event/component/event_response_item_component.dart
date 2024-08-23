import 'package:flutter/material.dart';
import 'package:titan/app/core/adapter/event/event_response_adapter.dart';
import 'package:titan/app/core/extension/string_extension.dart';
import 'package:titan/app/core/model/event/event_request_model.dart';
import 'package:titan/app/core/model/event/event_response_model.dart';
import 'package:titan/app/module/event/component/event_create_update_component.dart';
import 'package:titan/app/module/event/component/event_remove_component.dart';

class EventResponseItemComponent extends StatelessWidget {
  final EventResponseModel response;
  const EventResponseItemComponent({
    required this.response,
    super.key,
  });

  void onTapUpdateEvent(
    BuildContext context,
    EventRequestModel request,
  ) {
    var formKey = GlobalKey<FormState>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('event.dialog.title.edit'.translate()),
          content: EventCreateUpdateComponent(
            request: request,
            formKey: formKey,
          ),
        );
      },
    );
  }

  void onTapRemoveEvent(
    BuildContext context,
    EventRequestModel request,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('event.dialog.title.remove'.translate()),
          content: EventRemoveComponent(
            request: request,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    var width = currentWidth > 400 ? 400.0 : currentWidth;
    return SizedBox(
      width: width,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      response.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(response.method),
                  const Text(' - '),
                  Text('${response.interval.toString()}s'),
                ],
              ),
              const SizedBox(height: 8),
              Text(response.url),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => onTapRemoveEvent(
                        context,
                        EventResponseAdapter.responseToRequest(response),
                      ),
                      child: Text('event.item.button.remove'.translate()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => onTapUpdateEvent(
                        context,
                        EventResponseAdapter.responseToRequest(response),
                      ),
                      child: Text('event.item.button.edit'.translate()),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
