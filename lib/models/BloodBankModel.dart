class BloodBankModel {
  List<Body> body;
  String message;
  String code;
  String total;

  BloodBankModel({this.body, this.message, this.code, this.total});

  BloodBankModel.fromJson(Map<String, dynamic> json) {
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
  String patientId;
  String patientName;
  String fromLocation;
  String toDestination;
  String status;
  String bookedDate;
  String patientNote;
  String bloodBankId;
  String bloodBankName;
  String orderId;

  Body(
      {this.patientId,
        this.patientName,
        this.fromLocation,
        this.toDestination,
        this.status,
        this.bookedDate,
        this.patientNote,
        this.bloodBankId,
        this.bloodBankName,
        this.orderId});

  Body.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patientName = json['patientName'];
    fromLocation = json['fromLocation'];
    toDestination = json['toDestination'];
    status = json['status'];
    bookedDate = json['bookedDate'];
    patientNote = json['patientNote'];
    bloodBankId = json['bloodBankId'];
    bloodBankName = json['bloodBankName'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['fromLocation'] = this.fromLocation;
    data['toDestination'] = this.toDestination;
    data['status'] = this.status;
    data['bookedDate'] = this.bookedDate;
    data['patientNote'] = this.patientNote;
    data['bloodBankId'] = this.bloodBankId;
    data['bloodBankName'] = this.bloodBankName;
    data['orderId'] = this.orderId;
    return data;
  }
}
