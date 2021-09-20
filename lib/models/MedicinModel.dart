import 'package:flutter/cupertino.dart';

class MedicinlistModel{
  String userid,
      appno,
      medname, mednaid, duration, remarks, doctor, morning, afternoon, evening;

  MedicinlistModel();

  MedicinlistModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    appno = json['appno'];
    medname = json['medname'];
    mednaid = json['mednaid'];
    duration = json['duration'];
    remarks = json['remarks'];
    doctor = json['doctor'];
    morning = json['morning'];
    afternoon = json['afternoon'];
    evening = json['evening'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid.toString();
    data['appno'] = this.appno.toString();
    data['medname'] = this.medname.toString();
    data['mednaid'] = this.mednaid.toString();
    data['duration'] = this.duration.toString();
    data['remarks'] = this.remarks.toString();
    data['doctor'] = this.doctor.toString();
    data['morning'] = this.morning.toString();
    data['afternoon'] = this.afternoon.toString();
    data['evening'] = this.evening.toString();
    return data;
  }
  @override
  String toString() {
    return 'ItemModel{userid: $userid, appno: $appno, medname: $medname, mednaid: $mednaid, duration: $duration, remarks: $remarks, doctor: $doctor, morning: $morning, afternoon: $afternoon, evening: $evening}';
  }
}

