class ProfileModel {
  Body body;
  String message;
  String code;
  Null total;

  ProfileModel({this.body, this.message, this.code, this.total});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    message = json['message'];
    code = json['code'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }
}

class Body {
  String id;
  String eCardNo;
  String title;
  String fullName;
  String fName;
  String lName;
  String mobile;
  String bloodGroup;
  String eRelation;
  String eMobile;
  String fDoctor;
  String speciality;
  String docMobile;
  String eName;
  String country;
  String state;
  String gender;
  int age;
  double height;
  int weight;
  String email;
  String aadhar;
  String enteredBy;
  //List<Null> profileImage;
  String profileImageName;
  String profileImageType;
  String userId;
  String countryCode;
  String stateCode;
  String password;
  String countryName;
  String stateName;
  String genderName;
  String dob;
  String ageYears;

  Body(
      {
        this.id,
        this.eCardNo,
        this.title,
        this.fullName,
        this.fName,
        this.lName,
        this.mobile,
        this.bloodGroup,
        this.eRelation,
        this.fDoctor,
        this.eMobile,
        this.speciality,
        this.docMobile,
        this.eName,
        this.country,
        this.state,
        this.gender,
        this.age,
        this.height,
        this.weight,
        this.email,
        this.aadhar,
        this.enteredBy,
       // this.profileImage,
        this.profileImageName,
        this.profileImageType,
        this.userId,
        this.countryCode,
        this.stateCode,
        this.password,
        this.countryName,
        this.stateName,
        this.genderName,
        this.dob,
        this.ageYears});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['eCardNo'];
    title = json['title'];
    fullName = json['fullName'];
    fName = json['fName'];
    lName = json['lName'];
    mobile = json['mobile'];
    bloodGroup = json['bloodGroup'];
    eRelation = json['eRelation'];
    eMobile = json['eMobile'];
    fDoctor = json['fDoctor'];
    speciality = json['speciality'];
    docMobile = json['docMobile'];
    eName = json['eName'];
    country = json['country'];
    state = json['state'];
    gender = json['gender'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    email = json['email'];
    aadhar = json['aadhar'];
    enteredBy = json['enteredBy'];
    /*if (json['profileImage'] != null) {
      profileImage = new List<Null>();
      json['profileImage'].forEach((v) {
        //profileImage.add(new Null.fromJson(v));
      });
    }*/
    profileImageName = json['profileImageName'];
    profileImageType = json['profileImageType'];
    userId = json['userId'];
    countryCode = json['countryCode'];
    bloodGroup = json['bloodGroup'];
    stateCode = json['stateCode'];
    password = json['password'];
    countryName = json['countryName'];
    stateName = json['stateName'];
    genderName = json['genderName'];
    dob = json['dob'];
    ageYears = json['ageYears'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eCardNo'] = this.id;
    data['title'] = this.title;
    data['fullName'] = this.fullName;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['mobile'] = this.mobile;
    data['bloodGroup'] = this.bloodGroup;
    data['eRelation'] = this.eRelation;
    data['eMobile'] = this.eMobile;
    data['fDoctor'] = this.fDoctor;
    data['speciality'] = this.speciality;
    data['docMobile'] = this.docMobile;
    data['eName'] = this.eName;
    data['country'] = this.country;
    data['state'] = this.state;
    data['gender'] = this.gender;
    data['age'] = this.age.toString();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['email'] = this.email;
    data['aadhar'] = this.aadhar;
    data['enteredBy'] = this.enteredBy;
    /*if (this.profileImage != null) {
      //data['profileImage'] = this.profileImage.map((v) => v.toJson()).toList();
    }*/
    data['profileImageName'] = this.profileImageName;
    data['profileImageType'] = this.profileImageType;
    data['userId'] = this.userId;
    data['countryCode'] = this.countryCode;
    data['stateCode'] = this.stateCode;
    data['password'] = this.password;
    data['countryName'] = this.countryName;
    data['stateName'] = this.stateName;
    data['genderName'] = this.genderName;
    data['dob'] = this.dob;
    data['ageYears'] = this.ageYears;
    return data;
  }
}