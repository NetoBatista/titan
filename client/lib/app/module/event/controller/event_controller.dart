import 'package:flutter/material.dart';
import 'package:titan/app/core/interface/ievent_service.dart';
import 'package:titan/app/core/model/event/event_request_model.dart';
import 'package:titan/app/core/model/event/event_response_model.dart';
import 'package:titan/app/core/provider/navigator_provider.dart';
import 'package:titan/app/module/event/state/event_state.dart';

class EventController extends ValueNotifier<EventState> {
  final IEventService _eventService;
  EventController(
    this._eventService,
  ) : super(EventDefaultState());

  String filter = '';
  List<EventResponseModel> get events {
    if (filter.isEmpty) {
      return _allEvents;
    }
    return _allEvents
        .where((x) =>
            x.method.toUpperCase().contains(filter.toUpperCase()) ||
            x.name.toUpperCase().contains(filter.toUpperCase()) ||
            x.url.toUpperCase().contains(filter.toUpperCase()))
        .toList();
  }

  List<EventResponseModel> _allEvents = [];

  void onChangeFilter(String input) {
    filter = input;
    notifyListeners();
  }

  Future<void> init() async {
    try {
      value = EventLoadingate();
      _allEvents = await _eventService.get();
      value = EventDefaultState();
    } catch (error) {
      value = EventErrorState(error.toString());
    }
  }

  Future<void> create(
    EventRequestModel request,
  ) async {
    try {
      value = EventCreateLoadingate();
      var event = await _eventService.post(request);
      if (event != null) {
        events.add(event);
      }
      value = EventDefaultState();
    } catch (error) {
      value = EventErrorState(error.toString());
    }

    if (value is EventDefaultState) {
      NavigatorProvider.pop();
    }
  }

  Future<void> update(
    EventRequestModel request,
  ) async {
    try {
      value = EventUpdateLoadingate();
      var event = await _eventService.patch(request);
      if (event != null) {
        var index = events.indexWhere((x) => x.id == event.id);
        events.removeAt(index);
        events.insert(index, event);
      }
      value = EventDefaultState();
    } catch (error) {
      value = EventErrorState(error.toString());
    }

    if (value is EventDefaultState) {
      NavigatorProvider.pop();
    }
  }

  Future<void> remove(
    EventRequestModel request,
  ) async {
    try {
      value = EventDeleteLoadingate();
      var response = await _eventService.delete(request.id!);
      if (response) {
        var index = events.indexWhere((x) => x.id == request.id);
        events.removeAt(index);
      }
      value = EventDefaultState();
    } catch (error) {
      value = EventErrorState(error.toString());
    }

    if (value is EventDefaultState) {
      NavigatorProvider.pop();
    }
  }
}
