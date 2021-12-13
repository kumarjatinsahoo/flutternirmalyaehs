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
  bool isdata = true;
  double value=0.0;

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
              // log("Value?>>>>"+jsonEncode(map));
              setState(() {
                insuranceDetailsModel =
                    insurancedetails.InsuranceDetailsModel.fromJson(map);
                value=calDifYear(insuranceDetailsModel.body.policyEndDt,insuranceDetailsModel.body.endMonthYear,insuranceDetailsModel.body.policyStartDt,insuranceDetailsModel.body.strtMonthYear);
                log("Value>>>>>>>>>>>>>>"+value.toString());
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

  calculate(date,month){
    return Const.getExpireDate(date,month).difference(DateTime.now()).inDays.toString();
  }

  calDifYear(date,month,date1,month1){
    // return Const.getExpireDate(date,month).difference(Const.getExpireDate(date1,month1)).inDays.toString();
    int totalDif=Const.getExpireDate(date,month).difference(Const.getExpireDate(date1,month1)).inDays;
    int difFromCurr=Const.getExpireDate(date,month).difference(DateTime.now()).inDays;
    return (difFromCurr/totalDif);
  }
/*
  calculateDifference(){
    int year=calDifYear
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppData.kPrimaryColor,
          title: Text("Insurance"),
          centerTitle: true,
        ),
        body: (insuranceDetailsModel != null)
            ? Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          insuranceDetailsModel
                                                  .body?.insCompany ??
                                              "N/A",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: AppData.kPrimaryColor),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Policy No: ' +
                                                  insuranceDetailsModel
                                                      .body.policyNo ??
                                              "N/A",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        /*Text(
                                  'Contact No:9020234567',
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                ),*/
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Insurance Type',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Third party Administrator',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          insuranceDetailsModel
                                              .body.thirdPartyAdm,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sum Assured Amount',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          insuranceDetailsModel
                                              .body.sumAssuredAmt,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total insurance Amount',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          insuranceDetailsModel
                                              .body.totalInsAmount,
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

                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Start Date',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black26),
                                            /*color: Colors.blue[50]*/
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 3,),
                                              Text(
                                                insuranceDetailsModel
                                                    .body.policyStartDt,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    insuranceDetailsModel
                                                        .body.strtDay,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color:
                                                        Colors.black38),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    insuranceDetailsModel
                                                        .body
                                                        .strtMonthYear,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                      Colors.black38,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    textAlign:
                                                    TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 3,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircularPercentIndicator(
                                    radius: 100.0,
                                    lineWidth: 10.0,
                                    percent: value,
                                    // header: new Text("Icon header"),
                                    center: Text(calculate(insuranceDetailsModel
                                        .body.policyEndDt,insuranceDetailsModel
                                        .body.endMonthYear)+" Days\nLeft",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'End Date',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black26),
                                            /*color: Colors.blue[50]*/
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 3,),
                                              Text(
                                                insuranceDetailsModel
                                                    .body.policyEndDt,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    insuranceDetailsModel
                                                        .body.endDay,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color:
                                                        Colors.black38),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    insuranceDetailsModel
                                                        .body.endMonthYear,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                      Colors.black38,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    textAlign:
                                                    TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 3,),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container());
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
