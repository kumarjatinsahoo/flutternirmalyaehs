import 'package:flutter/cupertino.dart';

class NomineeModel {
  String memberNo,
  salutation,
  first_Name,
  middle_Name,
  last_Name,
  gender,
  dateOfBirth,
  relation_Code,
  marital_Status,
  height,
  weight,
  occupation,
  primaryMember;

  NomineeModel();

  NomineeModel.fromJson(Map<String, dynamic> json) {
    memberNo = json['memberNo'];
    salutation = json['salutation'];
    first_Name = json['first_Name'];
    middle_Name = json['middle_Name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    relation_Code = json['relation_Code'];
    height = json['height'];
    weight = json['weight'];
    occupation = json['occupation'];
    primaryMember = json['primaryMember'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberNo'] = this.memberNo.toString();
    data['salutation'] = this.salutation.toString();
    data['first_Name'] = this.first_Name.toString();
    data['last_Name'] = this.last_Name.toString();
    data['gender'] = this.gender.toString();
    data['dateOfBirth'] = this.dateOfBirth.toString();
    data['relation_Code'] = this.relation_Code.toString();
    data['height'] = this.height.toString();
    data['weight'] = this.weight.toString();
    data['occupation'] = this.occupation.toString();
    data['primaryMember'] = this.primaryMember.toString();
    return data;
  }

  Map<String, dynamic> toJson1() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberNo']  = this.memberNo.toString();
    data['salutation'] = this.salutation.toString();
    data['first_Name'] = this.first_Name.toString();
    data['last_Name'] = this.last_Name.toString();
    data['gender'] = this.gender.toString();
    data['dateOfBirth'] = this.dateOfBirth.toString();
    data['relation_Code'] = this.relation_Code.toString();
    data['height'] = this.height.toString();
    data['weight'] = this.weight.toString();
    data['occupation'] = this.occupation.toString();
    data['primaryMember'] = this.primaryMember.toString();
    return data;
  }
}
