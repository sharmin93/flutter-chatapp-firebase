import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';

import '../../message_data.dart';
import '../../models/message_model.dart';
import '../../ui/messages_body.dart';

class GetMessageList extends StatelessWidget {
  GetMessageList({Key? key}) : super(key: key);
  final messagesData = MessagesData();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
        query: messagesData.getMessageQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final message = MessageModel.fromJson(json);
          return MessagesBody(
            textMessage: message.textMessages.toString(),
            dateTime: message.date!,
          );
        },
      ),
    );
  }
}
