class ShareModel {
  String drid;
  String patientid;
  String refdrid;
  String appno;
  String notes;

  ShareModel({this.drid, this.patientid, this.refdrid, this.appno, this.notes});

  ShareModel.fromJson(Map<String, dynamic> json) {
    drid = json['drid'];
    patientid = json['patientid'];
    refdrid = json['refdrid'];
    appno = json['appno'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drid'] = this.drid;
    data['patientid'] = this.patientid;
    data['refdrid'] = this.refdrid;
    data['appno'] = this.appno;
    data['notes'] = this.notes;
    return data;
  }
}
