import 'package:flutter/cupertino.dart';
import 'package:user/models/TissueModel.dart';
import 'package:user/models/WitnessModel.dart';

import 'OrganModel.dart';



class AddOrganDonModel {
  String patientId;
  String donorName;
  String donorType;
  String typeUserName;
  String dob;
  String age;
  String bldGr;
  String mob;
  String email;
  String address;



 List<String> organList;
 List<String> tissueList;
  List<WitnessModel> witnessList;
  AddOrganDonModel();



  AddOrganDonModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    address = json['address'];
    donorType = json['donorType'];
    typeUserName = json['typeUserName'];
    dob = json['dob'];
    age = json['age'];
    bldGr = json['bldGr'];
    mob = json['mob'];
    email = json['email'];
    address = json['address'];

    if (json['item_details'] != null) {
      witnessList = new List<WitnessModel>();
      json['item_details'].forEach((v) {
        witnessList.add(new WitnessModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['address'] = this.address;
    data['donorType'] = this.donorType;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['bldGr'] = this.bldGr;
    data['mob'] = this.mob;
    data['address'] = this.address;

    if (this.witnessList != null) {
      data['item_details'] =
          this.witnessList.map((v) => v.toJson()).toList();
    }
    if (this.organList != null) {
      data['organList'] =
          this.organList.map((v) => v).toList();
    }

    if (this.tissueList != null) {
      data['tissueList'] =
          this.tissueList.map((v) => v).toList();
    }
    return data;
  }


}
