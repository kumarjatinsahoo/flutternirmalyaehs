class UserDetailsModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  UserDetailsModel({this.body, this.message, this.code, this.total});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = new List<Body>();
      json['body'].forEach((v) {
        body.add(new Body.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }
}

class Body {
  String regNo;
  String name;
  String mobileNo;
  String state;
  String gender;

  Body({this.regNo, this.name, this.mobileNo, this.state, this.gender});

  Body.fromJson(Map<String, dynamic> json) {
    regNo = json['regNo'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    state = json['state'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regNo'] = this.regNo;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['state'] = this.state;
    data['gender'] = this.gender;
    return data;
  }
}
