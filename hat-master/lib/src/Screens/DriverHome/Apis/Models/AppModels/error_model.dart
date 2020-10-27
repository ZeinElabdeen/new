class ApiError {
  ApiError({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
    key: json["key"] == null ? null : json["key"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "value": value == null ? null : value,
  };
}
