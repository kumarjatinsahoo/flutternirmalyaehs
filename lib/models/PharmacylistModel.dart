class PharmacylistModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  PharmacylistModel({this.body, this.message, this.code, this.total});

  PharmacylistModel.fromJson(Map<String, dynamic> json) {
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
  String key;
  String name;
  String code;
  String image;
  String language;

  Body({this.key, this.name, this.code, this.image, this.language});

  Body.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    code = json['code'];
    image = json['image'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['code'] = this.code;
    data['image'] = this.image;
    data['language'] = this.language;
    return data;
  }
}