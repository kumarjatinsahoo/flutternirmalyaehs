import 'package:flutter/cupertino.dart';
import 'package:user/models/WitnessModel.dart';



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



 // List<ItemModel> organList;
 // List<ItemModel> tissueList;
  List<WitnessModel> witnessList;
  AddOrganDonModel();



  AddOrganDonModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    address = json['address'];
    donorType = json['donorType'];

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

    if (this.witnessList != null) {
      data['item_details'] =
          this.witnessList.map((v) => v.toJson()).toList();
    }
    return data;
  }


}
