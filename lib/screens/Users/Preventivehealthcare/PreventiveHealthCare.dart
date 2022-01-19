import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class PreventiveHealthCare extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const PreventiveHealthCare({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _PreventiveHealthCareState createState() => _PreventiveHealthCareState();
}

class _PreventiveHealthCareState extends State<PreventiveHealthCare> {
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
  bool isdata = false;
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
    //loginResponse1 = widget.model.loginResponse1;
    //eHealthCardno = widget.model.patientseHealthCard;
    //loginResponse1=widget.eHealthCardno;
   // callAPI();
    //doccategory = widget.model.documentcategories;
    //callAPI(currentMax);
    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (documentListModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });*/
  }


 /* callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.RECENT_DOCUMENT_LIST + loginResponse1.body.user,
        userId: loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              recentUploadDocument = recent.RecentUploadDocument.fromJson(map);
            } else {
              setState(() {
                //isDataNoFound = true;
                // AppData.showInSnackBar(context, msg);
              });
            }
          });
        });
  }
*/



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


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Preventive Health Care"),
        backgroundColor: AppData.kPrimaryColor,
      ),
      body:
      Container(
          child: SingleChildScrollView(
            child: Padding(
                padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                child: /*(recentUploadDocument != null && recentUploadDocument.body!=null)?*/
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                   // recent.Body body = recentUploadDocument.body[i];
                    return Container(
                      width: 500,
                     // height: 210,
                      //width: size.width * 0.20,

                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          side: BorderSide(width: 1, color: Colors.blueGrey),
                        ),
                        child: Container(
                          child: Column(children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    child: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Uploaded By: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "N/A",
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      color: Colors.black54, fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Uploaded On: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  " N/A ",
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      color: Colors.black54, fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.image,
                                                  color: AppData.kPrimaryRedColor,
                                                  size: 80,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
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
                                            Row(
                                              children: [
                                                Text(
                                                  'Uploaded By: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "N/A",
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      color: Colors.black54, fontSize: 15),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Uploaded On: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  " N/A ",
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      color: Colors.black54, fontSize: 15),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 4,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),

                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),

                          ]),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                )
               //     :Container()
            ),
          )),
    );
  }
}
