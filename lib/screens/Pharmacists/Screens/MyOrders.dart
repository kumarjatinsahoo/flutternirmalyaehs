import 'dart:convert';
import 'dart:developer';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/PharmacyorderModel.dart' as oderlist;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/widgets/MyWidget.dart';

class MyOrders extends StatefulWidget {
  final MainModel model;

  const MyOrders({Key key, this.model}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int _selectedDestination = -1;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
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
    callAPI();
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
             // AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).text("ORDER_LIST"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        //leading: Icon(Icons.arrow_back, color: Colors.black),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: (pharmacyorderModel != null)
          ? ListView.builder(
              //physics: NeverScrollableScrollPhysics(),
              // controller: _scrollController,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                if (i == pharmacyorderModel.body.length) {
                  return (pharmacyorderModel.body.length % 10 == 0)
                      ? CupertinoActivityIndicator()
                      : Container();
                }
                oderlist.Body body = pharmacyorderModel.body[i];
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                                  widget.model.pharmacyorderModel = body;
                                  Navigator.pushNamed(
                                      context, "/confirmorder");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    /* Expanded(
                                  child: Image.asset(
                                    'assets/discount2.jpg',
                                    width: width * 0.4,
                                    // height: height,
                                    height: height * 0.17,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),*/
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                        /*  Text(
                                            'Name: ',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),*/
                                          Text(
                                            body.name,
                                            overflow: TextOverflow.clip,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 14,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                body.date,
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
                                                Icons.alarm,
                                                size: 15,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                body.time,
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                           Text(MyLocalizations.of(context).text("ORDER_ID"),
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            body.orderid,
                                            overflow: TextOverflow.clip,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(MyLocalizations.of(context).text("ADDRESS"),
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            body.address,
                                            overflow: TextOverflow.clip,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10.0, right: 10.0, bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      String orderid = body.orderid;
                                      String Status = "6";
                                      rejectApi(orderid, Status);
                                      callAPI();
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
                                        child: Text(MyLocalizations.of(context).text("REJECT"),
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
                                    onTap: () {
                                      acceptApi(body.orderid);
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
                                        child: Text(MyLocalizations.of(context).text("ACCEPT"),
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
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: pharmacyorderModel.body.length,
            )
          : Container(),
    );
  }

  rejectApi(String orderid, String status) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.CHANGE_STATUS_PHARMACY + orderid + "&status=6",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              popup(msg, context);
              // pocReportModel = PocReportModel.fromJson(map);
              //pharmacyorderModel = oderlist.PharmacyorderModel.fromJson(map);
              //  AppData.showInSnackBar(context, msg);

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
        api: ApiFactory.CHANGE_STATUS_PHARMACY + orderid + "&status=4",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              popup(msg, context);

            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
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
              //callAPI();

            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
}
