import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/DocterAppointmentlistModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentRequested extends StatefulWidget {
  MainModel model;

  DoctorAppointmentRequested({Key key, this.model}) : super(key: key);

  @override
  _DoctorAppointmentRequestedState createState() =>
      _DoctorAppointmentRequestedState();
}

class _DoctorAppointmentRequestedState
    extends State<DoctorAppointmentRequested> {
  DateTime selectedDate = DateTime.now();
  DoctorAppointmment doctorAppointmment;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  bool isdata = true;

  DateTime date = DateTime.now();

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr = df.format(date).toString();
      //toThis_.text = df.format(date);
      callAPI(selectedDatestr);
    });
  }

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
        fromThis_.value = TextEditingValue(text: df.format(selectedDate));
        selectedDatestr = df.format(selectedDate).toString();
        callAPI(selectedDatestr);
      });
  }

  leftArrow() {
    setState(() {
      selectedDate = selectedDate.subtract(Duration(days: 1));
      fromThis_.value = TextEditingValue(text: df.format(selectedDate));
      selectedDatestr = df.format(selectedDate).toString();
      callAPI(selectedDatestr);
    });
  }

  rightArrow() {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: 1));
      fromThis_.value = TextEditingValue(text: df.format(selectedDate));
      selectedDatestr = df.format(selectedDate).toString();
      callAPI(selectedDatestr);
    });
  }

  callAPI(String today) {
    /*if (comeFrom == Const.HEALTH_SCREENING_APNT) {*/
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.doctor_APPOINTMENT_LIST +
            widget.model.user +
            "&date=" +
            today +
            "&status=" +
            "7",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata = false;
              doctorAppointmment = DoctorAppointmment.fromJson(map);
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              isdata = false;
              doctorAppointmment=null;
              // isDataNotAvail = true;
/*
              AppData.showInSnackBar(context, msg);
*/
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //appointdate(),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      leftArrow();
                    },
                    child: Icon(
                      CupertinoIcons.arrow_left_circle,
                      size: 38,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appointdate(),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      rightArrow();
                    },
                    child: Icon(
                      CupertinoIcons.arrow_right_circle,
                      size: 38,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              isdata == true
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          CircularProgressIndicator(
                              //backgroundColor: AppData.matruColor,
                              ),
                        ],
                      ),
                    )
                  : doctorAppointmment == null || doctorAppointmment == null
                      ? Container(
                          child: Center(
                            child: Image.asset("assets/NoRecordFound.png",
                                          // height: 25,
                                        ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            Body appointmentlist = doctorAppointmment.body[i];
                            String date = appointmentlist.appdate +
                                "-" +
                                appointmentlist.appmonth +
                                "-" +
                                appointmentlist.appyear;
                            String name = appointmentlist.patname;
                            return InkWell(
                              onTap: () {
                                /* showDialog(
                                    context: context,
                                    builder: (BuildContext
                                    context) =>
                                        changeStatus(
                                            context,
                                            appointmentlist
                                                .patname,
                                            appointmentlist
                                                .doctorName),
                                  );*/
                                /* widget.model.userappointment = appointmentlist;


                              Navigator.pushNamed(context, "/usermedicinelist");*/
                              },
                              child: Column(
                                children: [
                                  Padding(
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
                                                  gradient: LinearGradient(
                                                      colors: [
                                                    Colors.blueGrey[50],
                                                    Colors.blue[50]
                                                  ])),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 10,
                                                    bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(MyLocalizations.of(context).text("USER_NAME1"),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Spacer(),
                                                              Text(
                                                                appointmentlist
                                                                        .status ??
                                                                    "N/A",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                            .yellow[
                                                                        700]),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            appointmentlist
                                                                    .patname ??
                                                                "N/A",
                                                            /*"",*/
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(MyLocalizations.of(context).text("GENDER"),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            appointmentlist
                                                                    .gender ??
                                                                "N/A",
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(MyLocalizations.of(context).text("AGE"),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                appointmentlist
                                                                        .age ??
                                                                    "N/A",
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(MyLocalizations.of(context).text("DATE"),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                /*'23-Nov-2020-11:30AM'*/
                                                                appointmentlist
                                                                        .appdate ??
                                                                    "N/A",
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                /*'23-Nov-2020-11:30AM'*/
                                                                "-" +
                                                                        appointmentlist
                                                                            .appmonth ??
                                                                    "N/A",
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                /*'23-Nov-2020-11:30AM'*/
                                                                "-" +
                                                                        appointmentlist
                                                                            .appyear ??
                                                                    "N/A",
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),

                                                          Text(
                                                            MyLocalizations.of(context).text("TIME"),
                                                            style: TextStyle(
                                                                color:
                                                                Colors.blue,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            /*'23-Nov-2020-11:30AM'*/
                                                            appointmentlist
                                                                .apptime ??
                                                                "N/A",
                                                            overflow:
                                                            TextOverflow
                                                                .clip,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize: 15),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(MyLocalizations.of(context).text("ADDRESS"),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            /*'23-Nov-2020-11:30AM'*/
                                                            appointmentlist
                                                                    .address ??
                                                                "N/A",
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(MyLocalizations.of(context).text("PATIENT_NOTES"),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            /*'23-Nov-2020-11:30AM'*/
                                                            appointmentlist
                                                                    .notes ??
                                                                "N/A",
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      widget.model.GETMETHODCALL_TOKEN(
                                                                          api: ApiFactory.user_APPOINTMENT_status + appointmentlist.doctorName + "&appstatus=" + "4",
                                                                          token: widget.model.token,
                                                                          fun: (Map<String, dynamic> map) {
                                                                            //Navigator.pop(context);
                                                                            if (map[Const.CODE] ==
                                                                                Const.SUCCESS) {
                                                                              rejectedPopup(context, map[Const.MESSAGE], name, date);
                                                                            } else {
                                                                              AppData.showInSnackBar(context, map[Const.MESSAGE]);
                                                                            }
                                                                          });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                          height: size
                                                                              .height *
                                                                              0.06,
                                                                          width: size
                                                                              .height *
                                                                              0.20,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          border:
                                                                              Border.all(color: Colors.black12),
                                                                          color: Colors.red[900]),
                                                                      child:
                                                                          RaisedButton(
                                                                        onPressed:
                                                                            null,
                                                                        child:
                                                                            Text(
                                                                          MyLocalizations.of(context)
                                                                              .text("REJECT"),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                        disabledColor:
                                                                            Colors.red[900],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Spacer(),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      widget.model.GETMETHODCALL_TOKEN(
                                                                          api: ApiFactory.user_APPOINTMENT_status + appointmentlist.doctorName + "&appstatus=" + "2",
                                                                          token: widget.model.token,
                                                                          fun: (Map<String, dynamic> map) {
                                                                            setState(() {
                                                                              if (map[Const.CODE] == Const.SUCCESS) {
                                                                                popup(context, map[Const.MESSAGE], name, date);
                                                                              } else {
                                                                                AppData.showInSnackBar(context, map[Const.MESSAGE]);
                                                                              }
                                                                            });
                                                                          });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height: size
                                                                              .height *
                                                                          0.06,
                                                                      width: size
                                                                              .height *
                                                                          0.20,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          border:
                                                                              Border.all(color: Colors.black12),
                                                                          color: Colors.blue),
                                                                      child:
                                                                          RaisedButton(
                                                                        onPressed:
                                                                            null,
                                                                        child:
                                                                            Text(
                                                                          MyLocalizations.of(context)
                                                                              .text("ACCEPT"),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                        disabledColor:
                                                                            Colors.blue[600],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
/*                                  Padding(
                                    padding:
                                    const EdgeInsets.all(
                                        5.0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .end,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              */ /*'Confirmed'*/ /*
                                              appointmentlist
                                                  .status ??
                                                  "N/A",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize:
                                                  15,
                                                  color: Colors
                                                      .yellow[
                                                  900]),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            widget.model
                                                .GETMETHODCALL_TOKEN(
                                                api: ApiFactory
                                                    .user_APPOINTMENT_status +
                                                    appointmentlist
                                                        .doctorName +
                                                    "&appstatus=" +
                                                    "2",
                                                token: widget
                                                    .model
                                                    .token,
                                                fun: (Map<
                                                    String,
                                                    dynamic>
                                                map) {
                                                  setState(
                                                          () {
                                                        String
                                                        msg =
                                                        map[Const.MESSAGE];
                                                        if (map[Const.CODE] ==
                                                            Const.SUCCESS) {
                                                          Navigator.of(context).pop();
                                                          //Navigator.of(context).pop();
                                                          doctorAppointmment =
                                                              DoctorAppointmment.fromJson(map);
                                                          // AppData.showInSnackBar(context, msg);
                                                          Navigator.of(context).pop();

                                                          // Navigator.pushNamed(context, "/dashDoctor");

                                                          // appointModel = lab.LabBookModel.fromJson(map);
                                                        } else {
                                                          // isDataNotAvail = true;
                                                          //AppData.showInSnackBar(context, msg);
                                                        }
                                                      });
                                                });
                                          },
                                          child: Material(
                                            elevation: 5,
                                            color:
                                            Colors.green,
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10.0),
                                            child:
                                            MaterialButton(
                                              child: Text(
                                                */ /*'Confirmed'*/ /*
                                                "Accept",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize:
                                                    15,
                                                    color: Colors
                                                        .white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            widget.model
                                                .GETMETHODCALL_TOKEN(
                                                api: ApiFactory
                                                    .user_APPOINTMENT_status +
                                                    appointmentlist
                                                        .doctorName +
                                                    "&appstatus=" +
                                                    "4",
                                                token: widget
                                                    .model
                                                    .token,
                                                fun: (Map<
                                                    String,
                                                    dynamic>
                                                map) {
                                                  log(">>>>>>>reject response<<<<<<<" +
                                                      jsonEncode(map));
                                                  setState(
                                                          () {
                                                        String
                                                        msg =
                                                        map[Const.MESSAGE];
                                                        if (map[Const.CODE] ==
                                                            Const.SUCCESS) {
                                                          Navigator.of(context).pop();
                                                          doctorAppointmment =
                                                              DoctorAppointmment.fromJson(map);
                                                          AppData.showInSnackBar(context,
                                                              msg);
                                                          //   Navigator.pushNamed(context, "/dashDoctor");

                                                          // appointModel = lab.LabBookModel.fromJson(map);
                                                        } else {
                                                          // isDataNotAvail = true;
                                                          // AppData.showInSnackBar(context, msg);
                                                        }
                                                      });
                                                });
                                          },
                                          child: Material(
                                            elevation: 5,
                                            color: Colors.red,
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10.0),
                                            child:
                                            MaterialButton(
                                              child: Text(
                                                */ /*'Confirmed'*/ /*
                                                "Reject",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize:
                                                    15,
                                                    color: Colors
                                                        .white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )*/
                                ],
                              ),
                            );
                          },
                          itemCount: doctorAppointmment.body.length,
                        )
              /*: Container(),*/
            ],
          ),
        ),
      ),
    ));
  }

  Widget changeStatus(BuildContext context, String patname, String doctorName) {
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
                Text(
                  /*"Lisa Rani"*/
                  patname,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text("Confirm"),
                  leading: Icon(Icons.check),
                  onTap: () {
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +
                            doctorName +
                            "&appstatus=" +
                            "2",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              doctorAppointmment =
                                  DoctorAppointmment.fromJson(map);
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
                  title: Text("Cancel"),
                  leading: Icon(Icons.cancel_outlined),
                  onTap: () {
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +
                            doctorName +
                            "&appstatus=" +
                            "4",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              doctorAppointmment =
                                  DoctorAppointmment.fromJson(map);
                              AppData.showInSnackBar(context, msg);
                              Navigator.of(context).pop();
                              // appointModel = lab.LabBookModel.fromJson(map);
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

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }

  popup(BuildContext context, String message, String name, String date) {
    return Alert(
        context: context,
        title: "Appointment for" +
            " " +
            name +
            " on " +
            date +
            " " +
            "is Accepted",
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
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  rejectedPopup(
      BuildContext context, String message, String name, String date) {
    return Alert(
        context: context,
        title: "Appointment for" +
            " " +
            name +
            " on " +
            date +
            " " +
            "is Rejected",
        type: AlertType.error,
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
            onPressed: () {
              //Navigator.pop(context);
              //Navigator.pop(context);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.of(context).pop();
              //Navigator.of(context).pop();
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
// style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
}
