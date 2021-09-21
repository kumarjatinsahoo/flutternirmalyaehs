class DoctorMedicationModel {

  String userid,
      appno,
      medname,
      fromdate,
      todate,
      country,
      remarks,
      doctor,
      morning,
      afternoon,
      evening;
  DoctorMedicationModel();

  DoctorMedicationModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    appno = json['appno'];
    medname = json['medname'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    country = json['country'];
    remarks = json['remarks'];
    doctor = json['doctor'];
    morning = json['morning'];
    afternoon = json['afternoon'];
    evening = json['evening'];
  }
  /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    if (this.item_details != null) {
      data['item_details'] =
          this.item_details.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
  dynamic toJson() {
    var param =
    [
      {
        "userid": this.userid,
        "appno": this.appno,
        "medname": this.medname,
        "fromdate": this.fromdate,
        "todate": this.todate,
        "remarks": this.remarks,
        "doctor": this.doctor,
        "morning": this.morning,
        "afternoon": this.afternoon,
        "evening": this.evening
      }
    ];
    return param;
  }

  @override
  String toString() {
    return 'DoctorMedicationModel{userid: $userid, appno: $appno, medname: $medname, fromdate: $fromdate, todate: $todate, country: $country, remarks: $remarks, doctor: $doctor, morning: $morning, afternoon: $afternoon, evening: $evening}';
  }
}
