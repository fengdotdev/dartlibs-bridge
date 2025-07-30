import 'package:bridge/types/headers.dart';
import 'package:http/http.dart' as http;

Future<(int statuscode, String body, Headers headers)> get({
  required Uri uri,
  Headers headers = const {},
}) async {
  final client = http.Client();

  try {
    final http.Response getResponse = await client.get(uri, headers: headers);

    final int statusCode = getResponse.statusCode;
    final String body = getResponse.body;
    final Headers responseHeaders = getResponse.headers;
    final somethins = getResponse.bodyBytes;

    return (statusCode, body, responseHeaders);
  } catch (e) {
    final int statusCode = 500; // Internal Server Error
    final String error = e.toString();

    return (statusCode, error, Headers());
  } finally {
    client.close();
  }
}


enum HttpResponseType {
  ok,
  created,
  noContent,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  internalServerError,
  serviceUnavailable,
}

enum ContentType {
  json,
  text,
  html,
  xml,
  pdf,
  imagePng,
  imageJpeg,
  imageGif,
}

final Map<HttpResponseType, Map<String, String>> httpResponseHeaders = {
  HttpResponseType.ok: {
    "Content-Type": "application/json",
    "Status": "200 OK"
  },
  HttpResponseType.created: {
    "Content-Type": "application/json",
    "Status": "201 Created"
  },
  HttpResponseType.noContent: {
    "Status": "204 No Content"
  },
  HttpResponseType.badRequest: {
    "Content-Type": "application/json",
    "Status": "400 Bad Request"
  },
  HttpResponseType.unauthorized: {
    "Content-Type": "application/json",
    "Status": "401 Unauthorized"
  },
  HttpResponseType.forbidden: {
    "Content-Type": "application/json",
    "Status": "403 Forbidden"
  },
  HttpResponseType.notFound: {
    "Content-Type": "application/json",
    "Status": "404 Not Found"
  },
  HttpResponseType.internalServerError: {
    "Content-Type": "application/json",
    "Status": "500 Internal Server Error"
  },
  HttpResponseType.serviceUnavailable: {
    "Content-Type": "application/json",
    "Status": "503 Service Unavailable"
  },
};

final Map<ContentType, String> contentTypeHeaders = {
  ContentType.json: "application/json",
  ContentType.text: "text/plain",
  ContentType.html: "text/html",
  ContentType.xml: "application/xml",
  ContentType.pdf: "application/pdf",
  ContentType.imagePng: "image/png",
  ContentType.imageJpeg: "image/jpeg",
  ContentType.imageGif: "image/gif",
};

Map<String, String> getHeaders(HttpResponseType type, {ContentType contentType = ContentType.json}) {
  final headers = httpResponseHeaders[type] ?? {};
  return {
    ...headers,
    "Content-Type": contentTypeHeaders[contentType] ?? "application/octet-stream"
  };
}

void main() {
  var responseType = HttpResponseType.notFound;
  var headers = getHeaders(responseType, contentType: ContentType.pdf);
  print(headers); // {"Content-Type": "application/pdf", "Status": "404 Not Found"}
}
