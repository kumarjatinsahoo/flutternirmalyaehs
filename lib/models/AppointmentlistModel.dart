class AppointmentlistModel {
  List<Body> body;
  String message;
  String code;
  String total;

  AppointmentlistModel({this.body, this.message, this.code, this.total});

  AppointmentlistModel.fromJson(Map<String, dynamic> json) {
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
  String userid;
  String doctorName;
  String speciality;
  String appdate;
  String apptime;
  String notes;
  String status;
  String appmonth;
  String appyear;
  String patname;

  Body(
      {this.userid,
        this.doctorName,
        this.speciality,
        this.appdate,
        this.apptime,
        this.notes,
        this.status,
        this.appmonth,
        this.appyear,
        this.patname});

  Body.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    doctorName = json['doctorName'];
    speciality = json['speciality'];
    appdate = json['appdate'];
    apptime = json['apptime'];
    notes = json['notes'];
    status = json['status'];
    appmonth = json['appmonth'];
    appyear = json['appyear'];
    patname = json['patname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['doctorName'] = this.doctorName;
    data['speciality'] = this.speciality;
    data['appdate'] = this.appdate;
    data['apptime'] = this.apptime;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['appmonth'] = this.appmonth;
    data['appyear'] = this.appyear;
    data['patname'] = this.patname;
    return data;
  }
}