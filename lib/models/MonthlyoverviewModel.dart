class MonthlyOverviewModel {
  Body body;
  String message;
  String code;
  Null total;

  MonthlyOverviewModel({this.body, this.message, this.code, this.total});

  MonthlyOverviewModel.fromJson(Map<String, dynamic> json) {
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
  String booked;
  String requested;
  String treated;
  String fromdate;
  String todate;

  Body({this.booked, this.requested, this.treated, this.fromdate, this.todate});

  Body.fromJson(Map<String, dynamic> json) {
    booked = json['booked'];
    requested = json['requested'];
    treated = json['treated'];
    fromdate = json['fromdate'];
    todate = json['todate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booked'] = this.booked;
    data['requested'] = this.requested;
    data['treated'] = this.treated;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    return data;
  }
}
