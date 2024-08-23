import 'dart:convert';

import 'package:titan/app/core/model/execution/execution_response_model.dart';

class ExecutionResponseAdapter {
  static ExecutionResponseModel fromMap(Map<String, dynamic> map) {
    return ExecutionResponseModel(
      id: map['id'] as String,
      eventId: map['eventId'] as String,
      createdAt: map['createdAt'] as String,
      step: map['step'] as String,
    );
  }

  static ExecutionResponseModel fromJson(String source) {
    return fromMap(json.decode(source) as Map<String, dynamic>);
  }

  static List<ExecutionResponseModel> fromJsonList(String source) {
    var data = json.decode(source) as List<dynamic>;
    return data.map((e) => fromMap(e)).toList();
  }
}
