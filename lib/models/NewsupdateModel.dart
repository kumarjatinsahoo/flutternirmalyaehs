class NewsupdateModel {
  List<Body> body;
  String message;
  String code;
  String total;

  NewsupdateModel({this.body, this.message, this.code, this.total});

  NewsupdateModel.fromJson(Map<String, dynamic> json) {
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
  String title;
  String subTitle;
  String country;
  String state;
  String district;
  String city;
  String fromDate;
  String toDate;
  String status;
  String vdoURL;
  String multipleFile;
  String docType;
  String docName;
  String fileName;
  String extension;
  String fileType;
  String admId;
  String unqId;

  Body(
      {this.title,
        this.subTitle,
        this.country,
        this.state,
        this.district,
        this.city,
        this.fromDate,
        this.toDate,
        this.status,
        this.vdoURL,
        this.multipleFile,
        this.docType,
        this.docName,
        this.fileName,
        this.extension,
        this.fileType,
        this.admId,
        this.unqId});

  Body.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    country = json['country'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    status = json['status'];
    vdoURL = json['vdoURL'];
    multipleFile = json['multipleFile'];
    docType = json['docType'];
    docName = json['docName'];
    fileName = json['fileName'];
    extension = json['extension'];
    fileType = json['fileType'];
    admId = json['admId'];
    unqId = json['unqId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['country'] = this.country;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['status'] = this.status;
    data['vdoURL'] = this.vdoURL;
    data['multipleFile'] = this.multipleFile;
    data['docType'] = this.docType;
    data['docName'] = this.docName;
    data['fileName'] = this.fileName;
    data['extension'] = this.extension;
    data['fileType'] = this.fileType;
    data['admId'] = this.admId;
    data['unqId'] = this.unqId;
    return data;
  }
}
