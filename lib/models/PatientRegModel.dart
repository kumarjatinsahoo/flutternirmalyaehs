class PatientRegModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  PatientRegModel({this.body, this.message, this.code, this.total});

  PatientRegModel.fromJson(Map<String, dynamic> json) {
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
 /* Null id;
  Null regNo;
  Null patientName;
  Null age;
  Null gender;
  Null mob;
  Null appntmntDate;
  Null appntmntTime;
  Null appointStatus;
  Null appntmntStatus;
  Null slNo;*/
  String countryId;
  String countryName;
  String stateId;
  String stateName;
  String districtId;
  String districtName;
  String cityId;
  String cityName;

  Body(
      {
        this.countryId,
        this.countryName,
        this.stateId,
        this.stateName,
        this.districtId,
        this.districtName,
        this.cityId,
        this.cityName});

  Body.fromJson(Map<String, dynamic> json) {
   /* id = json['id'];
    regNo = json['regNo'];
    patientName = json['patientName'];
    age = json['age'];
    gender = json['gender'];
    mob = json['mob'];
    appntmntDate = json['appntmntDate'];
    appntmntTime = json['appntmntTime'];
    appointStatus = json['appointStatus'];
    appntmntStatus = json['appntmntStatus'];
    slNo = json['slNo'];*/
    countryId = json['countryId'];
    countryName = json['countryName'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['districtId'] = this.districtId;
    data['districtName'] = this.districtName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    return data;
  }
}
