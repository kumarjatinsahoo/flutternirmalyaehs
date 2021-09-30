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

class ConfirmOrders extends StatefulWidget {
  final MainModel model;

  const ConfirmOrders({Key key, this.model}) : super(key: key);

  @override
  _ConfirmOrdersState createState() => _ConfirmOrdersState();
}
class _ConfirmOrdersState extends State<ConfirmOrders> {
  int _selectedDestination = -1;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  String pharamctorderid;
  cnfrmorder. PharmacycnfrmModel pharmacycnfrmModel;
  @override
  void initState() {
    super.initState();
    pharamctorderid=widget.model.pharmacyorderModel.orderid;
    callAPI();
  }
  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.PHARMACY_CNFRM_ORDER_LIST+pharamctorderid ,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              pharmacycnfrmModel = cnfrmorder. PharmacycnfrmModel.fromJson(map);

            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirm Orders',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body:
        (pharmacycnfrmModel != null)
            ?  ListView.builder(
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
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black12),
                            gradient: LinearGradient(colors: [
                              Colors.blueGrey[50],
                              Colors.blue[50]
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10, bottom: 10),
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
                                        'Medicine Name: ',
                                        style: TextStyle(
                                            color: AppData.kPrimaryColor),
                                      ),
                                      Text(body.medname??"N/A"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Quanitity : ',
                                        style: TextStyle(
                                            color: AppData.kPrimaryColor),
                                      ),
                                      Text(body.qty),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
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
                                  ),
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
            : Container(),
      ),
    );
  }
}
