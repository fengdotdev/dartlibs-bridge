import 'package:bridge/types/body.dart';
import 'package:bridge/types/method.dart';
import 'package:bridge/types/protocol.dart';

abstract interface class RequestInterface {
  Scheme? get scheme;
  String? get domain;
  String? get path;
  Method get method;
  Map<String, String> get queryParameters;
  String? get fragment;
  Map<String, String> get headers;
  Body get body;

  String get pathFormatted;
  String get queryParametersFormatted;
  String get fragmentFormatted;
  Uri? get url;
  String?
  get bridgeFullUrl; // if isBridgeRequest is true, return a string complaining with the bridge client, else null

  // boolen flags
  bool
  get isBridgeSwapable; // if true, bridge can swap the webclient with the bridge client (io, libc, etc)
  bool
  get isExternal; // if true, the request is from an external source and only work with webclient
  bool get isComplete;
  bool get isCompleteWithPath;
  bool get hasScheme;
  bool get hasDomain;
  bool get hasPath;
  bool get hasQueryParameters;
  bool get hasFragment;
  bool get hasHeaders;
  bool get hasBody;
  bool get isBridgeRequest;
}
