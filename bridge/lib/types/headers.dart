typedef Headers = Map<String, String>;



String headersToJson(Headers headers) {
  return "{${headers.entries.map((e) => "\"${e.key}\": \"${e.value}\"").join(", ")}}";
}