import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../firebase_db_data.dart';
import '../models/users_info_model.dart';

class MessageController extends ChangeNotifier {
  final messagesData = FirebaseDbData();
  UsersInfoModel usersInfoModel = UsersInfoModel();

  sendMessages(receiver, sender, String text, {emailId, userNameData}) {
    final messages =
        MessageModel(text, DateTime.now(), userNameData, receiver, sender);
    if (kDebugMode) {
      print('messageTextMessage${messages.textMessages}');
      print('messagesDate${messages.date}');
      print('messagesPrefName${messages.name}');
    }
    messagesData.saveMessagesToFireStoreDb(messages);
    notifyListeners();
  }
}
