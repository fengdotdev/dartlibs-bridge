import 'dart:typed_data';

import 'package:bridge/helpers/encode64.dart';


enum BodyType { string, bytes, empty, json, string64}

sealed class Body {
  const Body();

  BodyType get type;
  bool isEmpty();
  bool isBytes() => type == BodyType.bytes;
  bool isString() => type == BodyType.string;
  String get content;
  Uint8List? get bytes => isBytes() ? content as Uint8List : null;
  String? get string => isString() ? content : null;

  String toJson() {
    return "{ \"type\": \"${type.toString().split('.').last}\", \"content\": \"$content\" }";
  }

   factory Body.empty() {
    return StringData("");
  }

  factory Body.fromBytes(Uint8List value) {
    return BytesData(value);
  }

  factory Body.fromString(String value) {
    return StringData(value);
  }
}



StringData  bodyEmpty() {
  return StringData("");
}

class StringData extends Body {
  final String value;
  @override
  final BodyType type = BodyType.string;
  const StringData(this.value);

  @override
  String get content => value;

  @override
  bool isEmpty() {
    return value.isEmpty;
  }
}

class BytesData extends Body {
  final Uint8List value;
  @override
  final BodyType type = BodyType.bytes;
  const BytesData(this.value);

  @override
  String get content {
    final encode = encodeToBase64(value);
    return encode;
  }

  @override
  bool isEmpty() {
    return value.isEmpty;
  }
}
