import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
/*import 'package:user/models/BiomedicalModel.dart' as bio;*/
/*import 'package:user/models/DieseinfoModel.dart' as dieseinfo;*/
import 'package:user/models/DieseinfoModel.dart';
/*import 'package:user/models/DocumentListModel.dart' as document;*/
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart' as login;
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class DieseInfo extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const DieseInfo({Key key, this.model}) : super(key: key);

  @override
  _DieseInfoState createState() => _DieseInfoState();
}

class _DieseInfoState extends State<DieseInfo> {
  login.LoginResponse1 loginResponse1;
 /* bio.BiomedicalModel biomedicalModel;
  document.DocumentListModel documentListModel;*/
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
  DieseinfoModel dieseinfoModel;
  List<Body> foundUser;
  bool isDataNotAvail = false;
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
  bool isSearchShow = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI();
    /* _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (documentListModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });*/
  }

  callAPI() {
    widget.model.GETMETHODCALL(
        api: ApiFactory.DIESEINFO,
        // token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map["status"] == Const.SUCCESS) {
              setState(() {
                dieseinfoModel =DieseinfoModel.fromJson(map);
                foundUser = dieseinfoModel.body;
              });
            } else {
              setState(() {
                isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
  void _runFilter(String enteredKeyword) {
    List<Body> results = [];
    if (enteredKeyword.isEmpty) {
      results = dieseinfoModel.body;
    } else {
      results = dieseinfoModel.body
          .where((user) => user.name
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundUser = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
     /* appBar: AppBar(
        // leading: BackButton(
        //   color: bgColor,
        // ),
        centerTitle: true,
        title: Row(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              MyLocalizations.of(context).text("DISEASE_INFO"),
              *//*style: TextStyle(color: bgColor),*//*
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isSearchShow = !isSearchShow;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(!isSearchShow
                    ? Icons.search
                    : Icons.highlight_remove_rounded),
              ),
            )
          ],
        ),
        titleSpacing: 2,
        backgroundColor: AppData.kPrimaryColor,
      ),*/
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        title: Text( MyLocalizations.of(context).text("DISEASE_INFO")),
        /* leading: Icon(
              Icons.menu,
            ),*/
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 7.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSearchShow = !isSearchShow;
                    foundUser = dieseinfoModel.body;
                  });

                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(!isSearchShow
                      ? Icons.search
                      : Icons.highlight_remove_rounded),
                ),
              )),
          /*Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                        Icons.more_vert
                    ),
                  )
              ),*/
        ],
      ),
      body:
          /*isdata == true
          ? CircularProgressIndicator(
        backgroundColor: AppData.matruColor,
      )
          : dieseinfoModel == null || dieseinfoModel == null
          ? Container(
        child: Center(
          child: Text(
            MyLocalizations.of(context).text("NO_DATA_FOUND"),
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      )
          :*/
          Container(
        child: SingleChildScrollView(
          child: Column(
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  (isSearchShow)
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      child: TextField(
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            hintText: MyLocalizations.of(context).text("SEARCH")),
                      ),
                    ),
                  )
                      : Container(),
                  SizedBox(
                    height: 8,
                  ),
                  (dieseinfoModel != null &&
                      dieseinfoModel.body != null &&
                      dieseinfoModel.body.length > 0)
                      ?ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: foundUser.length,
                      itemBuilder: (context, i) {
                        //dieseinfo.Body body = dieseinfoModel.body[i];
                        return Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5,top: 5),
                          child: Container(
                            width: size.width * 0.20,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                side: BorderSide(
                                    width: 1, color: AppData.kPrimaryColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                          child: Text(foundUser[i].name ?? "N/A",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold))
                                      ),
                                      SizedBox(
                                        height: 20,),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              String pdfurl = foundUser[i].url;
                                              widget.model.diesepdf=pdfurl;
                                             /* widget.model.diesepdf=pdfurl;
                                              Navigator.pushNamed(
                                                context, "/diesepdf",
                                              );*/
                                              widget.model.pdfurl=pdfurl;
                                              Navigator.pushNamed(
                                                context, "/documentpdf",
                                              );
                                              },
                                            child: Text.rich(TextSpan(children: [
                                              TextSpan(text:foundUser[i].details?? "N/A" /*"Log in as Dhan Arogya Kranti User"*/,
                                                  style: TextStyle(color: Colors.black, fontSize: 14,)),
                                              TextSpan(text: " Know More", style: TextStyle(color: Colors.grey,fontSize: 12,decoration: TextDecoration.underline))
                                            ]),textAlign: TextAlign.justify
                                            ),

                                          ),


                                        ],

                                      ),
                                      /*Container(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(55),
                                              child: Icon(
                                                Icons.picture_as_pdf_rounded,
                                                color: AppData.kPrimaryRedColor,
                                                size: 80,
                                              )
                                              // height: 95,

                                              )),*/

                                      SizedBox(
                                        height: 20,
                                      ),

                                     /* Center(
                                        child: Text(foundUser[i].name ?? "N/A",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold))
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),*/

                                      //  SizedBox(height: 10,),
                                      InkWell(
                                        onTap: () {
                                          String pdfurl = foundUser[i].url;
                                         /* widget.model.diesepdf=pdfurl;
                                          print("ppppdddddddddddffffff" + pdfurl);
                                          Navigator.pushNamed(
                                            context,
                                            "/diesepdf",
                                          ).then((value) => widget.model.diesepdf);*/
                                          widget.model.pdfurl=pdfurl;
                                          Navigator.pushNamed(
                                            context, "/documentpdf",
                                          );
                                        },
                                        child: Center(
                                          child: Container(
                                            width: 400,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black12),
                                                color: AppData.kPrimaryColor),
                                            child: RaisedButton(
                                              onPressed: null,
                                              child: Text(MyLocalizations.of(context).text("VIEW_PDF"),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              disabledColor: AppData.kPrimaryColor,
                                            ),
                                          ),
                                        ),
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
                      //itemCount: dieseinfoModel.body.length,
                    ):(isDataNotAvail)
                      ? Container(
                    height: size.height - 100,
                    child: Center(
                      child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
                    ),
                  )
                      : MyWidgets.loading(context),
                ],
              ),
        ),
      ),
    );
  }
}
