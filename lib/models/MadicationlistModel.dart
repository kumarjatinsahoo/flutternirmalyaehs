
class MadicationlistModel {
  List<Body> body;
  String message;
  String code;
  String total;

  MadicationlistModel({this.body, this.message, this.code, this.total});

  MadicationlistModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = new List<Body>();
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
  String medname;
  String medtype;
  String dosage;
  String morning;
  String afternoon;
  String evening;
  String doctor;
  String fromdate;
  String todate;
  String userid;
  String appno;
  String remarks;

  Body(
      {this.medname,
        this.medtype,
        this.dosage,
        this.morning,
        this.afternoon,
        this.evening,
        this.doctor,
        this.fromdate,
        this.todate,
        this.userid,
        this.appno,
        this.remarks});

  Body.fromJson(Map<String, dynamic> json) {
    medname = json['medname'].toString();
    medtype = json['medtype'].toString();
    dosage = json['dosage'].toString();
    morning = json['morning'].toString();
    afternoon = json['afternoon'].toString();
    evening = json['evening'].toString();
    doctor = json['doctor'].toString();
    fromdate = json['fromdate'].toString();
    todate = json['todate'].toString();
    userid = json['userid'].toString();
    appno = json['appno'].toString();
    remarks = json['remarks'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medname'] = this.medname;
    data['medtype'] = this.medtype;
    data['dosage'] = this.dosage;
    data['morning'] = this.morning;
    data['afternoon'] = this.afternoon;
    data['evening'] = this.evening;
    data['doctor'] = this.doctor;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['userid'] = this.userid;
    data['appno'] = this.appno;
    data['remarks'] = this.remarks;
    return data;
  }
}