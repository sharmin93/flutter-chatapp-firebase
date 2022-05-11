import 'package:chat_app_using_firebase/views/messages/messages_body.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';

import '../../firebase_db_data.dart';
import '../../models/message_model.dart';

class GetMessageList extends StatelessWidget {
  final String? prefNameData;

  GetMessageList({Key? key, this.prefNameData}) : super(key: key);
  final messagesData = FirebaseDbData();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
        query: messagesData.getMessageQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final message = MessageModel.fromJson(json);
          return MessagesBody(
            prefNameData: prefNameData.toString(),
            messageModelData: message,
          );
        },
      ),
    );
  }
}
