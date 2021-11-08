class PocReportModel {
  List<Body> body;
  String message;
  String code;
  String total;

  PocReportModel({this.body, this.message, this.code, this.total});

  PocReportModel.fromJson(Map<String, dynamic> json) {
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
  toJson1(List<Body> list) {
    return list.map((v) => v.toJson()).toList();
  }

  addMore(Map<String, dynamic> json) {
    if (json['body'] != null) {
      json['body'].forEach((v) {
        body.add(new Body.fromJson(v));
      });
    }
  }
}

class Body {
  String medteluniqueid;
  String thpId;
  String thpName;
  String name;
  String phc;
  bool isChecked=false;
  String mobile;
  String gender;
  String age;
  String screeningDate;
  String patientUniqueid;
  String reportUrl;
  List<String> screeningDetails;

  Body(
      {this.medteluniqueid,
        this.thpId,
        this.thpName,
        this.name,
        this.phc,
        this.mobile,
        this.gender,
        this.age,
        this.screeningDate,
        this.patientUniqueid,
        this.reportUrl,
        this.screeningDetails});

  Body.fromJson(Map<String, dynamic> json) {
    medteluniqueid = json['medteluniqueid'];
    thpId = json['thp_id'];
    thpName = json['thp_name'];
    phc = json['phc'];
    name = json['name'];
    mobile = json['mobile'];
    gender = json['gender'];
    age = json['age'];
    screeningDate = json['screening_date'];
    patientUniqueid = json['patient_uniqueid'];
    reportUrl = json['report_url'];
    // if (json['screening_details'] != null) {
    //   screeningDetails = new List<Null>();
    //   json['screening_details'].forEach((v) {
    //     screeningDetails.add(new Null.fromJson(v));
    //   });
    //}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medteluniqueid'] = this.medteluniqueid;
    data['thp_id'] = this.thpId;
    data['thp_name'] = this.thpName;
    data['name'] = this.name;
    data['phc'] = this.phc;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['screening_date'] = this.screeningDate;
    data['patient_uniqueid'] = this.patientUniqueid;
    data['report_url'] = this.reportUrl;
    // if (this.screeningDetails != null) {
    //   data['screening_details'] =
    //       this.screeningDetails.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}