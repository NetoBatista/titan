import 'package:titan/app/core/model/event/event_request_model.dart';

class EventRequestAdapter {
  static Map<String, dynamic> toMap(EventRequestModel request) {
    return <String, dynamic>{
      'id': request.id,
      'name': request.name,
      'url': request.url,
      'method': request.method,
      'interval': request.interval,
    };
  }
}
