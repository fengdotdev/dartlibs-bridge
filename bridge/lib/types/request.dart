import 'package:bridge/interfaces/request_interface.dart';
import 'package:bridge/types/body.dart';
import 'package:bridge/types/method.dart';
import 'package:bridge/types/protocol.dart';

class Request implements RequestInterface {
  @override
  final Scheme? protocol;
  @override
  final String? domain;
  final String? _path;
  @override
  final Method method;
  @override
  final Map<String, String> queryParameters;
  @override
  final Map<String, String> headers;
  @override
  final Body body;

  Request({
    this.protocol = Scheme.https,
    this.domain = "",
    required  String path,
     this.method = Method.get,
     this.queryParameters = const {},
     this.headers = const {},
    required this.body,
  }) : _path = path;


  // return a request with the method set to get
  Request.get({
    this.protocol = Scheme.https,
    this.domain = "",
    required  String path,
    this.queryParameters = const {},
    this.headers = const {},
    required this.body,
  }) : method = Method.get, _path = path;


  Request.getNoBody({
    this.protocol = Scheme.https,
    this.domain = "",

    required  String path,
    this.queryParameters = const {},
    this.headers = const {},
  }) : method = Method.get, body = Body.empty(), _path = path;

  Request.post({
    this.protocol = Scheme.defaultProtocol,
    this.domain = "",
    required  String path,
    this.queryParameters = const {},
    this.headers = const {},
    required this.body,
  }) : method = Method.post, _path = path;

  Request.postNoBody({
    this.protocol = Scheme.defaultProtocol,
    this.domain = "",
    required  String path,
    this.queryParameters = const {},
    this.headers = const {},
  }) : method = Method.post, body = Body.empty(), _path = path;


  Request.delete({
    this.protocol = Scheme.defaultProtocol,
    this.domain = "",
    required  String path,
    this.queryParameters = const {},
    this.headers = const {},
    required this.body,
  }) : method = Method.delete, _path = path;




  @override
  String get path => removeFirstSlash(_path);



  //ex: path?query=parameters
  @override
  String get pathWithQueryParameters {
   final path = "${this.path}?${queryParameters.entries.map((e) => "${e.key}=${e.value}").join('&')}";
    return path;
  }

  //ex: protocol://domain/path?query=parameters
  @override
  Uri get urlWithQueryParameters {
    final uri = Uri.parse('${protocol.toString()}://$domain/$path');
    return uri.replace(queryParameters: queryParameters);
  }

  @override
  Uri get url {

    Panicdsfadsfadsf
    final uri = Uri.parse('${protocol.toString()}://$domain/$path');
    return uri;
  }
  
  @override
  bool hasBody() {
    return body.content.isNotEmpty;
  }
  
  @override
  bool hasHeaders() {
    return headers.isNotEmpty;
  }
  
  @override
  bool hasQueryParameters() {
    return queryParameters.isNotEmpty;
  
  }
  
  @override
  bool isDomainEmpty() {
    return domain.isEmpty;
  }

  @override
  bool isDefaultProtocol() {
    return protocol == Scheme.defaultProtocol;
  }

  @override
  bool hasDomain() {
    return domain.isNotEmpty;
  }
}




String removeFirstSlash(String input) {
  if (input.startsWith('/')) {
    return input.substring(1);
  }
  return input;
}