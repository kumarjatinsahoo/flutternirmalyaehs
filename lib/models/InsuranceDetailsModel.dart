class InsuranceDetailsModel {
  Body body;
  String message;
  String code;
  Null total;

  InsuranceDetailsModel({this.body, this.message, this.code, this.total});

  InsuranceDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String patientId;
  String patientName;
  String insCompany;
  String insType;
  String healthInsType;
  String policyNo;
  String policyStartDt;
  String policyEndDt;
  String totalInsAmount;
  String premiumDueDt;
  String thirdPartyAdm;
  String premiumAmount;
  String sumAssuredAmt;
  String strtMonthYear;
  String strtDay;
  String endMonthYear;
  String endDay;

  Body(
      {this.patientId,
        this.patientName,
        this.insCompany,
        this.insType,
        this.healthInsType,
        this.policyNo,
        this.policyStartDt,
        this.policyEndDt,
        this.totalInsAmount,
        this.premiumDueDt,
        this.thirdPartyAdm,
        this.premiumAmount,
        this.sumAssuredAmt,
        this.strtMonthYear,
        this.strtDay,
        this.endMonthYear,
        this.endDay});

  Body.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patientName = json['patientName'];
    insCompany = json['insCompany'];
    insType = json['insType'];
    healthInsType = json['healthInsType'];
    policyNo = json['policyNo'];
    policyStartDt = json['policyStartDt'];
    policyEndDt = json['policyEndDt'];
    totalInsAmount = json['totalInsAmount'];
    premiumDueDt = json['premiumDueDt'];
    thirdPartyAdm = json['thirdPartyAdm'];
    premiumAmount = json['premiumAmount'];
    sumAssuredAmt = json['sumAssuredAmt'];
    strtMonthYear = json['strtMonthYear'];
    strtDay = json['strtDay'];
    endMonthYear = json['endMonthYear'];
    endDay = json['endDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['insCompany'] = this.insCompany;
    data['insType'] = this.insType;
    data['healthInsType'] = this.healthInsType;
    data['policyNo'] = this.policyNo;
    data['policyStartDt'] = this.policyStartDt;
    data['policyEndDt'] = this.policyEndDt;
    data['totalInsAmount'] = this.totalInsAmount;
    data['premiumDueDt'] = this.premiumDueDt;
    data['thirdPartyAdm'] = this.thirdPartyAdm;
    data['premiumAmount'] = this.premiumAmount;
    data['sumAssuredAmt'] = this.sumAssuredAmt;
    data['strtMonthYear'] = this.strtMonthYear;
    data['strtDay'] = this.strtDay;
    data['endMonthYear'] = this.endMonthYear;
    data['endDay'] = this.endDay;
    return data;
  }
}
