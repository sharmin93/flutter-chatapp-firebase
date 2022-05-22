import 'dart:io';

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
  File? imageFile;
  String? imageName;
  String? imagePath;
  String? imageUrl;
  Messages? messages;
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
                builder: (context) =>
                    ChatRoom(
                      conversationId: createValue,
                    ),
              ),
            );
          }
        });
      } else {
        // loaded
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatRoom(
                  conversationId: value,
                ),
          ),
        );
      }
    });
  }

  sendMessage({String? text, String? conversationId}) {
    Messages messages = Messages(
        text: text, sender: userEmail, date: Timestamp.now(), messageType: 'text');
    firebaseData.saveMessageToDb(conversationId!, messages);
  }

  sendCameraImages( String? conversationId) async {
    var imagePath = await firebaseData.getImageFromCamera();
    if (kDebugMode) {
      print('${imagePath.toString()}');
    }
    Messages messages = Messages(
        text: '',
        sender: userEmail,
        date: Timestamp.now(),
        messageType: 'media',
        imagePath:imagePath);
    firebaseData.saveMessageToDb(conversationId!, messages);
  }
  sendGalleryImages( String? conversationId) async {
    var imagePath = await firebaseData.getImageFromGallery();
    if (kDebugMode) {
      print('${imagePath.toString()}');
    }
    Messages messages = Messages(
        text: '',
        sender: userEmail,
        date: Timestamp.now(),
        messageType: 'media',
        imagePath:imagePath);
    firebaseData.saveMessageToDb(conversationId!, messages);
  }
}
