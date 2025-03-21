import 'package:bridge/types/body.dart';
import 'package:bridge/types/method.dart';
import 'package:bridge/types/protocol.dart';

abstract interface class RequestInterface {
  Scheme? get scheme;
  String? get domain;
  String get path;


  Method get method;
  Map<String, String> get queryParameters;
  Map<String, String> get headers;
  Body get body;

  String get queryParametersFormatted;




  Uri? get url;

  bool isDomainEmpty();
  bool hasDomain();
  bool hasQueryParameters();
  bool hasHeaders();
  bool hasBody();
  bool isDefaultProtocol();
}
