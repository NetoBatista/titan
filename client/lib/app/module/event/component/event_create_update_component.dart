import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:titan/app/core/constant/event_method_constant.dart';
import 'package:titan/app/core/extension/context_extension.dart';
import 'package:titan/app/core/extension/string_extension.dart';
import 'package:titan/app/core/model/event/event_request_model.dart';
import 'package:titan/app/core/provider/navigator_provider.dart';
import 'package:titan/app/core/validator/form_validator.dart';
import 'package:titan/app/module/event/controller/event_controller.dart';
import 'package:titan/app/module/event/state/event_state.dart';

class EventCreateUpdateComponent extends StatefulWidget {
  final EventRequestModel request;
  final GlobalKey<FormState> formKey;
  const EventCreateUpdateComponent({
    required this.request,
    required this.formKey,
    super.key,
  });

  @override
  State<EventCreateUpdateComponent> createState() =>
      _EventCreateUpdateComponentState();
}

class _EventCreateUpdateComponentState
    extends State<EventCreateUpdateComponent> {
  GlobalKey<FormState> get formKey => widget.formKey;
  EventRequestModel get request => widget.request;
  late EventController _controller;

  Future<void> createUpdate() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (request.id != null) {
      _controller.update(request);
    } else {
      _controller.create(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    var width = currentWidth > 400 ? 400.0 : currentWidth;
    _controller = context.watchContext();
    var isLoading = _controller.value is EventCreateLoadingate ||
        _controller.value is EventUpdateLoadingate;
    return Form(
      key: formKey,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'event.dialog.input.name'.translate(),
              ),
              initialValue: request.name,
              maxLength: 100,
              validator: FormValidator.requiredField,
              onChanged: (String value) {
                request.name = value;
              },
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'event.dialog.input.url'.translate(),
              ),
              initialValue: request.url,
              maxLength: 1000,
              validator: FormValidator.requiredField,
              onChanged: (String value) {
                request.url = value;
              },
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'event.dialog.input.interval-in-seconds'.translate(),
              ),
              initialValue: request.interval.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 10,
              validator: FormValidator.requiredField,
              onChanged: (String value) {
                request.interval = int.tryParse(value) ?? 0;
              },
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: request.method,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              decoration: InputDecoration(
                labelText: 'event.dialog.input.select-method'.translate(),
                border: const OutlineInputBorder(),
              ),
              onChanged: isLoading
                  ? null
                  : (String? newValue) {
                      request.method = newValue ?? EventMethodConstant.get;
                    },
              items: EventMethodConstant.getAll().map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: isLoading,
              child: const LinearProgressIndicator(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: isLoading ? null : NavigatorProvider.pop,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: Text(
                    'event.dialog.action-button.cancel'.translate(),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: isLoading ? null : createUpdate,
                  child: Text(
                    'event.dialog.action-button.confirm'.translate(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
