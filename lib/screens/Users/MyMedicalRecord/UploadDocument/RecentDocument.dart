import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/DocumentListModel.dart' as document;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/RecentUploadDocument.dart'as recent;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';

import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/DocumentImageView.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/VideoDetailsPage.dart';
import 'package:user/widgets/PdfViewPage.dart';

class RecentDocument extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const RecentDocument({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _RecentDocumentState createState() => _RecentDocumentState();
}

class _RecentDocumentState extends State<RecentDocument> {
  LoginResponse1 loginResponse1;
  bio.BiomedicalModel biomedicalModel;
  document.DocumentListModel documentListModel;
  recent.RecentUploadDocument recentUploadDocument;
  ScrollController _scrollController = ScrollController();
  bool checkBoxValue = false;
  int currentMax = 1;
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = true;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');
  String profilePath = null, idproof = null;
  String doccategory;
  TextEditingController _date = TextEditingController();
  TextEditingController _reason = TextEditingController();
  TextEditingController _name = TextEditingController();

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  List<bool> error = [false, false, false, false, false, false];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  AddBioMedicalModel addBioMedicalModel = AddBioMedicalModel();
  String eHealthCardno;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    eHealthCardno = widget.model.patientseHealthCard;
    //loginResponse1=widget.eHealthCardno;
    callAPI();
    //doccategory = widget.model.documentcategories;
    //callAPI(currentMax);
    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (documentListModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });*/
  }


  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.RECENT_DOCUMENT_LIST + loginResponse1.body.user,
       /* userId: loginResponse1.body.user,*/
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
             recentUploadDocument = recent.RecentUploadDocument.fromJson(map);
             isdata=false;
            } else {
              setState(() {
                isdata=false;
                //isDataNoFound = true;
                // AppData.showInSnackBar(context, msg);
              });
            }
          });
        });
  }




/*
   callAPI(int i) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.UPLOAD_DOCUMENT +
            widget.model.patientseHealthCard +
            "&typeid=" +
            doccategory +
            "&page=" +
            i.toString(),
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              if (i == 1) {
                documentListModel = document.DocumentListModel.fromJson(map);

                //Navigator.pop(context);
              } else {
                //documentListModel.addMore(map);
              }
            } else {
              //if (i == 1) AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
*/
  getFormatType(String ext) {

    switch (ext.toLowerCase()) {
      case 'jpg':
        return 'img';
      case 'png':
        return 'img';
      case 'jpeg':
        return 'img';
      case 'heif':
        return 'img';

      case 'pdf':
        return 'doc';
      case 'doc':
        return 'doc';
      case 'pdf':
        return 'doc';

      case 'mp4':
        return 'vdo';
      case 'mkv':
        return 'vdo';
      case '3gp':
        return 'vdo';
      case 'mov':
        return 'vdo';
      case 'avp':
        return 'vdo';
      default:
        return null;
    }
  }

  IconData getIconFormat(String ext) {
    switch (ext.toLowerCase()) {
      case 'jpg':
        return Icons.image;
      case 'png':
        return Icons.image;
      case 'jpeg':
        return Icons.image;
      case 'heif':
        return Icons.image;

      case 'pdf':
        return Icons.document_scanner;
      case 'doc':
        return Icons.document_scanner;
      case 'pdf':
        return Icons.document_scanner;

      case 'mp4':
        return Icons.video_collection;
      case 'mkv':
        return Icons.video_collection;
      case '3gp':
        return Icons.video_collection;
      case 'mov':
        return Icons.video_collection;
      case 'avp':
        return Icons.video_collection;
      case 'avi':
        return Icons.video_collection;
      default:
        return Icons.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:isdata == true
              ? Center(
            child: CircularProgressIndicator(
              backgroundColor: AppData.matruColor,
            ),
          ):(recentUploadDocument != null && recentUploadDocument.body!=null)?
       Container(
          child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          child: (recentUploadDocument != null && recentUploadDocument.body!=null)?
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              recent.Body body = recentUploadDocument.body[i];
              return Container(
                width: 500,
                height: 210,
                //width: size.width * 0.20,

                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      //topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      //bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    side: BorderSide(width: 1, color: Colors.blueGrey),
                  ),
                  child: Container(
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 120,
                                // width: 50,
                                    child: InkWell(
                                      onTap: () {
                                        String pdfurl = body.fileName;
                                        String extension =
                                        AppData.getExt(pdfurl);
                                        print("eeeessssssssstttt" +
                                            extension);
                                        widget.model.pdfurl = pdfurl;
                                        print("ppppdddddddddddffffff" +
                                            pdfurl);
                                        String format =
                                        getFormatType(extension);
                                        log("print<<<<<<<<<<<"+getFormatType(extension));
                                        if(format!=null) {
                                          if (format == "img") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocumentImage(
                                                          model: widget
                                                              .model,
                                                        ))).then(
                                                    (value) =>
                                                widget.model.pdfurl);

                                            /*  Navigator.pushNamed(context, "/documentimage",).then((
                                          value) => widget.model.pdfurl);*/
                                          } else if (format == "doc") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfViewPage(
                                                          model: widget
                                                              .model,
                                                        ))).then(
                                                    (value) =>
                                                widget.model.pdfurl);
                                          } else if (format == "vdo") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoDetailsPage(
                                                          model: widget
                                                              .model,
                                                        ))).then(
                                                    (value) =>
                                                widget.model.pdfurl);
                                          }
                                        }else{
                                          AppData.showInSnackBar(context, "Unsupported file format");
                                        }
                                      },
                                      child: Icon(
                                        getIconFormat(AppData.getExt(
                                            body.fileName)),
                                        color: AppData.kPrimaryRedColor,
                                        size: 100,
                                      ),
                                    ),

                                decoration: new ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                    side: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyLocalizations.of(context).text("UPLOADED_BY"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    body.uploadedBy ?? "N/A",
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(MyLocalizations.of(context).text("UPLOADED_ON"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    body.uploadedOn,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                 /* Text(
                                    'User Remark: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),*/
                                  SizedBox(
                                    height: 3,
                                  ),
                                 /* Text(
                                    body.,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),*/
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ],
                      ),
                      //   SizedBox(height: 40,),
                      Expanded(
                        child: Container(
                          width: 400,
                          decoration: (i % 2 == 0)
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  // border: Border.all(color: Colors.black12),
                                  color:AppData.kPrimaryBlueColor)
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  //border: Border.all(color: Colors.black12),
                                  color: AppData.kPrimaryRedColor),
                          child: RaisedButton(
                            onPressed: null,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(MyLocalizations.of(context).text("CAPTURE"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                CircleAvatar(
                                    // radius: 40,
                                    backgroundColor: Colors.white,
                                    child: (i % 2 == 0)
                                        ? Icon(
                                            Icons.edit,
                                            color: AppData.kPrimaryBlueColor,
                                            size: 25,
                                          )
                                        : Icon(
                                            Icons.edit,
                                            size: 25,
                                            color:AppData.kPrimaryRedColor,
                                          )

                                    // Image radius
                                    ),
                                SizedBox(
                                  width: 15,
                                ),
                                CircleAvatar(
                                  //radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                      child: (i % 2 == 0)
                                          ? Icon(
                                              Icons.download_rounded,
                                              color:AppData.kPrimaryBlueColor,
                                              size: 25,
                                            )
                                          : Icon(
                                              Icons.download_rounded,
                                              size: 25,
                                              color:AppData.kPrimaryRedColor,
                                            )), // Image radius
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            },
            itemCount: recentUploadDocument.body.length,
          )
                :Container()
        ),
      )
      ):Container(
            child: Center(
              child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
            ),
          )
      ,
    );
  }
}
