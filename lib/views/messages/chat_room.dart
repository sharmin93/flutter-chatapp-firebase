import 'package:chat_app_using_firebase/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';
import 'package:ud_widgets/widgets/buttons/udTapper.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';

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
                      // SizedBox(
                      //   width: UdDesign.pt(260),
                      //   child: UdBasicTextInputField(
                      //     onChanged: (_) {},
                      //     controller: _messageTextController,
                      //     disableShadow: true,
                      //     borderColor: Colors.black,
                      //     borderRadius: UdDesign.pt(5),
                      //     borderWidth: UdDesign.pt(1),
                      //     width: double.infinity,
                      //     textAlignment: TextAlign.start,
                      //     padding: EdgeInsets.only(
                      //       left: UdDesign.pt(8),
                      //     ),
                      //     hintText: "Write something",
                      //     fontSize: UdDesign.fontSize(14),
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: UdDesign.pt(8)),
                          child: SizedBox(
                            width: UdDesign.pt(260),
                            height: UdDesign.pt(40),
                            child: Container(
                              // height: UdDesign.pt(40),
                              decoration: udContainerBoxDecoration(
                                context: context,
                                disableShadow: true,
                                borderRadius: UdDesign.pt(5),
                                borderColor: ProjectColors.black,
                                borderWidth: UdDesign.pt(1),
                              ),
                              child: TextField(
                                onChanged: (_) {},
                                controller: _messageTextController,
                                style: TextStyle(
                                  fontSize: UdDesign.fontSize(14),
                                  fontWeight: FontWeight.normal,
                                  color: ProjectColors.black,
                                ),
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: UdDesign.pt(8),
                                    top: UdDesign.pt(8),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      messageController.sendGalleryImages(
                                          widget.conversationId);
                                    },
                                    icon: const Icon(
                                      Icons.image,
                                      color: ProjectColors.black,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    borderSide: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    borderSide: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  filled: false,
                                  hintText: "Write somethings",
                                  hintStyle: TextStyle(
                                    color: ProjectColors.black,
                                    fontSize: UdDesign.fontSize(14),
                                  ),
                                ),
                                maxLines: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      UdGapY(
                        value: 25,
                      ),
                      IconButton(
                        onPressed: () {
                          messageController
                              .sendCameraImages(widget.conversationId);
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: ProjectColors.black,
                        ),
                      ),
                      UdTapper(
                        child: const Icon(
                          Icons.send_rounded,
                          color: ProjectColors.blue,
                        ),
                        onTap: () {
                          _messageTextController.text.isNotEmpty
                              ? messageController.sendMessage(
                                  text: _messageTextController.text,
                                  conversationId: widget.conversationId)
                              : const SizedBox();
                          _messageTextController.clear();
                        },
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
