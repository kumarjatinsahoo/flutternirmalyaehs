class LifeStyleHistryModel {
  Body body;
  String message;
  String code;
  Null total;

  LifeStyleHistryModel({this.body, this.message, this.code, this.total});

  LifeStyleHistryModel.fromJson(Map<String, dynamic> json) {
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
  String patientId;
  String patientName;
  String smokingId;
  String smokingName;
  String alcoholId;
  String alcoholName;
  String diet;
  String exercise;
  String occupation;
  String pets;
  String petName;

  Body(
      {
        this.patientId,
        this.patientName,
        this.smokingId,
        this.smokingName,
        this.alcoholId,
        this.alcoholName,
        this.diet,
        this.exercise,
        this.occupation,
        this.pets,
        this.petName});

  Body.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'].toString();
    patientName = json['patientName'].toString();
    smokingId = json['smokingId'].toString();
    smokingName = json['smokingName'].toString();
    alcoholId = json['alcoholId'].toString();
    alcoholName = json['alcoholName'].toString();
    diet = json['diet'].toString();
    exercise = json['exercise'].toString();
    occupation = json['occupation'].toString();
    pets = json['pets'].toString();
    petName = json['petName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['smokingId'] = this.smokingId;
    data['smokingName'] = this.smokingName;
    data['alcoholId'] = this.alcoholId;
    data['alcoholName'] = this.alcoholName;
    data['diet'] = this.diet;
    data['exercise'] = this.exercise;
    data['occupation'] = this.occupation;
    data['pets'] = this.pets;
    data['petName'] = this.petName;
    return data;
  }
}