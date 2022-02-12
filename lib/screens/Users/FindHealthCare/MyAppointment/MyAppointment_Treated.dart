import 'dart:developer';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AppointmentlistModel.dart';
import 'package:user/models/AppointmentlistModel.dart' as apt;
import 'package:user/models/Ratingmodel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/widgets/text_field_address.dart';

class MyAppointmentTreated extends StatefulWidget {
  MainModel model;

  MyAppointmentTreated({Key key, this.model}) : super(key: key);

  @override
  _MyAppointmentTreatedState createState() => _MyAppointmentTreatedState();
}

class _MyAppointmentTreatedState extends State<MyAppointmentTreated> {
  DateTime selectedDate = DateTime.now();
  AppointmentlistModel appointmentlistModel;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  bool isdata = true;
  Ratingmodel ratingmodel;
  double rate;
  List<bool> error = [false, false, false, false, false, false];

  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr = df.format(date).toString();
      //toThis_.text = df.format(date);
      callAPI("");
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
        api: ApiFactory.USER_APPOINTMENT_LIST +
            widget.model.user +
            "&date=" +
            today +
            "&status=" +
            "5",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata = false;
              appointmentlistModel = AppointmentlistModel.fromJson(map);
              String userid = map["userid"];
              //String travel =travel_allownces.toString();
              widget.model.userid = userid;
              print('userid>>>>>>>>>>>>>>>>>>: $userid.');

              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              appointmentlistModel = null;
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
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          CircularProgressIndicator(
                              //backgroundColor: AppData.matruColor,
                              ),
                        ],
                      ),
                    )
                  : appointmentlistModel == null || appointmentlistModel == null
                      ? Container(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                ),
                                Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
                              ],
                            ),
                          ),
                        )
                      : (appointmentlistModel != null)
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                apt.Body appointmentlist =
                                    appointmentlistModel.body[i];
                                /* itemCount: lists.length,
                          itemBuilder: (context, index) {*/
                                return InkWell(
                                    // onTap: () {
                                    //   widget.model.userappointment = appointmentlist;
                                    //
                                    //
                                    //   Navigator.pushNamed(context, "/usermedicinelist");
                                    // },
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0,
                                                          top: 10,
                                                          bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(MyLocalizations.of(context).text("DOCTOR_NAME"),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
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
                                                                          .doctorName ??
                                                                      "N/A",
                                                                  /*"",*/
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                (appointmentlist
                                                                            .patname ==
                                                                        "Registered Doctor")
                                                                    ? Container(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .check_circle,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              AppData.kPrimaryColor,
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(MyLocalizations.of(context).text("EDUCATION1"),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
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
                                                                          .docedu ??
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
                                                                (appointmentlist
                                                                            .docexp ==
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
                                                                      )
                                                                    : Container(),
                                                                (appointmentlist
                                                                            .docexp ==
                                                                        null)
                                                                    ? Text(
                                                                        appointmentlist.docexp ??
                                                                            "N/A",
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Colors.black),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(MyLocalizations.of(context).text("SPECIALITY"),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
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
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(MyLocalizations.of(context).text("ADDRESS"),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
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
                                                                      .dochospital ??
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
                                                            Text(MyLocalizations.of(context).text("DATE"),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              /*'23-Nov-2020-11:30AM'*/
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
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),

                                                            Text(MyLocalizations.of(context).text("TIME"),
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
                                                                  .apptime ??"N/A" +
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


                                                            Text(MyLocalizations.of(context).text("CONSULT_TYPE"),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              /*'23-Nov-2020-11:30AM'*/
                                                              appointmentlist
                                                                      .typeofconsult ??
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
                                                            Row(
                                                              children: [
                                                                RatingBar
                                                                    .readOnly(
                                                                  filledIcon:
                                                                      Icons
                                                                          .star,
                                                                  emptyIcon: Icons
                                                                      .star_border,
                                                                  initialRating:
                                                                      double.tryParse(appointmentlist
                                                                              .docrate
                                                                              .toString()) ??
                                                                          0,
                                                                  maxRating: 5,
                                                                  filledColor:
                                                                      Colors
                                                                          .green,
                                                                  size: 23.00,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  double.tryParse(appointmentlist
                                                                          .docrate
                                                                          .toString())
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  /*'Confirmed'*/
                                                                  appointmentlist
                                                                          .status ??
                                                                      "N/A",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15,
                                                                      color: AppData
                                                                          .kPrimaryColor),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    displayDialog(
                                                                      context,
                                                                      appointmentlist,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    elevation:
                                                                        5,
                                                                    color: AppData
                                                                        .kPrimaryColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3.0),
                                                                    child:
                                                                        MaterialButton(
                                                                      minWidth:
                                                                          90,
                                                                      height:
                                                                          40.0,
                                                                      child:
                                                                          Text(MyLocalizations.of(context).text("RATE"),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    // widget.model.userappointment = appointmentlist;
                                                                    widget.model
                                                                            .apntUserType =
                                                                        Const
                                                                            .HEALTH_CHKUP_APNT;
                                                                    widget.model
                                                                            .appno =
                                                                        appointmentlist
                                                                            ?.appno;
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        "/usermedicinelist");
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    elevation:
                                                                        5,
                                                                    color: AppData
                                                                        .kPrimaryColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3.0),
                                                                    child:
                                                                        MaterialButton(
                                                                      minWidth:
                                                                          90,
                                                                      height:
                                                                          40.0,
                                                                      child:
                                                                          Text(MyLocalizations.of(context).text("PRESCRIPTION"),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Spacer(),
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
                                                              Container(

                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(85),
                                                                border: Border.all(color: AppData.kPrimaryColor, width: 2),
                                                                color: Colors.white),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(85),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Image.asset(
                                                                    'assets/images/dprofile.png',
                                                                    height: size.height * 0.10,
                                                                    width: size.width * 0.20,
                                                                    //fit: BoxFit.cover,
                                                                  ),
                                                                )),
                                                          ),
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
                                                                    Text(
                                                                appointmentlist
                                                                    .patname ??
                                                                    "N/A",
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,fontSize: 13),
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
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          //  SizedBox(width: 10,),
                                                          new Spacer(),
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
                                                              'Confirmed'
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
                                                            '23-Nov-2020-11:30AM'+
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
                                                       Text(
                                                    "Patient Notes: " +
                                                        appointmentlist
                                                            .notes ??
                                                        "N/A",
                                                    overflow:
                                                    TextOverflow
                                                        .clip,
                                                    style:
                                                    TextStyle(fontSize: 13),
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
                                                              'Confirmed'
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
                                                              'Confirmed'
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
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:5.0),
                                                            child: Text(
                                                              appointmentlist
                                                                  .status ??
                                                                  "N/A",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize: 15,
                                                                  color: AppData
                                                                      .kPrimaryColor),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                             // widget.model.userappointment = appointmentlist;
                                                              widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
                                                              widget.model.appno=appointmentlist?.appno ;
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  "/usermedicinelist");
                                                            },
                                                            child: Material(
                                                              elevation: 5,
                                                              color: AppData
                                                                  .kPrimaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3.0),
                                                              child:
                                                                  MaterialButton(
                                                                minWidth: 90,
                                                                height: 40.0,
                                                                child: Text(
                                                                  'Confirmed'
                                                                  "Show Prescription",
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
                                                          // Spacer(),

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
                                ));
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

  void displayDialog(BuildContext context, Body appointmentlist) {
    textEditingController[1].text=appointmentlist.review??"";
    rate=double.tryParse(appointmentlist.rating);

    //textEditingController[0].text="";
   //rating=appointmentlist.rating;
    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Text(MyLocalizations.of(context).text("RATE_DOCTOR"),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBar(
                                    // initialRating: 3,
                                    onRatingChanged:(rating) {
                                      // rate=int.tryParse(rating.toString()).toString();
                                       rate=rating;
                                      print(rate);
                                    },
                                    size: 45,
                                    initialRating:rate??0.0,
                                    filledIcon: Icons.star,
                                    filledColor: Colors.yellow,
                                    emptyIcon: Icons.star_border,
                                  ),
                                ],
                              ),
                              fromAddress(1,
                                  MyLocalizations.of(context).text("REVIEW"),
                                  TextInputAction.next,
                                  TextInputType.text,
                                  "review"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  MyLocalizations.of(context).text("SUBMIT"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  setState(() {
                    if(rate == null||rate == ""){
                    AppData.showInSnackBar(context, "Please enter rating");
                    }
                    else if (textEditingController[1].text == null ||
                        textEditingController[1].text == "") {
                      AppData.showInSnackBar(context, "Please enter Reviews");
                    }
                    else{
                      Ratingmodel ratingmode = Ratingmodel();
                      ratingmode.userid = widget.model.user;
                      ratingmode.rating = rate.toInt().toString();
                      ratingmode.drid = appointmentlist.doctorid;
                      ratingmode.appno = appointmentlist.appno;
                      ratingmode.reviews = textEditingController[1].text;
                      log("Value json>>" + ratingmode.toJson().toString());
                      MyWidgets.showLoading(context);
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.DOCTOR_RATING,
                          json: ratingmode.toJson(),
                          token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          if (map["status"] == Const.SUCCESS) {

                            Navigator.pop(context);
                            // popup(context, map[Const.MESSAGE]);
                            callAPI(selectedDatestr);
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);
                          } else {
                            // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
          }
                  });
                },
              ),
            ],
          );
        },
        context: context);
  }

  Widget fromAddress(int index, String hint, inputAct, keyType, String type) {
    return TextFieldAddress(
      child: TextFormField(
        controller: textEditingController[index],
        // focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          // suffixIcon: Icon(Icons.person_rounded),
          //contentPadding: EdgeInsets.symmetric(vertical: 10)
        ),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (newValue) {},
        onFieldSubmitted: (value) {
          print("ValueValue" + error[index].toString());
          setState(() {
            error[index] = false;
          });
          //  AppData.fieldFocusChange(context, currentfn, nextFn);
        },
      ),
    );
  }
//style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue),),
}

class StarRating extends StatelessWidget {
  final int rating;

  StarRating({this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          rating >= 1 ? "assets/images/star.png" : "assets/images/stargrey.png",
          width: 13,
          height: 13,
        ),
        SizedBox(
          width: 3,
        ),
        Image.asset(
          rating >= 2 ? "assets/images/star.png" : "assets/images/stargrey.png",
          width: 13,
          height: 13,
        ),
        SizedBox(
          width: 3,
        ),
        Image.asset(
          rating >= 3 ? "assets/images/star.png" : "assets/images/stargrey.png",
          width: 13,
          height: 13,
        ),
        SizedBox(
          width: 3,
        ),
        Image.asset(
          rating >= 4 ? "assets/images/star.png" : "assets/images/stargrey.png",
          width: 13,
          height: 13,
        ),
        SizedBox(
          width: 3,
        ),
        Image.asset(
          rating >= 5 ? "assets/images/star.png" : "assets/images/stargrey.png",
          width: 13,
          height: 13,
        ),
      ],
    );
  }
}
