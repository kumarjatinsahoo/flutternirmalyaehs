import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/DocumentlistModell.dart' as document;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class DocumentList extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const DocumentList({Key key, this.model}) : super(key: key);

  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  LoginResponse1 loginResponse1;
  document.DocumentlistModell documentListModel;
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = false;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');
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
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL(
        api: ApiFactory.GET_DOCUMENT_API,
        // token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                documentListModel = document.DocumentlistModell.fromJson(map);
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

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    double tileSize = 80;
    double spaceTab = 20;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Document List"),
      ),
      body: isdata == true
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
              : Container(
                  child: SingleChildScrollView(
                    child: (documentListModel != null)
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Categories",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 145,
                                          right: 145,
                                        ),
                                        child: Divider(
                                          color: AppData.kPrimaryRedColor,
                                          thickness: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  itemCount: documentListModel.body.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 3 / 1.5,
                                          mainAxisSpacing: 7,
                                          crossAxisCount: (orientation ==
                                                  Orientation.portrait)
                                              ? 2
                                              : 3),
                                  itemBuilder: (context, i) {
                                    document.Body body = documentListModel.body[i];
                                    //String categories=body.key;
                                    //print("CCCCCCCCCCCCCCCCCCCAAAAAAAAAAAATTTTTTTT"+ widget.model.documentcategories);
                                    return Card(
                                      elevation: 10,
                                      child: Container(
                                          //height: tileSize,
                                          //width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.grey[300],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: InkWell(
                                              onTap: (){
                                                widget.model.documentcategories=body.key;
                                                Navigator.pushNamed(context, "/upload");
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5.0),
                                                    child: Container(
                                                        // color:AppData.kPrimaryRedColor,
                                                        decoration: (i % 2 == 0)
                                                            ? BoxDecoration(
                                                                color: AppData
                                                                    .kPrimaryRedColor,
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        10.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        const Offset(
                                                                      5.0,
                                                                      5.0,
                                                                    ), //Offset
                                                                    blurRadius:
                                                                        10.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ), //BoxShadow
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        const Offset(
                                                                            0.0,
                                                                            0.0),
                                                                    blurRadius:
                                                                        0.0,
                                                                    spreadRadius:
                                                                        0.0,
                                                                  ), //BoxShadow
                                                                ],
                                                              )
                                                            : BoxDecoration(
                                                                color: AppData
                                                                    .kPrimaryColor,
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        10.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        const Offset(
                                                                      5.0,
                                                                      5.0,
                                                                    ), //Offset
                                                                    blurRadius:
                                                                        10.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ), //BoxShadow
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .white,
                                                                    offset:
                                                                        const Offset(
                                                                            0.0,
                                                                            0.0),
                                                                    blurRadius:
                                                                        0.0,
                                                                    spreadRadius:
                                                                        0.0,
                                                                  ), //BoxShadow
                                                                ],
                                                              ),
                                                        //width: double.maxFinite,
                                                        //color: AppData.kPrimaryBlueColor,
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        child: Image.network(
                                                          body.code,
                                                          //color: AppData.kPrimaryColor,
                                                          height: 50,
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      body.name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ),
    );
  }
}
