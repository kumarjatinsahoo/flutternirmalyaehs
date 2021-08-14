class LabSignupModel {
  String organizationid;
  String titleid;
  String docname;
  String educationid;
  String speciality;
  String dob;
  String bloodgroup;
  String gender;
  String address;
  String countryid;
  String stateid;
  String districtid;
  String cityid;
  String pincode;
  String mobno;
  String email;
  String alteremail;
  String homephone;
  String officephone;
  String role;

  LabSignupModel(
      {this.organizationid,
        this.titleid,
        this.docname,
        this.educationid,
        this.speciality,
        this.dob,
        this.bloodgroup,
        this.gender,
        this.address,
        this.countryid,
        this.stateid,
        this.districtid,
        this.cityid,
        this.pincode,
        this.mobno,
        this.email,
        this.alteremail,
        this.homephone,
        this.officephone,
        this.role
      });

  LabSignupModel.fromJson(Map<String, dynamic> json) {
    organizationid = json['organizationid'];
    titleid = json['titleid'];
    docname = json['docname'];
    educationid = json['educationid'];
    speciality = json['speciality'];
    dob = json['dob'];
    bloodgroup = json['bloodgroup'];
    gender = json['gender'];
    address = json['address'];
    countryid = json['countryid'];
    stateid = json['stateid'];
    districtid = json['districtid'];
    cityid = json['cityid'];
    pincode = json['pincode'];
    mobno = json['mobno'];
    email = json['email'];
    alteremail = json['alteremail'];
    homephone = json['homephone'];
    officephone = json['officephone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organizationid'] = this.organizationid;
    data['titleid'] = this.titleid;
    data['docname'] = this.docname;
    data['educationid'] = this.educationid;
    data['speciality'] = this.speciality;
    data['dob'] = this.dob;
    data['bloodgroup'] = this.bloodgroup;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['countryid'] = this.countryid;
    data['stateid'] = this.stateid;
    data['districtid'] = this.districtid;
    data['cityid'] = this.cityid;
    data['pincode'] = this.pincode;
    data['mobno'] = this.mobno;
    data['email'] = this.email;
    data['alteremail'] = this.alteremail;
    data['homephone'] = this.homephone;
    data['officephone'] = this.officephone;
    data['role'] = this.role;
    return data;
  }
  @override
  String toString() {
    return 'DoctorRegistrationModel{ organizationid: $organizationid, titleid: $titleid,'
        ' docname: $docname, educationid: $educationid, speciality: $speciality,'
        ' dob: $dob, bloodgroup: $bloodgroup, gender: $gender,address: $address, countryid: $countryid,'
        ' stateid: $stateid, districtid: $districtid, cityid: $cityid,pincode: $pincode,'
        'homephone: $homephone,officephone: $officephone,mobno: $mobno,email: $email,'
        'alteremail: $alteremail,role:$role}';
  }
}