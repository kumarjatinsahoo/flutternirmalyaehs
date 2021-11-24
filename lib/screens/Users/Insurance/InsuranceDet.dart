import 'dart:convert';
import 'dart:developer';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:user/models/InsuranceDetailsModel.dart' as insurancedetails;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class InsuranceDetalis extends StatefulWidget {
  MainModel model;

  InsuranceDetalis({Key key, this.model}) : super(key: key);

  @override
  _InsuranceDetalisState createState() => _InsuranceDetalisState();
}

class _InsuranceDetalisState extends State<InsuranceDetalis> {
  var selectedMinValue;
  String insuranceid;
  insurancedetails.InsuranceDetailsModel insuranceDetailsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    insuranceid = widget.model.insuranceid;
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.INSURANCE_Details + insuranceid,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                insuranceDetailsModel =
                    insurancedetails.InsuranceDetailsModel.fromJson(map);
              });
            } else {
              setState(() {
                // isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Insurance"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
/*                  height: 90,
                      width: double.maxFinite,*/
                          /*  margin: const EdgeInsets.only(top: 6.0),*/
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  insuranceDetailsModel.body.insCompany??"N/A",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: AppData.kPrimaryColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Policy No:' +
                                      insuranceDetailsModel.body.policyNo??"N/A",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Contact No:9020234567',
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                              ],
                            ),
                            //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                          ],
                        ),
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // Underline thickness
                            ),
                          ),
                        ),
                      ),
                      Container(
/*                            height: 70,
                      width: double.maxFinite,*/
                          /*  margin: const EdgeInsets.only(top: 6.0),*/
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Policy Name',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Life Insurance',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // Underline thickness
                            ),
                          ),
                        ),
                      ),
                      Container(
/*                      height: 70,
                      width: double.maxFinite,*/
                          /*  margin: const EdgeInsets.only(top: 6.0),*/
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Insurance Type',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  insuranceDetailsModel.body.insType,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                          ],
                        ),
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // Underline thickness
                            ),
                          ),
                        ),
                      ),
                      Container(
/*
                      height: 70,
                      width: double.maxFinite,
*/
                          /*  margin: const EdgeInsets.only(top: 6.0),*/
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Third party Administrator',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  insuranceDetailsModel.body.thirdPartyAdm,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                          ],
                        ),
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // Underline thickness
                            ),
                          ),
                        ),
                      ),
                      Container(
                          /* height: 70,
                      width: double.maxFinite,*/
                          /*  margin: const EdgeInsets.only(top: 6.0),*/
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sum Assured Amount',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  insuranceDetailsModel.body.sumAssuredAmt,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                          ],
                        ),
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // Underline thickness
                            ),
                          ),
                        ),
                      ),
                      Container(
                          /*height: 70,
                      width: double.maxFinite,*/
                          /*  margin: const EdgeInsets.only(top: 6.0),*/
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total insurance Amount',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  insuranceDetailsModel.body.totalInsAmount,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                          ],
                        ),
                      )),
                      /* Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0, // Underline thickness
                        ),
                      ),
                    ),
                  ),*/
                      /*  Container(
                    height: 50,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,*/

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Start Date',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black26),
                                    /*color: Colors.blue[50]*/
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        insuranceDetailsModel
                                            .body.policyStartDt,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            insuranceDetailsModel.body.strtDay,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black38),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            insuranceDetailsModel
                                                .body.strtMonthYear,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            /* Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0),
                child: Image.asset("assets/images/callambulance.png",height: 30,)
            ),
*/
                            CircularPercentIndicator(
                              radius: 100.0,
                              lineWidth: 10.0,
                              percent: 0.8,
                              header: new Text("Icon header"),
                              center: new Icon(
                                Icons.person_pin,
                                size: 50.0,
                                color: Colors.blue,
                              ),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'End Date',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black26),
                                    /*color: Colors.blue[50]*/
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        insuranceDetailsModel.body.policyEndDt,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            insuranceDetailsModel.body.endDay,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black38),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            insuranceDetailsModel
                                                .body.endMonthYear,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
