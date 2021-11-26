import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/UserlabtestreportModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';

class TestReport extends StatefulWidget {
  MainModel model;

  TestReport({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestReport();
}

class _TestReport extends State<TestReport> {
  FocusNode _descriptionFocus, _focusNode;
    bool isDataNotAvail = false;
  UserlabtestreportModel userlabtestreportModel = UserlabtestreportModel();
  String eHealthCardno;
  bool isdata = false;


  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
    eHealthCardno = widget.model.patientseHealthCard;
    isdata = true;
    callLabtastAPI(eHealthCardno);

  }
  callLabtastAPI(String eHealthCardno) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.IABTEST_REPORTDOCTER + eHealthCardno,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          log("Error in>>>"+jsonEncode(map));
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata = false;
              userlabtestreportModel = UserlabtestreportModel.fromJson(map);
            } else {
              isdata = false;
             // AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
      body:
      isdata == true
          ? Center(
        child: Column(
          children: [
            SizedBox(
              height:
              MediaQuery.of(context).size.height * 0.35,
            ),
            CircularProgressIndicator(
              // backgroundColor: AppData.matruColor,
            ),
          ],
        ),
      )
          : userlabtestreportModel == null || userlabtestreportModel == null
          ? Container(
        child: Center(
          child: Column(
            children: [
              //SizedBox(height: 300,),
              SizedBox(
                height:
                MediaQuery.of(context).size.height * 0.35,
              ),
              Text(
                "No Data Found",
                style: TextStyle(
                    color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      )
          :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(children: [
              SizedBox(height: 5),
              Center(
                child: Text(
                  "LABS TEST REPORT LIST",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: (userlabtestreportModel != null && userlabtestreportModel.body!=null && userlabtestreportModel.body.isNotEmpty)
                    ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),

                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  itemCount: userlabtestreportModel.body.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Color(0xFFD2E4FC),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          side: BorderSide(
                              width: 1, color: Color(0xFFD2E4FC))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Patient Id",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  /*"121448674403477"*/
                                  userlabtestreportModel?.body[0]?.patientid ??
                                      "N/A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Patient Name",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  /*"Ipsita Sahoo"*/
                                  userlabtestreportModel
                                      .body[0].patientname ??
                                      "N/A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Age",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  userlabtestreportModel.body[0].age ??
                                      "N/A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Gender",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  userlabtestreportModel.body[0].gender ??
                                      "N/A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Weight",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  userlabtestreportModel.body[0].weight ??
                                      "N/A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Height",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  userlabtestreportModel.body[0].height ??
                                      "N/A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Test Date",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  userlabtestreportModel
                                      .body[0].testdate ??
                                      "N/A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Phc",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "   :   ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                Text(
                                  userlabtestreportModel.body[0].phc ??
                                      "N/A",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    : Container(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
