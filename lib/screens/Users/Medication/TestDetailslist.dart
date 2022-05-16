import 'dart:convert';
import 'dart:developer';

import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/PharmacycnfrmModel.dart';
import 'package:user/models/TestDetailslistModel.dart'as cnfrmorder;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestDetailslist extends StatefulWidget {
  final MainModel model;

  const TestDetailslist({Key key, this.model}) : super(key: key);

  @override
  _TestDetailslistState createState() => _TestDetailslistState();
}
class _TestDetailslistState extends State<TestDetailslist> {
  int _selectedDestination = -1;
  LoginResponse1 loginResponse1;
  int currentMax = 1;
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
  ScrollController _scrollController = ScrollController();
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  String pharamctorderid;
  bool isdata = false;
  cnfrmorder.TestDetailslistModel pharmacycnfrmModel;
  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI(currentMax);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (pharmacycnfrmModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });
    //callAPI();

  }
  callAPI(int i) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.GET_PATIENTALLLAB+loginResponse1.body.user+"&page="+ i.toString(),
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              if (i == 1) {
                pharmacycnfrmModel = cnfrmorder.TestDetailslistModel.fromJson(map);
                print('-Suvam----' + pharmacycnfrmModel.body.toString());
                //Navigator.pop(context);
              } else {
                pharmacycnfrmModel.addMore(map);
              }
              /*pharmacycnfrmModel = cnfrmorder.TestDetailslistModel.fromJson(map);*/
              isdata=false;
            } else {
              isdata=false;
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order history',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isdata == true
          ? Container(
        child: Center(
            child: Image.asset("assets/NoRecordFound.png",
              // height: 25,
              )
        ),
      ) : pharmacycnfrmModel == null
          ? Container(
          child:
          Center(
            child: CircularProgressIndicator(
              backgroundColor: AppData.matruColor,
            ),
          )
      )
          : Container(
        child: SingleChildScrollView(
            child: (pharmacycnfrmModel != null)
                ?ListView.builder(
              physics: NeverScrollableScrollPhysics(),
          // controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            if (i == pharmacycnfrmModel.body.length) {
              return (pharmacycnfrmModel.body.length % 10 == 0)
                  ? CupertinoActivityIndicator()
                  : Container();
            }
            cnfrmorder.Body body = pharmacycnfrmModel.body[i];
            return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                  child: Card(
                    child: Container(
                      //height: size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black12),
                          gradient: LinearGradient(colors: [
                            Colors.blueGrey[50],
                            Colors.blue[50]
                          ])),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OrderId: ',
                                style: TextStyle(
                                    color: AppData.kPrimaryColor),
                              ),
                              Text(body.orderId??"N/A"),
                            ],
                          ),

                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Test Name: ',
                                style: TextStyle(
                                    color: AppData.kPrimaryColor),
                              ),
                              Text(body.testname??"N/A"),
                            ],
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Test Group: ',
                                style: TextStyle(
                                    color: AppData.kPrimaryColor),
                              ),
                              Text(body.testgroup??"N/A"),
                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lab Name: ',
                                style: TextStyle(
                                    color: AppData.kPrimaryColor),
                              ),
                              Text(body.lab??"N/A"),
                            ],
                          ),

                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Request Date: ',
                                style: TextStyle(
                                    color: AppData.kPrimaryColor),
                              ),
                              Text(body.reqDate??"N/A"),
                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reject/Accept Date: ',
                                style: TextStyle(
                                    color: AppData.kPrimaryColor),
                              ),
                              Text(body.rejectDate??body?.acceptDate??""),
                            ],
                          ),
                          Row(
                            /*crossAxisAlignment:
                            CrossAxisAlignment.start,*/
                            children: [
                              Text(
                                'Remarks: ',
                                style: TextStyle(
                                    color: AppData.kPrimaryColor),
                              ),
                              Expanded(child: Text(body.remarks)),
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .end,
                            children: [
                              Text(
                                /*'Confirmed'*/
                                "",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 13),
                              ),
                              Spacer(),
                              body.status=="Reject"?
                              Text(body.status??"N/A",
                                style: TextStyle(

                                    fontSize: 15,
                                    color: Colors
                                        .red),
                              ):Container(),
                              body.status=="Confirm"?Text(body.status??"N/A",
                                  style: TextStyle(

                                      fontSize: 15,
                                      color: Colors
                                          .green)):Container(),
                              body.status=="Requested"? Text(body.status??"N/A",
                                style: TextStyle(

                                    fontSize: 15,
                                    color: Colors
                                        .orange),
                              ):Container(),
                              /*Text(
                                *//*'Confirmed'*//*
                                appointmentlist
                                    .status ??
                                    "N/A",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 15,
                                    color: Colors
                                        .green),
                              ),*/
                            ],
                          ),

                          /*Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Status: ',
                                style: TextStyle(
                                    color: AppData.kPrimaryColor),
                              ),
                              body.status=="Reject"?
                              Text(body.status??"N/A",
                                  style: TextStyle(

                                  fontSize: 15,
                                  color: Colors
                                      .red),
                    ):Container(),
                              body.status=="Confirm"?Text(body.status??"N/A",
                                style: TextStyle(

                                    fontSize: 15,
                                    color: Colors
                                        .green)):Container(),
                              body.status=="Requested"? Text(body.status??"N/A",
                                style: TextStyle(

                                    fontSize: 15,
                                    color: Colors
                                        .orange),
                              ):Container(),
                            ],
                          ),*/

                        ],
                      ),
                    ),
                  ),
            );
          },
        itemCount: pharmacycnfrmModel.body.length,
      )
    : Container()
        ),
    ),
         /* : Container(),*/
    );
  }
}
