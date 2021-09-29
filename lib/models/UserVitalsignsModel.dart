class VitalsignsModel {
  List<Body> body;
  String message;
  String code;
  Null total;

  VitalsignsModel({this.body, this.message, this.code, this.total});

  VitalsignsModel.fromJson(Map<String, dynamic> json) {
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
  int height;
  int weight;
  int bmi;
  int tempcel;
  double tempfar;
  int sysbp;
  int diabp;
  int pulse;
  int respiartion;
  int oxygen;

  Body(
      {this.height,
        this.weight,
        this.bmi,
        this.tempcel,
        this.tempfar,
        this.sysbp,
        this.diabp,
        this.pulse,
        this.respiartion,
        this.oxygen});

  Body.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    bmi = json['bmi'];
    tempcel = json['tempcel'];
    tempfar = json['tempfar'];
    sysbp = json['sysbp'];
    diabp = json['diabp'];
    pulse = json['pulse'];
    respiartion = json['respiartion'];
    oxygen = json['oxygen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['bmi'] = this.bmi;
    data['tempcel'] = this.tempcel;
    data['tempfar'] = this.tempfar;
    data['sysbp'] = this.sysbp;
    data['diabp'] = this.diabp;
    data['pulse'] = this.pulse;
    data['respiartion'] = this.respiartion;
    data['oxygen'] = this.oxygen;
    return data;
  }
}