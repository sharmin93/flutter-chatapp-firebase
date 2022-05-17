import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:flutter/foundation.dart';
class FirebaseDbData {
  FirebaseFirestore fireStoreDb = FirebaseFirestore.instance;
  String collectionConversation = "conversations";

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

  /// get messages by conversationId//
  // Future<MessageConversationModel?> getConversationById(String conversationId) async {
  //   var dataSnapshot = await fireStoreDb
  //       .collection(collectionConversation)
  //       .doc(conversationId)
  //       .get();
  //   if (dataSnapshot.exists) {
  //     return MessageConversationModel.fromJson(dataSnapshot.data()!);
  //   } else {
  //     return null;
  //   }
  // }

  saveMessageToDb(String conversationId, Messages messages) {
    fireStoreDb.collection(collectionConversation).doc(conversationId).update({
      "messages": FieldValue.arrayUnion([messages.toJson()])
    });
  }

  // Exception
  getQueryMessages(conversationId) {
    return FirebaseFirestore.instance
        .collection(collectionConversation)
        .doc(conversationId)
        .snapshots();
  }

///using get() to  query ///
  Future<List<MessageConversationModel>> getInboxMessages(email) async {
    List<MessageConversationModel> returnValue =[];
    var firstSnapshot = await fireStoreDb
        .collection(collectionConversation)
        .where("sender", isEqualTo: email).get();

    var secondSnapshot = await fireStoreDb
        .collection(collectionConversation)
        .where("receiver", isEqualTo: email).get();

    for (var conversation in firstSnapshot.docs) {
      returnValue.add(MessageConversationModel.fromJson(conversation.data()));
    }
    for (var conversation in secondSnapshot.docs) {
      returnValue.add(MessageConversationModel.fromJson(conversation.data()));
    }
    return returnValue;
  }


  ///using stream//
  ///
  // Stream<QuerySnapshot> getInboxMessages(email)  {
  //
  //   List<Stream<QuerySnapshot>> streams = [];
  //
  //   var firstQuery = fireStoreDb
  //       .collection(collectionConversation)
  //       .where("sender", isEqualTo: email).snapshots();
  //
  //
  //   var secondQuery = fireStoreDb
  //       .collection(collectionConversation)
  //       .where("receiver", isEqualTo: email).snapshots();
  //
  //   streams.add(secondQuery);
  //   streams.add(firstQuery);
  //
  //   Stream<QuerySnapshot> results = StreamGroup.merge(streams);
  //
  //
  //   return results;
  // }

}
