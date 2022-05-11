import 'package:chat_app_using_firebase/models/users_info_model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../firebase_db_data.dart';
import 'components/user_list_body.dart';

class UserListScreen extends StatelessWidget {
  UserListScreen({Key? key}) : super(key: key);
  final userInfoData = FirebaseDbData();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
        query: userInfoData.getUserQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final userInfoData = UsersInfoModel.fromJson(json);
          return UserListBody(
            userInfo: userInfoData,
          );
        },
      ),
    );
  }
}
