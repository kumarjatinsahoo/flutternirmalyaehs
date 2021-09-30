class AddBioMedicalModel {
  String userid;
  String bioMName;
  String bioMReason;
  String bioMDate;

  AddBioMedicalModel(
      {this.userid, this.bioMName, this.bioMReason, this.bioMDate});

  AddBioMedicalModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    bioMName = json['bioMName'];
    bioMReason = json['bioMReason'];
    bioMDate = json['bioMDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['bioMName'] = this.bioMName;
    data['bioMReason'] = this.bioMReason;
    data['bioMDate'] = this.bioMDate;
    return data;
  }
}
