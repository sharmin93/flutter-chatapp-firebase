import 'package:chat_app_using_firebase/utilities/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';
import 'package:ud_widgets/widgets/cards/card.dart';

class MessagesBody extends StatelessWidget {
  final String textMessage;
  final DateTime dateTime;

  const MessagesBody(
      {Key? key, required this.textMessage, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(UdDesign.pt(10)),
      child: UdCard(
        backgroundColor: ProjectColors.grey40.withOpacity(0.2),
        disableShadow: true,
        paddingHorizontal: UdDesign.pt(16),
        paddingVertical: UdDesign.pt(16),
        borderRadius: UdDesign.pt(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UdText(
              text: 'name',
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
        ),
      ),
    );
  }
}
