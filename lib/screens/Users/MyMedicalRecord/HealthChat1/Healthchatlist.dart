import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
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


  HealthChaatlist({Key key, this.model, this.isConfirmPage})
      : super(key: key);

  @override
  _MedicineList createState() => _MedicineList();
}




class _MedicineList extends State<HealthChaatlist> {
  DateTime selectedDate = DateTime.now();







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
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
                      height: 5,
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                            child: InkWell(
                              onTap: () {
                                },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5))),
                                  child: Container(
                                    //height: tileSize,
                                    // width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color:

                                                  AppData.kPrimaryColor,
                                                  width: 5)))
                                          /*: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryColor,
                                                  width: 5)))*/,
                                      child: Row(
                                       /* crossAxisAlignment:
                                        CrossAxisAlignment.center,*/
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Body Measurment".toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                   "Weight,Height,BMI",
                                                  style: TextStyle(fontSize: 13,color:Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                         /* SizedBox(
                                            width: spaceTab,
                                          ),*/
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child:Icon(Icons.more_vert,size: 25),
                                            /* Image.asset("assets/Forwordarrow.png",height: 25,),*/
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            )),
                        Container(
                            child: InkWell(
                              onTap: () {


                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5))),
                                  child: Container(
                                    //height: tileSize,
                                    // width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color:
                                                  AppData.kPrimaryRedColor,
                                                  width: 5)))
                                      /*: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryColor,
                                                  width: 5)))*/,
                                      child: Row(
                                        /* crossAxisAlignment:
                                        CrossAxisAlignment.center,*/
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Blood Pressure".toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Systolic/Diastalic",
                                                  style: TextStyle(fontSize: 13,color:Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                          /* SizedBox(
                                            width: spaceTab,
                                          ),*/
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child:Icon(Icons.more_vert,size: 25),
                                            /* Image.asset("assets/Forwordarrow.png",height: 25,),*/
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            )),
                        Container(
                            child: InkWell(
                              onTap: () {


                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5))),
                                  child: Container(
                                    //height: tileSize,
                                    // width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color:

                                                  AppData.kPrimaryColor,
                                                  width: 5)))
                                      /*: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryColor,
                                                  width: 5)))*/,
                                      child: Row(
                                        /* crossAxisAlignment:
                                        CrossAxisAlignment.center,*/
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Complete blood Count".toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Expanded(child:
                                                Text(
                                                  "Hb,WBCs,Nutrophils,Eosinophils,Basophis,Monocytes,platelets,ESR,Hct.....",
                                                  style: TextStyle(fontSize: 13,color:Colors.grey),
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                          /* SizedBox(
                                            width: spaceTab,
                                          ),*/
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child:Icon(Icons.more_vert,size: 25),
                                            /* Image.asset("assets/Forwordarrow.png",height: 25,),*/
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            )),
                        Container(
                            child: InkWell(
                              onTap: () {


                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5))),
                                  child: Container(
                                    //height: tileSize,
                                    // width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color:
                                                  AppData.kPrimaryRedColor,
                                                  width: 5)))
                                      /*: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryColor,
                                                  width: 5)))*/,
                                      child: Row(
                                        /* crossAxisAlignment:
                                        CrossAxisAlignment.center,*/
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Body Measurment".toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Weight,Height,BMI",
                                                  style: TextStyle(fontSize: 13,color:Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                          /* SizedBox(
                                            width: spaceTab,
                                          ),*/
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child:Icon(Icons.more_vert,size: 25),
                                            /* Image.asset("assets/Forwordarrow.png",height: 25,),*/
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            )),
                        Container(
                            child: InkWell(
                              onTap: () {


                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5))),
                                  child: Container(
                                    //height: tileSize,
                                    // width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color:

                                                  AppData.kPrimaryColor,
                                                  width: 5)))
                                      /*: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryColor,
                                                  width: 5)))*/,
                                      child: Row(
                                        /* crossAxisAlignment:
                                        CrossAxisAlignment.center,*/
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Body Measurment".toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Weight,Height,BMI",
                                                  style: TextStyle(fontSize: 13,color:Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                          /* SizedBox(
                                            width: spaceTab,
                                          ),*/
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child:Icon(Icons.more_vert,size: 25),
                                            /* Image.asset("assets/Forwordarrow.png",height: 25,),*/
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            )),
                        Container(
                            child: InkWell(
                              onTap: () {


                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5))),
                                  child: Container(
                                    //height: tileSize,
                                    // width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color:
                                                  AppData.kPrimaryRedColor,
                                                  width: 5)))
                                      /*: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryColor,
                                                  width: 5)))*/,
                                      child: Row(
                                        /* crossAxisAlignment:
                                        CrossAxisAlignment.center,*/
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text("Body Measurment".toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Weight,Height,BMI",
                                                  style: TextStyle(fontSize: 13,color:Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                          /* SizedBox(
                                            width: spaceTab,
                                          ),*/
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child:Icon(Icons.more_vert,size: 25),
                                            /* Image.asset("assets/Forwordarrow.png",height: 25,),*/
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            )),

                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),




        ],
      ),
    ),
      ),
    );
  }




}
