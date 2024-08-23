import 'package:titan/app/core/adapter/event/event_request_adapter.dart';
import 'package:titan/app/core/adapter/event/event_response_adapter.dart';
import 'package:titan/app/core/interface/ievent_service.dart';
import 'package:titan/app/core/interface/irequest_service.dart';
import 'package:titan/app/core/model/event/event_request_model.dart';
import 'package:titan/app/core/model/event/event_response_model.dart';

class EventService implements IEventService {
  final IRequestService _requestService;
  EventService(this._requestService);

  @override
  Future<List<EventResponseModel>> get() async {
    var response = await _requestService.get('Event');
    if (response.statusCode != 200) {
      return [];
    }
    return EventResponseAdapter.fromJsonList(response.body);
  }

  @override
  Future<EventResponseModel?> post(
    EventRequestModel request,
  ) async {
    var response = await _requestService.post(
      'Event',
      EventRequestAdapter.toMap(request),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return EventResponseAdapter.fromJson(response.body);
  }

  @override
  Future<EventResponseModel?> patch(
    EventRequestModel request,
  ) async {
    var response = await _requestService.patch(
      'Event/${request.id}',
      EventRequestAdapter.toMap(request),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return EventResponseAdapter.fromJson(response.body);
  }

  @override
  Future<bool> delete(String eventId) async {
    var response = await _requestService.delete('Event/$eventId');
    return response.statusCode == 200;
  }
}
