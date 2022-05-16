import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/users_info_model.dart';

class FirebaseDbData {
  FirebaseFirestore fireStoreDb = FirebaseFirestore.instance;
  String CollectionConversation ="conversations";

  Future<String?> getConversationId(String sender, String receiver) async {
    var snapshot = await fireStoreDb
        .collection(CollectionConversation)
        .where("sender", isEqualTo: sender)
        .where("receiver", isEqualTo: receiver).get();
    if(snapshot.size == 0){
      snapshot = await FirebaseFirestore
          .instance.collection(CollectionConversation)
          .where("sender", isEqualTo: receiver)
          .where("receiver", isEqualTo: sender).get();
    }

    if (snapshot.size == 0 ){
      return null; // no existing conversation. have to create new one
    }
    return snapshot.docs.first.id; // have existing conversation
  }

  Future<String?> createConversation(String sender, String receiver) async {
    // todo : have to check if already have a existing conversation

    MessageConversationModel messageConversationModel = MessageConversationModel();
    messageConversationModel.messages =[];
    messageConversationModel.sender = sender;
    messageConversationModel.receiver = receiver;

    var ref =  await fireStoreDb.collection(CollectionConversation).add(messageConversationModel.toJson());
    return ref.id; // have existing conversation
  }

  Future<MessageConversationModel?> getConversationById(String conversationId) async{
    var dataSnapshot = await fireStoreDb.collection(CollectionConversation).doc(conversationId).get();
    if(dataSnapshot.exists){
      return MessageConversationModel.fromJson(dataSnapshot.data()!);
    } else {
      return null;
    }
  }
  sendMessage(String conversationId, Messages messages) {
    fireStoreDb.collection(CollectionConversation).doc(conversationId).update({"messages": FieldValue.arrayUnion([messages.toJson()])});

  }




  getMessage() async {
    var collection = FirebaseFirestore.instance.collection('chats');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      String documentID = snapshot.id; // <-- Document ID
      print('docId$documentID');
      Map value = snapshot.data();
      return value;
    }
  }

}
