class UpdateProfileModel {
  String eCardNo;
  String fname;
  String lname;
  String dob;
  String bloodGroup;
  String address;
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
  String email;
  String pincode;
  String cityid;
  String distid;
  String stateid;
  String countryid;
  String mobile;
  String gender;

  UpdateProfileModel(
      {this.eCardNo,
      this.fname,
      this.lname,
      this.dob,
      this.bloodGroup,
      this.address,
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
      this.email,
      this.pincode,
      this.cityid,
      this.stateid,
      this.distid,
      this.countryid,
        this.mobile,
        this.gender
      });

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    eCardNo = json['eCardNo'];
    dob = json['dob'];
    fname = json['fname'];
    lname = json['lname'];
    bloodGroup = json['bloodGroup'];
    address = json['address'];
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
    email = json['email'];
    pincode = json['pincode'];
    cityid = json['cityid'];
    distid = json['distid'];
    stateid = json['stateid'];
    countryid = json['countryid'];
    mobile = json['mobile'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eCardNo'] = this.eCardNo;
    data['dob'] = this.dob;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['bloodGroup'] = this.bloodGroup;
    data['address'] = this.address;
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
    data['email'] = this.email;
    data['pincode'] = this.pincode;
    data['cityid'] = this.cityid;
    data['distid'] = this.distid;
    data['cityid'] = this.cityid;
    data['countryid'] = this.countryid;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    return data;
  }
}
