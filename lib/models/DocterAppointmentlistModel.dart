class DoctorAppointmment {
  List<Body> body;
  String message;
  String code;
  String total;

  DoctorAppointmment({this.body, this.message, this.code, this.total});

  DoctorAppointmment.fromJson(Map<String, dynamic> json) {
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
  String age;
  String gender;
  String address;
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

  Body({
    this.age,
    this.gender,
    this.address,
    this.userid,
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
    age = json['age'].toString();
    gender = json['gender'].toString();
    address = json['address'].toString();
    userid = json['userid'].toString();
    doctorName = json['doctorName'].toString();
    speciality = json['speciality'].toString();
    appdate = json['appdate'].toString();
    apptime = json['apptime'].toString();
    notes = json['notes'].toString();
    status = json['status'].toString();
    appmonth = json['appmonth'].toString();
    appyear = json['appyear'].toString();
    patname = json['patname'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['address'] = this.address;
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