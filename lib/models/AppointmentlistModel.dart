class AppointmentlistModel {
  List<Body> body;
  String message;
  String code;
  String total;

  AppointmentlistModel({this.body, this.message, this.code, this.total});

  AppointmentlistModel.fromJson(Map<String, dynamic> json) {
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
  String doctorid;
  String docedu;
  String docexp;
  String docrate;
  String dochospital;
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
  String appno;
  String typeofconsult;
  String rating;
  String review;

  Body({
    this.doctorid,
    this.docedu,
    this.docexp,
    this.docrate,
    this.dochospital,
    this.userid,
    this.doctorName,
    this.speciality,
    this.appdate,
    this.apptime,
    this.notes,
    this.status,
    this.appmonth,
    this.appyear,
    this.patname,
    this.appno,
    this.typeofconsult,
    this.rating,
    this.review,
  });

  Body.fromJson(Map<String, dynamic> json) {
    doctorid = json['doctorid'].toString();
    docedu = json['docedu'].toString();
    docexp = json['docexp'].toString();
    docrate = json['docrate'].toString();
    dochospital = json['dochospital'].toString();
    userid = json['userid'].toString();
    doctorName = (json.containsKey("doctorname"))
        ? json['doctorname'].toString()
        : json['doctorName'].toString();
    speciality = json['speciality'].toString();
    appdate = json['appdate'].toString();
    apptime = json['apptime'].toString();
    notes = json['notes'].toString();
    status = json['status'].toString();
    appmonth = json['appmonth'].toString();
    appyear = json['appyear'].toString();
    patname = json['patname'].toString();
    appno = json['appno'].toString();
    typeofconsult = json['typeofconsult'].toString();
    rating = json['rating'].toString();
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorid'] = this.doctorid;
    data['docedu'] = this.docedu;
    data['docexp'] = this.docexp;
    data['docrate'] = this.docrate;
    data['dochospital'] = this.dochospital;
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
    data['appno'] = this.appno;
    data['typeofconsult'] = this.typeofconsult;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}
