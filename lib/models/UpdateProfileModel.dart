class UpdateProfileModel {
  String eCardNo;
  String fName;
  String lName;
  String dob;
  String gender;
  String bloodGroup;
  String eName;
  String eRelation;
  String eMobile;
  String fDoctor;
  String speciality;
  String docMobile;
  String id;
  List<Null> profileImage;
  String profileImageName;
  String profileImageType;


  UpdateProfileModel(
      {this.eCardNo,
        this.fName,
        this.lName,
        this.dob,
        this.gender,
        this.bloodGroup,
        this.eName,
        this.eRelation,
        this.eMobile,
        this.fDoctor,
        this.speciality,
        this.id,
        this.docMobile,
        this.profileImage,
        this.profileImageName,
        this.profileImageType,
      });

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    eCardNo = json['eCardNo'];
    fName = json['fName'];
    lName = json['lName'];
    dob = json['dob'];
    gender = json['gender'];
    bloodGroup = json['bloodGroup'];
    eName = json['eName'];
    eRelation = json['eRelation'];
    eMobile = json['eMobile'];
    fDoctor = json['fDoctor'];
    id = json['id'];
    speciality = json['speciality'];
    docMobile = json['docMobile'];
    if (json['profileImage'] != null) {
      profileImage = new List<Null>();
      json['profileImage'].forEach((v) {
        //profileImage.add(new Null.fromJson(v));
      });
    }
    profileImageName = json['profileImageName'];
    profileImageType = json['profileImageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eCardNo'] = this.eCardNo;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['bloodGroup'] = this.bloodGroup;
    data['eName'] = this.eName;
    data['eRelation'] = this.eRelation;
    data['eMobile'] = this.eMobile;
    data['fDoctor'] = this.fDoctor;
    data['id'] = this.id;
    data['speciality'] = this.speciality;
    data['docMobile'] = this.docMobile;
    if (this.profileImage != null) {
      //data['profileImage'] = this.profileImage.map((v) => v.toJson()).toList();
    }
    data['profileImageName'] = this.profileImageName;
    data['profileImageType'] = this.profileImageType;
    return data;
  }
}