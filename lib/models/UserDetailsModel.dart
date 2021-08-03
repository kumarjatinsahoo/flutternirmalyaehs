class UserDetailsModel {
  String status;
  String message;
  List<Reglist> reglist;

  UserDetailsModel({this.status, this.message, this.reglist});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['reglist'] != null) {
      reglist = new List<Reglist>();
      json['reglist'].forEach((v) {
        reglist.add(new Reglist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.reglist != null) {
      data['reglist'] = this.reglist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reglist {
  String regNo;
  String name;
  String husbandorfather;
  String districtnm;
  String districtcd;
  String gender;
  String mobileNo;

  Reglist(
      {this.regNo,
        this.name,
        this.husbandorfather,
        this.districtnm,
        this.districtcd,
        this.mobileNo,
        this.gender});

  Reglist.fromJson(Map<String, dynamic> json) {
    regNo = json['regNo'];
    name = json['name'];
    husbandorfather = json['husbandorfather'];
    districtnm = json['districtnm'];
    districtcd = json['districtcd'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regNo'] = this.regNo;
    data['name'] = this.name;
    data['husbandorfather'] = this.husbandorfather;
    data['districtnm'] = this.districtnm;
    data['districtcd'] = this.districtcd;
    data['gender'] = this.gender;
    data['mobileNo'] = this.mobileNo;
    return data;
  }
}