import 'dart:developer';

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
import 'package:user/widgets/MyWidget.dart';

class TestReportListUser1 extends StatefulWidget {
  MainModel model;

  TestReportListUser1({Key key, this.model}) : super(key: key);

  @override
  _TestReportListUser1State createState() => _TestReportListUser1State();
}

class _TestReportListUser1State extends State<TestReportListUser1> {
  PocReportModel pocReportModel;
  bool isDataNotAvail = false;
  bool isdata = true;

  session.LoginResponse1 loginResponse1;
  ScrollController _scrollController = ScrollController();
  int currentMax = 1;

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

  /* callAPI() {
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
*/
  callAPI(int i) {
    log("SUVAM==========" +ApiFactory.POC_REPORT_LIST +
        "page=" +
        i.toString() +
        "&search=" +
        widget.model.user,);
    // MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.POC_REPORT_LIST +
            "page=" +
            i.toString() +
            "&search=" +
            widget.model.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata=false;
              if (i == 1) {
                pocReportModel = PocReportModel.fromJson(map);
                print('-Suvam----' + pocReportModel.body.toString());
                //Navigator.pop(context);
              } else {
                pocReportModel.addMore(map);
              }
            } else {
              setState(() {
              isdata=false;  
              });
              
             // isDataNotAvail = true;
              //if (i == 1) AppData.showInSnackBar(context, msg);
            }
          });
        });
  }


  getProperLink(String url){
    List<String> mainUrl=url.split("&id2=");
    List<String> date=mainUrl[1].split("-");
    String value=mainUrl[0]+"&id2="+date[2]+"-"+date[1]+"-"+date[0];
    log("URL iS>>>>>>>>"+value);
    return value;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text(MyLocalizations.of(context).text("VISIT_SUMMARY"),
              style: TextStyle(color: AppData.white),
            ),
            centerTitle: true,
            backgroundColor:AppData.kPrimaryColor,
        ),
        body: isdata == true
              ? Center(
            child: CircularProgressIndicator(
              backgroundColor: AppData.matruColor,
            ),
          ):
         (pocReportModel != null)?
         SingleChildScrollView(
     // physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          (pocReportModel != null)
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // controller: _scrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    if (i == pocReportModel.body.length) {
                      return (pocReportModel.body.length % 10 == 0)
                          ? CupertinoActivityIndicator()
                          : Container();
                    }
                    Body patient = pocReportModel.body[i];
                    var string = patient.screeningDate;
                    List splitedText = string.split("-");
                    print(splitedText[0]);
                    String string1 = splitedText[1];
                    print(splitedText[1]);
                    print(splitedText[2]);
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          if (patient.reportUrl != null) {
                            /*widget.model.pdfUrl = patient.reportUrl;
                              print("URL IMAGE?>>>>>"+patient.reportUrl);
                              Navigator.pushNamed(context, "/testReport");*/
                            print(">>>>>>PDF URL TEST REPORT????>>" +
                                patient.reportUrl);
                            //AppData.launchURL(patient.reportUrl);
                            AppData.launchURL(patient.reportUrl);
                          } else {
                            AppData.showInSnackBar(
                                context, "Data Not Available");
                          }
                          //AppData.launchURL(patient.reportUrl);
                          //callUrl("");
                        },
                        title: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  /*'June '*/
                                  AppData.getMonth(string1),
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  /* '23'*/
                                  splitedText[2],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  /*'2016'*/
                                  splitedText[0],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            /*Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),*/
                            Container(
                                height: 80,
                                child: VerticalDivider(color: Colors.grey)),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  patient.name + " ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  patient.phc ?? "N/A",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                (patient.thpName=="")
                                ?(patient.thpId == "")
                                    ? Container()
                                    : Text(
                                        patient.thpName ?? "N/A",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ):Container(),

                              ],
                            ),
                          ],
                        ),
                        trailing: Column(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                    );
                  },
                  itemCount: pocReportModel.body.length,
                )
              : Container(),
        ],
      ),
    )
            :Container(
          child: Center(
            child:  Image.asset("assets/NoRecordFound.png",
                                          // height: 25,
                                        ),
          ),
        )
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
