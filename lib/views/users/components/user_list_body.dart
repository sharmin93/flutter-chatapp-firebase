// class UserListBody extends StatelessWidget {
//   final UsersInfoModel userInfo;
//   final String? prefNameData;
//   const UserListBody({Key? key, required this.userInfo, this.prefNameData})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(UdDesign.pt(4)),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>const ChatRoom(
//               conversationId: "123",
//               ),
//             ),
//           );
//         },
//         child: UdCard(
//           height: UdDesign.pt(60),
//           backgroundColor: ProjectColors.grey40.withOpacity(0.3),
//           disableShadow: true,
//           paddingHorizontal: UdDesign.pt(16),
//           paddingVertical: UdDesign.pt(16),
//           borderRadius: UdDesign.pt(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               UdText(
//                 text: userInfo.userEmailId!=''? userInfo.userEmailId:'nmnmn',
//                 fontSize: UdDesign.fontSize(12),
//                 fontWeight: FontWeight.w500,
//                 color: ProjectColors.blue,
//               ),
//               UdGapY(
//                 value: 8,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
