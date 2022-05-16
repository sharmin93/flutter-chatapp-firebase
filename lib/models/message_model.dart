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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    return data;
  }
}

class Messages {
  Timestamp? date;
  String? sender;
  String? text;

  Messages({this.date, this.sender, this.text});

  Messages.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sender = json['sender'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['sender'] = this.sender;
    data['text'] = this.text;
    return data;
  }
}