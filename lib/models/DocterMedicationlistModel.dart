import 'package:user/models/MedicinModel.dart';

class DoctorMedicationlistModel {
  String  userid,
      appno,
      medname,
      duration,
      remarks,
      doctor,
      morning,
      afternoon,
      evening;



  DoctorMedicationlistModel();

  DoctorMedicationlistModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    appno = json['appno'];
    medname = json['medname'];
    remarks = json['remarks'];
    duration = json['duration'];
    doctor = json['doctor'];
    morning = json['morning'];
    afternoon = json['afternoon'];
    evening = json['evening'];

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
        "remarks": this.remarks,
        "duration": this.duration,
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
    return 'DoctorMedicationModel{userid: $userid, appno: $appno, medname: $medname, duration: $duration, remarks: $remarks, doctor: $doctor, morning: $morning, afternoon: $afternoon, evening: $evening}';
  }
}
