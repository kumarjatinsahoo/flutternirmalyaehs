import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:user/localization/localizations.dart';
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
  //DateTime selectedDate = DateTime.now();
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  final df = new DateFormat('dd-MM-yyyy');
  String selectedDatestr;
  bool isdata = false;

  var selectedMinValue;
  DateTime date = DateTime.now();
  monthly.MonthlyOverviewModel monthlyOverviewModel;
  LoginResponse1 loginResponse;
  Map<String, double> dataMap = Map();
  var booked, requested, treated;
  double bookedd, requestedd, treatedd;

// 0.0
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
        /*.add(Duration(days: 60))*/); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(picked));
        /*  widget.model.GETMETHODCALL(
            api: ApiFactory.VIEW_ATTENDANCE(
                partnerId: loginResponse.userData.partnerid,
                fromdate: fromThis_.text,
                todate: toThis_.text),
            fun: (Map<String, dynamic> map) {});*/
        /* print(">>>>>>>>>>API IS>>>>>>>>>>"+ApiFactory.VIEW_VIEWISSUEREPORT(
            partnerId: loginResponse.userData.partnerid,
            fromdate: fromThis_.text,
            //fromdate: "01/03/2021",
            todate: toThis_.text));*/
        /* widget.model.GETMETHODCALL(
            api: ApiFactory.VIEW_VIEWISSUEREPORT(
                partnerId: loginResponse.userData.partnerid,
                fromdate: fromThis_.text,
                //fromdate: "01/03/2021",
                todate: toThis_.text),
            //todate: "15/04/2021"),
            fun: (Map<String, dynamic> map) {
              setState(() {
                if (map[Const.STATUS] == Const.SUCCESS) {
                  issueREportModel=IssueReportModel.fromJson(map);
                } else {
                  AppData.showInSnackBar(context, map[Const.MESSAGE]);
                }
              });
            });*/
      });
  }

  final df1 = new DateFormat('dd-MM-yyyy');

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 60)),
        lastDate: DateTime.now()); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        toThis_.value = TextEditingValue(text: df1.format(picked));
      });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    print("Value is>>>>>>\n\n\n\n" + tod.toString());
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  //Reason _character = Reason.Absent;
  // DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    var df = DateFormat("dd-MM-yyyy");
    //fromThis_.text = df.format(date);
    fromThis_.text = df.format(DateTime(date.year, date.month, 1));
    toThis_.text = df.format(date);
    callApi(fromThis_.text, toThis_.text);

    //changeGraph();
  }

  // void changeGraph(x,y,z) {
  //   bookedd = double.parse(booked??"0");
  //   requestedd = double.parse(requested??"0");
  //   treatedd = double.parse(treated??"0");
  //   dataMap.putIfAbsent("Booked", () => bookedd);
  //   dataMap.putIfAbsent("Requested", () => requestedd);
  //   dataMap.putIfAbsent("Treated", () => treatedd);
  // }
  /* Map<String, double> dataMap = {
    "Confirmed":1,
    "Reruest": 1,
    "Recejcted": 5,

  };*/
  callApi(String fromdate, String todate) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.GET_PHARMACY_MONTHOVERVIEW +
            loginResponse.body.user +
            "&fromdate=" +
            fromdate +
            "&todate=" +
            todate,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                monthlyOverviewModel =
                    monthly.MonthlyOverviewModel.fromJson(map);
                String booked = monthlyOverviewModel.body.booked.toString();
                String requested =
                    monthlyOverviewModel.body.requested.toString();
                String treated = monthlyOverviewModel.body.treated.toString();

                double bookedd = double.parse(booked ?? "0");
                double requestedd = double.parse(requested ?? "0");
                double treatedd = double.parse(treated ?? "0");
                log("Value post>>"+bookedd.toString()+">>"+requestedd.toString()+">>"+treatedd.toString());
                dataMap.clear();
                dataMap.putIfAbsent("Booked", () => bookedd);
                dataMap.putIfAbsent("Requested", () => requestedd);
                dataMap.putIfAbsent("Treated", () => treatedd);

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
        title:Text(MyLocalizations.of(context).text("MONTHLY_OVERVIEW")),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
      ),
      body: (monthlyOverviewModel != null)
          ? Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /*  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                child: Expanded(
                          child: Container(
                           // width: 150,
                            child: Text(
                              "To Date",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        ),
                        //Spacer(),
                        Spacer(),
                        monthendDate(),
                        //Spacer(),
        */ /*Expanded(
          child:  monthstartDate(),
        ),*/ /*
                        //Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Expanded(
                          child: Container(
                            //width: 150,
                            child: Text(
                              "From Date",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ),
                        ),
                        Spacer(),
                        monthendDate(),
                        //Spacer(),
                      ],
                    ),*/
                    Container(
                      //height: 40,
                      margin: EdgeInsets.only(top: 15, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Text(MyLocalizations.of(context).text("FROM_DATE"),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Text(MyLocalizations.of(context).text("TO_DATE"),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            /*child: MyWidgets.dateUI("To this", _toThis, () {
                      }),*/
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //height: 40,
                      margin: EdgeInsets.only(top: 0, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print("Click done");
                                _selectDate(context);
                              },
                              child: AbsorbPointer(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: fromThis_,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.calendar_today),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: 'From Date',
                                      //labelText: 'Booking Date',
                                      alignLabelWithHint: false,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 10, top: 4, right: 4),
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
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print("Click done");
                                _selectDate1(context);
                              },
                              child: AbsorbPointer(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: toThis_,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.calendar_today),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: 'To Date',
                                      //labelText: 'Booking Date',
                                      alignLabelWithHint: false,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 10, top: 4, right: 4),
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
                            /*child: MyWidgets.dateUI("To this", _toThis, () {
                      }),*/
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: nextButton(),
                    ),
                    SizedBox(
                      height: 15,
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
                                    topRight: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                  color: Colors.green[500],
                                  border: Border.all(
                                    color: Colors.green[500],
                                    width: 1.0,
                                  )),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(MyLocalizations.of(context).text("CONFIRMED"),
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
                                        child: Text(
                                          monthlyOverviewModel.body.booked ??
                                              "N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //booked = int.parse('1');
                                      ),
                                      /* child: Image.asset(
                                            */ /* "assets/logo1.png"*/ /*
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
                                    topRight: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                  color: Colors.yellow[600],
                                  border: Border.all(
                                    color: Colors.yellow[600],
                                    width: 1.0,
                                  )),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(MyLocalizations.of(context).text("REQUESTED"),
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
                                        child: Text(
                                          monthlyOverviewModel.body.requested ??
                                              "N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      /* child: Image.asset(
                                            */ /* "assets/logo1.png"*/ /*
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
                                    topRight: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                  color: AppData.kPrimaryColor,
                                  border: Border.all(
                                    color: AppData.kPrimaryColor,
                                    width: 1.0,
                                  )),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(MyLocalizations.of(context).text("REJECTED"),
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
                                        child: Text(
                                          monthlyOverviewModel.body.treated ??
                                              "N/A",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      /* child: Image.asset(
                                            */ /* "assets/logo1.png"*/ /*
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
                          chartRadius: MediaQuery.of(context).size.width / 2.0,
                          colorList: <Color>[
                            Colors.green[500],
                            Colors.yellow[600],
                            AppData.kPrimaryColor
                          ],
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

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        callApi(fromThis_.text, toThis_.text);
        //callApi();
        //AppData.showInSnackBar(context, "Please select Title");
        //validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.blue, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(MyLocalizations.of(context).text("GO"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget monthstartDate() {
    return Container(
      height: 40,
      width: 190,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Icon(Icons.calendar_today),
          SizedBox(
            width: 5,
          ),
          Text(monthlyOverviewModel.body.todate ?? "N/A"),
        ],
      ),
    );
  }

  Widget monthendDate() {
    return Container(
      height: 40,
      width: 190,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Icon(Icons.calendar_today),
          SizedBox(
            width: 5,
          ),
          Text(monthlyOverviewModel.body.fromdate ?? "N/A"),
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

/*Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
        */ /*.add(Duration(days: 60))*/ /*); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(selectedDate));
        selectedDatestr = df.format(selectedDate).toString();
        //callAPI(selectedDatestr);
      });
  }*/
}
