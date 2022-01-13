class RecentUploadDocument {
  List<Body> body;
String message;
String code;
String total;

RecentUploadDocument({this.body, this.message, this.code, this.total});

RecentUploadDocument.fromJson(

Map<String, dynamic> json
) {
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
}}

class Body {
  String mulFile;
  String docType;
  String docName;
  String userid;
  String fileName;
  String extension;
  String uploadDate;
  String filetype;
  String uploadedBy;
  String uploadedOn;
  String file;

  Body({this.mulFile,
    this.docType,
    this.docName,
    this.userid,
    this.fileName,
    this.extension,
    this.uploadDate,
    this.filetype,
    this.uploadedBy,
    this.uploadedOn,
    this.file});

  Body.fromJson(Map<String, dynamic> json) {
    mulFile = json['mulFile'];
    docType = json['docType'];
    docName = json['docName'];
    userid = json['userid'];
    fileName = json['fileName'];
    extension = json['extension'];
    uploadDate = json['uploadDate'];
    filetype = json['filetype'];
    uploadedBy = json['uploadedBy'];
    uploadedOn = json['uploadedOn'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mulFile'] = this.mulFile;
    data['docType'] = this.docType;
    data['docName'] = this.docName;
    data['userid'] = this.userid;
    data['fileName'] = this.fileName;
    data['extension'] = this.extension;
    data['uploadDate'] = this.uploadDate;
    data['filetype'] = this.filetype;
    data['uploadedBy'] = this.uploadedBy;
    data['uploadedOn'] = this.uploadedOn;
    data['file'] = this.file;
    return data;
  }
}
