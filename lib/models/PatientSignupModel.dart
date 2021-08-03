class PatientSignupModel{
  String fName,
      mobile,
      age,
      country,
      state,
      gender,
      height,
      weight,
      email,
      aadhar,
      profileImage,
      enteredBy,
      profileImageType,
      countryCode,
      stateCode;

  PatientSignupModel();
  PatientSignupModel.fromJson(Map<String, dynamic> json) {
    fName = json['fName'];
    mobile = json['mobile'];
    age = json['age'];
    country = json['country'];
    state = json['state'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    email = json['email'];
    aadhar = json['aadhar'];
    enteredBy = json['enteredBy'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    stateCode = json['stateCode'];
    countryCode = json['countryCode'];

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

    var param={
      "fName": this.fName,
      "mobile": this.mobile,
      "age": this.age,
      "country": this.country,
      "state": this.state,
      "gender": (this.gender=="Female")?"2":"1",
      "height": this.height,
      "weight": this.weight,
      "email": this.email,
      "aadhar": this.aadhar,
      "enteredBy": this.enteredBy,
      "profileImageType": this.profileImageType,
      "stateCode": this.stateCode,
      "countryCode": this.countryCode,
      "profileImage":[this.profileImage]
    };

    return param;
  }
  @override
  String toString() {
    return 'PatientSignupModel{fName: $fName, mobile: $mobile, age: $age, country: $country, state: $state, gender: $gender, height: $height, weight: $weight, email: $email, aadhar: $aadhar, enteredBy: $enteredBy, profileImageType: $profileImageType, countryCode: $countryCode, stateCode: $stateCode}';
  }
}

