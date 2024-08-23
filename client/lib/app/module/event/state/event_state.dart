abstract class EventState {}

class EventDefaultState extends EventState {}

class EventLoadingate extends EventState {}

class EventCreateLoadingate extends EventState {}

class EventUpdateLoadingate extends EventState {}

class EventDeleteLoadingate extends EventState {}

class EventErrorState extends EventState {
  String error;
  EventErrorState(this.error);
}
