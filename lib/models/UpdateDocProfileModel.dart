class UpdateDocProfileModel {
  String dctrid;
  String dob;
  String gender;
  String educationid;
  String imaNo;
  String adhaarNo;
  String passportNo;
  String votterId;
  String liceneceNo;
  String panNo;

  /*List<Null> profileImage;
  String profileImageName;
  String profileImageType;*/

  UpdateDocProfileModel(
      {this.dctrid,
        this.dob,
        this.gender,
        this.educationid,
        this.imaNo,
        this.adhaarNo,
        this.passportNo,
        this.votterId,
        this.liceneceNo,
        this.panNo,

      });

  UpdateDocProfileModel.fromJson(Map<String, dynamic> json) {
    dctrid = json['dctrid'];
    dob = json['dob'];
    gender = json['gender'];
    educationid = json['educationid'];
    imaNo = json['imaNo'];
    adhaarNo = json['adhaarNo'];
    passportNo = json['passportNo'];
    votterId = json['votterId'];
    liceneceNo = json['liceneceNo'];
    panNo = json['panNo'];

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
    data['imaNo'] = this.imaNo;
    data['adhaarNo'] = this.adhaarNo;
    data['passportNo'] = this.passportNo;
    data['votterId'] = this.votterId;
    data['liceneceNo'] = this.liceneceNo;
    data['panNo'] = this.panNo;
    /*  if (this.profileImage != null) {
      //data['profileImage'] = this.profileImage.map((v) => v.toJson()).toList();
    }
    data['profileImageName'] = this.profileImageName;
    data['profileImageType'] = this.profileImageType;*/
    return data;
  }
}