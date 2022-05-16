import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/users_info_model.dart';

class FirebaseDbData {
  DatabaseReference messageRef = FirebaseDatabase.instance.ref();
  FirebaseDatabase db = FirebaseDatabase.instance;
  FirebaseFirestore fireStoreDb = FirebaseFirestore.instance;
  late DatabaseReference keyRef;

  saveUserToFireStoreDb(UsersInfoModel usersInfoModel) {
    fireStoreDb
        .collection('users')
        .doc(usersInfoModel.userEmailId)
        .set(usersInfoModel.toJson());
  }

  saveMessagesToFireStoreDb(MessageModel messageModel) {
    fireStoreDb.collection('chats').doc().set(messageModel.toJson());
  }
  //
  // saveMessages(MessageModel message) {
  //   db.ref('/messages').push().set(message.toJson());
  // }
  //
  // getMessageQuery() {
  //   DatabaseReference ref = messageRef.child('messages');
  //   return ref;
  // }

  // getUserQuery() {
  //   DatabaseReference userRef = messageRef.child('users');
  //   return userRef;
  // }

  Future<UsersInfoModel?> getUserByEmail(emailId) async {
    var value = await fireStoreDb.collection('users').doc(emailId).get();
    if (!value.exists) {
      return null;
    }
    return UsersInfoModel.fromJson(value.data()!);
  }

  getMessage() async {
    var collection = FirebaseFirestore.instance.collection('chats');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      String documentID = snapshot.id; // <-- Document ID
      print('docId$documentID');
      Map value = snapshot.data();
      return value;
    }
  }
}
