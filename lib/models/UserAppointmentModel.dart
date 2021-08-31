class UserAppointmentModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  UserAppointmentModel({this.body, this.message, this.code, this.total});

  UserAppointmentModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String regNo;
  String patientName;
  int age;
  String gender;
  String mob;
  String appntmntDate;
  String appntmntTime;
  int appointStatus;
  String appntmntStatus;

  Body(
      {this.id,
        this.regNo,
        this.patientName,
        this.age,
        this.gender,
        this.mob,
        this.appntmntDate,
        this.appntmntTime,
        this.appointStatus,
        this.appntmntStatus});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regNo = json['regNo'];
    patientName = json['patientName'];
    age = json['age'];
    gender = json['gender'];
    mob = json['mob'];
    appntmntDate = json['appntmntDate'];
    appntmntTime = json['appntmntTime'];
    appointStatus = json['appointStatus'];
    appntmntStatus = json['appntmntStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['regNo'] = this.regNo;
    data['patientName'] = this.patientName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['mob'] = this.mob;
    data['appntmntDate'] = this.appntmntDate;
    data['appntmntTime'] = this.appntmntTime;
    data['appointStatus'] = this.appointStatus;
    data['appntmntStatus'] = this.appntmntStatus;
    return data;
  }
}
