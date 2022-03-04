import 'package:flutter/cupertino.dart';
import 'package:user/models/TissueModel.dart';
import 'package:user/models/NomineeModel.dart';

import 'OrganModel.dart';
class BloodbanklistModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  BloodbanklistModel({this.body, this.message, this.code, this.total});

  BloodbanklistModel.fromJson(Map<String, dynamic> json) {
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
  String status;
  String bookedDate;
  String patientNote;
  String bloodBankId;
  String bloodBankName;
  String orderId;
  String bloodGrId;
  String bloodGrName;

  Body(
      {this.patientId,
        this.patientName,
        this.status,
        this.bookedDate,
        this.patientNote,
        this.bloodBankId,
        this.bloodBankName,
        this.orderId,
        this.bloodGrId,
        this.bloodGrName});

  Body.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patientName = json['patientName'];
    status = json['status'];
    bookedDate = json['bookedDate'];
    patientNote = json['patientNote'];
    bloodBankId = json['bloodBankId'];
    bloodBankName = json['bloodBankName'];
    orderId = json['orderId'];
    bloodGrId = json['bloodGrId'];
    bloodGrName = json['bloodGrName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['status'] = this.status;
    data['bookedDate'] = this.bookedDate;
    data['patientNote'] = this.patientNote;
    data['bloodBankId'] = this.bloodBankId;
    data['bloodBankName'] = this.bloodBankName;
    data['orderId'] = this.orderId;
    data['bloodGrId'] = this.bloodGrId;
    data['bloodGrName'] = this.bloodGrName;
    return data;
  }
}
