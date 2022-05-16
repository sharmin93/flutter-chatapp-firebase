import 'package:chat_app_using_firebase/models/users_info_model.dart';
import 'package:flutter/material.dart';

import '../../firebase_db_data.dart';
import '../messages/chat_room.dart';

class UserListScreen extends StatefulWidget {
  final String? prefNameData;

  UserListScreen({Key? key, this.prefNameData}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final userInfoData = FirebaseDbData();
  UsersInfoModel? usersInfoModel;
  List userList = ['fly.com', 'fig.com', 'ass.com'];
  @override
  // void initState() {
  //   userInfoData.getUserByEmail(widget.prefNameData).then((value) {
  //     usersInfoModel = value;
  //     setState(() {});
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: userList != null
            ? ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Text(userList[index].toString()),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatRoom(
                                  prefNameData: widget.prefNameData,
                                  selectedUserData: userList[index].toString()),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                })
            : const CircularProgressIndicator());
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
