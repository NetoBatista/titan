import 'package:flutter/material.dart';
import 'package:titan/app/core/extension/string_extension.dart';
import 'package:titan/app/core/model/event/event_request_model.dart';
import 'package:titan/app/module/event/component/event_create_update_component.dart';
import 'package:titan/app/module/event/controller/event_controller.dart';

class EventHeaderComponent extends StatelessWidget {
  final EventRequestModel request;
  final EventController controller;
  const EventHeaderComponent({
    required this.controller,
    required this.request,
    super.key,
  });

  void onTapNewEvent(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('event.dialog.title.new'.translate()),
          content: EventCreateUpdateComponent(
            request: request,
            formKey: formKey,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        var maxWidth = constraints.maxWidth;
        var widthSearch = maxWidth > 860 ? 600.0 : maxWidth - 260;
        var widthButton = maxWidth <= 600 ? maxWidth : 0.0;
        if (maxWidth <= 600) {
          widthSearch = maxWidth;
        }
        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widthSearch),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'event.button.search'.translate(),
                  prefixIcon: const Icon(Icons.search_outlined),
                ),
                initialValue: '',
                onChanged: controller.onChangeFilter,
              ),
            ),
            const SizedBox(width: 16),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: widthButton),
              child: FilledButton(
                onPressed: () => onTapNewEvent(context),
                child: Text('event.button.new-event'.translate()),
              ),
            ),
          ],
        );
      },
    );
  }
}
