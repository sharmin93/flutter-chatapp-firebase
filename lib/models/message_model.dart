class MessageModel {
  String? textMessages;
  DateTime? date;
  String? prefNameData;

  MessageModel(this.textMessages, this.date, this.prefNameData);

  MessageModel.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        textMessages = json['textMessages'] as String,
        prefNameData = json['prefNameData'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date.toString(),
        'textMessages': textMessages,
        'prefNameData': prefNameData,
      };
}
