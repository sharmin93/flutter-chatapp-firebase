import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../message_data.dart';

class MessageDataController extends ChangeNotifier {
  final messagesData = MessagesData();
  SharedPreferences? prefs;

  sendMessages(text, userNameData) {
    print('controller$userNameData');
    final messages = MessageModel(text, DateTime.now(), userNameData);
    if (kDebugMode) {
      print('messagessend${messages.textMessages}');
      print('messagesdate${messages.date}');
      print('messagesPrefName${messages.prefNameData}');
    }
    messagesData.saveMessages(messages);

    notifyListeners();
  }
}
