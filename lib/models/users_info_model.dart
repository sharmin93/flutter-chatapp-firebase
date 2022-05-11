class UsersInfoModel {
  String? userEmailId;

  UsersInfoModel(this.userEmailId);

  UsersInfoModel.fromJson(Map<dynamic, dynamic> json)
      : userEmailId = json['userEmailId'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'userEmailId': userEmailId,
      };
}
