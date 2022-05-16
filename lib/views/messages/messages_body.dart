import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:chat_app_using_firebase/utilities/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/ud_widgets.dart';

class MessagesBody extends StatelessWidget {



  const MessagesBody(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('chat');
    // return Padding(
    //   padding: EdgeInsets.all(UdDesign.pt(10)),
    //   child: UdCard(
    //     backgroundColor: messageModelData.name == prefNameData
    //         ? ProjectColors.blue.withOpacity(0.25)
    //         : ProjectColors.grey40.withOpacity(0.2),
    //     disableShadow: true,
    //     paddingHorizontal: UdDesign.pt(16),
    //     paddingVertical: UdDesign.pt(16),
    //     borderRadius: UdDesign.pt(10),
    //     child: Column(
    //       crossAxisAlignment: messageModelData.name == prefNameData
    //           ? CrossAxisAlignment.end
    //           : CrossAxisAlignment.start,
    //       children: [
    //         messageModelData.name == prefNameData
    //             ? const SizedBox()
    //             : UdText(
    //                 text: messageModelData.name ?? '',
    //                 fontSize: UdDesign.fontSize(12),
    //                 fontWeight: FontWeight.w500,
    //                 color: ProjectColors.blue,
    //               ),
    //         UdGapY(
    //           value: 8,
    //         ),
    //         UdText(
    //           text: messageModelData.textMessages != null
    //               ? messageModelData.textMessages.toString()
    //               : '',
    //           fontSize: UdDesign.fontSize(12),
    //           fontWeight: FontWeight.normal,
    //           color: ProjectColors.black,
    //         ),
    //         UdGapY(
    //           value: 6,
    //         ),
    //         Align(
    //           alignment: Alignment.bottomRight,
    //           child: UdText(
    //             text: messageModelData.date != null
    //                 ? DateFormat('hh:mm a').format(
    //                     DateTime.parse(
    //                       messageModelData.date.toString(),
    //                     ).toLocal(),
    //                   )
    //                 : '',
    //             fontSize: UdDesign.fontSize(12),
    //             fontWeight: FontWeight.w500,
    //             color: ProjectColors.black.withOpacity(0.5),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
