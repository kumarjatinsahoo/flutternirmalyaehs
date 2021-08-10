// class UserRegistrationModel {
//   String title;
//   String fName;
//   String lName;
//   String mobile;
//   String country;
//   String state;
//   int gender;
//   List<Null> profileImage;
//   int age;
//   String ageYears;
//   String countryCode;
//   String stateCode;
//   String dob;
//
//   UserRegistrationModel(
//       {this.title,
//         this.fName,
//         this.lName,
//         this.mobile,
//         this.country,
//         this.state,
//         this.gender,
//         this.profileImage,
//         this.age,
//         this.ageYears,
//         this.countryCode,
//         this.stateCode,
//         this.dob});
//
//   UserRegistrationModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     fName = json['fName'];
//     lName = json['lName'];
//     mobile = json['mobile'];
//     country = json['country'];
//     state = json['state'];
//     gender = json['gender'];
//     if (json['profileImage'] != null) {
//       profileImage = new List<Null>();
//       json['profileImage'].forEach((v) {
//         profileImage.add(new Null.fromJson(v));
//       });
//     }
//     age = json['age'];
//     ageYears = json['ageYears'];
//     countryCode = json['countryCode'];
//     stateCode = json['stateCode'];
//     dob = json['dob'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['fName'] = this.fName;
//     data['lName'] = this.lName;
//     data['mobile'] = this.mobile;
//     data['country'] = this.country;
//     data['state'] = this.state;
//     data['gender'] = this.gender;
//     if (this.profileImage != null) {
//       data['profileImage'] = this.profileImage.map((v) => v.toJson()).toList();
//     }
//     data['age'] = this.age;
//     data['ageYears'] = this.ageYears;
//     data['countryCode'] = this.countryCode;
//     data['stateCode'] = this.stateCode;
//     data['dob'] = this.dob;
//     return data;
//   }
// }
class UserRegistrationModel{
  String title,
      fName,
      lName,
      mobile,
      age,
      country,
      state,
      gender,
      profileImage,
      ageYears,
      countryCode,
      stateCode,
      dob,profileImageType;

  UserRegistrationModel();
  UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    fName = json['fName'];
    lName = json['lName'];
    mobile = json['mobile'];
    age = json['age'];
    country = json['country'];
    state = json['state'];
    gender = json['gender'];
    profileImage = json['profileImage'];
    ageYears = json['ageYears'];
    stateCode = json['stateCode'];
    countryCode = json['countryCode'];
    dob = json['dob'];
    profileImageType = json['profileImageType'];

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
      "title": this.title,
      "fName": this.fName,
      "lName": this.lName,
      "mobile": this.mobile,
      "age": this.age,
      "country": this.country,
      "state": this.state,
      "gender": this.gender,
      "dob": this.dob,
      "ageYears": this.ageYears,
      "stateCode": this.stateCode,
      "countryCode": this.countryCode,
      "profileImageType": this.profileImageType,
      "profileImage":[this.profileImage]
    };

    return param;
  }
  @override
  String toString() {
    return 'UserRegistrationModel{title: $title, fName: $fName, lName: $lName, mobile: $mobile, age: $age, country: $country, state: $state, gender: $gender, profileImage: $profileImage, ageYears: $ageYears, countryCode: $countryCode, stateCode: $stateCode, dob: $dob}';
  }
}

