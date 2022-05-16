class MessageModel {
  String? textMessages;
  DateTime? date;
  String? name;
  String? sender;
  String? receiver;

  MessageModel(
      this.textMessages, this.date, this.name, this.receiver, this.sender);

  MessageModel.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        textMessages = json['textMessages'] != null
            ? json['textMessages'] as String
            : null,
        name = json['name'] as String,
        receiver = json['receiver'] != null ? json['receiver'] as String : null,
        sender = json['name'] != null ? json['name'] as String : null;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date.toString(),
        'textMessages': textMessages,
        'name': name,
        'receiver': receiver,
        'sender': sender,
      };
}
