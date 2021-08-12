class UserDashboardModel {
  Body body;
  Null message;
  Null code;
  Null total;

  UserDashboardModel({this.body, this.message, this.code, this.total});

  UserDashboardModel.fromJson(Map<String, dynamic> json) {
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
  bool isEContactAdded;
  bool isFDoctorAdded;

  Body({this.isEContactAdded, this.isFDoctorAdded});

  Body.fromJson(Map<String, dynamic> json) {
    isEContactAdded = json['isEContactAdded'];
    isFDoctorAdded = json['isFDoctorAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEContactAdded'] = this.isEContactAdded;
    data['isFDoctorAdded'] = this.isFDoctorAdded;
    return data;
  }
}