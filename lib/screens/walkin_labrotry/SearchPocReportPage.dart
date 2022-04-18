import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart'as poclogin;

//import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/PocReportModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class SearchPocReportPage extends StatefulWidget {
  MainModel model;

  SearchPocReportPage({Key key, this.model}) : super(key: key);

  @override
  _SearchPocReportPageState createState() => _SearchPocReportPageState();
}

class _SearchPocReportPageState extends State<SearchPocReportPage> {
  PocReportModel pocReportModel;
  poclogin.LoginResponse1 loginResponse1;
  //LoginResponse1 loginResponse;
  bool isdata = false;

  TextEditingController _searchContain = TextEditingController();
  ScrollController _scrollController = ScrollController();
  int currentMax = 1;
  String search;

  @override
  void initState() {
    //loginResponse = widget.model.loginResponse1;
    super.initState();
    loginResponse1 = widget.model.loginResponse1;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (pocReportModel.body.length % 20 == 0) callAPI(search, ++currentMax);
      }
    });
  }

  callAPI(String search, int i) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.POC_REPORT_LISTT +
            loginResponse1.body.user +
            "&page=" +
            i.toString() +
            "&search=" +
            search,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              if (i == 1) {
                pocReportModel = PocReportModel.fromJson(map);
                //Navigator.pop(context);
              } else {
                pocReportModel.addMore(map);
              }
            } else {
              if (i == 1) AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).text("SEARCH_HERE"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            search1(),
            Column(
              children: [
                (pocReportModel != null)
                    ? ListView.builder(
                        controller: _scrollController,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          if (i == pocReportModel.body.length) {
                            return (pocReportModel.body.length % 20 == 0)
                                ? CupertinoActivityIndicator()
                                : Container();
                          }
                          Body patient = pocReportModel.body[i];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child:(pocReportModel != null)? ListTile(
                              onTap: () {
                                if (patient.reportUrl != null) {
                                  /*widget.model.pdfUrl = patient.reportUrl;
                        print("URL IMAGE?>>>>>"+patient.reportUrl);
                        Navigator.pushNamed(context, "/testReport");*/
                                  print(">>>>>>PDF URL TEST REPORT????>>" +
                                      patient.reportUrl);
                                  AppData.launchURL(
                                      "https://docs.google.com/gview?embedded=true&url=" +
                                          patient.reportUrl);
                                } else {
                                  AppData.showInSnackBar(
                                      context, "Data Not Available");
                                }
                                //AppData.launchURL(patient.reportUrl);
                                //callUrl("");
                              },

                              title: Text(
                                (i + 1).toString() + ". " + patient.name + " ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  (patient.thpId == "")
                                      ? Container()
                                      : Text(
                                          patient.thpName ?? "",
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.start,
                                        ),
                                  Text(
                                    patient.patientUniqueid,
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                  Text(
                                    patient.mobile ?? "",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                  Text(
                                    patient.gender ?? "",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                  Text(
                                    patient.age ?? "",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                  Text(
                                    patient.screeningDate ?? "",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                              //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
                              trailing: Icon(Icons.arrow_right_outlined),
                            ): Container(),

                          );
                        },
                        itemCount: pocReportModel.body.length + 1,
                      )
                    : Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        (isdata)
                            ? Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
                            : Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget search1() {
    return Container(
      height: 57.0,
      color: AppData.kPrimaryColor,
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white12,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0))),
        child: TextFormField(
          textInputAction: TextInputAction.search,
          //enabled: isEnable,
          controller: _searchContain,
          autofocus: false,
          textAlignVertical: TextAlignVertical.center,
          // inputFormatters: [
          //   UpperCaseTextFormatter(),
          //   WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9/-]")),
          // ],
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3),
              border: InputBorder.none,
              //fillColor: Colors.white,
              hintText: MyLocalizations.of(context).text("NAME") +
                  "/ " +
                  MyLocalizations.of(context).text("MOBILE_NO") +
                  "/ " +
                  MyLocalizations.of(context).text("REGISTER_NO."),
              hintStyle: TextStyle(color: Colors.white54),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          onFieldSubmitted: (v) {
            setState(() {
              this.search = v;
            });
            callAPI(v, currentMax);
          },
        ),
      ),
    );
  }

  goWhere(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding: EdgeInsets.only(top: 18, left: 18, right: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),52
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  //Navigator.pushNamed(context, "/AccountDetails");
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, "/patientDetail");
                                  //Navigator.pushNamed(context, "/ashaDash");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Icon(
                                      Icons.account_circle_outlined,
                                      size: 40,
                                    ),
                                    Text(
                                      MyLocalizations.of(context)
                                          .text("PERSONAL_DETAILS"),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 80,
                                child: VerticalDivider(
                                  color: Colors.black,
                                )),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, "/AccountDetails");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Icon(
                                      Icons.account_balance_wallet_outlined,
                                      size: 40,
                                    ),
                                    Text(
                                      MyLocalizations.of(context)
                                          .text("ACCOUNT_DETAILS"),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*ListTile(
                          title: Text("Appointments"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            chooseAppointment(context);
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Sonography Test"),
                          leading: Icon(
                            Icons.account_circle_outlined,
                            size: 40,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/patientDetail");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Account Details"),
                          leading: Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 40,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/AccountDetails");
                          },
                        ),*/
                        Divider(),
                        MaterialButton(
                          child: Text(
                            MyLocalizations.of(context).text("CANCEL"),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  chooseAppointment(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding: EdgeInsets.only(top: 18, left: 18, right: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text("For Pathology"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/pathology");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("For Physician"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/pathology");
                          },
                        ),
                        MaterialButton(
                          child: Text(
                            MyLocalizations.of(context).text("CANCEL"),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
