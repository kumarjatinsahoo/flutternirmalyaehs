import 'dart:convert';
import 'dart:developer';

import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/PharmacycnfrmModel.dart'as cnfrmorder;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final MainModel model;

  const OrderDetails({Key key, this.model}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}
class _OrderDetailsState extends State<OrderDetails> {
  int _selectedDestination = -1;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  String pharamctorderid;
  bool isdata = false;
  cnfrmorder. PharmacycnfrmModel pharmacycnfrmModel;
  @override
  void initState() {
    super.initState();
    pharamctorderid=widget.model.pharmacyorderModel.orderid;
    callAPI();
  }
  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.ORDER_DETAILS_LAB+pharamctorderid ,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              pharmacycnfrmModel = cnfrmorder.PharmacycnfrmModel.fromJson(map);
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
          'Confirm Orders',
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
      )
          : pharmacycnfrmModel == null
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Test Name: ',
                                      style: TextStyle(
                                          color: AppData.kPrimaryColor),
                                    ),
                                    Text(body.name??"N/A"),
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
                                    Text(body.key??"N/A"),
                                  ],
                                ),

                              /*  Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Type: ',
                                      style: TextStyle(
                                          color: AppData.kPrimaryColor),
                                    ),
                                    Text(body.medtype??"N/A"),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),*/
                              ],
                            ),
                            /*Icon(Icons.more_vert)*/
                          ],
                        ),
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
