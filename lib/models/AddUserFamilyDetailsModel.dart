class AddUserFamilyDetailsModel {
  String userid;
  String memberid;
  String relation;
  String famid;

  AddUserFamilyDetailsModel(
      {this.userid, this.memberid, this.relation, this.famid});

  AddUserFamilyDetailsModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    memberid = json['memberid'];
    relation = json['relation'];
    famid = json['famid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['memberid'] = this.memberid;
    data['relation'] = this.relation;
    data['famid'] = this.famid;
    return data;
  }
}
