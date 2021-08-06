class PatientListModel {
  List<Body> body;
  String message;
  String code;
  String total;

  PatientListModel({this.body, this.message, this.code, this.total});

  PatientListModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != String) {
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
    if (this.body != String) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }
}

class Body {
  String id;
  String title;
  String fName;
  String lName;
  String mobile;
  String country;
  String state;
  String gender;
  String age;
  String height;
  String weight;
  String email;
  String aadhar;
  String enteredBy;
  String profileImageName;
  String profileImageType;
  String userId;
  String countryCode;
  String stateCode;
  String password;
  String countryName;
  String stateName;
  String genderName;

  Body(
      {this.id,
        this.title,
        this.fName,
        this.lName,
        this.mobile,
        this.country,
        this.state,
        this.gender,
        this.age,
        this.height,
        this.weight,
        this.email,
        this.aadhar,
        this.enteredBy,
        this.profileImageName,
        this.profileImageType,
        this.userId,
        this.countryCode,
        this.stateCode,
        this.password,
        this.countryName,
        this.stateName,
        this.genderName});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fName = json['fName'];
    lName = json['lName'];
    mobile = json['mobile'];
    country = json['country'];
    state = json['state'];
    gender = json['gender'];
    age = json['age'].toString();
    height = json['height'].toString();
    weight = json['weight'].toString();
    email = json['email'];
    aadhar = json['aadhar'];
    enteredBy = json['enteredBy'];
    profileImageName = json['profileImageName'];
    profileImageType = json['profileImageType'];
    userId = json['userId'];
    countryCode = json['countryCode'];
    stateCode = json['stateCode'];
    password = json['password'];
    countryName = json['countryName'];
    stateName = json['stateName'];
    genderName = json['genderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['mobile'] = this.mobile;
    data['country'] = this.country;
    data['state'] = this.state;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['email'] = this.email;
    data['aadhar'] = this.aadhar;
    data['enteredBy'] = this.enteredBy;
    data['profileImageName'] = this.profileImageName;
    data['profileImageType'] = this.profileImageType;
    data['userId'] = this.userId;
    data['countryCode'] = this.countryCode;
    data['stateCode'] = this.stateCode;
    data['password'] = this.password;
    data['countryName'] = this.countryName;
    data['stateName'] = this.stateName;
    data['genderName'] = this.genderName;
    return data;
  }
}
