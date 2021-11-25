class PharmacyRegistrationModel {
  String organizationid;
  String titleid;
  String docname;
  String experience;
  String speciality;
  String gender;
  String address;
  String countryid;
  String stateid;
  String districtid;
  String cityid;
  String pincode;
  String mobno;
  String email;
  String role;
  String documentUpload;
  String documentExt;

  PharmacyRegistrationModel({this.organizationid,
    this.titleid,
    this.docname,
    this.experience,
    this.speciality,
    this.gender,
    this.address,
    this.countryid,
    this.stateid,
    this.districtid,
    this.cityid,
    this.pincode,
    this.mobno,
    this.email,
    this.role});

  PharmacyRegistrationModel.fromJson(Map<String, dynamic> json) {
    organizationid = json['organizationid'];
    titleid = json['titleid'];
    docname = json['docname'];
    experience = json['experience'];
    speciality = json['speciality'];
    gender = json['gender'];
    address = json['address'];
    countryid = json['countryid'];
    stateid = json['stateid'];
    districtid = json['districtid'];
    cityid = json['cityid'];
    pincode = json['pincode'];
    mobno = json['mobno'];
    email = json['email'];
    role = json['role'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organizationid'] = this.organizationid;
    data['titleid'] = this.titleid;
    data['docname'] = this.docname;
    data['experience'] = this.experience;
    data['speciality'] = this.speciality;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['countryid'] = this.countryid;
    data['stateid'] = this.stateid;
    data['districtid'] = this.districtid;
    data['cityid'] = this.cityid;
    data['pincode'] = this.pincode;
    data['mobno'] = this.mobno;
    data['email'] = this.email;
    data['role'] = this.role;
    data['profileImage'] = this.documentUpload;
    data['profileImageType'] =this.documentExt;
    return data;
  }

  @override
  String toString() {
    return 'DoctorRegistrationModel{ organizationid: $organizationid, titleid: $titleid,'
        ' docname: $docname,experience:$experience, address: $address,speciality: $speciality,'
        '  gender: $gender, countryid: $countryid,'
        ' stateid: $stateid, districtid: $districtid, cityid: $cityid,pincode: $pincode,'
        'mobno:$mobno,email: $email,'
        'role:$role}';
  }
}