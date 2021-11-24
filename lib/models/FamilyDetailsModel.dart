class FamilyDetailsModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  FamilyDetailsModel({this.body, this.message, this.code, this.total});

  FamilyDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String uid;
  String memeberName;
  String relation;
  String age;

  Body({this.uid, this.memeberName, this.relation, this.age});

  Body.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    memeberName = json['memeberName'];
    relation = json['relation'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['memeberName'] = this.memeberName;
    data['relation'] = this.relation;
    data['age'] = this.age;
    return data;
  }
}
