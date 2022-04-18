import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:user/models/AmbulanceAllModel.dart' as ambulanceall;
import 'package:user/models/AmbulanceAllModel.dart';
import 'package:user/models/BloodBankModel.dart' as bloodbank;
import 'package:user/models/BloodbanklistModel.dart';
import 'package:user/models/PharmacyorderModel.dart' as oderlist;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/widgets/MyWidget.dart';

class AllBloodBank extends StatefulWidget {
  final MainModel model;

  const AllBloodBank({Key key, this.model}) : super(key: key);

  @override
  _AllBloodBankState createState() => _AllBloodBankState();
}

class _AllBloodBankState extends State<AllBloodBank> {
  int _selectedDestination = -1;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  bool isdata = true;

  bloodbank.BloodBankModel bloodbanklistModel;

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
    //isdata = true;
    callAPI();
  }

  callAPI() {
    //MyWidgets.showLoading(context);

    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.BLOODBANK_ALL +
            loginResponse.body.user +
            "&status=" +
            "",
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                isdata = false;
                bloodbanklistModel = bloodbank.BloodBankModel.fromJson(map);
              });
            } else {
              isdata = false;
              //isDataNotAvail = true;
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
            'Blood Bank',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          //leading: Icon(Icons.arrow_back, color: Colors.black),
        ),
        body: isdata == true
            ? /*showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            })*/
            Center(
                child: CircularProgressIndicator(),
              )
            /* ? Center(
              child: CircularProgressIndicator(
          backgroundColor: AppData.matruColor,
        ),
            )*/
            : bloodbanklistModel == null || bloodbanklistModel == null
                ? Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 300,
                          ),
                         Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: (bloodbanklistModel != null)
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // controller: _scrollController,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              if (i == bloodbanklistModel.body.length) {
                                return (bloodbanklistModel.body.length % 10 ==
                                        0)
                                    ? CupertinoActivityIndicator()
                                    : Container();
                              }
                              bloodbank.Body body = bloodbanklistModel.body[i];
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
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 140.00,
                                                        child: Text(
                                                          "Name ",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      // Spacer(),
                                                      Expanded(
                                                        child: Text(
                                                          body.patientName.trim(),
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                              TextAlign.start,
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
                                                          "Blood Group",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      //  Spacer(),
                                                      Expanded(
                                                        child: Text(
                                                          body.bloodGrName.trim(),
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                          TextAlign.start,
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
                                                        width: 140.00,
                                                        child: Text(
                                                          "Date",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      //  Spacer(),
                                                      Expanded(
                                                        child: Text(
                                                            toDate(body.bookedDate),
                                                          //body.bookedDate.trim(),
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                          TextAlign.start,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      //   Spacer(),
                                                      Expanded(
                                                        child: Text(
                                                          body.patientNote.trim(),
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          textAlign:
                                                          TextAlign.start,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  /* Row(
                                                children: [
                                                  Text(
                                                    ' ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            changeStatus(
                                                                context,
                                                                body.orderId),
                                                      );
                                                      // widget.model.userappointment = appointmentlist;

                                                      //  Navigator.pushNamed(context, "/usermedicinelist");
                                                    },
                                                    child: MaterialButton(
                                                      child: Text(
                                                        */ /*'Confirmed'*/ /*
                                                        "Status",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 15,
                                                            color: AppData
                                                                .kPrimaryBlueColor),
                                                      ),
                                                    ),
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
                  ));
  }
}
