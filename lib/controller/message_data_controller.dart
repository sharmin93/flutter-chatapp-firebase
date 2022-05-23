import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
                builder: (context) => ChatRoom(
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
            builder: (context) => ChatRoom(
              conversationId: value,
            ),
          ),
        );
      }
    });
  }

  sendMessage({String? text, String? conversationId}) {
    Messages messages = Messages(
        text: text,
        sender: userEmail,
        date: Timestamp.now(),
        messageType: 'text');
    firebaseData.saveMessageToDb(conversationId!, messages);
  }

  ///check storage Permission//
  Future checkCameraPermission(String? conversationId) async {
    final PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      if (kDebugMode) {
        print('permissionStatus${status}');
      }
      await sendCameraImages(conversationId);
    }
    if (status.isDenied || status.isLimited) {
      final PermissionStatus status = await Permission.camera.request();
      if (kDebugMode) {
        print('Please give camera permission');
        print('permissionStatus${status}');
      }
    }
    if (status.isRestricted || status.isPermanentlyDenied) {
      await openAppSettings();

      if (kDebugMode) {
        print('change setting');
        print('permissionStatus${status}');
      }
    }
    notifyListeners();
  }

  Future checkGalleryPermission(String? conversationId) async {
    final PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      if (kDebugMode) {
        print('permissionStatus${status}');
      }
      await sendGalleryImages(conversationId);
    }
    if (status.isDenied || status.isLimited) {
      await Permission.storage.request();
      if (kDebugMode) {
        print('Please give storage permission');
        print('permissionStatus${status}');
      }
    }
    if (status.isRestricted || status.isPermanentlyDenied) {
      await openAppSettings();
      if (kDebugMode) {
        print('change setting');
        print('permissionStatus${status}');
      }
    }
    notifyListeners();
  }

  sendCameraImages(String? conversationId) async {
    var imagePath = await firebaseData.getImageFromCamera();
    if (kDebugMode) {
      print(imagePath);
    }
    Messages messages = Messages(
        text: '',
        sender: userEmail,
        date: Timestamp.now(),
        messageType: 'media',
        imagePath: imagePath);
    firebaseData.saveMessageToDb(conversationId!, messages);
  }

  sendGalleryImages(String? conversationId) async {
    var imagePath = await firebaseData.getImageFromGallery();
    if (kDebugMode) {
      print(imagePath);
    }
    Messages messages = Messages(
        text: '',
        sender: userEmail,
        date: Timestamp.now(),
        messageType: 'media',
        imagePath: imagePath);
    firebaseData.saveMessageToDb(conversationId!, messages);
  }
}
