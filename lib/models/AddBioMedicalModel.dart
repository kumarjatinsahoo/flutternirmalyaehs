class AddBioMedicalModel {
  String userid;
  String bioMName;
  String bioMReason;
  String bioMDate;
  String id;

  AddBioMedicalModel(
      {this.userid, this.bioMName, this.bioMReason, this.bioMDate,this.id});

  AddBioMedicalModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    bioMName = json['bioMName'];
    bioMReason = json['bioMReason'];
    bioMDate = json['bioMDate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['bioMName'] = this.bioMName;
    data['bioMReason'] = this.bioMReason;
    data['bioMDate'] = this.bioMDate;
    data['id'] = this.id;
    return data;
  }
}
