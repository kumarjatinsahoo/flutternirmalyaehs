class ChemistsLocationWise {
  List<Body> body;
  String message;
  String code;
  String total;

  ChemistsLocationWise({this.body, this.message, this.code, this.total});

  ChemistsLocationWise.fromJson(Map<String, dynamic> json) {
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
  String id;
  String name;
  String address;
  String pin;
  String image;
  String type;

  Body({this.id, this.name, this.address, this.pin, this.image, this.type});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    pin = json['pin'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['pin'] = this.pin;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}