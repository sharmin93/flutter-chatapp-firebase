import 'package:firebase_database/firebase_database.dart';

import 'models/message_model.dart';

class MessagesData {
  DatabaseReference messageRef = FirebaseDatabase.instance.ref();
  saveMessages(MessageModel message) {
    messageRef.child('messages').push().set(message.toJson());
  }

  getMessageQuery() {
    var ref = messageRef.child('messages');
    return ref;
  }
}
