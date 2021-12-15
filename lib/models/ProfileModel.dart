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
  String eCardNo;
  String profileImage;
  String fullName;
  String dob;
  String bloodGroup;
  String gender;
  String mobile;
  String eName;
  String eRelation;
  String eMobile;
  String fDoctor;
  String speciality;
  String docMobile;
  String title;
  String fName;
  String lName;
  String profileImageName;
  String profileImageType;
  List<Null> pImage;
  String address;
  String pAddress;
  String genderId;
  String eRelationId;
  String specialityId;
  String bloodGroupId;
  String maritialstatus;
  String occupation;
  String qualification;
  String specialization;
  String pancardno;
  String passportno;
  String adharno;
  String votercardno;
  String licenceno;
  String licenceauthority;
  List<EmergenceList> emergenceList;
  List<FamilyDoctorList> familyDoctorList;
  List<FamilyDetailsList> familyDetailsList;

  Body(
      {this.eCardNo,
        this.profileImage,
        this.fullName,
        this.dob,
        this.bloodGroup,
        this.gender,
        this.mobile,
        this.eName,
        this.eRelation,
        this.eMobile,
        this.fDoctor,
        this.speciality,
        this.docMobile,
        this.title,
        this.fName,
        this.lName,
        this.profileImageName,
        this.profileImageType,
        this.pImage,
        this.address,
        this.pAddress,
        this.genderId,
        this.eRelationId,
        this.specialityId,
        this.bloodGroupId,
        this.maritialstatus,
        this.occupation,
        this.qualification,
        this.specialization,
        this.pancardno,
        this.passportno,
        this.adharno,
        this.votercardno,
        this.licenceno,
        this.licenceauthority,
        this.emergenceList,
        this.familyDoctorList,
        this.familyDetailsList});

  Body.fromJson(Map<String, dynamic> json) {
    eCardNo = json['eCardNo'];
    profileImage = json['profileImage'];
    fullName = json['fullName'];
    dob = json['dob'];
    bloodGroup = json['bloodGroup'];
    gender = json['gender'];
    mobile = json['mobile'];
    eName = json['eName'];
    eRelation = json['eRelation'];
    eMobile = json['eMobile'];
    fDoctor = json['fDoctor'];
    speciality = json['speciality'];
    docMobile = json['docMobile'];
    title = json['title'];
    fName = json['fName'];
    lName = json['lName'];
    profileImageName = json['profileImageName'];
    profileImageType = json['profileImageType'];
   /* if (json['pImage'] != null) {
      pImage = new List<Null>();
      json['pImage'].forEach((v) {
        pImage.add(new Null.fromJson(v));
      });
    }*/
    address = json['address'];
    pAddress = json['pAddress'];
    genderId = json['genderId'];
    eRelationId = json['eRelationId'];
    specialityId = json['specialityId'];
    bloodGroupId = json['bloodGroupId'];
    maritialstatus = json['maritialstatus'];
    occupation = json['occupation'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    pancardno = json['pancardno'];
    passportno = json['passportno'];
    adharno = json['adharno'];
    votercardno = json['votercardno'];
    licenceno = json['licenceno'];
    licenceauthority = json['licenceauthority'];
    if (json['emergenceList'] != null) {
      emergenceList = new List<EmergenceList>();
      json['emergenceList'].forEach((v) {
        emergenceList.add(new EmergenceList.fromJson(v));
      });
    }
    if (json['familyDoctorList'] != null) {
      familyDoctorList = new List<FamilyDoctorList>();
      json['familyDoctorList'].forEach((v) {
        familyDoctorList.add(new FamilyDoctorList.fromJson(v));
      });
    }
    /*if (json['familyDetailsList'] != null) {
      familyDetailsList = new List<Null>();
      json['familyDetailsList'].forEach((v) {
        familyDetailsList.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eCardNo'] = this.eCardNo;
    data['profileImage'] = this.profileImage;
    data['fullName'] = this.fullName;
    data['dob'] = this.dob;
    data['bloodGroup'] = this.bloodGroup;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['eName'] = this.eName;
    data['eRelation'] = this.eRelation;
    data['eMobile'] = this.eMobile;
    data['fDoctor'] = this.fDoctor;
    data['speciality'] = this.speciality;
    data['docMobile'] = this.docMobile;
    data['title'] = this.title;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['profileImageName'] = this.profileImageName;
    data['profileImageType'] = this.profileImageType;
   /* if (this.pImage != null) {
      data['pImage'] = this.pImage.map((v) => v.toJson()).toList();
    }*/
    data['address'] = this.address;
    data['pAddress'] = this.pAddress;
    data['genderId'] = this.genderId;
    data['eRelationId'] = this.eRelationId;
    data['specialityId'] = this.specialityId;
    data['bloodGroupId'] = this.bloodGroupId;
    data['maritialstatus'] = this.maritialstatus;
    data['occupation'] = this.occupation;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['pancardno'] = this.pancardno;
    data['passportno'] = this.passportno;
    data['adharno'] = this.adharno;
    data['votercardno'] = this.votercardno;
    data['licenceno'] = this.licenceno;
    data['licenceauthority'] = this.licenceauthority;
    if (this.emergenceList != null) {
      data['emergenceList'] =
          this.emergenceList.map((v) => v.toJson()).toList();
    }
    if (this.familyDoctorList != null) {
      data['familyDoctorList'] =
          this.familyDoctorList.map((v) => v.toJson()).toList();
    }
   /* if (this.familyDetailsList != null) {
      data['familyDetailsList'] =
          this.familyDetailsList.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class FamilyDetailsList {
}

class FamilyDoctorList {
  String id;
  String name;
  String mobile;
  String type;
  String typeid;

  FamilyDoctorList({this.id, this.name, this.mobile, this.type, this.typeid});
  FamilyDoctorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    type = json['type'];
    typeid = json['typeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['type'] = this.type;
    data['typeid'] = this.typeid;
    return data;
  }

}


class EmergenceList {
  String id;
  String name;
  String mobile;
  String type;
  String typeid;

  EmergenceList({this.id, this.name, this.mobile, this.type, this.typeid});

  EmergenceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    type = json['type'];
    typeid = json['typeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['type'] = this.type;
    data['typeid'] = this.typeid;
    return data;
  }
}













/*
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
  String address;
  String pAddress;
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
  String genderId;
  String eRelationId;
  String specialityId;
  String bloodGroupId;
  String profileImage;
  String maritialstatus;
  String occupation;
  String qualification;
  String specialization;
  String pancardno;
  String passportno;
  String adharno;
  String votercardno;
  String licenceno;
  String licenceauthority;

  Body({
    this.id,
    this.eCardNo,
    this.title,
    this.fullName,
    this.fName,
    this.lName,
    this.mobile,
    this.address,
    this.pAddress,
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
    this.genderId,
    this.eRelationId,
    this.specialityId,
    this.bloodGroupId,
    this.ageYears,
    this.maritialstatus,
    this.occupation,
    this.qualification,
    this.specialization,
    this.pancardno,
    this.passportno,
    this.adharno,
    this.votercardno,
    this.licenceno,
    this.licenceauthority,
  });

  Body.fromJson(Map<String, dynamic> json) {
    id = json['eCardNo'];
    title = json['title'];
    fullName = json['fullName'];
    fName = json['fName'];
    lName = json['lName'];
    mobile = json['mobile'];
    address = json['address'];
    pAddress = json['pAddress'];
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
    genderId = json['genderId'];
    eRelationId = json['eRelationId'];
    bloodGroupId = json['bloodGroupId'];

    */
/*if (json['profileImage'] != null) {
      profileImage = new List<Null>();
      json['profileImage'].forEach((v) {
        //profileImage.add(new Null.fromJson(v));
      });
    }*//*

    profileImageName = json['profileImageName'];
    profileImage = json['profileImage'];
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
    maritialstatus = json['maritialstatus'];
    occupation = json['occupation'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    pancardno = json['pancardno'];
    passportno = json['passportno'];
    adharno = json['adharno'];
    votercardno = json['votercardno'];
    licenceno = json['licenceno'];
    licenceauthority = json['licenceauthority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eCardNo'] = this.id;
    data['title'] = this.title;
    data['fullName'] = this.fullName;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['pAddress'] = this.pAddress;
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
    data['genderId'] = this.genderId;
    data['eRelationId'] = this.eRelationId;
    data['specialityId'] = this.specialityId;
    data['bloodGroupId'] = this.bloodGroupId;

    */
/*if (this.profileImage != null) {
      //data['profileImage'] = this.profileImage.map((v) => v.toJson()).toList();
    }*//*

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
    data['maritialstatus'] = this.maritialstatus;
    data['occupation'] = this.occupation;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['pancardno'] = this.pancardno;
    data['passportno'] = this.passportno;
    data['adharno'] = this.adharno;
    data['passportno'] = this.passportno;
    data['votercardno'] = this.votercardno;
    data['licenceno'] = this.licenceno;
    data['licenceauthority'] = this.licenceauthority;
    return data;
  }
}
*/
