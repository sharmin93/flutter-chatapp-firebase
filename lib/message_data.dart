import 'package:firebase_database/firebase_database.dart';

import 'models/message_model.dart';

class MessagesData {
  DatabaseReference messageRef = FirebaseDatabase.instance.ref();
  var ref;
  saveMessages(MessageModel message) {
    messageRef.child('messages').push().set(message.toJson());
  }

  saveUser(MessageModel message) {
    messageRef
        .child('User')
        .push()
        .child('messages')
        .push()
        .set(message.toJson());
  }

  getMessageQuery() {
    ref = messageRef.child('messages');
    return ref;
  }
}
