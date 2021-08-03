class LabBookModel {
  String status;
  String message;
  List<Labappointmnt> labappointmnt;

  LabBookModel({this.status, this.message, this.labappointmnt});

  LabBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['labappointmnt'] != null) {
      labappointmnt = new List<Labappointmnt>();
      json['labappointmnt'].forEach((v) {
        labappointmnt.add(new Labappointmnt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.labappointmnt != null) {
      data['labappointmnt'] =
          this.labappointmnt.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Labappointmnt {
  String regNo;
  String motherName;
  int id;
  int districtcd;
  int appointStatus;
  String gender;
  String age;
  String appntmntDate;
  String appntmntTime;
  String appntmntStatus;
  String mob;

  Labappointmnt(
      {this.regNo,
        this.id,
        this.motherName,
        this.districtcd,
        this.gender,
        this.appntmntDate,
        this.appntmntTime,
        this.appointStatus,
        this.age,
        this.appntmntStatus,
        this.mob});

  Labappointmnt.fromJson(Map<String, dynamic> json) {
    regNo = json['regNo'];
    motherName = json['motherName'];
    id = json['id'];
    districtcd = json['districtcd'];
    gender = json['gender'];
    appntmntDate = json['appntmntDate'];
    appntmntTime = json['appntmntTime'];
    age = json['age'].toString();
    appntmntStatus = json['appntmntStatus'];
    appointStatus = json['appointStatus'];
    mob = json['mob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regNo'] = this.regNo;
    data['motherName'] = this.motherName;
    data['id'] = this.id;
    data['districtcd'] = this.districtcd;
    data['gender'] = this.gender;
    data['appntmntDate'] = this.appntmntDate;
    data['appntmntTime'] = this.appntmntTime;
    data['appntmntStatus'] = this.appntmntStatus;
    data['age'] = this.age;
    data['appointStatus'] = this.appointStatus;
    data['mob'] = this.mob;
    return data;
  }
}