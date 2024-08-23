import 'package:flutter/material.dart';
import 'package:titan/app/core/interface/ievent_service.dart';
import 'package:titan/app/core/interface/iexecution_service.dart';
import 'package:titan/app/module/home/adapter/home_adapter.dart';
import 'package:titan/app/module/home/model/home_execution_model.dart';
import 'package:titan/app/module/home/state/home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  final IEventService _eventService;
  final IExecutionService _executionService;
  HomeController(
    this._eventService,
    this._executionService,
  ) : super(HomeDefaultState());

  List<HomeExecutionModel> homeExecutions = [];

  Future<void> init() async {
    try {
      value = HomeLoadingate();
      var events = await _eventService.get();
      var executions = await _executionService.get();
      for (var execution in executions) {
        var event = events.firstWhere((x) => x.id == execution.eventId);
        var item = HomeExecutionAdapter.toHomeExecutionModel(
          execution,
          event,
        );
        homeExecutions.add(item);
      }
      value = HomeDefaultState();
    } catch (error) {
      value = HomeErrorState(error.toString());
    }
  }
}
