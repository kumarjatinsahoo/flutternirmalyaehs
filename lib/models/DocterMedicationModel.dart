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
    /* stateCode = json['stateCode'];
    countryCode = json['countryCode'];
    dob = json['dob'];
    profileImageType = json['profileImageType'];*/
  }

  dynamic toJson() {
    /* final Map<String, dynamic> data = new Map<String, dynamic>();
   // List<String> img=[this.profileImage];
    data['fName'] = this.fName;
    data['mobile'] = this.mobile;
    data['age'] = this.age;
    data['country'] = this.country;
    data['state'] = this.state;
    data['gender'] = this.gender;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['email'] = this.email;
    data['aadhar'] = this.aadhar;
    data['gender'] = this.gender;
    data['enteredBy'] = this.enteredBy;
   // data['profileImage'].map =img;
    data['profileImageType'] = this.profileImageType;
    data['stateCode']= this.stateCode;
    data['countryCode'] = this.countryCode;*/

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
