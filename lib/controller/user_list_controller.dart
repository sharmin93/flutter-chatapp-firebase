import 'package:flutter/foundation.dart';

import '../firebase_db_data.dart';
import '../models/users_info_model.dart';

class UserListController extends ChangeNotifier {
  final firebaseDbData = FirebaseDbData();

  addUser(userEmail) {
    final userInfo = UsersInfoModel(userEmail);
    if (kDebugMode) {
      print('messagesPrefName${userInfo.userEmailId}');
    }
    firebaseDbData.saveUserDb(userInfo);
    notifyListeners();
  }

  addUserToList(emailId, String text) {
    if (text != emailId) {
      final userInfo = UsersInfoModel(emailId);
      if (kDebugMode) {
        print('emailId${userInfo.userEmailId}');
      }
      firebaseDbData.saveUserDb(userInfo);
    }
  }
}
