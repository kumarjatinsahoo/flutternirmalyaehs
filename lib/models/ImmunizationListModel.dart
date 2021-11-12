class ImmunizationListModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  ImmunizationListModel({this.body, this.message, this.code, this.total});

  ImmunizationListModel.fromJson(Map<String, dynamic> json) {
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
  String immunizationId;
  String immunizationDetails;
  String status;
  String immunizationDate;
  String doctorName;
  String slno;

  Body(
      {this.patientId,
        this.patientName,
        this.immunizationId,
        this.immunizationDetails,
        this.status,
        this.immunizationDate,
        this.doctorName,
        this.slno

      });

  Body.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patientName = json['patientName'];
    immunizationId = json['immunizationId'];
    immunizationDetails = json['immunizationDetails'];
    status = json['status'];
    immunizationDate = json['immunizationDate'];
    doctorName = json['doctorName'];
    slno = json['slno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['immunizationId'] = this.immunizationId;
    data['immunizationDetails'] = this.immunizationDetails;
    data['status'] = this.status;
    data['immunizationDate'] = this.immunizationDate;
    data['doctorName'] = this.doctorName;
    data['slno'] = this.slno;
    return data;
  }
}
