import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/DocterMedicationlistModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MedicalPrescriptionModel.dart' as medicine;
import 'package:user/models/MedicalPrescriptionModel.dart';
import 'package:user/models/MedicinModel.dart';
/*import 'package:user/models/MedicineListModel.dart' as medicine;*/
import 'package:user/models/MedicineListModel.dart';
import 'package:user/models/ResultsServer.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/widgets/text_field_address.dart';

class HealthChaatlist extends StatefulWidget {
  MainModel model;

  final bool isConfirmPage;

  HealthChaatlist({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _MedicineList createState() => _MedicineList();
}

class _MedicineList extends State<HealthChaatlist> {
  DateTime selectedDate = DateTime.now();
  String selectedDatestr;
  TextEditingController appointmentdate = TextEditingController();
  TextEditingController heightdate = TextEditingController();
  TextEditingController bMIdate = TextEditingController();
  TextEditingController systolicdate = TextEditingController();
  TextEditingController diastolicdate = TextEditingController();
  TextEditingController haemoglobindate = TextEditingController();
  TextEditingController stime = TextEditingController();
  TextEditingController heighttime = TextEditingController();
  TextEditingController bMItime = TextEditingController();
  TextEditingController systolictime = TextEditingController();
  TextEditingController diastolictime = TextEditingController();
  TextEditingController haemoglobintime = TextEditingController();
  final df = new DateFormat('dd-MM-yyyy');
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  TimeOfDay selectedTime = TimeOfDay.now();
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();
  FocusNode fnode10 = new FocusNode();
  FocusNode fnode11 = new FocusNode();
  FocusNode fnode12 = new FocusNode();
  TimeOfDay selectedStartTime;
  TimeOfDay selectedEndTime;
  String selectTime24;
  String selectTimeheigth24;
  String selectTimeBMI24;
  String selectTimesYstolic24;
  String selectTimediastolic24;
  String selectTimehaemoglobin24;

  String time;

  bool isActive = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    //loginResponse1 = widget.model.loginResponse1;
    //UserMedicineList1.pharmacyModel = null;
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = 80;
    double spaceTab = 20;
    double edgeInsets = 3;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Health Chart list"),
      ),
      body: Container(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserView(context),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Container(
                                        //height: tileSize,
                                        // width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color:
                                                        AppData.kPrimaryColor,
                                                    width: 5))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Body Measurement"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Weight,Height,BMI",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(Icons.more_vert,
                                                  size: 25),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserViewBloodpressur(context),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Container(
                                        //height: tileSize,
                                        // width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData
                                                        .kPrimaryRedColor,
                                                    width: 5))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Blood Pressure"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Systolic/Diastolic",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(Icons.more_vert,
                                                  size: 25),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                              Container(
                                  child: InkWell(
                                //
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserViewCompleteBloodCount(
                                            context),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Container(
                                        //height: tileSize,
                                        // width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color:
                                                        AppData.kPrimaryColor,
                                                    width: 5))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Complete blood Count"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        "Hb,WBCs,Nutrophils,Eosinophils,Basophis,Monocytes,platelets,ESR,Hct.....",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(Icons.more_vert,
                                                  size: 25),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserViewSugerpanel(context),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Container(
                                        //height: tileSize,
                                        // width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData
                                                        .kPrimaryRedColor,
                                                    width: 5))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Sugar panel".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Fasting,Random,HbAlc",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(Icons.more_vert,
                                                  size: 25),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserViewTemperature(context),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Container(
                                        //height: tileSize,
                                        // width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color:
                                                        AppData.kPrimaryColor,
                                                    width: 5))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Temperature".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Temperature",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(Icons.more_vert,
                                                  size: 25),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserViewPulse(context),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Container(
                                        //height: tileSize,
                                        // width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData
                                                        .kPrimaryRedColor,
                                                    width: 5))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "pulse".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Pulse",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(Icons.more_vert,
                                                  size: 25),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserViewRespiration(context),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Container(
                                        //height: tileSize,
                                        // width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color:
                                                        AppData.kPrimaryColor,
                                                    width: 5))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Respiration".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Respiration",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(Icons.more_vert,
                                                  size: 25),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                              Container(
                                  child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserViewOxygensaturation(context),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 5,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: Container(
                                        //height: tileSize,
                                        // width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData
                                                        .kPrimaryRedColor,
                                                    width: 5))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Oxygen Saturation"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Oxygen Saturation",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Icon(Icons.more_vert,
                                                  size: 25),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
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
    );
  }

  Widget dialogUserView(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            textEditingController[0].text = "";
            appointmentdate.text="";
            stime.text="";
            Navigator.pop(context);

          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 410,
            child: Column(
              children: [
                Text(
                  "body Measurement".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 3,
                            initialIndex: 0,
                            //backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: AppData.kPrimaryRedColor,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Color(0xffF15C22),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Weight(kg)",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Height(cm)",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Body Mass Index",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: LimitedBox(
                                      // use this
                                      maxHeight: 300,
                                      child: TabBarView(
                                        children: [
                                          weight(),
                                          height(),
                                          heightBMI(),
                                        ],
                                      )),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dialogUserViewBloodpressur(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 410,
            child: Column(
              children: [
                Text(
                  "Blood Pressurs".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 2,
                            initialIndex: 0,
                            //backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: AppData.kPrimaryRedColor,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Color(0xffF15C22),
                                  /*indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),
                          insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                        ),*/
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Systolic",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Diastalic",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                /*Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey, width: 0.5))),
                                    child: TabBarView(
                                        children: <Widget>[
                                          rowValue(),
                                          rowValue(),
                                          rowValue(),

                                        ])),*/

                                /*Expanded( //height: widget.layoutHeight,
                                    child: new TabBarView(
                                      ///controller: _controller,
                                      children: <Widget>[
                                       rowValue(),
                                       rowValue(),
                                       rowValue(),

                                      ],
                                    )
                                )*/
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: LimitedBox(
                                      // use this
                                      maxHeight: 300,
                                      child: TabBarView(
                                        children: [
                                          Systolic(),
                                          Diastolic(),
                                        ],
                                      )),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dialogUserViewCompleteBloodCount(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            textEditingController[0].text = "";
            appointmentdate.text="";
            stime.text="";
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 410,
            child: Column(
              children: [
                Text(
                  "Complete Blood Count".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 9,
                            initialIndex: 0,
                            //backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: AppData.kPrimaryRedColor,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Color(0xffF15C22),
                                  /*indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),
                          insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                        ),*/
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Haemoglobin",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("WBCs",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Neutrophils",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Eosinophils",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Basophils",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Manocytes",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Platelets",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("ESR",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("HCT",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: LimitedBox(
                                      // use this
                                      maxHeight: 300,
                                      child: TabBarView(
                                        children: [
                                          Haemoglobin(),
                                          Diastolic(),
                                          Diastolic(),
                                          Diastolic(),
                                          Diastolic(),
                                          Diastolic(),
                                          Diastolic(),
                                          Diastolic(),
                                          Diastolic(),
                                        ],
                                      )),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dialogUserViewTemperature(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            textEditingController[0].text = "";
            appointmentdate.text="";
            stime.text="";
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 410,
            child: Column(
              children: [
                Text(
                  "Temperature".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 1,
                            initialIndex: 0,
                            //backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: AppData.kPrimaryRedColor,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Color(0xffF15C22),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Temperature",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: LimitedBox(
                                      // use this
                                      maxHeight: 300,
                                      child: TabBarView(
                                        children: [
                                          Diastolictemp(),
                                        ],
                                      )),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dialogUserViewPulse(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 410,
            child: Column(
              children: [
                Text(
                  "Pulse".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 1,
                            initialIndex: 0,
                            //backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: AppData.kPrimaryRedColor,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Color(0xffF15C22),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Pulse",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: LimitedBox(
                                      // use this
                                      maxHeight: 300,
                                      child: TabBarView(
                                        children: [
                                          Pulse(),
                                        ],
                                      )),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dialogUserViewRespiration(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            textEditingController[0].text = "";
            appointmentdate.text="";
            stime.text="";
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 410,
            child: Column(
              children: [
                Text(
                  "Respiration".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 1,
                            initialIndex: 0,
                            //backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: AppData.kPrimaryRedColor,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Color(0xffF15C22),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Respiration",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: LimitedBox(
                                      // use this
                                      maxHeight: 300,
                                      child: TabBarView(
                                        children: [
                                          Respiration(),
                                        ],
                                      )),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dialogUserViewOxygensaturation(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 410,
            child: Column(
              children: [
                Text(
                  "Oxygensaturation".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 1,
                            initialIndex: 0,
                            //backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: AppData.kPrimaryRedColor,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Color(0xffF15C22),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Oxygensaturation",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: LimitedBox(
                                      // use this
                                      maxHeight: 300,
                                      child: TabBarView(
                                        children: [
                                          OxygenSaturation(),
                                        ],
                                      )),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dialogUserViewSugerpanel(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 410,
            child: Column(
              children: [
                Text(
                  "Sugar Panel".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 3,
                            initialIndex: 0,
                            //backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  automaticIndicatorColorAdjustment: true,
                                  indicatorColor: AppData.kPrimaryRedColor,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Color(0xffF15C22),
                                  /*indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),
                          insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                        ),*/
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Fasting",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("Random",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text("HbAlc",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 13)),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0.5))),
                                  child: LimitedBox(
                                      // use this
                                      maxHeight: 300,
                                      child: TabBarView(
                                        children: [
                                          SugarFasting(),
                                          SugarRandom(),
                                          SugarHbAIc(),
                                         // Diastolic(),
                                          //Diastolic(),
                                        ],
                                      )),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget weight() {
    textEditingController[0].text = "";
    appointmentdate.text="";
    stime.text="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(kg)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[0],
                                focusNode: fnode1,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              appointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: comultationTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButton(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget height() {
    textEditingController[1].text ="";
    heightdate.text = "";
    heighttime.text = "";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(cm)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[1],
                                focusNode: fnode2,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              heightappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: heightTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtonheight(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget heightBMI() {
    textEditingController[2].text="";
    bMIdate.text="";
    bMItime.text="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[2],
                                focusNode: fnode3,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              bMIappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: bMITime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtonBMI(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Systolic() {
    textEditingController[3].text ="";
    systolicdate.text ="";
    systolictime.text="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(mmHg)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[3],
                                focusNode: fnode3,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              sYstolicappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: sYstolicTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtonSystolic(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Diastolictemp() {
    textEditingController[4].text ="";
    diastolicdate.text ="";
    diastolictime.text ="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(C)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[4],
                                focusNode: fnode4,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              diastolicappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: diastolicTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtondiastolic(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Respiration() {
    textEditingController[4].text ="";
    diastolicdate.text ="";
    diastolictime.text ="";

    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(per minute)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[4],
                                focusNode: fnode4,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              diastolicappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: diastolicTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtondiastolic(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget OxygenSaturation() {
    textEditingController[4].text ="";
    diastolicdate.text ="";
    diastolictime.text ="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(%)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[4],
                                focusNode: fnode4,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              diastolicappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: diastolicTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtondiastolic(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Diastolic() {
    textEditingController[4].text ="";
    diastolicdate.text ="";
    diastolictime.text ="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(mmHg)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[4],
                                focusNode: fnode4,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              diastolicappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: diastolicTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtondiastolic(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
 Widget SugarRandom() {
    textEditingController[7].text ="";
    diastolicdate.text ="";
    diastolictime.text ="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(mmHg)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[7],
                                //focusNode: fnode4,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              diastolicappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: diastolicTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: nextSugarRandom(),
                    /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget SugarHbAIc() {
    textEditingController[8].text ="";
    diastolicdate.text ="";
    diastolictime.text ="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(mmHg)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[8],
                                //focusNode: fnode4,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              diastolicappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: diastolicTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                   // nextSugarRandom(),
                    nextSugarhbaic(),
                    /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Pulse() {
    textEditingController[4].text ="";
    diastolicdate.text ="";
    diastolictime.text ="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(bpm)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[4],
                                focusNode: fnode4,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              diastolicappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: diastolicTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtondiastolic(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Haemoglobin() {
    textEditingController[5].text ="";
    haemoglobindate.text ="";
    haemoglobintime.text ="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(gm/dl)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[5],
                                focusNode: fnode5,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              haemoglobinappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: haemoglobinTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtonhaemoglobin(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget SugarFasting() {
    textEditingController[6].text ="";
    haemoglobindate.text ="";
    haemoglobintime.text ="";
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value(gm/dl)",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[6],
                                focusNode: fnode5,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              haemoglobinappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: haemoglobinTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                    nextButtonsugarfasting(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget WBCs() {
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 0.0, top: 4.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Enter Value",
                            style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black54,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        /* SizedBox(
                      width: spaceTab,
                    ),*/
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.3),
                              ),
                              child: TextFormField(
                                maxLength: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Value",
                                  counterText: "",

                                  /*prefixIcon:
                                    Icon(Icons.person_rounded),*/
                                  hintStyle: TextStyle(
                                      color: AppData.hintColor, fontSize: 16),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: textEditingController[6],
                                focusNode: fnode6,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9.]")),
                                ],
                                /*onFieldSubmitted: (value) {
                                    AppData.fieldFocusChange(context, fnode1, fnode2);
                                  },*/
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(
                  height: 6,
                ),*/
                  // SizedBox(width: 20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, top: 10, right: 5.0),
                    child: Row(
                      children: [
                        //Icon(Icons.bloodtype,size: 20),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Select Date"
                            /* MyLocalizations.of(context).text("BLOODGROUP")*/,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child:
                              haemoglobinappointdate(), /*Text(
                             "N/A",
                              style: TextStyle(fontSize: 14
                                //fontWeight: FontWeight.w500,
                              ),
                            ),*/
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 10, right: 5.0, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Text(
                              "Select Time",
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                // color: AppData.kPrimaryColor,
                                /*fontWeight: FontWeight.w600*/
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: haemoglobinTime(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 14.0, top: 5.0, bottom: 5.0),
                      child: Image.asset(
                        "assets/images/line_chart.png",
                        height: 25,
                      ),
                    ),
                  ),

                  Divider(
                    color: AppData.lightgreyBorder,
                    height: 6,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        nextButtonhaemoglobin(), /*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                  ),
                  //SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  validate() async {
    //_formKey.currentState.validate();
    if (textEditingController[0].text == "" ||
        textEditingController[0].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (appointmentdate.text == "" || appointmentdate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (stime.text == "" || stime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDb();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

  saveDb() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": appointmentdate.text,
      "recordtime": selectTime24,
      "testname": "Weight",
      "testresult": textEditingController[0].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          //Navigator.pop(context);
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
          /* if (map[Const.STATUS] == Const.SUCCESS) {

            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            AppData.showInSnackBargreen(context, map[Const.MESSAGE]);
            //popup(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
            Navigator.pop(context);
            Navigator.pop(context);
          }*/
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  Widget nextButtonheight() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validateheight();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  validateheight() async {
    //_formKey.currentState.validate();
    if (textEditingController[1].text == "" ||
        textEditingController[1].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (heightdate.text == "" || heightdate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (heighttime.text == "" || heighttime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDbheight();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

  saveDbheight() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": heightdate.text,
      "recordtime": selectTimeheigth24,
      "testname": "Height",
      "testresult": textEditingController[1].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  Widget nextButtonBMI() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validateBMI();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  validateBMI() async {
    //_formKey.currentState.validate();
    if (textEditingController[2].text == "" ||
        textEditingController[2].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (bMIdate.text == "" || bMIdate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (bMItime.text == "" || bMItime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDbBMI();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

  saveDbBMI() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": bMIdate.text,
      "recordtime": selectTimeBMI24,
      "testname": "BMI",
      "testresult": textEditingController[2].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  Widget nextButtonSystolic() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validateSystolic();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  validateSystolic() async {
    //_formKey.currentState.validate();
    if (textEditingController[3].text == "" ||
        textEditingController[3].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (systolicdate.text == "" || systolicdate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (systolictime.text == "" || systolictime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDbSystolic();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

  saveDbSystolic() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": systolicdate.text,
      "recordtime": selectTimesYstolic24,
      "testname": "Systolic",
      "testresult": textEditingController[3].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  Widget nextButtondiastolic() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validatediastolic();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
  Widget nextSugarRandom() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validatesugarrandom();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

 Widget nextSugarhbaic() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validateSugarhbaic();
        validatesugarrandom();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  validatediastolic() async {
    //_formKey.currentState.validate();
    if (textEditingController[4].text == "" ||
        textEditingController[4].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (diastolicdate.text == "" || diastolicdate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (diastolictime.text == "" || diastolictime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDbDiastolic();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }
  validatesugarrandom() async {
    //_formKey.currentState.validate();
    if (textEditingController[7].text == "" ||
        textEditingController[7].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (diastolicdate.text == "" || diastolicdate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (diastolictime.text == "" || diastolictime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDbSugarrandom();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

  validateSugarhbaic() async {
    //_formKey.currentState.validate();
    if (textEditingController[8].text == "" ||
        textEditingController[8].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (diastolicdate.text == "" || diastolicdate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (diastolictime.text == "" || diastolictime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDbSugarhbaic();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

  saveDbDiastolic() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": diastolicdate.text,
      "recordtime": selectTimediastolic24,
      "testname": "Diastolic",
      "testresult": textEditingController[4].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }
  saveDbSugarrandom() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": diastolicdate.text,
      "recordtime": selectTimediastolic24,
      "testname": "Diastolic",
      "testresult": textEditingController[7].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  saveDbSugarhbaic() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": diastolicdate.text,
      "recordtime": selectTimediastolic24,
      "testname": "Diastolic",
      "testresult": textEditingController[8].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  Widget nextButtonhaemoglobin() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validatehaemoglobin();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
 Widget nextButtonsugarfasting() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validatesugarfasting();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  validatehaemoglobin() async {
    //_formKey.currentState.validate();
    if (textEditingController[5].text == "" ||
        textEditingController[5].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (haemoglobindate.text == "" || haemoglobindate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (haemoglobintime.text == "" || haemoglobintime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDbhaemoglobin();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

 validatesugarfasting() async {
    //_formKey.currentState.validate();
    if (textEditingController[6].text == "" ||
        textEditingController[6].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    } else if (haemoglobindate.text == "" || haemoglobindate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (haemoglobintime.text == "" || haemoglobintime.text == null) {
      AppData.showInSnackBar(context, "Please select time");
    } else {
      saveDbsugarfasting();
     // saveDbhaemoglobin();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }

  saveDbhaemoglobin() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": haemoglobindate.text,
      "recordtime": selectTimehaemoglobin24,
      "testname": "HB",
      "testresult": textEditingController[5].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }
  saveDbsugarfasting() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate": haemoglobindate.text,
      "recordtime": selectTimehaemoglobin24,
      "testname": "HB",
      "testresult": textEditingController[6].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS1] == Const.SUCCESS) {
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
              //Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  /* Widget nextButtonheight() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validatehight();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
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
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }


  validate() async {
    //_formKey.currentState.validate();
    if (textEditingController[0].text == "" || textEditingController[0].text == null) {
      AppData.showInSnackBar(context, "Please enter value");
    }  else if (appointmentdate.text == "" || appointmentdate.text == null) {
      AppData.showInSnackBar(context, "Please select Date");
    } else if (stime.text == "" || stime.text == null) {
      AppData.showInSnackBar(context, "Please select time");

    } else {
      saveDb();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      */ /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/ /*
    }
  }

  saveDb() {
    Map<String, dynamic> map = {
      "userid": widget.model.user,
      "recorddate":appointmentdate.text,
      "recordtime":selectTime24,
      "testname":"Height",
      "testresult":textEditingController[0].text,
    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_USERHEALTHRECORD,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {

          if (map[Const.STATUS] == Const.SUCCESS) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            AppData.showInSnackBargreen(context, map[Const.MESSAGE]);
            //popup(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
            Navigator.pop(context);
          }
        });
    */ /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/ /*
  }*/
  Future<Null> _selectDate(BuildContext context, String _responseStatus) async {
    // MyWidgets.showLoading(context);
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate:
            DateTime.now().add(Duration(days: 6570))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      /*selectedDatestr = df.format(selectedDate).toString();*/

      switch (_responseStatus) {
        case 'weight':
          return appointmentdate.text = df.format(picked);
        case 'height':
          return heightdate.text = df.format(picked);
        case 'BMI':
          return bMIdate.text = df.format(picked);
        case 'Systolic':
          return systolicdate.text = df.format(picked);
        case 'Diastolic':
          return diastolicdate.text = df.format(picked);
        case 'Haemoglobin':
          return haemoglobindate.text = df.format(picked);
      }
    });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    /*if (timeOfDay != null && timeOfDay != selectedTime) {*/
    setState(() {
      selectedTime = timeOfDay;
      selectedStartTime = timeOfDay;
      selectTime24 =
          (timeOfDay.hour).toString() + ":" + (timeOfDay.minute).toString();
      stime.text = formatTimeOfDay(timeOfDay);
      /*switch (_responseStatus1) {
        case 'weight':
          return stime.text = formatTimeOfDay(timeOfDay);
        case 'height':
          return heighttime.text = formatTimeOfDay(timeOfDay);
        case 'PENDING':
          return stime.text = formatTimeOfDay(timeOfDay);
      }*/
    });
    /*}*/
  }

  _selectTimehight(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    /*if (timeOfDay != null && timeOfDay != selectedTime) {*/
    setState(() {
      selectedTime = timeOfDay;
      selectedStartTime = timeOfDay;
      selectTimeheigth24 =
          (timeOfDay.hour).toString() + ":" + (timeOfDay.minute).toString();
      heighttime.text = formatTimeOfDay(timeOfDay);
    });
    /*}*/
  }

  _selectTimeBMI(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    /*if (timeOfDay != null && timeOfDay != selectedTime) {*/
    setState(() {
      selectedTime = timeOfDay;
      selectedStartTime = timeOfDay;
      selectTimeBMI24 =
          (timeOfDay.hour).toString() + ":" + (timeOfDay.minute).toString();
      bMItime.text = formatTimeOfDay(timeOfDay);
    });
    /*}*/
  }

  _selectTimesYstolic(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    /*if (timeOfDay != null && timeOfDay != selectedTime) {*/
    setState(() {
      selectedTime = timeOfDay;
      selectedStartTime = timeOfDay;
      selectTimesYstolic24 =
          (timeOfDay.hour).toString() + ":" + (timeOfDay.minute).toString();
      systolictime.text = formatTimeOfDay(timeOfDay);
    });
    /*}*/
  }

  _selectTimesYdiastolic(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    /*if (timeOfDay != null && timeOfDay != selectedTime) {*/
    setState(() {
      selectedTime = timeOfDay;
      selectedStartTime = timeOfDay;
      selectTimediastolic24 =
          (timeOfDay.hour).toString() + ":" + (timeOfDay.minute).toString();
      diastolictime.text = formatTimeOfDay(timeOfDay);
    });
    /*}*/
  }

  _selectTimesHaemoglobin(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    /*if (timeOfDay != null && timeOfDay != selectedTime) {*/
    setState(() {
      selectedTime = timeOfDay;
      selectedStartTime = timeOfDay;
      selectTimehaemoglobin24 =
          (timeOfDay.hour).toString() + ":" + (timeOfDay.minute).toString();
      haemoglobintime.text = formatTimeOfDay(timeOfDay);
    });
    /*}*/
  }

  String formatTimeOfDay(TimeOfDay tod) {
    print("Value is>>>>>>\n\n\n\n" + tod.toString());
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  Widget appointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => /*_selectDate(context,),*/
            _selectDate(context, "weight"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: appointmentdate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                /*  validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },*/
                onFieldSubmitted: (value) {
                  //error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                      "Date",
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  /* suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color:Colors.grey,
                  ),*/
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget heightappointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => /*_selectDate(context,),*/
            _selectDate(context, "height"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: heightdate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                /*  validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },*/
                onFieldSubmitted: (value) {
                  //error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                      "Date",
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  /* suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color:Colors.grey,
                  ),*/
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bMIappointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => /*_selectDate(context,),*/
            _selectDate(context, "BMI"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: bMIdate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                /*  validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },*/
                onFieldSubmitted: (value) {
                  //error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                      "Date",
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  /* suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color:Colors.grey,
                  ),*/
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sYstolicappointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => /*_selectDate(context,),*/
            _selectDate(context, "Systolic"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: systolicdate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                /*  validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },*/
                onFieldSubmitted: (value) {
                  //error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                      "Date",
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  /* suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color:Colors.grey,
                  ),*/
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget diastolicappointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => /*_selectDate(context,),*/
            _selectDate(context, "Diastolic"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: diastolicdate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                /*  validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },*/
                onFieldSubmitted: (value) {
                  //error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                      "Date",
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  /* suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color:Colors.grey,
                  ),*/
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget haemoglobinappointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => /*_selectDate(context,),*/
            _selectDate(context, "Haemoglobin"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: haemoglobindate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                /*  validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },*/
                onFieldSubmitted: (value) {
                  //error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                      "Date",
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  /* suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color:Colors.grey,
                  ),*/
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget wBCsappointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => /*_selectDate(context,),*/
            _selectDate(context, "Haemoglobin"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: haemoglobindate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                /*  validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },*/
                onFieldSubmitted: (value) {
                  //error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                      "Date",
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  /* suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color:Colors.grey,
                  ),*/
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formFieldExperience(int index, String hint, FocusNode currentfn) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  enabled: widget.isConfirmPage ? false : true,
                  controller: textEditingController[index],
                  focusNode: currentfn,
                  cursorColor: AppData.kPrimaryColor,
                  textInputAction: TextInputAction.next,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    counterText: "",
                    hintText: hint,
                    hintStyle:
                        TextStyle(color: AppData.hintColor, fontSize: 15),
                  ),
                  onFieldSubmitted: (value) {
                    // print(error[2]);
                    // error[4] = false;
                    setState(() {});
                    //AppData.fieldFocusChange(context, currentfn);
                  },
                  onSaved: (value) {
                    //userPersonalForm.phoneNumber = value;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget comultationTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _selectTime(context);
          //_selectDate(context, "validity");
        },
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: stime,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: //"Date Of Pregency",
                    "Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                /* suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  size: 18,
                  color:Colors.grey,
                ),*/
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget heightTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _selectTimehight(context);
          //_selectDate(context, "validity");
        },
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: heighttime,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: //"Date Of Pregency",
                    "Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                /* suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  size: 18,
                  color:Colors.grey,
                ),*/
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bMITime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _selectTimeBMI(context);
          //_selectDate(context, "validity");
        },
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: bMItime,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: //"Date Of Pregency",
                    "Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                /* suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  size: 18,
                  color:Colors.grey,
                ),*/
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sYstolicTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _selectTimesYstolic(context);
          //_selectDate(context, "validity");
        },
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: systolictime,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: //"Date Of Pregency",
                    "Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                /* suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  size: 18,
                  color:Colors.grey,
                ),*/
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget diastolicTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _selectTimesYdiastolic(context);
          //_selectDate(context, "validity");
        },
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: diastolictime,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: //"Date Of Pregency",
                    "Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                /* suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  size: 18,
                  color:Colors.grey,
                ),*/
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget haemoglobinTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _selectTimesHaemoglobin(context);
          //_selectDate(context, "validity");
        },
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: diastolictime,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: //"Date Of Pregency",
                    "Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                /* suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  size: 18,
                  color:Colors.grey,
                ),*/
              ),
            ),
          ),
        ),
      ),
    );
  }
}
