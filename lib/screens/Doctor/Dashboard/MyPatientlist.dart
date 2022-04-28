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
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class MyPatientlist extends StatefulWidget {
  MainModel model;
  static KeyvalueModel nameModel = null;
  static KeyvalueModel typeModel = null;
  static KeyvalueModel severitylistModel = null;

  MyPatientlist({Key key, this.model}) : super(key: key);

  @override
  _MyPatientlistState createState() => _MyPatientlistState();
}

class _MyPatientlistState extends State<MyPatientlist> {
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
  myPatientlist.MyPatientlistModel myPatientlistModel;
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
        api: ApiFactory.MYPATIENTLIST_LIST + loginResponse.body.user,
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata = false;
              // pocReportModel = PocReportModel.fromJson(map);
              myPatientlistModel = myPatientlist.MyPatientlistModel.fromJson(map);
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
          title: Text(MyLocalizations.of(context).text("MY_PATIENT")),
        ),
        body: isdata == true
            ? Center(
              child: CircularProgressIndicator(
          //backgroundColor: AppData.matruColor,
        ),
            )
            : myPatientlistModel == null || myPatientlistModel == ""
            ? Container(
          child: Center(
            child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
          ),
        ) :
        SingleChildScrollView(

          child: (myPatientlistModel != null) ?
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // controller: _scrollController,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              if (i == myPatientlistModel.body.length) {
                return (myPatientlistModel.body.length % 10 == 0)
                    ? CupertinoActivityIndicator()
                    : Container();
              }
              myPatientlist.Body body = myPatientlistModel.body[i];
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
                                        .start,
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
                                      Expanded(
                                        child: Text(
                                          /*'23-Nov-2020-11:30AM'*/
                                          body.patName,
                                          overflow:
                                          TextOverflow
                                              .clip,
                                          style: TextStyle(
                                              color: Colors
                                                  .black),
                                        ),
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
                                        child: Text(
                                          /*'Confirmed'*/
                                          MyLocalizations.of(context).text("PATIENT_ADDRESS"),
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
                                          body.address,
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
                                        child: Text(
                                          /*'Confirmed'*/
                                          MyLocalizations.of(context).text("MOBILE_NO"),
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
                                          body.mobile,
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
                                          MyLocalizations.of(context).text("OPD_DATE"),
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
                                        body.date,
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
            itemCount: myPatientlistModel.body.length,
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
