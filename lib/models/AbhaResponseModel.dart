class AbhaResponseModel {
  String token;
  String refreshToken;
  String healthIdNumber;
  String name;
  String gender;
  dynamic yearOfBirth;
  dynamic monthOfBirth;
  dynamic dayOfBirth;
  String firstName;
  dynamic healthId;
  String lastName;
  String middleName;
  dynamic stateCode;
  dynamic districtCode;
  String stateName;
  String districtName;
  String email;
  dynamic kycPhoto;
  String profilePhoto;
  dynamic mobile;
  List<String> authMethods;
  dynamic pincode;
  Tags tags;
  bool newOne;

  AbhaResponseModel(
      {this.token,
      this.refreshToken,
      this.healthIdNumber,
      this.name,
      this.gender,
      this.yearOfBirth,
      this.monthOfBirth,
      this.dayOfBirth,
      this.firstName,
      this.healthId,
      this.lastName,
      this.middleName,
      this.stateCode,
      this.districtCode,
      this.stateName,
      this.districtName,
      this.email,
      this.kycPhoto,
      this.profilePhoto,
      this.mobile,
      this.authMethods,
      this.pincode,
      this.tags,
      this.newOne});

  AbhaResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    healthIdNumber = json['healthIdNumber'];
    name = json['name'];
    gender = json['gender'];
    yearOfBirth = json['yearOfBirth'];
    monthOfBirth = json['monthOfBirth'];
    dayOfBirth = json['dayOfBirth'];
    firstName = json['firstName'];
    healthId = json['healthId'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    stateCode = json['stateCode'];
    districtCode = json['districtCode'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    email = json['email'];
    kycPhoto = json['kycPhoto'];
    profilePhoto = json['profilePhoto'];
    mobile = json['mobile'];
    authMethods = json['authMethods'].cast<String>();
    pincode = json['pincode'];
    // tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
    newOne = json['new'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['healthIdNumber'] = this.healthIdNumber;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['yearOfBirth'] = this.yearOfBirth;
    data['monthOfBirth'] = this.monthOfBirth;
    data['dayOfBirth'] = this.dayOfBirth;
    data['firstName'] = this.firstName;
    data['healthId'] = this.healthId;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['stateCode'] = this.stateCode;
    data['districtCode'] = this.districtCode;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['email'] = this.email;
    data['kycPhoto'] = this.kycPhoto;
    data['profilePhoto'] = this.profilePhoto;
    data['mobile'] = this.mobile;
    data['authMethods'] = this.authMethods;
    data['pincode'] = this.pincode;
    if (this.tags != null) {
      data['tags'] = this.tags.toJson();
    }
    data['new'] = this.newOne;
    return data;
  }
}

class Tags {
  //Tags({});

  Tags.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
