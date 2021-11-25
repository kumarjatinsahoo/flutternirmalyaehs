import 'dart:convert';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AppointmentlistModel.dart' as apnt;
import 'package:user/models/LoginResponse1.dart';

import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAppointmentConfirmed extends StatefulWidget {
  MainModel model;

  MyAppointmentConfirmed({Key key, this.model}) : super(key: key);

  @override
  _MyAppointmentConfirmedState createState() => _MyAppointmentConfirmedState();
}

class _MyAppointmentConfirmedState extends State<MyAppointmentConfirmed> {
  DateTime selectedDate = DateTime.now();
  apnt.AppointmentlistModel appointmentlistModel;
  LoginResponse1 loginResponse;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  bool isdata = false;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr = df.format(date).toString();
      loginResponse = widget.model.loginResponse1;
      print(">>>>>>>" + jsonEncode(loginResponse.toJson()));
      isdata = true;
      callAPI("");
    });
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
        api: ApiFactory.USER_APPOINTMENT_LIST +
            widget.model.user +
            "&date="+
            today +
            "&status="+
            "2",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata = false;
              appointmentlistModel = apnt.AppointmentlistModel.fromJson(map);
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              isdata = false;
              // isDataNotAvail = true;
              // AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                            height:
                            MediaQuery.of(context).size.height * 0.35,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  /* Center(
                child: CircularProgressIndicator(),
              )*/
                  : appointmentlistModel == null || appointmentlistModel == null
                      ? Container(
                        child: Center(

                          child: Column(
                              children: [

                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.35,
                                ),
                                Text(
                                  MyLocalizations.of(context).text("NO_DATA_FOUND"),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        )
                      : (appointmentlistModel != null)
                          ?ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                apnt.Body appointmentlist =
                                    appointmentlistModel.body[i];
                                return
                                  Column(
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
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'User Name: ',
                                                              style: TextStyle(
                                                                  color: Colors.blue,
                                                                  fontWeight:
                                                                  FontWeight.w600),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  appointmentlist.doctorName ??
                                                                      "N/A",
                                                                  /*"",*/
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: 15),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  5,
                                                                ),
                                                                (appointmentlist.patname ==
                                                                    "Registered Doctor")
                                                                    ? Container(
                                                                  child: Icon(
                                                                    Icons.check_circle,
                                                                    size: 16,
                                                                    color: AppData.kPrimaryColor,
                                                                  ),
                                                                )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Text(
                                                              'Education: ',
                                                              style: TextStyle(
                                                                  color: Colors.blue,
                                                                  fontWeight:
                                                                  FontWeight.w600),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  appointmentlist.docedu ??
                                                                      "N/A",
                                                                  overflow:
                                                                  TextOverflow.clip,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: 15),
                                                                ),
                                                                (appointmentlist.docexp ==
                                                                    null)
                                                                    ? Text(
                                                                  "  Exp ",
                                                                  overflow:
                                                                  TextOverflow.clip,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      13,
                                                                      color:
                                                                      Colors.black),
                                                                ):Container(),
                                                                (appointmentlist.docexp == null)
                                                                    ?Text(
                                                                  appointmentlist.docexp ??
                                                                      "N/A",
                                                                  overflow:
                                                                  TextOverflow.clip,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      13,
                                                                      color:
                                                                      Colors.black),
                                                                ):Container(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              'Speciality: ',
                                                              style: TextStyle(
                                                                  color: Colors.blue,
                                                                  fontWeight:
                                                                  FontWeight.w600),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                              appointmentlist
                                                                  .speciality ??
                                                                  "N/A",
                                                              overflow:
                                                              TextOverflow
                                                                  .clip,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              'Address: ',
                                                              style: TextStyle(
                                                                  color: Colors.blue,
                                                                  fontWeight:
                                                                  FontWeight.w600),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                              /*'23-Nov-2020-11:30AM'*/
                                                              appointmentlist
                                                                  .dochospital??"N/A",
                                                              overflow:
                                                              TextOverflow
                                                                  .clip,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              'Date: ',
                                                              style: TextStyle(
                                                                  color: Colors.blue,
                                                                  fontWeight:
                                                                  FontWeight.w600),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              /*'23-Nov-2020-11:30AM'*/
                                                              appointmentlist
                                                                  .appdate ??"N/A" +
                                                                  appointmentlist
                                                                      .apptime ??"N/A",
                                                              overflow:
                                                              TextOverflow
                                                                  .clip,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: [
                                                                RatingBar
                                                                    .readOnly(
                                                                  filledIcon:
                                                                  Icons.star,
                                                                  emptyIcon:
                                                                  Icons.star_border,
                                                                  initialRating:
                                                                  double.tryParse(appointmentlist.docrate.toString()) ??
                                                                      0,
                                                                  maxRating:
                                                                  5,
                                                                  filledColor:
                                                                  Colors.green,
                                                                  size:
                                                                  23.00,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  5,
                                                                ),
                                                                Text(
                                                                  double.tryParse(appointmentlist.docrate.toString())
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.w700),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                              children: [
                                                                Text(
                                                                  /*'Confirmed'*/
                                                                  "",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize: 13),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  /*'Confirmed'*/
                                                                  appointmentlist
                                                                      .status ??
                                                                      "N/A",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize: 15,
                                                                      color: Colors
                                                                          .green),
                                                                ),
                                                              ],
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
                                   /* Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Card(
                                            elevation: 15,
                                            child: Container(

                                                //width: double.maxFinite,

                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.grey[300],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [

                                                              CircleAvatar(
                                                                radius: 50,
                                                                foregroundColor:
                                                                Colors
                                                                    .white,
                                                                child:
                                                                Image.asset(
                                                                  'assets/images/dprofile.png',
                                                                  height:
                                                                  size.height *
                                                                      0.10,
                                                                  width:
                                                                  size.width *
                                                                      0.20,
                                                                  //fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        appointmentlist.doctorName ??
                                                                            "N/A",
                                                                        *//*"",*//*
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        5,
                                                                      ),
                                                                      (appointmentlist.patname ==
                                                                          "Registered Doctor")
                                                                          ? Container(
                                                                        child: Icon(
                                                                          Icons.check_circle,
                                                                          size: 16,
                                                                          color: AppData.kPrimaryColor,
                                                                        ),
                                                                      )
                                                                          : Container(),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        appointmentlist.docedu ??
                                                                            "N/A",
                                                                        overflow:
                                                                        TextOverflow.clip,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            13,
                                                                            color:
                                                                            Colors.black),
                                                                      ),
                                                                      (appointmentlist.docexp ==
                                                                          null)
                                                                          ? Text(
                                                                        "  Exp ",
                                                                        overflow:
                                                                        TextOverflow.clip,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            13,
                                                                            color:
                                                                            Colors.black),
                                                                      ):Container(),
                                                                      (appointmentlist.docexp == null)
                                                                          ?Text(
                                                                        appointmentlist.docexp ??
                                                                            "N/A",
                                                                        overflow:
                                                                        TextOverflow.clip,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            13,
                                                                            color:
                                                                            Colors.black),
                                                                      ):Container(),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Text(
                                                                    appointmentlist
                                                                        .speciality ??
                                                                        "N/A",
                                                                    overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  *//*  Text(
                                                                appointmentlist
                                                                    .patname ??
                                                                    "N/A",
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,fontSize: 13),
                                                              ),*//*
                                                                  Row(
                                                                    children: [
                                                                      RatingBar
                                                                          .readOnly(
                                                                        filledIcon:
                                                                        Icons.star,
                                                                        emptyIcon:
                                                                        Icons.star_border,
                                                                        initialRating:
                                                                        double.tryParse(appointmentlist.docrate.toString()) ??
                                                                            0,
                                                                        maxRating:
                                                                        5,
                                                                        filledColor:
                                                                        Colors.green,
                                                                        size:
                                                                        23.00,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        5,
                                                                      ),
                                                                      Text(
                                                                        double.tryParse(appointmentlist.docrate.toString())
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.w700),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          //  SizedBox(width: 10,),
                                                          *//*new Spacer(),*//*
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                              top: 15.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          Container(
                                                            width: 110,
                                                            child: Text(
                                                              *//*'Confirmed'*//*
                                                              "Address",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(" : "),
                                                          Text(
                                                            *//*'23-Nov-2020-11:30AM'*//*
                                                            appointmentlist
                                                                .dochospital,
                                                            overflow:
                                                            TextOverflow
                                                                .clip,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      *//* Text(
                                                    "Patient Notes: " +
                                                        appointmentlist
                                                            .notes ??
                                                        "N/A",
                                                    overflow:
                                                    TextOverflow
                                                        .clip,
                                                    style:
                                                    TextStyle(fontSize: 13),
                                                  ),*//*
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          Container(
                                                            width: 110,
                                                            child: Text(
                                                              *//*'Confirmed'*//*
                                                              "Date",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                fontSize: 15,),
                                                            ),
                                                          ),
                                                          Text(" : "),
                                                          Text(
                                                            *//*'23-Nov-2020-11:30AM'*//*
                                                            appointmentlist
                                                                .appdate ??
                                                                "N/A" +
                                                                    appointmentlist
                                                                        .apptime ??
                                                                "N/A",
                                                            overflow:
                                                            TextOverflow
                                                                .clip,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          Container(
                                                            width: 110,
                                                            child: Text(
                                                              *//*'Confirmed'*//*
                                                              "Patient Notes",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                fontSize: 15,),
                                                            ),
                                                          ),
                                                          Text(" : "),
                                                          Text(
                                                            *//*'23-Nov-2020-11:30AM'*//*
                                                            appointmentlist
                                                                .notes,
                                                            overflow:
                                                            TextOverflow
                                                                .clip,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text(
                                                            *//*'Confirmed'*//*
                                                            "",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize: 15),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            *//*'Confirmed'*//*
                                                            appointmentlist
                                                                .status ??
                                                                "N/A",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  ],
                                );
                              },
                              itemCount: appointmentlistModel.body.length,
                            )
                          : Container(),
            ],
          ),
        ),
      ),
    ));
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

  /*else if (comeFrom == Const.HEALTH_CHKUP_APNT) {
      widget.model.GETMETHODCALL_TOKEN(
          api: ApiFactory.HEALTH_CHKUP_LIST + today,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              String msg = map[Const.MESSAGE];
              if (map[Const.CODE] == Const.SUCCESS) {
                appointModel = lab.LabBookModel.fromJson(map);
              } else {
                isDataNotAvail = true;
                AppData.showInSnackBar(context, msg);
              }
            });
          });
    }*/

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
}
