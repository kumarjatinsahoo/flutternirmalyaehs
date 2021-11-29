import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MonthlyoverviewModel.dart'as monthly;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class MonthlyOverview extends StatefulWidget {
  MainModel model;

  MonthlyOverview({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MonthlyOverview();
}

class _MonthlyOverview extends State<MonthlyOverview> {
  DateTime selectedDate = DateTime.now();

  // apnt.AppointmentlistModel appointmentlistModel;
  //LoginResponse1 loginResponse;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  bool isdata = false;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  monthly.MonthlyOverviewModel monthlyOverviewModel;
  LoginResponse1 loginResponse;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callApi();

  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.MONTHLY_OVERVIEW + loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                monthlyOverviewModel =
                    monthly.MonthlyOverviewModel.fromJson(map);
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


  @override
  Widget build(BuildContext context) {
   // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Overview'),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
      ),
      body: (monthlyOverviewModel != null)? Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 150,
                      child: Text(
                        "To Date",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  monthstartDate(),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 150,
                      child: Text(
                        "From Date",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  monthendDate(),
                  Spacer(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Material(
                          elevation: 5,
                          color: Colors.green[500],
                          borderRadius:
                          BorderRadius
                              .circular(
                              3.0),
                          child:

                          Expanded(
                            child: MaterialButton(
                              minWidth: 90,
                              height: 80.0,
                              child: Column(
                                children: [
                                  Text(
                                    "CONFIRMED",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        fontSize:
                                        13,
                                        color: Colors
                                            .white),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(monthlyOverviewModel.body.booked??"N/A",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Material(
                          elevation: 5,
                          color: Colors.yellow[600]
                              ,
                          borderRadius:
                          BorderRadius
                              .circular(
                              3.0),
                          child:
                          Expanded(
                            child: MaterialButton(
                              minWidth: 90,
                              height: 80.0,
                              child: Column(
                                children: [
                                  Text(
                                    "REQUESTED",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        fontSize:
                                        12,
                                        color: Colors
                                            .white),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(monthlyOverviewModel.body.requested??"N/A",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),

                            ),

                          ),
                        ),

                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Material(
                          elevation: 5,
                          color: AppData
                              .kPrimaryColor,
                          borderRadius:
                          BorderRadius
                              .circular(
                              3.0),
                          child:
                          Expanded(
                            child: MaterialButton(
                              minWidth: 100,
                              height: 80.0,
                              child: Column(
                                children: [
                                  Text(
                                    "TREATED",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        fontSize:
                                        12,
                                        color: Colors
                                            .white),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(monthlyOverviewModel.body.treated??"N/A",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ):Container(),
    );
  }
  Widget monthstartDate(){
    return Container(
      height: 40,
      width: 190,
      margin: EdgeInsets.only(top: 20, bottom: 10),
   child: Row(
        children: [
          Icon(Icons.calendar_today),
          SizedBox(width:5,),
          Text(monthlyOverviewModel.body.todate??"N/A"),
        ],
      ),

    );

}
Widget monthendDate(){
    return Container(
      height: 40,
      width: 190,
      margin: EdgeInsets.only(top: 20, bottom: 10),


   child: Row(
        children: [
          Icon(Icons.calendar_today),
          SizedBox(width:5,),
          Text(monthlyOverviewModel.body.fromdate??"N/A"),
        ],
      ),

    );

}

  Widget appointdate() {
    return Container(
      height: 40,
      width: 190,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: InkWell(
        onTap: () {
          print("Click done");
          _selectDate(context);
        },
        child: AbsorbPointer(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              autofocus: false,
              controller: fromThis_,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'From this',
                //labelText: 'Booking Date',
                alignLabelWithHint: false,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
        /*.add(Duration(days: 60))*/); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(selectedDate));
        selectedDatestr = df.format(selectedDate).toString();
        //callAPI(selectedDatestr);
      });
  }
}
