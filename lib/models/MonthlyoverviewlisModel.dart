class MonthlyOverviewlistModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  MonthlyOverviewlistModel({this.body, this.message, this.code, this.total});

  MonthlyOverviewlistModel.fromJson(Map<String, dynamic> json) {
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
  String booked;
  String requested;
  String treated;
  String fromdate;
  String todate;
  String patientname;
  String reqDate;
  String patNote;

  Body(
      {this.booked,
        this.requested,
        this.treated,
        this.fromdate,
        this.todate,
        this.patientname,
        this.reqDate,
        this.patNote});

  Body.fromJson(Map<String, dynamic> json) {
    booked = json['booked'];
    requested = json['requested'];
    treated = json['treated'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    patientname = json['patientname'];
    reqDate = json['reqDate'];
    patNote = json['patNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booked'] = this.booked;
    data['requested'] = this.requested;
    data['treated'] = this.treated;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['patientname'] = this.patientname;
    data['reqDate'] = this.reqDate;
    data['patNote'] = this.patNote;
    return data;
  }
}