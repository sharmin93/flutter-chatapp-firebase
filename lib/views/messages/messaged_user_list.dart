import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import 'package:ud_widgets/widgets/cards/card.dart';
import 'package:ud_widgets/widgets/gaps/gapx.dart';
import 'package:ud_widgets/widgets/gaps/gapy.dart';
import 'package:ud_widgets/widgets/shapes/shape.dart';
import 'package:ud_widgets/widgets/texts/text.dart';

import '../../controller/message_data_controller.dart';
import '../../utilities/constants/colors.dart';

class MessagedUserList extends StatelessWidget {
  MessagedUserList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => MessageController(),
        child: Consumer<MessageController>(
          builder: (_, messageController, __) {
            return Column(children: [
              Padding(
                padding: EdgeInsets.all(UdDesign.pt(8)),
                child: UdCard(
                  backgroundColor: ProjectColors.grey40.withOpacity(0.2),
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
                          UdText(text: 'userName'),
                          UdGapY(
                            value: 4,
                          ),
                          UdText(text: 'latest messages'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
