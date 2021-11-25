class DoctorRegistrationModel{
   String dctrid;
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
   String homephone;
   String officephone;
   String experience;
   String mobno;
   String email;
   String alteremail;
   String userid;
   String password;
   String role;
   String documentUpload;
   String documentExt;
  DoctorRegistrationModel();
  DoctorRegistrationModel.fromJson(Map<String, dynamic> json) {
    dctrid = json['dctrid'];
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
    homephone = json['homephone'];
    officephone = json['officephone'];
    experience = json['experience'];
    mobno = json['mobno'];
    email = json['email'];
    alteremail = json['alteremail'];
    userid = json['userid'];
    password = json['password'];
    role = json['role'];

  }

  dynamic toJson() {
    var param={
      "dctrid": this.dctrid,
      "organizationid": this.organizationid,
      "titleid": this.titleid,
      "docname": this.docname,
      "educationid": this.educationid,
      //"gender": (this.gender),
      "speciality": this.speciality,
      "dob": this.dob,
      "bloodgroup": this.bloodgroup,
      "gender": this.gender,
      "address": this.address,
      "countryid": this.countryid,
      "stateid": this.stateid,
      "districtid": this.districtid,
      "cityid": this.cityid,
      "pincode": this.pincode,
      "homephone": this.homephone,
      "officephone": this.officephone,
      "experience": this.experience,
      "mobno": this.mobno,
      "email": this.email,
      "alteremail": this.alteremail,
      "userid": this.userid,
      "password": this.password,
      "role": this.role,
      "profileImage": [this.documentUpload],
      "profileImageType": this.documentExt,
    };

    return param;
  }
  @override
  String toString() {
    return 'DoctorRegistrationModel{dctrid: $dctrid, organizationid: $organizationid, titleid: $titleid,'
        ' docname: $docname, educationid: $educationid, speciality: $speciality,'
        ' dob: $dob, bloodgroup: $bloodgroup, gender: $gender,address: $address, countryid: $countryid,'
        ' stateid: $stateid, districtid: $districtid, cityid: $cityid,pincode: $pincode,'
        'homephone: $homephone,officephone: $officephone,mobno: $mobno,email: $email,'
        'alteremail: $alteremail,userid: $userid,password: $password,role:$role,experience:$experience}';
  }
}

