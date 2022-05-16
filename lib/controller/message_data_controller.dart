import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../firebase_db_data.dart';
import '../models/users_info_model.dart';

class MessageController extends ChangeNotifier {
  final messagesData = FirebaseDbData();
  UsersInfoModel usersInfoModel = UsersInfoModel();

}
