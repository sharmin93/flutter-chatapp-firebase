import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';
import 'package:ud_widgets/widgets/appbars/appbar.dart';
import 'package:ud_widgets/widgets/buttons/udTapper.dart';
import 'package:ud_widgets/widgets/cards/card.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/input/basic_text_input_field.dart';

import '../../controller/message_data_controller.dart';
import '../../firebase_db_data.dart';
import '../../main.dart';
import '../../models/message_model.dart';
import '../../reusable/widgets/getMessagList.dart';
import '../../utilities/constants/colors.dart';

class ChatRoom extends StatefulWidget {
  final String? conversationId;

  ChatRoom({
    Key? key,
    this.conversationId,
  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageTextController = TextEditingController();
  final firebaseData = FirebaseDbData();
  MessageConversationModel? messageConversationModel;

  @override
  void initState() {
    firebaseData.getConversationById(widget.conversationId!).then((value) {
      if (value != null) {
        messageConversationModel = value;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UdAppBar(
        context: context,
        customLeft: UdTapper(
          onTap: () {
            Navigator.pop(context);
          },
          child: UdCard(
            paddingHorizontal: 0,
            paddingVertical: 0,
            height: UdDesign.pt(35),
            width: UdDesign.pt(35),
            borderColor: ProjectColors.black,
            borderRadius: UdDesign.pt(5),
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.arrow_back,
              color: ProjectColors.black,
              size: UdDesign.pt(24),
            ),
          ),
        ),
        customMiddle: UdText(
          text: 'Chat Room ${widget.conversationId}',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(UdDesign.pt(16)),
        child: ChangeNotifierProvider(
            create: (_) => MessageController(),
            child: Consumer<MessageController>(
              builder: (context, messageController, __) {
                return Column(
                  children: [
                    GetMessageList(messageConversationModel),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: UdDesign.pt(300),
                          child: UdBasicTextInputField(
                            onChanged: (_) {},
                            controller: _messageTextController,
                            disableShadow: true,
                            borderColor: Colors.black,
                            borderRadius: UdDesign.pt(5),
                            borderWidth: UdDesign.pt(1),
                            width: double.infinity,
                            textAlignment: TextAlign.start,
                            padding: EdgeInsets.only(
                              left: UdDesign.pt(8),
                            ),
                            hintText: "Write something",
                            fontSize: UdDesign.fontSize(14),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        UdGapY(
                          value: 20,
                        ),
                        UdTapper(
                          child: const Icon(Icons.send_sharp),
                          onTap: () {
                            //Todo
                            Messages messages = Messages(
                                text: _messageTextController.text,
                                sender:userEmail,
                                date: Timestamp.now());
                            firebaseData.sendMessage(
                                widget.conversationId!, messages);
                            _messageTextController.clear();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
