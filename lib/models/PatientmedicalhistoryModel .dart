class PatientmedicalhistoryModel {
  Body body;
  String message;
  String code;
  Null total;

  PatientmedicalhistoryModel({this.body, this.message, this.code, this.total});

  PatientmedicalhistoryModel.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    message = json['message'];
    code = json['code'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }
}

class Body {
  List<MedicalHistory> medicalHistory;
  List<Majorsurgery> majorsurgery;
  List<MedicalCondition> medicalCondition;

  Body({this.medicalHistory, this.majorsurgery, this.medicalCondition});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['medicalHistory'] != null) {
      medicalHistory = new List<MedicalHistory>();
      json['medicalHistory'].forEach((v) {
        medicalHistory.add(new MedicalHistory.fromJson(v));
      });
    }
    if (json['majorsurgery'] != null) {
      majorsurgery = new List<Majorsurgery>();
      json['majorsurgery'].forEach((v) {
        majorsurgery.add(new Majorsurgery.fromJson(v));
      });
    }
    if (json['medicalCondition'] != null) {
      medicalCondition = new List<MedicalCondition>();
      json['medicalCondition'].forEach((v) {
        medicalCondition.add(new MedicalCondition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicalHistory != null) {
      data['medicalHistory'] =
          this.medicalHistory.map((v) => v.toJson()).toList();
    }
    if (this.majorsurgery != null) {
      data['majorsurgery'] = this.majorsurgery.map((v) => v.toJson()).toList();
    }
    if (this.medicalCondition != null) {
      data['medicalCondition'] =
          this.medicalCondition.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicalHistory {
  String drName;
  String uname;
  String date;
  Null dnote;
  Null opid;
  Null opName;

  MedicalHistory(
      {this.drName, this.uname, this.date, this.dnote, this.opid, this.opName});

  MedicalHistory.fromJson(Map<String, dynamic> json) {
    drName = json['drName'];
    uname = json['uname'];
    date = json['date'];
    dnote = json['dnote'];
    opid = json['opid'];
    opName = json['opName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drName'] = this.drName;
    data['uname'] = this.uname;
    data['date'] = this.date;
    data['dnote'] = this.dnote;
    data['opid'] = this.opid;
    data['opName'] = this.opName;
    return data;
  }
}

class Majorsurgery {
  String uname;
  String opid;
  String opName;
  String date;
  String dnote;
  String drName;

  Majorsurgery(
      {this.uname, this.opid, this.opName, this.date, this.dnote, this.drName});

  Majorsurgery.fromJson(Map<String, dynamic> json) {
    uname = json['uname'];
    opid = json['opid'];
    opName = json['opName'];
    date = json['date'];
    dnote = json['dnote'];
    drName = json['drName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uname'] = this.uname;
    data['opid'] = this.opid;
    data['opName'] = this.opName;
    data['date'] = this.date;
    data['dnote'] = this.dnote;
    data['drName'] = this.drName;
    return data;
  }
}

class MedicalCondition {
  String diagnosisId;
  String uid;
  String description;

  MedicalCondition({this.diagnosisId, this.uid, this.description});

  MedicalCondition.fromJson(Map<String, dynamic> json) {
    diagnosisId = json['diagnosisId'];
    uid = json['uid'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diagnosisId'] = this.diagnosisId;
    data['uid'] = this.uid;
    data['description'] = this.description;
    return data;
  }
}
