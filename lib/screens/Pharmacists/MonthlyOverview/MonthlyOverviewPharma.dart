import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MonthlyoverviewModel.dart' as monthly;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class MonthlyOverviewPharma extends StatefulWidget {
  MainModel model;

  MonthlyOverviewPharma({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MonthlyOverview();
}

class _MonthlyOverview extends State<MonthlyOverviewPharma> {
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
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,

  };
  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.GET_PHARMACY_MONTHOVERVIEW + loginResponse.body.user,
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
      body: (monthlyOverviewModel != null)
          ? Container(
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
                          InkWell(
                            onTap: () {
                              widget.model.apntUserType = Const.CONFIRMED;
                              widget.model.wtodate =
                                  monthlyOverviewModel.body.todate;
                              widget.model.wfromdate =
                                  monthlyOverviewModel.body.fromdate;
                              Navigator.pushNamed(
                                  context, "/monthlyOverviewPharmaklist");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              /* height: MediaQuery.of(context).size.height * 0.23,*/
                              height: 85,
                              width: 110,
                              decoration: BoxDecoration(

                                /// borderRadius: BorderRadius.circular(7.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight:Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                  color:  Colors.green[500],
                                  border: Border.all(
                                    color: Colors.green[500],
                                    width: 1.0,
                                  )
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.center,
                                        child: Text(
                                          "CONFIRMED",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      Align(
                                        alignment: Alignment.center,
                                        child:Text(
                                          monthlyOverviewModel.body.booked ?? "N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                         /* child: Image.asset(
                                            *//* "assets/logo1.png"*//*
                                            icon,
                                            fit: BoxFit.fitWidth,
                                            width: 50,
                                            height: 50.0,
                                            color:AppData.kPrimaryColor,
                                          )*/
                                    ],
                                  ),

                                ],
                              ),
                            ),

                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              widget.model.apntUserType = Const.REQUESTED;
                              widget.model.wtodate =
                                  monthlyOverviewModel.body.todate;
                              widget.model.wfromdate =
                                  monthlyOverviewModel.body.fromdate;
                              Navigator.pushNamed(
                                  context, "/monthlyOverviewPharmaklist");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              /* height: MediaQuery.of(context).size.height * 0.23,*/
                              height: 85,
                              width: 110,
                              decoration: BoxDecoration(

                                /// borderRadius: BorderRadius.circular(7.0),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight:Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                  color:  Colors.yellow[600],
                                  border: Border.all(
                                    color: Colors.yellow[600],
                                    width: 1.0,
                                  )
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "REQUESTED",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child:Text(
                                          monthlyOverviewModel.body.requested ?? "N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      /* child: Image.asset(
                                            *//* "assets/logo1.png"*//*
                                            icon,
                                            fit: BoxFit.fitWidth,
                                            width: 50,
                                            height: 50.0,
                                            color:AppData.kPrimaryColor,
                                          )*/
                                    ],
                                  ),

                                ],
                              ),
                            ),

                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              widget.model.apntUserType = Const.TREATED;
                              widget.model.wtodate =
                                  monthlyOverviewModel.body.todate;
                              widget.model.wfromdate =
                                  monthlyOverviewModel.body.fromdate;
                              Navigator.pushNamed(
                                  context, "/monthlyOverviewPharmaklist");
                            }, child: Container(
                            padding: const EdgeInsets.all(0.0),
                            /* height: MediaQuery.of(context).size.height * 0.23,*/
                            height: 85,
                            width: 110,
                            decoration: BoxDecoration(

                              /// borderRadius: BorderRadius.circular(7.0),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight:Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                ),
                                color: AppData.kPrimaryColor,
                                border: Border.all(
                                  color: AppData.kPrimaryColor,
                                  width: 1.0,
                                )
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "REJECTED",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child:Text(
                                        monthlyOverviewModel.body.treated ?? "N/A",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    /* child: Image.asset(
                                            *//* "assets/logo1.png"*//*
                                            icon,
                                            fit: BoxFit.fitWidth,
                                            width: 50,
                                            height: 50.0,
                                            color:AppData.kPrimaryColor,
                                          )*/
                                  ],
                                ),

                              ],
                            ),
                          ),

                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: PieChart(
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 1.5,
                          //colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 100,
                          //centerText: "HYBRID",
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: false,
                            //legendShape: _BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                          // gradientList: ---To add gradient colors---
                          // emptyColorGradient: ---Empty Color gradient---
                        ),
                      ),
                    )
      /*PieChart(
        PieChartData(
          // read about it in the PieChartData section
        ),
        swapAnimationDuration: Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),*/
                  ],
                ),
              ),
            )
          : Container(),
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
