import 'package:chat_app_using_firebase/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ud_widgets/widgets/texts/text.dart';

import '../../firebase_db_data.dart';
import '../../main.dart';
import '../../models/message_model.dart';
import '../../utilities/constants/colors.dart';
import 'inbox_user_list.dart';

class MessagedUserList extends StatefulWidget {
  const MessagedUserList({Key? key}) : super(key: key);

  @override
  State<MessagedUserList> createState() => _MessagedUserListState();
}

class _MessagedUserListState extends State<MessagedUserList> {
  final FirebaseDbData firebaseDbData = FirebaseDbData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: firebaseDbData.inboxQueryMessage(userEmail),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return UdText(
                  text: 'something went wrong.',
                  color: ProjectColors.black,
                );
              } else {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data != '') {
                  QuerySnapshot qs = snapshot.data;
                  return ListView.builder(
                    itemCount: qs.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      MessageConversationModel messageConversationData =
                          MessageConversationModel.fromJson(
                              qs.docs[index].data()! as Map<String, dynamic>);

                      if ((userEmail == messageConversationData.sender ||
                              userEmail == messageConversationData.receiver) &&
                          (messageConversationData.messages!.isEmpty)) {
                        return UdText(text: '');
                      } else {
                        return InboxUserList(
                          snapshot: qs,
                          index: index,
                          messageConversationData: messageConversationData,
                        );
                      }
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
