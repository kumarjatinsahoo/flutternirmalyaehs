import 'dart:convert';
import 'dart:developer';
import 'package:user/models/AmbulanceAllModel.dart' as ambulanceall;
import 'package:user/models/AmbulanceAllModel.dart';
import 'package:user/models/PharmacyorderModel.dart' as oderlist;
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
  bool isdata = true;

  oderlist.PharmacyorderModel pharmacyorderModel;
  ambulanceall.AmbulanceAllModel ambulanceallmodel;

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
    widget.model.GETMETHODCALL(
        api: ApiFactory.AMBULANCE_ALL + loginResponse.body.user+ "&status=" +"",
        // userId: loginResponse.body.user,
        // token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                isdata = false;
                ambulanceallmodel =
                    ambulanceall.AmbulanceAllModel.fromJson(map);
              });
            } else {
              isdata = false;
             // isDataNotAvail = true;
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
        body:  isdata == true
            ? Center(
              child: CircularProgressIndicator(
          //backgroundColor: AppData.matruColor,
        ),
            )
            : ambulanceallmodel == null || ambulanceallmodel == null
            ? Container(
          child: Center(
            child: Text(
              'No Data Found',
              style:
              TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),

        ):
             SingleChildScrollView(
                child: (ambulanceallmodel != null)
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // controller: _scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          if (i == ambulanceallmodel.body.length) {
                            return (ambulanceallmodel.body.length % 10 == 0)
                                ? CupertinoActivityIndicator()
                                : Container();
                          }
                          ambulanceall.Body body = ambulanceallmodel.body[i];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            child: Card(
                              child: Container(
                                //height: height * 0.30,
                                // color: Colors.grey[200],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

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

                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 140,
                                                    child: Text(
                                                      "Name ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      body.patientName,
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
                                                  Container(
                                                    width: 140,
                                                    child: Text(
                                                      "From",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                 child: Text(
                                                    body.fromLocation,
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
                                                  Container(
                                                    width: 140,
                                                    child: Text(
                                                      "Destination",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                 child: Text(
                                                    body.toDestination,
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
                                                  Container(
                                                    width: 140,
                                                    child: Text(
                                                      'Patient Notes',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      body.patientNote,
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
                        itemCount: ambulanceallmodel.body.length,
                      )
                    : Container(),
              )
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
