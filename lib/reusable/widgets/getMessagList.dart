import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';

import '../../message_data.dart';
import '../../models/message_model.dart';
import '../../ui/messages_body.dart';

class GetMessageList extends StatelessWidget {
  final String? prefNameData;

  GetMessageList({Key? key, this.prefNameData}) : super(key: key);
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
            prefNameData: prefNameData.toString(),
            messageModelData: message,
          );
        },
      ),
    );
  }
}
