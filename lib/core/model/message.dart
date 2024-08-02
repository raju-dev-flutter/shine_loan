class Message {
  String? message;

  Message({this.message});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
