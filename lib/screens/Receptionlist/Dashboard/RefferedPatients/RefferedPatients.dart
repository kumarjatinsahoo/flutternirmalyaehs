import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AllergicModel.dart' as allergic;
import 'package:user/models/AllergicPostModel.dart';
import 'package:user/models/AmbulancelistModel.dart'as ambulance;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MyPatientlistModel.dart'as myPatientlist;
import 'package:user/models/RefferedPatientsModel.dart'as refferpatient;
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class RefferedPatients extends StatefulWidget {
  MainModel model;
  static KeyvalueModel nameModel = null;
  static KeyvalueModel typeModel = null;
  static KeyvalueModel severitylistModel = null;

  RefferedPatients({Key key, this.model}) : super(key: key);

  @override
  _RefferedPatientsState createState() => _RefferedPatientsState();
}

class _RefferedPatientsState extends State<RefferedPatients> {
  var selectedMinValue;
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
  ];
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();


  List<KeyvalueModel> severitylist = [
    KeyvalueModel(name: "High", key: "High"),
    KeyvalueModel(name: "Medium", key: "Medium"),
    KeyvalueModel(name: "Low", key: "Low"),
  ];
  LoginResponse1 loginResponse;
  bool isDataNoFound = false;
  refferpatient. RefferedpatientsModel refferedpatientsModel;
  bool isdata = false;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    isdata = true;
    callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.REFFERED_LIST + loginResponse.body.user,
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata = false;
              // pocReportModel = PocReportModel.fromJson(map);
              refferedpatientsModel = refferpatient.RefferedpatientsModel.fromJson(map);
            } else {
              isdata = false;
              setState(() {

                //isDataNoFound = true;
                // AppData.showInSnackBar(context, msg);

              });
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          title: Text(MyLocalizations.of(context).text("REFFERED_PATIENT")),
        ),
        body: isdata == true
            ? Center(
          child: CircularProgressIndicator(
            //backgroundColor: AppData.matruColor,
          ),
        )
            : refferedpatientsModel == null || refferedpatientsModel == ""
            ? Container(
          child: Center(
            child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
          ),

        ) :
        SingleChildScrollView(

          child: (refferedpatientsModel != null) ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // controller: _scrollController,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              if (i == refferedpatientsModel.body.length) {
                return (refferedpatientsModel.body.length % 10 == 0)
                    ? CupertinoActivityIndicator()
                    : Container();
              }
              refferpatient.Body body = refferedpatientsModel.body[i];
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Card(
                  child: Container(
                    //height: height * 0.30,
                    // color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blueGrey[50],
                                Colors.blue[50]
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 5),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .end,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Text(
                                          /*'Confirmed'*/
                                          MyLocalizations.of(context).text("PATIENT_NAME"),
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Text(" : "),
                                      Text(
                                        /*'23-Nov-2020-11:30AM'*/
                                        body.patientname,
                                        overflow:
                                        TextOverflow
                                            .clip,
                                        style: TextStyle(
                                            color: Colors
                                                .black),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,

                                    children: [
                                      Container(
                                        width: 120,
                                        child: Text( MyLocalizations.of(context).text("REFFERED_NAME"),
                                          /*'Confirmed'*/
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Text(" : "),
                                      Expanded(
                                        child: Text(
                                          /*'23-Nov-2020-11:30AM'*/
                                          body.refdrname,
                                          overflow:
                                          TextOverflow
                                              .clip,
                                          style: TextStyle(
                                              color: Colors
                                                  .black),
                                        ),)
                                      /*Text(
                                */ /*'23-Nov-2020-11:30AM'*/ /*
                                body.fromLocation,
                                overflow:
                                TextOverflow
                                    .clip,
                                style: TextStyle(
                                    color: Colors
                                        .black),
                              ),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Text(MyLocalizations.of(context).text("NOTE"),
                                          /*'Confirmed'*/
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Text(" : "),
                                      Expanded(
                                        child: Text(
                                          /*'23-Nov-2020-11:30AM'*/
                                          body.notes,
                                          overflow:
                                          TextOverflow
                                              .clip,
                                          style: TextStyle(
                                              color: Colors
                                                  .black),
                                        ),)

                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .end,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Text(
                                          /*'Confirmed'*/
                                          MyLocalizations.of(context).text("DATE"),
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Text(" : "),
                                      Text(
                                        /*'23-Nov-2020-11:30AM'*/
                                        body.sdate,
                                        overflow:
                                        TextOverflow
                                            .clip,
                                        style: TextStyle(
                                            color: Colors
                                                .black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .end,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Text(
                                          /*'Confirmed'*/
                                          MyLocalizations.of(context).text(""),
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          widget.model.receptionhospitalid=body.hosid;
                                          widget.model.receptionpatientid=body.patientid;
                                          Navigator.pushNamed(context, "/refferedpatientsbookAppoint");
                                        },
                                        child: Material(
                                          elevation: 5,
                                          color: AppData
                                              .kPrimaryColor,
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              3.0),
                                          child:
                                          MaterialButton(
                                            minWidth: 170,
                                            height: 40.0,
                                            child: Text(MyLocalizations.of(context).text("BOOK_APPOINTMENT"),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize:
                                                  15,
                                                  color: Colors
                                                      .white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            //itemCount:5,
            itemCount: refferedpatientsModel.body.length,
          ) : Container(),
        )

    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }


}
