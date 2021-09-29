class AllergicPostModel {
  String userid;
  String allnameid;
  String alltypeid;
  String severity;
  String reaction;
  String updatedby;

  AllergicPostModel(
      {this.userid,
        this.allnameid,
        this.alltypeid,
        this.severity,
        this.reaction,
        this.updatedby});

  AllergicPostModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    allnameid = json['allnameid'];
    alltypeid = json['alltypeid'];
    severity = json['severity'];
    reaction = json['reaction'];
    updatedby = json['updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['allnameid'] = this.allnameid;
    data['alltypeid'] = this.alltypeid;
    data['severity'] = this.severity;
    data['reaction'] = this.reaction;
    data['updatedby'] = this.updatedby;
    return data;
  }
}
