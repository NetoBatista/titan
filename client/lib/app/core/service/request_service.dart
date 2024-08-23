import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:titan/app/core/interface/irequest_service.dart';
import 'package:titan/app/core/model/response_model.dart';

class RequestService implements IRequestService {
  final Duration _timeoutDefault = const Duration(seconds: 15);
  static const String _baseUrl = String.fromEnvironment(
    "URL_API",
    defaultValue: 'http://localhost:5002/api',
  );

  @override
  Future<ResponseModel> get(
    String endpoint,
  ) async {
    return await _sendRequest(
      () => http.get(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: _headersDefault(),
      ),
    );
  }

  @override
  Future<ResponseModel> post(
    String endpoint,
    dynamic body,
  ) async {
    return await _sendRequest(
      () => http.post(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: _headersDefault(),
        body: jsonEncode(body),
      ),
    );
  }

  @override
  Future<ResponseModel> patch(
    String endpoint,
    dynamic body,
  ) async {
    return await _sendRequest(
      () => http.patch(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: _headersDefault(),
        body: jsonEncode(body),
      ),
    );
  }

  @override
  Future<ResponseModel> delete(
    String endpoint,
  ) async {
    return await _sendRequest(
      () => http.delete(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: _headersDefault(),
      ),
    );
  }

  Future<ResponseModel> _sendRequest(
    Future<Response> Function() request,
  ) async {
    var response = await request().timeout(_timeoutDefault);
    return ResponseModel(
      statusCode: response.statusCode,
      body: _convertBody(response),
    );
  }

  Map<String, String> _headersDefault() {
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return headers;
  }

  String _convertBody(Response response) {
    if (response.body.isEmpty) {
      return '';
    }
    return response.body;
  }
}
