class PharmacycnfrmModel {
  List<Body> body;
  String message;
  String code;
 // Null total;

  PharmacycnfrmModel({this.body, this.message, this.code});

  PharmacycnfrmModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = new List<Body>();
      json['body'].forEach((v) {
        body.add(new Body.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
   // total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
   // data['total'] = this.total;
    return data;
  }
}

class Body {
  String medname;
  String medtype;
  Null dosage;
  Null morning;
  Null afternoon;
  Null evening;
  Null doctor;
  Null fromdate;
  Null todate;
  Null userid;
  Null appno;
  Null remarks;
  Null duration;
  Null meddate;
  String qty;
  Null srlNoOne;
  Null srlNoTwo;
  Null medid;
  Null reqstatus;
  Null status;
  dynamic key;
  dynamic name;

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
        this.remarks,
        this.duration,
        this.meddate,
        this.qty,
        this.srlNoOne,
        this.srlNoTwo,
        this.medid,
        this.reqstatus,
        this.status});

  Body.fromJson(Map<String, dynamic> json) {
    medname = json['medname'];
    medtype = json['medtype'];
    dosage = json['dosage'];
    morning = json['morning'];
    afternoon = json['afternoon'];
    evening = json['evening'];
    doctor = json['doctor'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    userid = json['userid'];
    appno = json['appno'];
    remarks = json['remarks'];
    duration = json['duration'];
    meddate = json['meddate'];
    qty = json['qty'];
    srlNoOne = json['srlNoOne'];
    srlNoTwo = json['srlNoTwo'];
    medid = json['medid'];
    reqstatus = json['reqstatus'];
    status = json['status'];
    if(json.containsKey("key")) {
      key = json["key"];
    }if(json.containsKey("name")) {
      name = json["name"];
    }
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
    data['duration'] = this.duration;
    data['meddate'] = this.meddate;
    data['qty'] = this.qty;
    data['srlNoOne'] = this.srlNoOne;
    data['srlNoTwo'] = this.srlNoTwo;
    data['medid'] = this.medid;
    data['reqstatus'] = this.reqstatus;
    data['status'] = this.status;
    return data;
  }
}
