import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/BloodBankModel.dart'as ambulanceappoint;

import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart';

import 'package:user/widgets/MyWidget.dart';

class RequestBloodBank extends StatefulWidget {
  final MainModel model;

  const RequestBloodBank({Key key, this.model}) : super(key: key);

  @override
  _RequestBloodBankState createState() => _RequestBloodBankState();
}

class _RequestBloodBankState extends State<RequestBloodBank> {
  int _selectedDestination = -1;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  bool isdata =true;
  ambulanceappoint.BloodBankModel bloodbanklistModel;


  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
  static String toDate(String date) {
    if (date != null && date != "") {
      final DateTime formatter = DateFormat("yyyy-MM-dd").parse(date);
      DateFormat toNeed = DateFormat("dd-MM-yyyy");
      final String formatted = toNeed.format(formatter);
      return formatted;
    } else {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.BLOODBANK_ALL + loginResponse.body.user+"&status="+"7",
         userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                isdata =false;
                bloodbanklistModel =
                    ambulanceappoint.BloodBankModel.fromJson(map);
              });
            } else {
              isdata =false;
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
            'Requested',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          //leading: Icon(Icons.arrow_back, color: Colors.black),
        ),
        body:
        // (ambulanceAppointmentModel != null)
        //     ?
        isdata == true
            ? Center(
              child: CircularProgressIndicator(
          //backgroundColor: AppData.matruColor,
        ),
            )
            : bloodbanklistModel == null || bloodbanklistModel == null
            ? Container(
          child: Center(
            child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
          ),

        ):
        SingleChildScrollView(
          child: (bloodbanklistModel != null)
              ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // controller: _scrollController,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              if (i == bloodbanklistModel.body.length) {
                return (bloodbanklistModel.body.length % 10 == 0)
                    ? CupertinoActivityIndicator()
                    : Container();
              }
              ambulanceappoint.Body body = bloodbanklistModel.body[i];
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
                                /* widget.model.pharmacyorderModel=body;
                              Navigator.pushNamed(context, "/orderDetails");*/
                              },
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Name  ",
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        body.patientName,
                                        style: TextStyle(
                                            fontSize: 15),
                                        textAlign:
                                        TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Bloodgroup",
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        body.bloodGrName,
                                        style: TextStyle(
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Date",
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        toDate(body.bookedDate),
                                        //body.bookedDate,
                                        style: TextStyle(
                                            fontSize: 15),
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
                                      Spacer(),
                                      Text(
                                        body.patientNote,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            String orderid = body.orderId;
                                            rejectApi(orderid);
                                            callAPI();
                                          },
                                          child: Container(
                                            // height: size.height * 0.06,
                                            //width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black12),
                                                color: Colors.red[900]),
                                            child: RaisedButton(
                                              onPressed: null,
                                              child: Text(
                                                "Reject",
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
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            String orderid = body.orderId;
                                            acceptApi(orderid);
                                          },
                                          child: Container(
                                            // height: size.height * 0.06,
                                            //width: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black12),
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
                                  /*Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            String orderid = body.orderId;
                                            acceptApi(orderid);
                                           // callAPI();
                                          },
                                          child: Container(
                                            height: size.height * 0.06,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black12),
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
                                    Spacer(),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            String orderid = body.orderId;
                                            acceptApi(orderid);
                                          },
                                          child: Container(
                                            height: size.height * 0.06,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black12),
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
                                  ),*/
                               /*   Row(
                                    children: [
                                      Text(
                                        ' ',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Text(
                                        *//*'Confirmed'*//*
                                        body.status,
                                        textAlign: TextAlign.right,

                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize: 15,
                                            color: AppData
                                                .kPrimaryBlueColor),
                                      ),
                                    ],
                                  ),*/
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
            itemCount: bloodbanklistModel.body.length,
          )
              : Container(),
        ),
          /*  : Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                ),
                (isdata)
                    ? Text(
                  'No Data Found',
                  style:
                  TextStyle(color: Colors.black, fontSize: 15),
                )
                    : CircularProgressIndicator(),
              ],
            ),
          ),
        )*/
    );
  }


  Widget changeStatus(BuildContext context, String orderid) {
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
                  */ /*"Lisa Rani"*/ /*
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
                  title: Text("Accept"),
                  leading: Icon(Icons.check),
                  onTap: () {
/*
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.ambulance_APPOINTMENT_status +
                            orderid +
                            "&status=" +
                            "4",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              ambulanceallmodel =
                                  AmbulanceAllModel.fromJson(map);
                              AppData.showInSnackBar(context, msg);

                              // appointModel = lab.LabBookModel.fromJson(map);
                            } else {
                              // isDataNotAvail = true;
                              AppData.showInSnackBar(context, msg);
                            }
                          });
                        });
*/
                    //updateApi(userName.id.toString(), "0", i);
                  },
                ),
                Divider(
                  height: 2,
                ),
                ListTile(
                  title: Text("Reject"),
                  leading: Icon(Icons.cancel_outlined),
                  onTap: () {
/*
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.ambulance_APPOINTMENT_status +
                            orderid +
                            "&status=" +
                            "6",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              ambulanceallmodel =
                                  AmbulanceAllModel.fromJson(map);
                              AppData.showInSnackBar(context, msg);

                            } else {
                              // isDataNotAvail = true;
                              AppData.showInSnackBar(context, msg);
                            }
                          });
                        });
*/
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
  rejectApi(String orderid) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.bloodbank_status +
            orderid +
            "&status=" +
            "4",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
        //  setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              popup(msg, context);

            } else {
              // isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        //});
  }

  acceptApi(String orderid,) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.bloodbank_status +
            orderid +
            "&status=" +
            "2",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
         // setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
             // Navigator.of(context).pop();
              // appointModel = lab.LabBookModel.fromJson(map);
              popup(msg, context);
            } else {
              // isDataNotAvail = true;
             AppData.showInSnackBar(context, msg);
            }
          //});
        });
  }

  popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        title: "Success",
        desc: msg,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
              //Navigator.pop(context, true);
             Navigator.pop(context, true);
             Navigator.pop(context, true);
            // callAPI();

            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

}


