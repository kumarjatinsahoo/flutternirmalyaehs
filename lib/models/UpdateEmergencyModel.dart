class UpdateEmergencyModel {
  String userid;
  String name;
  String relation;
  String mobile;

  UpdateEmergencyModel({this.userid, this.name, this.relation, this.mobile});

  UpdateEmergencyModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
    relation = json['relation'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['mobile'] = this.mobile;
    return data;
  }
}
