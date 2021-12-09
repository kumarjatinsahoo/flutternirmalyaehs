class RefferedpatientsModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  RefferedpatientsModel({this.body, this.message, this.code, this.total});

  RefferedpatientsModel.fromJson(Map<String, dynamic> json) {
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
  String id;
  String patientid;
  Null drid;
  String notes;
  String refdrid;
  Null appno;
  String patientname;
  String refdrname;
  String sdate;
  String stime;
  String hosid;

  Body(
      {this.id,
        this.patientid,
        this.drid,
        this.notes,
        this.refdrid,
        this.appno,
        this.patientname,
        this.refdrname,
        this.sdate,
        this.stime,
        this.hosid,
      });

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientid = json['patientid'];
    drid = json['drid'];
    notes = json['notes'];
    refdrid = json['refdrid'];
    appno = json['appno'];
    patientname = json['patientname'];
    refdrname = json['refdrname'];
    sdate = json['sdate'];
    stime = json['stime'];
    hosid = json['hosid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientid'] = this.patientid;
    data['drid'] = this.drid;
    data['notes'] = this.notes;
    data['refdrid'] = this.refdrid;
    data['appno'] = this.appno;
    data['patientname'] = this.patientname;
    data['refdrname'] = this.refdrname;
    data['sdate'] = this.sdate;
    data['stime'] = this.stime;
    data['hosid'] = this.hosid;
    return data;
  }
}