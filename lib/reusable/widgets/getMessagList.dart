import 'package:chat_app_using_firebase/models/message_model.dart';
import 'package:chat_app_using_firebase/models/users_info_model.dart';
import 'package:flutter/cupertino.dart';

import '../../firebase_db_data.dart';

class GetMessageList extends StatefulWidget {
 final MessageConversationModel? messageConversationModel;
  const GetMessageList(this.messageConversationModel,
      {Key? key})
      : super(key: key);

  @override
  State<GetMessageList> createState() => _GetMessageListState();
}

class _GetMessageListState extends State<GetMessageList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.messageConversationModel != null?
            Container(height: 100,
              child: ListView.builder(shrinkWrap: true,
                  itemCount: widget.messageConversationModel?.messages?.length,
                  itemBuilder: (context,index) {
                    return Expanded(child: Text('${widget.messageConversationModel?.messages![index].text}'));
                  }),
            ):Container(),
          ],
    );
  }
}
