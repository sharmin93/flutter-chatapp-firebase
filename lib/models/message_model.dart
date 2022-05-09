class MessageModel {
  String? textMessages;
  DateTime? date;
  MessageModel(this.textMessages, this.date);
  MessageModel.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        textMessages = json['textMessages'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date.toString(),
        'textMessages': textMessages,
      };
}
