import 'package:chat_app_using_firebase/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/widgets/cards/card.dart';
import 'package:ud_widgets/widgets/gaps/gapx.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/shapes/shape.dart';
import 'package:ud_widgets/widgets/texts/text.dart';

import '../../firebase_db_data.dart';
import '../../main.dart';
import '../../models/message_model.dart';
import '../../utilities/constants/colors.dart';
import 'chat_room.dart';

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
                return const Text('error found');
              } else {
                if (snapshot.hasData) {
                  QuerySnapshot qs = snapshot.data;
                  return ListView.builder(
                    itemCount: qs.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      MessageConversationModel messageConversationData =
                          MessageConversationModel.fromJson(
                              qs.docs[index].data()! as Map<String, dynamic>);

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatRoom(
                                conversationId: qs.docs[index].id,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(UdDesign.pt(8)),
                          child: UdCard(
                            backgroundColor:
                                ProjectColors.grey40.withOpacity(0.2),
                            disableShadow: true,
                            paddingHorizontal: UdDesign.pt(16),
                            paddingVertical: UdDesign.pt(16),
                            borderRadius: UdDesign.pt(10),
                            child: Row(
                              children: [
                                UdShape(
                                  size: UdDesign.pt(30),
                                  radius: UdDesign.pt(20),
                                  color: ProjectColors.blue,
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: ProjectColors.white,
                                    size: UdDesign.pt(25),
                                  ),
                                ),
                                UdGapX(
                                  value: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UdText(
                                        text: userEmail ==
                                                messageConversationData.sender
                                            ? messageConversationData.receiver
                                                .toString()
                                                .split("@")[0]
                                                .replaceAll(".com", "")
                                            : messageConversationData.sender
                                                .toString()
                                                .split("@")[0]
                                                .replaceAll(".com", "")),
                                    UdGapY(
                                      value: 4,
                                    ),
                                    UdText(
                                        text:
                                            'email: ${userEmail == messageConversationData.sender ? messageConversationData.receiver.toString() : messageConversationData.sender.toString()}'),
                                    UdText(
                                        text: messageConversationData
                                                        .messages !=
                                                    null &&
                                                messageConversationData
                                                    .messages!.isNotEmpty
                                            ? 'Latest message: ${messageConversationData.messages![messageConversationData.messages!.length - 1].text}'
                                            : ''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return UdText(
                    text: 'No user found',
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
