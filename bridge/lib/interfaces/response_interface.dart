import 'package:bridge/types/body.dart';
import 'package:bridge/types/statuscodes.dart';

abstract interface class ResponseInterface {
  StatusCode get statusCode;

  String? get errorMessage;

  Map<String, String> get headers;

  Body get body;

  bool isSuccess();

  bool isJson();
}
