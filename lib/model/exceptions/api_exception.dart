import 'dart:convert';

class ApiException implements Exception {

  late String message;
  late int code;
  var realReason;

  ApiException({required String jsonBody, int code = 400, dynamic realReason}) {
    ErrorMessage errorMessage = ErrorMessage.fromJson(json.decode(jsonBody));
    message = errorMessage.message;
    code = code;
    realReason = realReason;
  }

  @override
  String toString() {
    return "{message: $message, code: $code, realReason: $realReason}";
  }
}

class ErrorMessage {
  late String _message;

  ErrorMessage.fromJson(Map<String, dynamic> parsedJson) {
    _message = parsedJson['message'];
  }

  String get message => _message;

  @override
  String toString() {
    return "{message: $_message}";
  }
}