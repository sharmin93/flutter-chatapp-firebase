import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:chat_app_using_firebase/utilities/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';

class MessagesBody extends StatelessWidget {
  final String textMessage;
  final DateTime dateTime;
  final String? prefNameData;
  final MessageModel messageModelData;

  const MessagesBody(
      {Key? key,
      required this.textMessage,
      required this.dateTime,
      this.prefNameData,
      required this.messageModelData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(UdDesign.pt(10)),
      child: UdCard(
          backgroundColor: messageModelData.prefNameData == prefNameData
              ? ProjectColors.blue.withOpacity(0.25)
              : ProjectColors.grey40.withOpacity(0.2),
          disableShadow: true,
          paddingHorizontal: UdDesign.pt(16),
          paddingVertical: UdDesign.pt(16),
          borderRadius: UdDesign.pt(4),
          child: Column(
            crossAxisAlignment: messageModelData.prefNameData == prefNameData
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              messageModelData.prefNameData == prefNameData
                  ? const SizedBox()
                  : UdText(
                      text: messageModelData.prefNameData,
                      fontSize: UdDesign.fontSize(12),
                      fontWeight: FontWeight.w500,
                      color: ProjectColors.blue,
                    ),
              UdGapY(
                value: 8,
              ),
              UdText(
                text: textMessage.toString(),
                fontSize: UdDesign.fontSize(12),
                fontWeight: FontWeight.normal,
                color: ProjectColors.black,
              ),
              UdGapY(
                value: 6,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: UdText(
                  text: DateFormat('hh:mm a').format(
                    DateTime.parse(
                      dateTime.toString(),
                    ).toLocal(),
                  ),
                  fontSize: UdDesign.fontSize(12),
                  fontWeight: FontWeight.w500,
                  color: ProjectColors.black.withOpacity(0.5),
                ),
              ),
            ],
          )
          // : Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       UdText(
          //         text: messageModelData.prefNameData,
          //         fontSize: UdDesign.fontSize(12),
          //         fontWeight: FontWeight.w500,
          //         color: ProjectColors.blue,
          //       ),
          //       UdGapY(
          //         value: 8,
          //       ),
          //       UdText(
          //         text: textMessage.toString(),
          //         fontSize: UdDesign.fontSize(12),
          //         fontWeight: FontWeight.normal,
          //         color: ProjectColors.black,
          //       ),
          //       Align(
          //         alignment: Alignment.bottomRight,
          //         child: UdText(
          //           text: DateFormat('hh:mm a').format(
          //             DateTime.parse(
          //               dateTime.toString(),
          //             ).toLocal(),
          //           ),
          //           fontSize: UdDesign.fontSize(12),
          //           fontWeight: FontWeight.w500,
          //           color: ProjectColors.black.withOpacity(0.5),
          //         ),
          //       ),
          //     ],
          //   ),
          ),
    );
  }
}
