class EventMethodConstant {
  static const String get = "GET";
  static const String put = "PUT";
  static const String post = "POST";
  static const String patch = "PATCH";
  static const String delete = "DELETE";

  static List<String> getAll() {
    return [
      get,
      put,
      post,
      patch,
      delete,
    ];
  }
}
