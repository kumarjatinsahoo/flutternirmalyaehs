import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user/scoped-models/MainModel.dart';

class PrintReportWebView extends StatefulWidget {
  MainModel model;

  PrintReportWebView({Key key, this.model}) : super(key: key);


  @override
  PrintReportWebViewState createState() => PrintReportWebViewState();
}

class PrintReportWebViewState extends State<PrintReportWebView> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //DateTime selectedDate = DateTime.now();

  StreamSubscription _connectionChangeStream;
  bool isOnline = false;
  Color bgColor = Colors.white;
  Color txtColor = Colors.black;

 /* List<KeyvalueModel> lists = [
    KeyvalueModel(),
    KeyvalueModel(),
    KeyvalueModel(),
    KeyvalueModel(),
    KeyvalueModel(),
    KeyvalueModel(),
    KeyvalueModel(),
    KeyvalueModel(),
  ];*/
  DateTime selectedDate = DateTime.now();
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  TextEditingController _intimeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  //BllinglistModel bllinglistModel = null;
  String time;




  //Reason _character = Reason.Absent;
  DateTime date = DateTime.now();
  //DateTime date1 = new DateTime(date.year, now.month+1, 0);
  //LoginResponse loginResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  /*  ConnectionStatusSingleton connectionStatus =
    ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);*/
    setState(() {
    // isOnline = connectionStatus.hasConnection;
    //loginResponse = widget.model.loginResponse;
   /* var df = DateFormat("dd/MM/yyyy");
    fromThis_.text = df.format(date);
    toThis_.text = df.format(date);*/

   /* widget.model.GETMETHODCALL(
        api: ApiFactory.VIEW_BILLINREPORT(
            partnerId: loginResponse.userData.partnerid,
            fromdate: fromThis_.text,
            //fromdate: "02/03/2021",
           todate: toThis_.text),
        //todate: "03/05/2021"),
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS] == Const.SUCCESS) {
              bllinglistModel=BllinglistModel.fromJson(map);
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


  final _key = UniqueKey();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BackButton(
          color: bgColor,
        ),
        title: Text(
          "print Repor",
          style: TextStyle(color: bgColor),
        ),
        backgroundColor:Color(0xFF0F6CE1),
      ),
      body: Column(
        children: [
          Expanded(
            /*child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: "https://sidhudkl.000webhostapp.com/api/groom.php?fromdate="+widget.model.fromdate+"&todate="+widget.model.todate+"&partnerId="+widget.model.empid,
             *//* initialUrl: ApiFactory.VIEW_PRINTREPORT(
                  partnerId: loginResponse.userData.partnerid,
                  fromdate: widget.model.fromdate,

                  //fromdate: "02/03/2021",
                  todate: widget.model.todate),*//*
            ),*/
          ),
        ],
      ),
     /* body: SafeArea(
        child: Container(
          color: bgColor,
          margin: EdgeInsets.only(left: 5, right: 5),
          height: MediaQuery.of(context).size.height,

        ),
      ),*/
    );
  }




  validate() async {
    _formKey.currentState.validate();
  }
}
