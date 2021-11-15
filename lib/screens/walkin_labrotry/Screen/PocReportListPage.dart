import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart' as poclogin;
import 'package:user/models/PocReportModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class PocReportListPage extends StatefulWidget {
  MainModel model;

  PocReportListPage({Key key, this.model}) : super(key: key);

  @override
  _PocReportListPageState createState() => _PocReportListPageState();
}

class _PocReportListPageState extends State<PocReportListPage> {
  poclogin.LoginResponse1 loginResponse1;
  PocReportModel pocReportModel;
  bool isDataNotAvail = false;
  ScrollController _scrollController = ScrollController();
  bool checkBoxValue = false;
  int currentMax = 1;
  bool isdata = false;

  static const platform = AppData.channel;

  // List<MedicinlistModel> medicinlist = [];
  List<Body> selectPocreport = [];

  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI(currentMax);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (pocReportModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });
  }

/*
  Future<void> callUrl(String data) async {
    try {
      final int result = await platform.invokeMethod('callUrl', data);
    } on PlatformException catch (e) {}
  }*/

  callAPI(int i) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.POC_REPORT_LISTT +
            loginResponse1.body.user +
            "&page=" +
            i.toString() +
            "&search=",
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
              isDataNotAvail = true;
              if (i == 1) AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  sendSmsAPI() {
    // log("Poc result     "+jsonEncode(pocReportModel.toJson1(selectPocreport)));
    widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.POC_REPORT_SMS,
        token: widget.model.token,
        json: pocReportModel.toJson1(selectPocreport),
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              //pocReportModel = PocReportModel.fromJson(map);
              Navigator.pushNamed(context, "/patientDashboard");

              //Navigator.pop(context);
            } else {
              //  isDataNotAvail = true;
              // if (i == 1) AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "POC Report List",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                if (selectPocreport.length > 10 ||
                    selectPocreport.length == 0) {
                  AppData.showInSnackBar(context, "Please select 10 reports");
                } else {
                  //AppData.showInSnackDone(context, "Working");
                  sendSmsAPI();
                }
              },
              child: Text(
                "Send SMS",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Spacer(),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/searchPoc");
                },
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            SizedBox(
              width: 15,
            )
          ],
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.kPrimaryColor,
        elevation: 0,
      ),
      body: (pocReportModel != null)
          ? ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, i) {
                if (i == pocReportModel.body.length) {
                  return (pocReportModel.body.length % 20 == 0)
                      ? CupertinoActivityIndicator()
                      : Container();
                }
                Body patient = pocReportModel.body[i];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      /* if (patient.reportUrl != null) {
                        AppData.launchURL(patient.reportUrl);
                      } else {
                        AppData.showInSnackBar(context, "Data Not Available");
                      }
*/ //AppData.launchURL(patient.reportUrl);
                      //callUrl("");
                    },

                    leading: SizedBox(
                      width: 25,
                      height: 15,
                      child: Checkbox(
                          value: patient.isChecked,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: AppData.kPrimaryBlueColor,
                          onChanged: (bool val) {
                            setState(() {
                              patient.isChecked = val;
                              if (val) {
                                selectPocreport.add(patient);
                              } else {
                                selectPocreport.remove(patient);
                              }
                            });
                          }),
                    ),
                    /*title:
              Text(
                (i + 1).toString() + ". " + patient.name + " ",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),*/
                    subtitle: SizedBox(
                      child: InkWell(
                        onTap: () {
                          if (patient.reportUrl != null) {
                            AppData.launchURL(patient.reportUrl);
                          } else {
                            AppData.showInSnackBar(
                                context, "Data Not Available");
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (i + 1).toString() + ". " + patient.name + " ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
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
                      ),
                    ),
                    //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
                    trailing: Icon(Icons.arrow_right_outlined),
                  ),
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
                        ? Text(
                            'No Data Found',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
    );
    /*body: ListTile(
        onTap: () {
        },
        title: Text(
          (i + 1).toString() +
              ". " +
              patient.firstName +
              " " +
              patient.midName ??
              "" + patient.lastName,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              patient.sector,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              patient.pregnancyRegDt,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
            Text(
              patient.husbandFatherNm,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
        trailing: Icon(Icons.arrow_right_outlined),
      ),*/
  }
}
