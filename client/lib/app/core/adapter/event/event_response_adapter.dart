import 'dart:convert';

import 'package:titan/app/core/model/event/event_request_model.dart';
import 'package:titan/app/core/model/event/event_response_model.dart';

class EventResponseAdapter {
  static EventResponseModel fromMap(Map<String, dynamic> map) {
    return EventResponseModel(
      id: map['id'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
      interval: map['interval'] as int,
      method: map['method'] as String,
    );
  }

  static EventResponseModel fromJson(String source) {
    return fromMap(json.decode(source) as Map<String, dynamic>);
  }

  static List<EventResponseModel> fromJsonList(String source) {
    var data = json.decode(source) as List<dynamic>;
    return data.map((e) => fromMap(e)).toList();
  }

  static EventRequestModel responseToRequest(EventResponseModel response) {
    return EventRequestModel(
      id: response.id,
      name: response.name,
      url: response.url,
      method: response.method,
      interval: response.interval,
    );
  }
}
