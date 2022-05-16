import 'package:chat_app_using_firebase/models/users_info_model.dart';
import 'package:flutter/cupertino.dart';

import '../../firebase_db_data.dart';

class GetMessageList extends StatefulWidget {
  final String? prefNameData;

  const GetMessageList({Key? key, this.prefNameData}) : super(key: key);

  @override
  State<GetMessageList> createState() => _GetMessageListState();
}

class _GetMessageListState extends State<GetMessageList> {
  final messagesData = FirebaseDbData();
  UsersInfoModel? usersInfoModel;
  String? receiver;
  Map? conversationData;
  @override
  void initState() {
    messagesData.getMessage().then((value) {
      print('valueId${value}');
      conversationData = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('id'),
      ],
    );
  }
}
