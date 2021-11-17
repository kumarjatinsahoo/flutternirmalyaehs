import 'package:dio/dio.dart';

class AddUploadDocumentModel {
  String userid;
  MultipartFile  mulFile;
  String docType;
  String docName;
  String fileName;
  String extension;

  AddUploadDocumentModel(
      {this.userid, this.mulFile, this.docType, this.docName,this.fileName,this.extension});

  AddUploadDocumentModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    mulFile = json['mulFile'];
    docType = json['docType'];
    docName = json['docName'];
    fileName = json['fileName'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['mulFile'] = this.mulFile;
    data['docType'] = this.docType;
    data['docName'] = this.docName;
    data['fileName'] = this.fileName;
    data['extension'] = this.extension;
    return data;
  }
}
