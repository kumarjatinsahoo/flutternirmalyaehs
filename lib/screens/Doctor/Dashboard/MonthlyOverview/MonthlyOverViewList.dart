import 'dart:convert';
import 'dart:developer';
import 'package:user/models/AmbulanceAllModel.dart' as ambulanceall;
import 'package:user/models/AmbulanceAllModel.dart';
import 'package:user/models/MonthlyoverviewlisModel.dart'as monthlyoverview;
import 'package:user/models/PharmacyorderModel.dart' as oderlist;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/widgets/MyWidget.dart';

class MonthlyOverviewlist extends StatefulWidget {
  final MainModel model;

  const MonthlyOverviewlist({Key key, this.model}) : super(key: key);

  @override
  _MonthlyOverviewlistState createState() => _MonthlyOverviewlistState();
}

class _MonthlyOverviewlistState extends State<MonthlyOverviewlist> {
  int _selectedDestination = -1;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  bool isdata = true;

  oderlist.PharmacyorderModel pharmacyorderModel;
  monthlyoverview.MonthlyOverviewlistModel monthlyOverviewlistModel;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
  }
  callAPI() {
    if(widget.model.apntUserType == Const.CONFIRMED) {
      widget.model.GETMETHODCALL_TOKEN(
          api: ApiFactory.GET_DOCTEROVERVIEWLIST + loginResponse.body.user +
              "&status=" + "2" + "&frmdt=" + widget.model.wfromdate + "&todt=" +
              widget.model.wtodate,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              log("Value>>>" + jsonEncode(map));
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                setState(() {
                  isdata=false;
                  monthlyOverviewlistModel = monthlyoverview.MonthlyOverviewlistModel.fromJson(map);
                });
              } else {
                setState(() {
                  isdata=false;
                  // isDataNoFound = true;
                });
                //AppData.showInSnackBar(context, msg);
              }
            });
          });
    }else if(widget.model.apntUserType == Const.REQUESTED){
      widget.model.GETMETHODCALL_TOKEN(
          api: ApiFactory.GET_DOCTEROVERVIEWLIST + loginResponse.body.user +
              "&status=" + "7" + "&frmdt=" + widget.model.wfromdate + "&todt=" +
              widget.model.wtodate,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              log("Value>>>" + jsonEncode(map));
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                setState(() {
                  isdata=false;
                  monthlyOverviewlistModel =
                      monthlyoverview.MonthlyOverviewlistModel.fromJson(map);
                });
              } else {
                setState(() {
                  isdata=false;
                  // isDataNoFound = true;
                });
                //AppData.showInSnackBar(context, msg);
              }
            });
          });

    }else if(widget.model.apntUserType == Const.TREATED){
      widget.model.GETMETHODCALL_TOKEN(
          api: ApiFactory.GET_DOCTEROVERVIEWLIST + loginResponse.body.user +
              "&status=" + "5" + "&frmdt=" + widget.model.wfromdate + "&todt=" +
              widget.model.wtodate,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              log("Value>>>" + jsonEncode(map));
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                setState(() {
                  isdata=false;
                  monthlyOverviewlistModel =
                      monthlyoverview.MonthlyOverviewlistModel.fromJson(map);
                });
              } else {
                setState(() {
                  isdata=false;
                });
                //AppData.showInSnackBar(context, msg);
              }
            });
          });

    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Monthly Overview List',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          //leading: Icon(Icons.arrow_back, color: Colors.black),
        ),
        body:  isdata == true
            ? Center(
              child: CircularProgressIndicator(
          //backgroundColor: AppData.matruColor,
        ),
            )
            : monthlyOverviewlistModel == null || monthlyOverviewlistModel == null
            ? Container(
          child: Center(
            child:Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
          ),

        ):
             SingleChildScrollView(
                child: (monthlyOverviewlistModel != null)
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // controller: _scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          if (i == monthlyOverviewlistModel.body.length) {
                            return (monthlyOverviewlistModel.body.length % 10 == 0)
                                ? CupertinoActivityIndicator()
                                : Container();
                          }
                          monthlyoverview.Body body = monthlyOverviewlistModel.body[i];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
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
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10,
                                            bottom: 5),
                                        child: InkWell(
                                          onTap: () {

                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    " Patient Name ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                          Text(
                                            "  :",
                                            style: TextStyle(
                                                fontSize: 15),

                                          ),
                                          Expanded(child:
                                                  Text(
                                                    body.patientname,
                                                    style: TextStyle(
                                                        fontSize: 15),

                                                  ),
                                          ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Request Date",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    "  :",
                                                    style: TextStyle(
                                                        fontSize: 15),

                                                  ),
                                                  Expanded(child:
                                                  Text(
                                                    body.reqDate,
                                                    style: TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),

                                              Row(
                                                children: [
                                                  Text(
                                                    'Patient Notes',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    "  :",
                                                    style: TextStyle(
                                                        fontSize: 15),

                                                  ),
                                                  Expanded(child:
                                                  Text(
                                                    body.patNote??"N/A",
                                                    style: TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
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
                        itemCount: monthlyOverviewlistModel.body.length,
                      )
                    : Container(),
              )
           );
  }



}
