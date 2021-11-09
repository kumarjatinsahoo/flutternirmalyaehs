import 'package:flutter/cupertino.dart';
import 'package:user/models/TissueModel.dart';
import 'package:user/models/WitnessModel.dart';

import 'OrganModel.dart';
 class AmbulancelistModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  AmbulancelistModel({this.body, this.message, this.code, this.total});

  AmbulancelistModel.fromJson(Map<String, dynamic> json) {
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
  String ambulanceId;
  String ambulanceName;
  Null orderId;

  Body(
      {this.patientId,
        this.patientName,
        this.fromLocation,
        this.toDestination,
        this.status,
        this.bookedDate,
        this.patientNote,
        this.ambulanceId,
        this.ambulanceName,
        this.orderId});

  Body.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patientName = json['patientName'];
    fromLocation = json['fromLocation'];
    toDestination = json['toDestination'];
    status = json['status'];
    bookedDate = json['bookedDate'];
    patientNote = json['patientNote'];
    ambulanceId = json['ambulanceId'];
    ambulanceName = json['ambulanceName'];
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
    data['ambulanceId'] = this.ambulanceId;
    data['ambulanceName'] = this.ambulanceName;
    data['orderId'] = this.orderId;
    return data;
  }
}
