import 'package:firebase_database/firebase_database.dart';

import 'models/message_model.dart';

class FirebaseDbData {
  DatabaseReference messageRef = FirebaseDatabase.instance.ref();
  FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference keyRef;
  saveUserDb(usersInfoModel) {
    db.ref().child('users').push().set(usersInfoModel.toJson());
  }

  saveMessages(MessageModel message) {
    db.ref('/messages').push().set(message.toJson());
  }

  getMessageQuery() {
    DatabaseReference ref = messageRef.child('messages');
    return ref;
  }

  getUserQuery() {
    DatabaseReference userRef = messageRef.child('users');
    return userRef;
  }
}
