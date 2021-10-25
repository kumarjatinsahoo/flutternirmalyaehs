import 'package:flutter/cupertino.dart';

class WitnessModel {
  String donorName,
      donorType,
      typeUserName,relation , age,mob,address,email;

  WitnessModel();
  WitnessModel.fromJson(Map<String, dynamic> json) {
    donorName = json['donorName'];
    donorType = json['donorType'];
    typeUserName = json['typeUserName'];
    age = json['age'];
    address = json['address'];
    email = json['email'];
    relation = json['relation'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['donorName'] = this.donorName.toString();
    data['donorType'] = this.donorType.toString();
    data['typeUserName'] = this.typeUserName.toString();
    data['age'] = this.age.toString();
    data['address'] = this.address.toString();
    data['email'] = this.email.toString();
    data['relation'] = this.relation.toString();
    return data;
  }


}
