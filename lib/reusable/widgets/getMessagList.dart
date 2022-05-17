import 'package:chat_app_using_firebase/controller/message_data_controller.dart';
import 'package:chat_app_using_firebase/firebase_db_data.dart';
import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ud_widgets/ud_widgets.dart';

import '../../views/messages/messages_body.dart';

class GetMessageList extends StatefulWidget {
  final MessageConversationModel? messageConversationModel;
  final String? conversationId;
  final MessageController? controller;
  const GetMessageList(this.messageConversationModel, this.conversationId,
      {Key? key, this.controller})
      : super(key: key);

  @override
  State<GetMessageList> createState() => _GetMessageListState();
}

class _GetMessageListState extends State<GetMessageList> {
  final FirebaseDbData firebaseDbData = FirebaseDbData();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: firebaseDbData.getQueryMessages(widget.conversationId),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              var userMessagesDoc = snapshot.data;
              if (!snapshot.hasData) {
                return UdText(text: 'loading');
              } else {
                MessageConversationModel messagesDataModel =
                    MessageConversationModel.fromJson(userMessagesDoc.data());

                if (messagesDataModel.messages!.isEmpty) {
                  if (kDebugMode) {
                    print('no data${snapshot.hasData}');
                  }
                  return Center(child: UdText(text: 'No chats founds.'));
                } else {
                  return MessagesBody(
                      messagesConversationsData: messagesDataModel);
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
