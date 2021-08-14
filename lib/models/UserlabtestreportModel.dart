class UserlabtestreportModel {
  List<Body> body;
  String message;
  String code;
  String total;

  UserlabtestreportModel({this.body, this.message, this.code, this.total});

  UserlabtestreportModel.fromJson(Map<String, dynamic> json) {
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
  String patientid;
  String patientname;
  String age;
  String gender;
  String weight;
  String height;
  String testdate;
  String phc;
  String medtelid;

  Body(
      {this.patientid,
        this.patientname,
        this.age,
        this.gender,
        this.weight,
        this.height,
        this.testdate,
        this.phc,
        this.medtelid});

  Body.fromJson(Map<String, dynamic> json) {
    patientid = json['patientid'].toString();
    patientname = json['patientname'].toString();
    age = json['age'].toString();
    gender = json['gender'].toString();
    weight = json['weight'].toString();
    height = json['height'].toString();
    testdate = json['testdate'].toString();
    phc = json['phc'].toString();
    medtelid = json['medtelid'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientid'] = this.patientid;
    data['patientname'] = this.patientname;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['testdate'] = this.testdate;
    data['phc'] = this.phc;
    data['medtelid'] = this.medtelid;
    return data;
  }
}