class OrganlistModel {
  Body body;
  String message;
  String code;
  String total;

  OrganlistModel({this.body, this.message, this.code, this.total});

  OrganlistModel.fromJson(Map<String, dynamic> json) {
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
  String donorName;
  String donorType;
  String typeUserName;
  String dob;
  String age;
  String bldGr;
  String mob;
  String email;
  String address;
  String patientId;
  String relation;
  String organList;
  String tissueList;
  String witnessList;
  List<DonatedOrganList> donatedOrganList;
  String donorid;
  String createddate;

  Body(
      {this.donorName,
        this.donorType,
        this.typeUserName,
        this.dob,
        this.age,
        this.bldGr,
        this.mob,
        this.email,
        this.address,
        this.patientId,
        this.relation,
        this.organList,
        this.tissueList,
        this.witnessList,
        this.donatedOrganList,
        this.donorid,
        this.createddate});

  Body.fromJson(Map<String, dynamic> json) {
    donorName = json['donorName'];
    donorType = json['donorType'];
    typeUserName = json['typeUserName'];
    dob = json['dob'];
    age = json['age'];
    bldGr = json['bldGr'];
    mob = json['mob'];
    email = json['email'];
    address = json['address'];
    patientId = json['patientId'];
    relation = json['relation'];
    organList = json['organList'];
    tissueList = json['tissueList'];
    witnessList = json['witnessList'];
    if (json['donatedOrganList'] != null) {
      donatedOrganList = new List<DonatedOrganList>();
      json['donatedOrganList'].forEach((v) {
        donatedOrganList.add(new DonatedOrganList.fromJson(v));
      });
    }
    donorid = json['donorid'];
    createddate = json['createddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['donorName'] = this.donorName;
    data['donorType'] = this.donorType;
    data['typeUserName'] = this.typeUserName;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['bldGr'] = this.bldGr;
    data['mob'] = this.mob;
    data['email'] = this.email;
    data['address'] = this.address;
    data['patientId'] = this.patientId;
    data['relation'] = this.relation;
    data['organList'] = this.organList;
    data['tissueList'] = this.tissueList;
    data['witnessList'] = this.witnessList;
    if (this.donatedOrganList != null) {
      data['donatedOrganList'] =
          this.donatedOrganList.map((v) => v.toJson()).toList();
    }
    data['donorid'] = this.donorid;
    data['createddate'] = this.createddate;
    return data;
  }
}

class DonatedOrganList {
  String key;
  String name;
  String code;
  String image;
  String language;

  DonatedOrganList({this.key, this.name, this.code, this.image, this.language});

  DonatedOrganList.fromJson(Map<String, dynamic> json) {
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