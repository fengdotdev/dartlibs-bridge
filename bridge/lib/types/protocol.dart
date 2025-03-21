// also known as scheme
enum Scheme {
  http('http'),
  https('https'); // this must be the default protocol 

  final String value;

  const Scheme(this.value);

  static Scheme? fromString(String value) {
    for (var item in Scheme.values) {
      if (item.value == value) {
        return item;
      }
    }
    return null;
  }



  @override
  String toString() {
    return  value;
  }
}
