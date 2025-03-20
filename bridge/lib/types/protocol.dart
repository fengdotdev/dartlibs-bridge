
enum Protocol {
  defaultProtocol(null), // prefered by the client
  http('http'),
  https('https');

  final String? value;

  const Protocol(this.value);


  static Protocol? fromString(String value) {
    for (var item in Protocol.values) {
      if (item.value == value) {
        return item;
      }
    }
    return null;
  }


  bool isDefaultProtocol() {
    return this == Protocol.defaultProtocol;
  }

  bool isNull() {
    return this == Protocol.defaultProtocol;
  }

  static String fromEnumOr(Protocol value, String or) {
    return value.value ?? or;
  }


  // Returns the protocol from the value
  // Returns http if defaultProtocol for avoid wrong values
  @override
  String toString() {
    return value ?? 'http';
  }
}




