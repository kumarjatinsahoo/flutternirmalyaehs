class UpdateEmergencyModel {
  String userid;
  String name;
  String relation;
  String mobile;
  String id;

  UpdateEmergencyModel(
      {this.userid, this.name, this.relation, this.mobile, this.id});

  UpdateEmergencyModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
    relation = json['relation'];
    mobile = json['mobile'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['mobile'] = this.mobile;
    data['id'] = this.id;
    return data;
  }
  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['mobile'] = this.mobile;
   // data['id'] = this.id;
    return data;
  }
}
