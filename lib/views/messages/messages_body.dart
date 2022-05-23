import 'package:chat_app_using_firebase/main.dart';
import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/widgets/cards/card.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/texts/text.dart';

import '../../utilities/constants/colors.dart';

class MessagesBody extends StatelessWidget {
  final MessageConversationModel? messagesConversationsData;

  MessagesBody({Key? key, this.messagesConversationsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messagesConversationsData?.messages?.length,
        itemBuilder: (context, index) {
          DateTime? date =
              messagesConversationsData?.messages![index].date?.toDate();
          return messagesConversationsData?.messages![index].messageType ==
                  'media'
              ? Padding(
                  padding: EdgeInsets.all(UdDesign.pt(8)),
                  child: UdCard(
                    backgroundColor: userEmail ==
                            messagesConversationsData?.messages?[index].sender
                        ? ProjectColors.grey40.withOpacity(0.2)
                        : ProjectColors.blue.withOpacity(0.2),
                    disableShadow: true,
                    paddingHorizontal: UdDesign.pt(12),
                    paddingVertical: UdDesign.pt(12),
                    borderRadius: UdDesign.pt(10),
                    child: Column(
                      crossAxisAlignment: userEmail ==
                              messagesConversationsData?.messages?[index].sender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        messagesConversationsData?.messages?[index].imagePath !=
                                    null &&
                                messagesConversationsData
                                        ?.messages?[index].imagePath !=
                                    ''
                            ? Align(
                                alignment: userEmail ==
                                        messagesConversationsData
                                            ?.messages?[index].sender
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                child: Image.network(
                                  '${messagesConversationsData?.messages?[index].imagePath}',
                                  fit: BoxFit.fitWidth,
                                  height: UdDesign.pt(200),
                                  width: UdDesign.pt(200),
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                        UdGapY(
                          value: 6,
                        ),
                        Align(
                          alignment: userEmail ==
                                  messagesConversationsData
                                      ?.messages?[index].sender
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          child: UdText(
                            text: messagesConversationsData
                                        ?.messages![index].date !=
                                    null
                                ? 'send at ${DateFormat('hh:mm a').format(
                                    DateTime.parse(date.toString()).toLocal(),
                                  )}'
                                : '',
                            fontSize: UdDesign.fontSize(12),
                            fontWeight: FontWeight.w500,
                            color: ProjectColors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(UdDesign.pt(8)),
                  child: UdCard(
                    backgroundColor: userEmail ==
                            messagesConversationsData?.messages?[index].sender
                        ? ProjectColors.grey40.withOpacity(0.2)
                        : ProjectColors.blue.withOpacity(0.2),
                    disableShadow: true,
                    paddingHorizontal: UdDesign.pt(12),
                    paddingVertical: UdDesign.pt(12),
                    borderRadius: UdDesign.pt(10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: userEmail ==
                                messagesConversationsData
                                    ?.messages?[index].sender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          UdText(
                            text: messagesConversationsData
                                ?.messages![index].text,
                            fontSize: UdDesign.fontSize(12),
                            fontWeight: FontWeight.w500,
                            color: ProjectColors.blue,
                          ),
                          UdGapY(
                            value: 6,
                          ),
                          Align(
                            alignment: userEmail ==
                                    messagesConversationsData
                                        ?.messages?[index].sender
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            child: UdText(
                              text: messagesConversationsData
                                          ?.messages![index].date !=
                                      null
                                  ? 'send at ${DateFormat('hh:mm a').format(
                                      DateTime.parse(date.toString()).toLocal(),
                                    )}'
                                  : '',
                              fontSize: UdDesign.fontSize(12),
                              fontWeight: FontWeight.w500,
                              color: ProjectColors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
