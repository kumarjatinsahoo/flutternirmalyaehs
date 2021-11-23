import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/DocumentListModel.dart' as document;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class UploadDocument extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const UploadDocument({Key key, this.model}) : super(key: key);

  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  LoginResponse1 loginResponse1;
  bio.BiomedicalModel biomedicalModel;
  document.DocumentListModel documentListModel;
  ScrollController _scrollController = ScrollController();
  bool checkBoxValue = false;
  int currentMax = 1;
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = false;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');
  String profilePath = null, idproof = null;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI(currentMax);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (documentListModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });
  }

  callAPI(int i) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.UPLOAD_DOCUMENT +
            loginResponse1.body.user +
            "&page=" +
            i.toString() ,
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          title: Text("Upload Document"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/adduploaddocument");
                  // displayTextInputDialog(context);
                },
                child: Icon(
                  Icons.add_circle_outline_sharp,
                  size: 26.0,
                ),
              ),
            ),
          ]),
      body:
          isdata == true
          ? CircularProgressIndicator(
              backgroundColor: AppData.matruColor,
            )
          : documentListModel == null || documentListModel == null
              ? Container(
                  child: Center(
                    child: Text(
                      MyLocalizations.of(context).text("NO_DATA_FOUND"),
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                )
              :
          Container(
        child: SingleChildScrollView(
            child: (documentListModel != null)
             ?
                ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            document.Body body = documentListModel.body[i];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: size.width * 0.20,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    side: BorderSide(width: 1, color: AppData.kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(55),
                                  child: Icon(
                                    Icons.picture_as_pdf_rounded,
                                    color: AppData.kPrimaryRedColor,
                                    size: 100,
                                  )
                                  // height: 95,

                                  )),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text("Document Name :",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 5,),
                              Text(body.docName??"N/A",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("Document Type   :",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 5,),

                              Text( body.docType??"N/A",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          //  SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                "",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  String pdfurl=body.fileName;
                                  widget.model.pdfurl=pdfurl;
                                  print("ppppdddddddddddffffff"+pdfurl);
                                  print("pdf"+widget.model.pdfurl);
                                  Navigator.pushNamed(context, "/documentpdf",).then((value) => widget.model.pdfurl);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black12),
                                      color: AppData.kPrimaryColor),
                                  child: RaisedButton(
                                    onPressed: null,
                                    child: Text(
                                      'View Pdf',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    disabledColor: AppData.kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ]),
                  ),
                ),
              ),
            );
          },
          itemCount: documentListModel.body.length,
        )
            : Container(),
    ),
          ),

    );
  }
}
