/*
class ProfileModel1 {
  Body body;
  String message;
  String code;
 // Null total;

  ProfileModel1({this.body, this.message, this.code});

  ProfileModel1.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    message = json['message'];
    code = json['code'];
  //  total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
   // data['total'] = this.total;
    return data;
  }
}

class Body {
  String id;
  String useraccount;
  String name;
  String profileimage;
  String gender;
  String mobile;
  String birthdate;
  String email;
  String state;
  String country;
  String education;
  String speciality;
  String organization;
  String aadhaar;
  String imano;
  String pancardno;
  String passportno;
  String votercardno;
  String licenceno;
  String role;

  Body(
      {this.id,
        this.useraccount,
        this.name,
        this.profileimage,
        this.gender,
        this.mobile,
        this.birthdate,
        this.email,
        this.state,
        this.country,
        this.education,
        this.speciality,
        this.organization,
        this.aadhaar,
        this.imano,
        this.pancardno,
        this.passportno,
        this.votercardno,
        this.licenceno,
        this.role});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    useraccount = json['useraccount'];
    name = json['name'];
    profileimage = json['profileimage'];
    gender = json['gender'];
    mobile = json['mobile'];
    birthdate = json['birthdate'];
    email = json['email'];
    state = json['state'];
    country = json['country'];
    education = json['education'];
    speciality = json['speciality'];
    organization = json['organization'];
    aadhaar = json['aadhaar'];
    imano = json['imano'];
    pancardno = json['pancardno'];
    passportno = json['passportno'];
    votercardno = json['votercardno'];
    licenceno = json['licenceno'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['useraccount'] = this.useraccount;
    data['name'] = this.name;
    data['profileimage'] = this.profileimage;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['birthdate'] = this.birthdate;
    data['email'] = this.email;
    data['state'] = this.state;
    data['country'] = this.country;
    data['education'] = this.education;
    data['speciality'] = this.speciality;
    data['organization'] = this.organization;
    data['aadhaar'] = this.aadhaar;
    data['imano'] = this.imano;
    data['pancardno'] = this.pancardno;
    data['passportno'] = this.passportno;
    data['votercardno'] = this.votercardno;
    data['licenceno'] = this.licenceno;
    data['role'] = this.role;
    return data;
  }
}
*/
class ProfileModel1 {
  Body body;
  String message;
  String code;
  Null total;

  ProfileModel1({this.body, this.message, this.code, this.total});

  ProfileModel1.fromJson(Map<String, dynamic> json) {
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
  String useraccount;
  String name;
  String profileimage;
  String gender;
  String mobile;
  String birthdate;
  String email;
  String state;
  String country;
  String education;
  String speciality;
  String organization;
  String aadhaar;
  String imano;
  String pancardno;
  String passportno;
  String votercardno;
  String licenceno;
  String role;
  String bldGr;
  String gendername;
  String bldGrname;
  String licenseauthority;
  String address;
  String experience;

  Body(
      {this.id,
        this.useraccount,
        this.name,
        this.profileimage,
        this.gender,
        this.mobile,
        this.birthdate,
        this.email,
        this.state,
        this.country,
        this.education,
        this.speciality,
        this.organization,
        this.aadhaar,
        this.imano,
        this.pancardno,
        this.passportno,
        this.votercardno,
        this.licenceno,
        this.role,
        this.bldGr,
        this.gendername,
        this.bldGrname,
        this.licenseauthority,
        this.address,
        this.experience});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    useraccount = json['useraccount'];
    name = json['name'];
    profileimage = json['profileimage'];
    gender = json['gender'];
    mobile = json['mobile'];
    birthdate = json['birthdate'];
    email = json['email'];
    state = json['state'];
    country = json['country'];
    education = json['education'];
    speciality = json['speciality'];
    organization = json['organization'];
    aadhaar = json['aadhaar'];
    imano = json['imano'];
    pancardno = json['pancardno'];
    passportno = json['passportno'];
    votercardno = json['votercardno'];
    licenceno = json['licenceno'];
    role = json['role'];
    bldGr = json['bldGr'];
    gendername = json['gendername'];
    bldGrname = json['bldGrname'];
    licenseauthority = json['licenseauthority'];
    address = json['address'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['useraccount'] = this.useraccount;
    data['name'] = this.name;
    data['profileimage'] = this.profileimage;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['birthdate'] = this.birthdate;
    data['email'] = this.email;
    data['state'] = this.state;
    data['country'] = this.country;
    data['education'] = this.education;
    data['speciality'] = this.speciality;
    data['organization'] = this.organization;
    data['aadhaar'] = this.aadhaar;
    data['imano'] = this.imano;
    data['pancardno'] = this.pancardno;
    data['passportno'] = this.passportno;
    data['votercardno'] = this.votercardno;
    data['licenceno'] = this.licenceno;
    data['role'] = this.role;
    data['bldGr'] = this.bldGr;
    data['gendername'] = this.gendername;
    data['bldGrname'] = this.bldGrname;
    data['licenseauthority'] = this.licenseauthority;
    data['address'] = this.address;
    data['experience'] = this.experience;
    return data;
  }
}