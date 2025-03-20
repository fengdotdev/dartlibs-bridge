enum Method {
  get("GET"),
  post("POST"),
  put("PUT"),
  delete("DELETE"),
  patch("PATCH");

  final String value;

  const Method(this.value);

  @override
   String toString(){
    return value;
   }
}