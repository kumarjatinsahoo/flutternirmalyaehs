class IntrestSignUp {
  List<Body> body;
  String message;
  String code;
  String total;

  IntrestSignUp({this.body, this.message, this.code, this.total});

  IntrestSignUp.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = <Body>[];
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
  String catagory;
  List<String> subCatagoryList;
  Body({this.catagory, this.subCatagoryList});
  Body.fromJson(Map<String, dynamic> json) {
    catagory = json['catagory'];
    subCatagoryList = json['subCatagoryList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catagory'] = this.catagory;
    data['subCatagoryList'] = this.subCatagoryList;
    return data;
  }
}
