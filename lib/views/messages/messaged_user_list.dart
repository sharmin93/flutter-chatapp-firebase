import 'package:chat_app_using_firebase/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/widgets/cards/card.dart';
import 'package:ud_widgets/widgets/gaps/gapx.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/shapes/shape.dart';
import 'package:ud_widgets/widgets/texts/text.dart';

import '../../controller/message_data_controller.dart';
import '../../firebase_db_data.dart';
import '../../models/message_model.dart';
import '../../utilities/constants/colors.dart';

class MessagedUserList extends StatefulWidget {
  const MessagedUserList({Key? key}) : super(key: key);

  @override
  State<MessagedUserList> createState() => _MessagedUserListState();
}

class _MessagedUserListState extends State<MessagedUserList> {
  var messageController = MessageController();
  final FirebaseDbData firebaseDbData = FirebaseDbData();
  @override
  void initState() {
    super.initState();
    messageController.getMessagedUserList(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        ///using mesagecontroller//
      ChangeNotifierProvider(
        create: (_) => messageController,
        child: Consumer<MessageController>(
          builder: (_, messageController, __) {
            return
              Column(
              children: [
                messageController.inboxList.isNotEmpty
                    ? Expanded(
                  child: ListView.builder(
                    itemCount: messageController.inboxList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(onTap: (){

                        if(messageController.inboxList[index].sender==userEmail){
                          messageController.checkMessagesConversations(
                              selectedUser: messageController.inboxList[index].receiver,
                              context: context);
                        }else{
                          messageController.checkMessagesConversations(
                              selectedUser: messageController.inboxList[index].sender,
                              context: context);
                        }

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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    UdText(
                                        text:messageController
                                            .inboxList[index].sender==userEmail?
                                        'userName: ${messageController
                                            .inboxList[index].receiver}':
                                        'userName: ${messageController
                                            .inboxList[index].sender}'),
                                    UdGapY(
                                      value: 4,
                                    ),
                                    UdText(
                                      text: messageController.inboxList[index]
                                          .messages != null &&
                                          messageController.inboxList[index]
                                              .messages!.isNotEmpty
                                          ? 'latest messages: ${messageController
                                          .inboxList[index]
                                          .messages![messageController
                                          .inboxList[index]
                                          .messages!.length-1].text}'
                                          : "no messsages",
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
