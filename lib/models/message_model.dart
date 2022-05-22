import 'package:cloud_firestore/cloud_firestore.dart';

class MessageConversationModel {
  List<Messages>? messages;
  String? sender;
  String? receiver;

  MessageConversationModel({this.messages, this.sender, this.receiver});

  MessageConversationModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    sender = json['sender'];
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['sender'] = this.sender;
    data['receiver'] = receiver;
    data[sender!] = true;
    data[receiver!] = true;
    return data;
  }
}

class Messages {
  Timestamp? date;
  String? sender;
  String? text;
  String? messageType;
  String? imagePath;

  Messages({this.date, this.sender, this.text, this.messageType, imagePath});

  Messages.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sender = json['sender'];
    text = json['text'];
    messageType = json['messageType'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['sender'] = sender;
    data['text'] = text;
    data['messageType'] = messageType;
    data['imagePath'] = imagePath;
    return data;
  }
}
