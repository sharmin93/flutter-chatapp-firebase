import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../message_data.dart';

class MessageDataController extends ChangeNotifier {
  final messagesData = MessagesData();

  sendMessages(text) {
    final messages = MessageModel(text, DateTime.now());
    if (kDebugMode) {
      print('messagessend${messages.textMessages}');
      print('messagesdate${messages.date}');
    }
    messagesData.saveMessages(messages);

    notifyListeners();
  }
}
