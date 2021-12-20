class UpdateDocProfileModel {
  String dctrid;
  String dob;
  String gender;
  String educationid;
  String experience;
  String imaNo;
  String adhaarNo;
  String passportNo;
  String votterId;
  String liceneceNo;
  String liceneceAuthority;
  String panNo;
  String countryid;
  String stateid;
  String districtid;
  String cityid;
  String address;
  String pincode;
  String mobno;
  String email;
  String bloodgroup;

  /*List<Null> profileImage;
  String profileImageName;
  String profileImageType;*/

  UpdateDocProfileModel(
      {this.dctrid,
        this.dob,
        this.gender,
        this.educationid,
        this.experience,
        this.imaNo,
        this.adhaarNo,
        this.passportNo,
        this.votterId,
        this.liceneceNo,
        this.liceneceAuthority,
        this.countryid,
        this.panNo,
        this.stateid,
        this.districtid,
        this.cityid,
        this.address,
        this.pincode,
        this.mobno,
        this.email,
        this.bloodgroup,

      });

  UpdateDocProfileModel.fromJson(Map<String, dynamic> json) {
    dctrid = json['dctrid'];
    dob = json['dob'];
    gender = json['gender'];
    educationid = json['educationid'];
    experience = json['experience'];
    imaNo = json['imaNo'];
    adhaarNo = json['adhaarNo'];
    passportNo = json['passportNo'];
    votterId = json['votterId'];
    liceneceNo = json['liceneceNo'];
    liceneceAuthority = json['liceneceAuthority'];
    panNo = json['panNo'];
    countryid = json['countryid'];
    stateid  = json['stateid'];
    districtid  = json['districtid'];
    cityid  = json['cityid'];
    address  = json['address'];
    pincode  = json['pincode'];
    mobno  = json['mobno'];
    email  = json['email'];
    bloodgroup  = json['bloodgroup'];

    /*if (json['profileImage'] != null) {
      profileImage = new List<Null>();
      json['profileImage'].forEach((v) {
        //profileImage.add(new Null.fromJson(v));
      });
    }
    profileImageName = json['profileImageName'];
    profileImageType = json['profileImageType'];*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dctrid'] = this.dctrid;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['educationid'] = this.educationid;
    data['experience'] = this.experience;
    data['imaNo'] = this.imaNo;
    data['adhaarNo'] = this.adhaarNo;
    data['passportNo'] = this.passportNo;
    data['votterId'] = this.votterId;
    data['liceneceNo'] = this.liceneceNo;
    data['liceneceAuthority'] = this.liceneceAuthority;
    data['panNo'] = this.panNo;
    data['countryid'] = this.countryid;
    data['stateid'] = this.stateid;
    data['districtid'] = this.districtid;
    data['cityid'] = this.cityid;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['mobno'] = this.mobno;
    data['email'] = this.email;
    data['bloodgroup'] = this.bloodgroup;
    /*  if (this.profileImage != null) {
      //data['profileImage'] = this.profileImage.map((v) => v.toJson()).toList();
    }
    data['profileImageName'] = this.profileImageName;
    data['profileImageType'] = this.profileImageType;*/
    return data;
  }
}