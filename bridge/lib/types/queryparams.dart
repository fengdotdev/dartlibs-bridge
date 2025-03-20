typedef QueryParams = Map<String, String>;

String queryParamsToJson(QueryParams queryParams) {
  return "{${queryParams.entries.map((e) => "\"${e.key}\": \"${e.value}\"").join(", ")}}";
}
