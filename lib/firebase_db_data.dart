import 'package:firebase_database/firebase_database.dart';

import 'models/message_model.dart';
import 'models/users_info_model.dart';

class FirebaseDbData {
  DatabaseReference messageRef = FirebaseDatabase.instance.ref();
  FirebaseDatabase db = FirebaseDatabase.instance;

  saveUser(UsersInfoModel usersInfoModel) {
    db.ref().child('users').push().set(usersInfoModel.toJson());
    // print('key${orderRef.key}');
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
