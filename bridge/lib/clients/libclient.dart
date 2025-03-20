import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:bridge/helpers/encode64.dart';
import 'package:bridge/interfaces/client.dart';
import 'package:bridge/interfaces/request_interface.dart';
import 'package:bridge/interfaces/response_interface.dart';
import 'package:bridge/types/body.dart';
import 'package:bridge/types/headers.dart';
import 'package:bridge/types/queryparams.dart';
import 'package:bridge/types/response.dart';
import 'package:bridge/types/statuscodes.dart';


class LibClient implements Client {
  final ffi.DynamicLibrary _dylib;

  LibClient(String path) : _dylib = ffi.DynamicLibrary.open(path);

  @override
  Future<ResponseInterface> make(RequestInterface req) async {
    return call(req);
  }

  Future<ResponseInterface> call(RequestInterface req) async {
    // Structuring json
    final String jsonString = requestToJson(req);

    // packing as base64
    final String msg64 = packing(jsonString);

    // calling lib
    final String rawresponse = await libcall(msg64);

    // unpacking base64
    final String stringresponse = unpacking(rawresponse);

    // parsing json
    final Map<String, dynamic> map = jsonDecode(stringresponse);

    return createResponse(map);
  }

  Response createResponse(Map<String, dynamic> map) {
    final Body responseBody = Body.fromString(map["body"]);
    final int responseStatusCode = map["statusCode"] ?? 0;
    final Headers responseHeaders = map["headers"] ?? {};



      final StatusCode statusCode = StatusCode.fromCode(responseStatusCode);

    final Response response = Response(
      body: responseBody,
      statusCode: statusCode,
      headers: responseHeaders,
    );

    return response;
  }

  String requestToJson(RequestInterface req) {
    final String jsonheaders = headersToJson(req.headers);
    final String jsonqueryParameters = queryParamsToJson(req.queryParameters);
    final String jsonbody = req.body.toJson();
    return "{ \"method\": \"${req.method.name}\", \"path\": \"${req.path}\", \"headers\": $jsonheaders, \"queryParameters\": $jsonqueryParameters, \"body\": $jsonbody }";
  }

  String packing(String data) {
    // todo add cipher
    return encodeToBase64String(data);
  }

  String unpacking(String data) {
    // todo add cipher
    return decodeFromBase64String(data);
  }

  Future<String> libcall(String msg64) async {
    return Future.value("");
  }
}
