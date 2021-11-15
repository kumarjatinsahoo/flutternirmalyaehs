import 'package:flutter/cupertino.dart';
import 'package:user/models/TissueModel.dart';
import 'package:user/models/WitnessModel.dart';

import 'OrganModel.dart';
class MyPatientlistModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  MyPatientlistModel({this.body, this.message, this.code, this.total});

  MyPatientlistModel.fromJson(Map<String, dynamic> json) {
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
  String patName;
  String address;
  String mobile;
  String date;

  Body({this.patientId, this.patName, this.address, this.mobile, this.date});

  Body.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patName = json['patName'];
    address = json['address'];
    mobile = json['mobile'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['patName'] = this.patName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['date'] = this.date;
    return data;
  }
}