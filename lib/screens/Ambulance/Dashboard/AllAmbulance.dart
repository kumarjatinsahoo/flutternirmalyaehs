import 'dart:convert';
import 'dart:developer';

import 'package:user/models/PharmacyorderModel.dart'as oderlist;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/widgets/MyWidget.dart';

class AllAmbulance extends StatefulWidget {
  final MainModel model;

  const AllAmbulance({Key key, this.model}) : super(key: key);

  @override
  _AllAmbulanceState createState() => _AllAmbulanceState();
}

class _AllAmbulanceState extends State<AllAmbulance> {
  int _selectedDestination = -1;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  bool isdata = false;

  oderlist.PharmacyorderModel pharmacyorderModel;
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
   // callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.ORDER_LIST + loginResponse.body.user,
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                pharmacyorderModel = oderlist.PharmacyorderModel.fromJson(map);
              });

            } else {
              isDataNotAvail = true;
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ambulance',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        //leading: Icon(Icons.arrow_back, color: Colors.black),

      ),
      body:

     SingleChildScrollView(
        child: ListView.builder(
          //physics: NeverScrollableScrollPhysics(),
          // controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (context, i) {
           /* if (i == pharmacyorderModel.body.length) {
              return (pharmacyorderModel.body.length % 10 == 0)
                  ? CupertinoActivityIndicator()
                  : Container();
            }
            oderlist.Body body = pharmacyorderModel.body[i];*/
            return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
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
                            onTap: () {
                             /* widget.model.pharmacyorderModel=body;
                              Navigator.pushNamed(context, "/orderDetails");*/
                            },
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 14,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Name",
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "",
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 15,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "From",
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        " ",
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 15,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "To",
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        " ",
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Patient Notes: ',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        'Patient Notes: ',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        ' ',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                           showDialog(
                                    context: context,
                                    builder: (BuildContext
                                    context) =>
                                        changeStatus(context),
                                  );
                                          // widget.model.userappointment = appointmentlist;


                            //  Navigator.pushNamed(context, "/usermedicinelist");
                                        },
                                        child: MaterialButton(
                                          child: Text(
                                            /*'Confirmed'*/
                                            "Status",
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                fontSize:
                                                15,
                                                color: Colors
                                                    .white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Spacer(),
                    /*  Padding(
                        padding: const EdgeInsets.only(top: 10,
                            left: 10.0, right: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  rejectApi(body.orderid);

                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.red[900]),
                                  child: RaisedButton(
                                    onPressed: null,
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    disabledColor: Colors.red[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  acceptApi(body.orderid);
                                },
                                child: Container(
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.blue),
                                  child: RaisedButton(
                                    onPressed: null,
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    disabledColor: Colors.blue[600],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )*/
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount:5,
         // itemCount: pharmacyorderModel.body.length,
        ),
      ),
          // : Container(),
    );
  }

  rejectApi(String orderid) {
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.CHANGE_STATUS_LAB +orderid+"&status=6",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              //pharmacyorderModel = oderlist.PharmacyorderModel.fromJson(map);
              //  AppData.showInSnackBar(context, msg);
              callAPI();

            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  acceptApi(String orderid) {
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.CHANGE_STATUS_LAB +orderid+"&status=4",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              callAPI();
              AppData.showInSnackDone(context, msg);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
  Widget changeStatus(BuildContext context) {
    //NomineeModel nomineeModel = NomineeModel();
    //Nomine
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 20),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text(
                  "CHANGE STATUS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
             /*   Text(
                  *//*"Lisa Rani"*//*
                  patname,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),*/
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text("Confirm"),
                  leading: Icon(Icons.check),
                  onTap: () {
                   /* widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +
                            doctorName +
                            "&appstatus=" +
                            "2",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              doctorAppointmment =
                                  DoctorAppointmment.fromJson(map);
                              AppData.showInSnackBar(context, msg);

                              // appointModel = lab.LabBookModel.fromJson(map);
                            } else {
                              // isDataNotAvail = true;
                              AppData.showInSnackBar(context, msg);
                            }
                          });
                        });*/
                    //updateApi(userName.id.toString(), "0", i);
                  },
                ),
                Divider(
                  height: 2,
                ),
                ListTile(
                  title: Text("Cancel"),
                  leading: Icon(Icons.cancel_outlined),
                  onTap: () {
                   /* widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +
                            doctorName +
                            "&appstatus=" +
                            "4",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              doctorAppointmment =
                                  DoctorAppointmment.fromJson(map);
                              AppData.showInSnackBar(context, msg);
                              Navigator.of(context).pop();
                              // appointModel = lab.LabBookModel.fromJson(map);
                            } else {
                              // isDataNotAvail = true;
                              AppData.showInSnackBar(context, msg);
                            }
                          });
                        });*/
                    //updateApi(userName.id.toString(), "1", i);
                  },
                ),
                /*Divider(
                  height: 2,
                ),*/
                /* ListTile(
                  title: Text("COMPLETED"),
                  leading: Icon(Icons.done_outline_outlined),
                  onTap: () {
//                    updateApi(userName.id.toString(), "2", i);
                  },
                )*/
              ],
            ),
          );
        },
      ),

      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("CANCEL"),
        ),
      ],
    );
  }

}
