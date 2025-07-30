
import 'dart:io';

import 'package:bridge/interfaces/request_interface.dart';
  

  
class Request implements RequestInterface{


    @override
  String get pathFormatted => removeFirstSlash(hasPath ? path! : ""); // remove first slash e.g. /path -> path always return string "" if null

  @override
  String get queryParametersFormatted {
    if (queryParameters.isEmpty) return '';
    return '?${queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')}'; // return query parameters formatted as ?key=value&key=value
  }

  @override
  String get fragmentFormatted => removehash(hasFragment ? fragment! : ""); // remove first hash e.g. #fragment -> fragment always return string "" if null

  @override
  // return url as Uri if isComplete(at least contains a scheme and domain) else null
  Uri? get url {
    try {
      return isComplete
          ? Uri(
            scheme: scheme?.value ?? '',
            host: domain ?? '',
            path: hasPath ? path : null,
            queryParameters: hasQueryParameters ? queryParameters : null,
            fragment: hasFragment ? fragment : null,
          )
          : null;
    } catch (e) {
      return null;
    }
  }

  @override
  bool get isComplete => hasScheme && hasDomain; // a complete request must have a scheme and domain at least
  @override
  bool get isCompleteWithPath => isComplete && hasPath; // a complete request with path must have a scheme, domain and path
  @override
  bool get hasScheme => scheme != null;
  @override
  bool get hasDomain => domain != null && domain!.isNotEmpty;
  @override
  bool get hasPath => path != null && path!.isNotEmpty;
  @override
  bool get hasQueryParameters => queryParameters.isNotEmpty;
  @override
  bool get hasFragment => fragment != null && fragment!.isNotEmpty;
  @override
  bool get hasHeaders => headers.isNotEmpty;
  @override
  bool get hasBody => !body.isEmpty();

  @override
  // bridge need a path at least, and
  bool get isBridgeRequest => isBridgeSwapable && hasPath && !isExternal;

  @override
  String? get bridgeFullUrl {
    if (isBridgeRequest ) {
      final String result = "/$pathFormatted${hasHeaders ? queryParametersFormatted : ''}${hasFragment ? fragmentFormatted : ''}";
    return result;
      
    }
    return null;
  }
  
  @override
  // TODO: implement body
  Body get body => throw UnimplementedError();
  
  @override
  // TODO: implement domain
  String? get domain => throw UnimplementedError();
  
  @override
  // TODO: implement fragment
  String? get fragment => throw UnimplementedError();
  
  @override
  // TODO: implement headers
  Map<String, String> get headers => throw UnimplementedError();
  
  @override
  // TODO: implement isBridgeSwapable
  bool get isBridgeSwapable => throw UnimplementedError();
  
  @override
  // TODO: implement isExternal
  bool get isExternal => throw UnimplementedError();
  
  @override
  // TODO: implement method
  Method get method => throw UnimplementedError();
  
  @override
  // TODO: implement path
  String? get path => throw UnimplementedError();
  
  @override
  // TODO: implement queryParameters
  Map<String, String> get queryParameters => throw UnimplementedError();
  
  @override
  // TODO: implement scheme
  Scheme? get scheme => throw UnimplementedError();

}






String removeFirstSlash(String input) {
  if (input.startsWith('/')) {
    return input.substring(1);
  }
  return input;
}

String removehash(String input) {
  if (input.startsWith('#')) {
    return input.substring(1);
  }
  return input;
}















HttpClient