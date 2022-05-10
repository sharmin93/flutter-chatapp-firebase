import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../message_data.dart';

class MessageController extends ChangeNotifier {
  final messagesData = MessagesData();

  sendMessages(text, userNameData) {
    final messages = MessageModel(text, DateTime.now(), userNameData);

    if (kDebugMode) {
      print('messageTextMessage${messages.textMessages}');
      print('messagesDate${messages.date}');
      print('messagesPrefName${messages.name}');
    }
    messagesData.saveMessages(messages);
    messagesData.saveUser(messages);
    notifyListeners();
  }
}
