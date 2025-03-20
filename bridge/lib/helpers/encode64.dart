import 'dart:convert';
import 'dart:typed_data';

String encodeToBase64(Uint8List data) {
  return base64Encode(data);
}

String encodeToBase64String(String data) {
  return encodeToBase64(Uint8List.fromList(utf8.encode(data)));
}


Uint8List decodeFromBase64(String base64String) {
  return base64Decode(base64String);
}


String decodeFromBase64String(String base64String) {
  return utf8.decode(decodeFromBase64(base64String));
}