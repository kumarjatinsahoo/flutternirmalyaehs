class PharmacyorderModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  PharmacyorderModel({this.body, this.message, this.code, this.total});

  PharmacyorderModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  String address;
  String date;
  String time;
  String orderid;

  Body({this.name, this.address, this.date, this.time, this.orderid});

  Body.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    date = json['date'];
    time = json['time'];
    orderid = json['orderid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['date'] = this.date;
    data['time'] = this.time;
    data['orderid'] = this.orderid;
    return data;
  }
}