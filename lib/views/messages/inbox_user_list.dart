import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/widgets/cards/card.dart';
import 'package:ud_widgets/widgets/gaps/gapx.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/shapes/shape.dart';
import 'package:ud_widgets/widgets/texts/text.dart';

import '../../main.dart';
import '../../utilities/constants/colors.dart';
import 'chat_room.dart';

class InboxUserList extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;
  final MessageConversationModel messageConversationData;

  const InboxUserList(
      {Key? key,
      required this.snapshot,
      required this.index,
      required this.messageConversationData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime? date = messageConversationData
    //     .messages![messageConversationData.messages!.length - 1].date!
    //     .toDate();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
              conversationId: snapshot.docs[index].id,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(UdDesign.pt(8)),
        child: UdCard(
          backgroundColor: ProjectColors.grey40.withOpacity(0.2),
          disableShadow: true,
          paddingHorizontal: UdDesign.pt(16),
          paddingVertical: UdDesign.pt(16),
          borderRadius: UdDesign.pt(5),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UdText(
                        text: userEmail == messageConversationData.sender
                            ? messageConversationData.receiver
                                .toString()
                                .split("@")[0]
                                .replaceAll(".com", "")
                            : messageConversationData.sender
                                .toString()
                                .split("@")[0]
                                .replaceAll(".com", ""),
                        fontSize: UdDesign.fontSize(14),
                        fontWeight: FontWeight.bold,
                        color: ProjectColors.black),
                    UdGapY(
                      value: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        messageConversationData
                                    .messages![messageConversationData
                                            .messages!.length -
                                        1]
                                    .messageType ==
                                'media'
                            ? Icon(
                                Icons.image,
                                color: ProjectColors.black,
                                size: UdDesign.pt(20),
                              )
                            : messageConversationData
                                        .messages![messageConversationData
                                                .messages!.length -
                                            1]
                                        .text!
                                        .length >
                                    30
                                ? Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: UdDesign.pt(4)),
                                      child: UdText(
                                        text: messageConversationData
                                                        .messages !=
                                                    null &&
                                                messageConversationData
                                                    .messages!.isNotEmpty
                                            ? '${messageConversationData.messages![messageConversationData.messages!.length - 1].text}'
                                            : '',
                                        fontSize: UdDesign.fontSize(14),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.only(right: UdDesign.pt(4)),
                                    child: UdText(
                                      text: messageConversationData.messages !=
                                                  null &&
                                              messageConversationData
                                                  .messages!.isNotEmpty
                                          ? '${messageConversationData.messages![messageConversationData.messages!.length - 1].text}'
                                          : '',
                                      fontSize: UdDesign.fontSize(14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                        UdGapY(
                          value: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ProjectColors.grey40,
                              ),
                            ),
                            UdGapX(
                              value: 3,
                            ),
                            Center(
                              child: UdText(
                                text:
                                    messageConversationData.messages != null &&
                                            messageConversationData
                                                .messages!.isNotEmpty
                                        ? messageConversationData
                                                    .messages![
                                                        messageConversationData
                                                                .messages!
                                                                .length -
                                                            1]
                                                    .date !=
                                                null
                                            ? DateFormat('dd MMMM').format(
                                                DateTime.parse(messageConversationData
                                                        .messages![
                                                            messageConversationData
                                                                    .messages!
                                                                    .length -
                                                                1]
                                                        .date!
                                                        .toDate()
                                                        .toString())
                                                    .toLocal(),
                                              )
                                            : ''
                                        : '',
                                fontSize: UdDesign.fontSize(12),
                                fontWeight: FontWeight.w500,
                                color: ProjectColors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
