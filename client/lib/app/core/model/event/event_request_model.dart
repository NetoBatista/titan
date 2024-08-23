class EventRequestModel {
  String? id;
  String name;
  String url;
  String method;
  int interval;
  EventRequestModel({
    this.id,
    required this.name,
    required this.url,
    required this.method,
    required this.interval,
  });
}
