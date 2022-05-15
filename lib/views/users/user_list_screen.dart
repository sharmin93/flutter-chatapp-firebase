import 'package:chat_app_using_firebase/models/users_info_model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../firebase_db_data.dart';
import 'components/user_list_body.dart';

class UserListScreen extends StatefulWidget {
  final String? prefNameData;

  UserListScreen({Key? key, this.prefNameData}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final userInfoData = FirebaseDbData();
  UsersInfoModel? usersInfoModel;
@override
  void initState() {
  userInfoData.getUserByEmail(widget.prefNameData).then((value) {
    usersInfoModel=value;
    setState(() {

    });
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // ignore: unnecessary_null_comparison
      child: usersInfoModel!=null && usersInfoModel?.conversations!=null?
      ListView.builder(itemCount: usersInfoModel?.conversations?.length,
          itemBuilder:(context, index){
        return Text(usersInfoModel!.conversations![index].conversationName!);
      }):Text('no data found'));
      // FirebaseAnimatedList(
      //   query: userInfoData.getOwnUser(),
      //   itemBuilder: (context, snapshot, animation, index) {
      //     final json = snapshot.value as Map<dynamic, dynamic>;
      //     final userInfoData = UsersInfoModel.fromJson(json);
      //     return UserListBody(
      //         userInfo: userInfoData, prefNameData: widget.prefNameData);
      //   },
      // ),
    // );
  }
}
