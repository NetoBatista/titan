import 'package:titan/app/core/model/event/event_request_model.dart';
import 'package:titan/app/core/model/event/event_response_model.dart';

abstract class IEventService {
  Future<List<EventResponseModel>> get();
  Future<EventResponseModel?> patch(
    EventRequestModel request,
  );
  Future<EventResponseModel?> post(
    EventRequestModel request,
  );
  Future<bool> delete(String eventId);
}
