class FamilyDoctorModel {
  String userid;
  String name;
  String type;
  String mobile;
  String id;

  FamilyDoctorModel(
      {this.userid, this.name, this.type, this.mobile, this.id});

  FamilyDoctorModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['name'];
    type = json['type'];
    mobile = json['mobile'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['type'] = this.type;
    data['mobile'] = this.mobile;
    data['id'] = this.id;
    return data;
  }
  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['type'] = this.type;
    data['mobile'] = this.mobile;
    // data['id'] = this.id;
    return data;
  }
}
