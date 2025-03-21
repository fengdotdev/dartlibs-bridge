import 'package:bridge/interfaces/client.dart';
import 'package:bridge/interfaces/request_interface.dart';
import 'package:bridge/interfaces/response_interface.dart';
import 'package:bridge/types/body.dart';
import 'package:bridge/types/headers.dart';
import 'package:bridge/types/protocol.dart';
import 'package:bridge/types/response.dart';
import 'package:bridge/types/statuscodes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebCLient implements Client {
  final Scheme protocol;
  final String? domain;
  final Headers headers = {};

  // Create a web client with a secure connection (https)
  WebCLient({
    this.domain,
    //http headers
    Headers headers = const {},
  }) : protocol = Scheme.https {
    this.headers.addAll(headers);
  }

  // Create a web client with an insecure connection (http)
  WebCLient.insecure({
    this.domain,
    //http headers
    Headers headers = const {},
  }) : protocol = Scheme.http {
    this.headers.addAll(headers);
  }

  @override
  Future<ResponseInterface> make(RequestInterface req) async {
    final result = createHttpRequest(req);
    final httprequest = result.httprequest;
    final error = result.error;

    if (error != null || httprequest == null) {
      final StatusCode statusCode = StatusCode.badRequest;
      final Response response = Response(
        body: Body.fromString(""),
        statusCode: statusCode,
        headers: {},
        errorMessage: error ?? "Error creating request",
      );
      return response;
    }

    try {
      final http.StreamedResponse streamedResponse = await http.Client().send(
        httprequest,
      );

      final int responseStatusCode = streamedResponse.statusCode;
      final Map<String, String> headersMap = Map.fromEntries(
        streamedResponse.headers.entries,
      );

      final String contentType = headersMap['content-type'] ?? '';
      bool isBinary =
          !contentType.contains('text') && !contentType.contains('json');

      final String bodyString =
          isBinary
              ? base64Encode(await streamedResponse.stream.toBytes())
              : await streamedResponse.stream.bytesToString();

      final Body responseBody = Body.fromString(bodyString);

      final StatusCode statusCode = StatusCode.fromCode(responseStatusCode);

      final Response response = Response(
        body: responseBody,
        statusCode: statusCode,
        headers: headersMap,
      );

      return response;
    } catch (e) {
      final StatusCode statusCode = StatusCode.badRequest;
      final Response response = Response(
        body: Body.fromString(""),
        statusCode: statusCode,
        headers: {},
        errorMessage: e.toString(),
      );
      return response;
    }
  }

  ({http.Request? httprequest, String? error}) createHttpRequest(
    RequestInterface req,
  ) {
    try {
      final String method = req.method.toString();

      final String protocol =
          req.protocol.isNull()
              ? this.protocol.toString()
              : req.protocol.toString();
      final Uri url =
          req.hasDomain()
              ? req.url
              : Uri.parse("$protocol://$domain/${req.pathWithQueryParameters}");
      final Map<String, String> mergedHeaders = {...req.headers, ...headers};
      final String body = req.body.content;

      final http.Request request =
          http.Request(method, url)
            ..headers.addAll(mergedHeaders)
            ..body = body;

      return (httprequest: request, error: null);
    } catch (e) {
      return (httprequest: null, error: e.toString());
    }
  }

  bool isSecure() {
    return protocol == Scheme.https;
  }

  bool isInsecure() {
    return protocol == Scheme.http;
  }

  bool hasDomain() {
    return domain != null;
  }

  Uri reqUri(RequestInterface req) {
    final end = req.pathWithQueryParameters;

    if (req.hasDomain()) {
      return req.url;
    }
  }
}
