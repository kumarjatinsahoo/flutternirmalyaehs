class InsurancePostModel {
  String patientId;
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

  InsurancePostModel(
      {
        this.patientId,
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
        this.sumAssuredAmt});

  InsurancePostModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
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
    return data;
  }
}
