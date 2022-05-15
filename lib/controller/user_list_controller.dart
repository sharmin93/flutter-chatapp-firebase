import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../firebase_db_data.dart';
import '../models/users_info_model.dart';
import 'package:uuid/uuid.dart';

class UserListController extends ChangeNotifier {
  final firebaseDbData = FirebaseDbData();
  var uuid = Uuid();
  addUser(userEmail) {
    final userInfo = UsersInfoModel(userEmailId: userEmail,
        id: uuid.v4(),
        name: userEmail,
        conversations:[]);
    if (kDebugMode) {
      print('messagesPrefName${userInfo.userEmailId}');
    }
    firebaseDbData.saveUserToFireStoreDb(userInfo);
    notifyListeners();
  }

  getUserInfo(String emailId, String? selfEmailId){
    firebaseDbData.getUserByEmail(emailId).then((otherUser){

      if (otherUser == null){
        print("user not found");
      } else{
        firebaseDbData.getUserByEmail(selfEmailId).then((selfUser) {
          if (selfUser == null){
            return null; // error case
          }
          selfUser.conversations ??= [];
          otherUser.conversations ??= [];
          for(var con in selfUser.conversations!){
              if (con.otherEmailId == emailId){
                return con.conversationId;
              }
          }
          // create a conversation;
          // get conversation id
          selfUser.conversations!.add(Conversation(otherEmailId: otherUser.userEmailId, conversationId: "random1234", conversationName: otherUser.name));
          otherUser.conversations!.add(Conversation(otherEmailId: selfUser.userEmailId, conversationId: "random1234", conversationName: selfUser.name));

          firebaseDbData.fireStoreDb.collection("users").doc(selfUser.userEmailId).set(selfUser.toJson());
          firebaseDbData.fireStoreDb.collection("users").doc(otherUser.userEmailId).set(otherUser.toJson());
        });
      }
    });


  }
  // addUserToList(emailId, String text) {
  //   if (text != emailId) {
  //
  //     final userInfo = UsersInfoModel(emailId);
  //     if (kDebugMode) {
  //       print('emailId${userInfo.userEmailId}');
  //     }
  //     firebaseDbData.saveUserDb(userInfo);
  //   }
  // }
}
