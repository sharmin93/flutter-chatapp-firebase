import 'package:chat_app_using_firebase/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';
import 'package:ud_widgets/widgets/buttons/udTapper.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/input/basic_text_input_field.dart';

import '../../controller/message_data_controller.dart';
import '../../firebase_db_data.dart';
import '../../models/message_model.dart';
import '../../reusable/widgets/getMessagList.dart';
import '../../utilities/constants/colors.dart';
import '../users/user_inbox_screen.dart';

class ChatRoom extends StatefulWidget {
  final String? conversationId;

  const ChatRoom({
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UdAppBar(
        context: context,
        customLeft: UdTapper(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserInboxScreen()),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UdCard(
                paddingHorizontal: 0,
                paddingVertical: 0,
                height: UdDesign.pt(25),
                width: UdDesign.pt(25),
                borderColor: ProjectColors.transparent,
                borderRadius: UdDesign.pt(1),
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.arrow_back,
                  color: ProjectColors.white,
                  size: UdDesign.pt(24),
                ),
              ),
              UdGapX(
                value: 4,
              ),
              UdShape(
                size: UdDesign.pt(25),
                radius: UdDesign.pt(20),
                color: ProjectColors.white,
                child: Icon(
                  Icons.person_rounded,
                  color: ProjectColors.blue,
                  size: UdDesign.pt(25),
                ),
              ),
              UdGapX(
                value: 6,
              ),
              UdText(
                text: userEmail.replaceAll('@yopmail.com', ''),
                color: ProjectColors.white,
              ),
            ],
          ),
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
                    Expanded(
                      child: GetMessageList(
                          messageConversationModel, widget.conversationId),
                    ),
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
                          child: const Icon(
                            Icons.send_rounded,
                            color: ProjectColors.blue,
                          ),
                          onTap: () {
                            messageController.sendMessage(
                                text: _messageTextController.text,
                                conversationId: widget.conversationId);

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
