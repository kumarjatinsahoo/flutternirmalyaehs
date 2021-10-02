class BiomedicalModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  BiomedicalModel({this.body, this.message, this.code, this.total});

  BiomedicalModel.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = [];
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
  String bioMName;
  String bioMReason;
  String bioMDate;

  Body({this.bioMName, this.bioMReason, this.bioMDate});

  Body.fromJson(Map<String, dynamic> json) {
    bioMName = json['bioMName'];
    bioMReason = json['bioMReason'];
    bioMDate = json['bioMDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bioMName'] = this.bioMName;
    data['bioMReason'] = this.bioMReason;
    data['bioMDate'] = this.bioMDate;
    return data;
  }
}
