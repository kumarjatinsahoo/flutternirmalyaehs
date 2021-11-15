class ImmunizationPostModel {
  String patientId;
  String patientName;
  String immunizationId;
  String immunizationDetails;
  String status;
  String immunizationDate;
  String doctorName;

  ImmunizationPostModel(
      {this.patientId, this.patientName, this.immunizationId, this.immunizationDetails,this.status,this.immunizationDate,this.doctorName});

  ImmunizationPostModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patientName = json['patientName'];
    immunizationId = json['immunizationId'];
    immunizationDetails = json['immunizationDetails'];
    status = json['status'];
    immunizationDate = json['immunizationDate'];
    doctorName = json['doctorName'];
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
    return data;
  }
}
