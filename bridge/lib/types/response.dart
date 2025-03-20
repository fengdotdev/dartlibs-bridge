

import 'package:bridge/interfaces/response_interface.dart';
import 'package:bridge/types/body.dart';
import 'package:bridge/types/statuscodes.dart';

class Response implements ResponseInterface {

  Response({
    required this.body,
    required this.statusCode,
    required this.headers,
    this.errorMessage,
    
  });
  @override
  final Body body;
  @override
  final StatusCode statusCode;
  @override
  final Map<String, String> headers;

  @override
  final String? errorMessage;


  @override


  bool isSuccess() {
    return statusCode.isSuccess() && errorMessage == null;
  }

  @override
  bool isJson() {
    return headers['content-type']!.contains('application/json');
  }
  



}