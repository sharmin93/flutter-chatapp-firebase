import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../firebase_db_data.dart';
import '../models/users_info_model.dart';

class UserListController extends ChangeNotifier {
  final firebaseDbData = FirebaseDbData();

  sendUserInfo(emailId) {
    final userInfo = UsersInfoModel(emailId);
    if (kDebugMode) {
      print('emailId${userInfo.userEmailId}');
    }
    firebaseDbData.saveUser(userInfo);
    notifyListeners();
  }
}
