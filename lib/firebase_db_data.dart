import 'dart:async';

import 'package:async/async.dart' show StreamGroup;
import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:flutter/foundation.dart';

class FirebaseDbData {
  FirebaseFirestore fireStoreDb = FirebaseFirestore.instance;
  String collectionConversation = "conversations";
  List<Stream<QuerySnapshot>>? results;

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
}
