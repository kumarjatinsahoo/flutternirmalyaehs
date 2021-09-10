import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/ConnectionStatusSingleton.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class MedicinReportPage extends StatefulWidget {
  MainModel model;

  MedicinReportPage({Key key, this.model}) : super(key: key);

  @override
  _MedicinReportPageState createState() => _MedicinReportPageState();
}

class _MedicinReportPageState extends State<MedicinReportPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<KeyvalueModel> lists = [
    KeyvalueModel(),
    KeyvalueModel(),
  ];
  DateTime selectedDate = DateTime.now();
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  TextEditingController _intimeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  //IssueReportModel issueREportModel = null;
  StreamSubscription _connectionChangeStream;
  bool isOnline = false;
  bool isOnliIssuelistModelne = false;
  //PurchaseledgerModel purchaseledgerModel = null;
  String time;

  final df = new DateFormat('dd/MM/yyyy');

  /*Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
      *//*.add(Duration(days: 60))*//*); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(picked));
          widget.model.GETMETHODCALL(
            api: ApiFactory.VIEW_ATTENDANCE(
                partnerId: "26",
                fromdate: fromThis_.text,
                todate: toThis_.text),
            fun: (Map<String, dynamic> map) {});
        print(">>>>>>>>>>API IS>>>>>>>>>>"+ApiFactory.VIEW_VIEWISSUEREPORT(
            partnerId: "26",
            fromdate: fromThis_.text,
            //fromdate: "01/03/2021",
            todate: toThis_.text));
        widget.model.GETMETHODCALL(
            api: ApiFactory.VIEW_VIEWISSUEREPORT(
                partnerId:"26",
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
            });
      });
  }
*/
  final df1 = new DateFormat('dd/MM/yyyy');

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
    print("Value is>>>>>>\n\n\n\n"+tod.toString());
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }

  //Reason _character = Reason.Absent;
  DateTime date = DateTime.now();
  //DateTime date1 = new DateTime(date.year, now.month+1, 0);
  //LoginResponse loginResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConnectionStatusSingleton connectionStatus =
    ConnectionStatusSingleton.getInstance();
   /* _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);*/
    setState(() {
      isOnline = connectionStatus.hasConnection;
     // loginResponse = widget.model.loginResponse;
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      toThis_.text = df.format(date);
      /*print(">>>>>>>>>>API IS>>>>>>>>>>"+ApiFactory.VIEW_VIEWISSUEREPORT(
          partnerId: "26",
          fromdate: fromThis_.text,
          //fromdate: "01/03/2021",
          todate: toThis_.text));*/
      /*widget.model.GETMETHODCALL(
          api: ApiFactory.VIEW_VIEWISSUEREPORT(
              partnerId: "26",
              fromdate: fromThis_.text,
              //fromdate: "02/03/2021",
              todate: toThis_.text),
          //todate: "03/05/2021"),
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

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }
  double valueWidth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    valueWidth=size.width/4-10;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Medicine List"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            /*  MyWidgets.search(() {
                AppData.showInSnackBar(context, "Hi buddy");
              }),*/
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 4),
                child: MyWidgets.header("Medicine List", Alignment.topLeft),
              ),
              /*Row(children: [
                MyWidgets.dateUI("From this", _fromThis,_selectDate(context)),

              ],),*/
              SizedBox(
                height: 10,
              ),
              /*Container(
                height: 40,
                margin: EdgeInsets.only(top: 10, bottom: 10),
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
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextFormField(
                              autofocus: false,
                              controller: fromThis_,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                hintText: 'From this',
                                //labelText: 'Booking Date',
                                alignLabelWithHint: false,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                contentPadding:
                                EdgeInsets.only(left: 10, top: 4, right: 4),
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
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextFormField(
                              autofocus: false,
                              controller: toThis_,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                hintText: 'To this',
                                //labelText: 'Booking Date',
                                alignLabelWithHint: false,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                contentPadding:
                                EdgeInsets.only(left: 10, top: 4, right: 4),
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
                      *//*child: MyWidgets.dateUI("To this", _toThis, () {
                      }),*//*
                    ),
                  ],
                ),
              ),*/
             /* SizedBox(
                height: 20,
              ),*/
             /* (issueREportModel != null &&
                  issueREportModel.issuereport != null &&
                  issueREportModel.issuereport.length > 0)
                  ?*/SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: _dataTable(),
                ),
              )/*: MyWidgets.loading(context),*/
            ],
          ),
        ),
      ),
    );
  }

  DataTable _dataTable() {
    /*MaterialStateProperty<Colors> material=[
      Colors.red
    ];*/
    return DataTable(
        onSelectAll: (b) {},
        //dataRowHeight: 3,
        columnSpacing: 6,
        horizontalMargin: 5,
        headingRowHeight: 40,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => AppData.greyBorder),
        // sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
            label: Container(
              //color: Colors.red,
              width: valueWidth,
              child: Center(
                child: Text(
                  'Item Name',
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              //color: Colors.red,'
              width: valueWidth,
              alignment: Alignment.center,
              child: Text(
                "QTY",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            numeric: false,
            tooltip: "To display first name of the Name",
          ),
          DataColumn(
            label: Container(
              width: valueWidth,
              child: Center(
                child: Text(
                  "Issue To",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Container(
              width: valueWidth,
              child: Center(
                child: Text(
                  "Issued Dt",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
        rows: /*issueREportModel.issuereport*/lists
            .asMap()
            .map((i, data) => MapEntry(
                  i,
                  DataRow(
                    // selected: true,
                    cells: [
                      /*DataCell(Container(
                  width: 10, //SET width
                  child: Text('${i + 1}'))),*/
                      DataCell(
                        Container(
                          width: valueWidth,
                          child: Center(
                            child: Text(
                             /* data.itemName*/"mona",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // showEditIcon: true,
                        // placeholder: true,
                      ),
                      DataCell(
                        Container(
                          width: valueWidth,
                          child: Center(
                            child: Text(/*data.quantity*/"4",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Container(
                            width: valueWidth,
                            child: Center(
                                child: Text(
                              /*data.issueTo*/"12345",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ))),
                      ),
                      DataCell(
                        Container(
                            width: valueWidth,
                            child: Center(
                                child: Text(/*data.issueDate*/"06/02/2021",
                                    style: TextStyle(color: Colors.black)))),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                    ],
                  ),
                ))
            .values
            .toList());
  }
}
