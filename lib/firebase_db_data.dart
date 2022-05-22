import 'dart:async';
import 'dart:io';

import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FirebaseDbData {
  FirebaseFirestore fireStoreDb = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String collectionConversation = "conversations";
  Messages messages = Messages();
  String imageCollection = "images";
  List<Stream<QuerySnapshot>>? results;
  File? imageFile;
  String? imageName;
  String? imagePath;
  String? imageUrl;

  Future<String?> getConversationId(String sender, String receiver) async {
    var snapshot = await fireStoreDb
        .collection(collectionConversation)
        .where("sender", isEqualTo: sender)
        .where("receiver", isEqualTo: receiver)
        .get();
    if (snapshot.size == 0) {
      snapshot = await FirebaseFirestore.instance
          .collection(collectionConversation)
          .where("sender", isEqualTo: receiver)
          .where("receiver", isEqualTo: sender)
          .get();
    }

    if (snapshot.size == 0) {
      return null; // no existing conversation. have to create new one
    }
    return snapshot.docs.first.id; // have existing conversation
  }

  Future<String?> createConversation(String sender, String receiver) async {
    MessageConversationModel messageConversationModel =
        MessageConversationModel();
    messageConversationModel.messages = [];
    messageConversationModel.sender = sender;
    messageConversationModel.receiver = receiver;

    var ref = await fireStoreDb
        .collection(collectionConversation)
        .add(messageConversationModel.toJson());
    return ref.id; // have existing conversation
  }

  saveMessageToDb(String conversationId, Messages messages) {
    fireStoreDb.collection(collectionConversation).doc(conversationId).update({
      "messages": FieldValue.arrayUnion([messages.toJson()])
    });
  }

  getQueryMessages(conversationId) {
    return FirebaseFirestore.instance
        .collection(collectionConversation)
        .doc(conversationId)
        .snapshots();
  }

  inboxQueryMessage(email) {
    var firstQuery = fireStoreDb
        .collection(collectionConversation)
        .where(FieldPath([email]), isEqualTo: true)
        .snapshots();

    return firstQuery;
  }

  ///image storage function//
  Future getImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        uploadImage();
      }
    });
  }

  Future getImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    await imagePicker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    imageName = const Uuid().v1();
    var ref =
        firebaseStorage.ref().child(imageCollection).child("$imageName.jpg");
    var uploadTask = await ref.putFile(imageFile!).catchError((error) {
      if (kDebugMode) {
        print('error$error');
      }
    });
    await uploadTask.ref.getDownloadURL().then((imageUrl) {
      if (imageUrl != null) {
        print('imageUrl$imageUrl');
      }
    });
  }
}
