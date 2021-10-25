
  class MedicalPrescriptionModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  MedicalPrescriptionModel({this.body, this.message, this.code, this.total});

  MedicalPrescriptionModel.fromJson(Map<String, dynamic> json) {
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

  String medname;
  String medtype;
  String dosage;
  String morning;
  String afternoon;
  String evening;
  String doctor;
  String fromdate;
  String todate;
  String userid;
  String appno;
  String remarks;
  String duration;
  String meddate;
  String qty;
  String srlNoOne;
  String srlNoTwo;
  String medid;
  String reqstatus;
  String status;
  String testgroup;
  String testname;
  String quantity;
  String drName;

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
  this.status,
  this.testgroup,
  this.testname,
  this.quantity,
  this.drName});

  Body.fromJson(Map<String, dynamic> json) {
  medname = json['medname'].toString();
  medtype = json['medtype'].toString();
  dosage = json['dosage'].toString();
  morning = json['morning'].toString();
  afternoon = json['afternoon'].toString();
  evening = json['evening'].toString();
  doctor = json['doctor'].toString();
  fromdate = json['fromdate'].toString();
  todate = json['todate'].toString();
  userid = json['userid'].toString();
  appno = json['appno'].toString();
  remarks = json['remarks'].toString();
  duration = json['duration'].toString();
  meddate = json['meddate'].toString();
  qty = json['qty'].toString();
  srlNoOne = json['srlNoOne'].toString();
  srlNoTwo = json['srlNoTwo'].toString();
  medid = json['medid'].toString();
  reqstatus = json['reqstatus'].toString();
  status = json['status'].toString();
  testgroup = json['testgroup'].toString();
  testname = json['testname'].toString();
  quantity = json['quantity'].toString();
  drName = json['drName'].toString();
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
  data['testgroup'] = this.testgroup;
  data['testname'] = this.testname;
  data['quantity'] = this.quantity;
  data['drName'] = this.drName;
  return data;
  }
  }

