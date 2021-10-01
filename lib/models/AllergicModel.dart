class AllergicModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  AllergicModel({this.body, this.message, this.code, this.total});

  AllergicModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = [];
      json['body'].forEach((v) {
        body.add(new Body.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }
}

class Body {
  String allName;
  String allFood;
  String severity;
  String reaction;
  String userid;
  String allnameid;
  String alltypeid;
  String updatedby;

  Body(
      {this.allName,
        this.allFood,
        this.severity,
        this.reaction,
        this.userid,
        this.allnameid,
        this.alltypeid,
        this.updatedby});

  Body.fromJson(Map<String, dynamic> json) {
    allName = json['allName'];
    allFood = json['allFood'];
    severity = json['severity'];
    reaction = json['reaction'];
    userid = json['userid'];
    allnameid = json['allnameid'];
    alltypeid = json['alltypeid'];
    updatedby = json['updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allName'] = this.allName;
    data['allFood'] = this.allFood;
    data['severity'] = this.severity;
    data['reaction'] = this.reaction;
    data['userid'] = this.userid;
    data['allnameid'] = this.allnameid;
    data['alltypeid'] = this.alltypeid;
    data['updatedby'] = this.updatedby;
    return data;
  }
}
