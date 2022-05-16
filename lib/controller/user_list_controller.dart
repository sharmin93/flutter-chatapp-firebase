import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../firebase_db_data.dart';
import '../models/users_info_model.dart';
import '../views/messages/chat_room.dart';

class UserListController extends ChangeNotifier {
  final firebaseDbData = FirebaseDbData();
  var uuid = const Uuid();
  UsersInfoModel usersInfoModel = UsersInfoModel();
  // addUser(userEmail) {
  //   final userInfo = UsersInfoModel(
  //       userEmailId: userEmail,
  //       id: uuid.v4(),
  //       name: userEmail,
  //       conversations: []);
  //   if (kDebugMode) {
  //     print('messagesPrefName${userInfo.userEmailId}');
  //   }
  //   firebaseDbData.saveUserToFireStoreDb(userInfo);
  //   notifyListeners();
  // }

}
