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
  addUser(userEmail) {
    final userInfo = UsersInfoModel(
        userEmailId: userEmail,
        id: uuid.v4(),
        name: userEmail,
        conversations: []);
    if (kDebugMode) {
      print('messagesPrefName${userInfo.userEmailId}');
    }
    firebaseDbData.saveUserToFireStoreDb(userInfo);
    notifyListeners();
  }

  getUserInfo(String emailId, String? selfEmailId) {
    firebaseDbData.getUserByEmail(emailId).then((otherUser) {
      if (otherUser == null) {
        if (kDebugMode) {
          print("user not found");
        }
      } else {
        firebaseDbData.getUserByEmail(selfEmailId).then((selfUser) {
          if (selfUser == null) {
            return null; // error case
          }
          selfUser.conversations ??= [];
          otherUser.conversations ??= [];
          for (var conversation in selfUser.conversations!) {
            if (conversation.otherEmailId == emailId) {
              return conversation.conversationId;
            }
          }
          // create a conversation;
          // get conversation id
          selfUser.conversations!.add(Conversation(
              otherEmailId: otherUser.userEmailId,
              conversationId: usersInfoModel.userEmailId,
              conversationName: otherUser.name));
          otherUser.conversations!.add(Conversation(
              otherEmailId: selfUser.userEmailId,
              conversationId: "random1234",
              conversationName: selfUser.name));

          firebaseDbData.fireStoreDb
              .collection("users")
              .doc(selfUser.userEmailId)
              .set(selfUser.toJson());
          firebaseDbData.fireStoreDb
              .collection("users")
              .doc(otherUser.userEmailId)
              .set(otherUser.toJson());
        });
      }
    });
  }

  getSearchedUserInfo(String emailId, String? selfEmailId, context) {
    firebaseDbData.getUserByEmail(emailId).then((otherUser) {
      if (otherUser == null) {
        if (kDebugMode) {
          print("user not found");
        }
      } else {
        usersInfoModel = otherUser;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
              prefNameData: usersInfoModel.userEmailId.toString(),
            ),
          ),
        );
        print('searchedUser${usersInfoModel.userEmailId}');
        firebaseDbData.getUserByEmail(selfEmailId).then((selfUser) {
          if (selfUser == null) {
            return null; // error case
          } else {
            usersInfoModel = selfUser;
            if (kDebugMode) {
              print('selfUser${usersInfoModel.userEmailId}');
            }
          }
        });
      }
    });
  }
}
