import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart' as session;
import 'package:user/models/PocReportModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class TestReportListUser1 extends StatefulWidget {
  MainModel model;

  TestReportListUser1({Key key, this.model}) : super(key: key);

  @override
  _TestReportListUser1State createState() => _TestReportListUser1State();
}

class _TestReportListUser1State extends State<TestReportListUser1> {
  PocReportModel pocReportModel;
  bool isDataNotAvail = false;
  ScrollController _scrollController = ScrollController();

  static const platform = AppData.channel;
  session.LoginResponse1 loginResponse1;

  @override
  void initState() {
    super.initState();
    loginResponse1=widget.model.loginResponse1;
    callAPI();
  }
/*
  Future<void> callUrl(String data) async {
    try {
      final int result = await platform.invokeMethod('callUrl', data);
    } on PlatformException catch (e) {}
  }*/

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.TEST_REPORT_USER,
        userId: loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              pocReportModel = PocReportModel.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
        "Test Report List",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      titleSpacing: 5,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppData.kPrimaryColor,
      elevation: 0,
    ),
      body:(pocReportModel != null)
          ? ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, i) {
                if (i == pocReportModel.body.length) {
                  return (pocReportModel.body.length % 10 == 0)
                      ? CupertinoActivityIndicator()
                      : Container();
                }
                Body patient = pocReportModel.body[i];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.all(15),
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
                      if (patient.reportUrl != null) {
                        /*widget.model.pdfUrl = patient.reportUrl;
                        print("URL IMAGE?>>>>>"+patient.reportUrl);
                        Navigator.pushNamed(context, "/testReport");*/
                        print(">>>>>>PDF URL TEST REPORT????>>" + patient.reportUrl);
                        AppData.launchURL("https://docs.google.com/gview?embedded=true&url="+patient.reportUrl);
                      } else {
                        AppData.showInSnackBar(context, "Data Not Available");
                      }
                      //AppData.launchURL(patient.reportUrl);
                      //callUrl("");
                    },

                    title: Text(
                      (i + 1).toString() + ". " + patient.name + " ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                                patient.thpName??"",
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.start,
                              ),
                        Text(
                          patient.patientUniqueid,
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          patient.mobile??"",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          patient.gender??"",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          patient.age??"",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          patient.screeningDate??"",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
                    trailing: Icon(Icons.arrow_right_outlined),
                  ),
                );
              },
              itemCount: pocReportModel.body.length,
            )
          : Container(),
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
