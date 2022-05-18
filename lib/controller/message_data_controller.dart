import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../firebase_db_data.dart';
import '../main.dart';
import '../models/message_model.dart';
import '../views/messages/chat_room.dart';

class MessageController extends ChangeNotifier {
  MessageConversationModel? messageConversationModel;

  final firebaseData = FirebaseDbData();
  String? selectedUser;

  List<MessageConversationModel> inboxList = [];

  checkMessagesConversations({selectedUser, context}) {
 //init
    firebaseData.getConversationId(userEmail, selectedUser).then((value) {

      if (value == null) {
        firebaseData
            .createConversation(userEmail, selectedUser)
            .then((createValue) {
              //loaded
          if (createValue != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                  conversationId: createValue,
                ),
              ),
            );
          }
        });
      }
      else {
        // loaded
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
              conversationId: value,
            ),
          ),
        );
      }

    });
  }

  sendMessage({String? text, String? conversationId}) {
    Messages messages =
        Messages(text: text, sender: userEmail, date: Timestamp.now());
    firebaseData.saveMessageToDb(conversationId!, messages);
  }

}
