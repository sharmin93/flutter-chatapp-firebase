class MessageModel {
  String? textMessages;
  DateTime? date;
  String? name;

  MessageModel(this.textMessages, this.date, this.name);

  MessageModel.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        textMessages = json['textMessages'] as String,
        name = json['name'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date.toString(),
        'textMessages': textMessages,
        'name': name,
      };
}
