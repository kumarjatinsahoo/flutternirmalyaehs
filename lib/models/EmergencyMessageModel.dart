class EmergencyMessageModel {
  String userid;
  String msg;

  EmergencyMessageModel({this.userid, this.msg});

  EmergencyMessageModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['msg'] = this.msg;
    return data;
  }
}
