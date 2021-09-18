import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/PatientsDetailsModel.dart';
import 'package:user/models/VitalModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';

class VitalDoctor extends StatefulWidget {
  MainModel model;

  VitalDoctor({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VitalDoctor();
}

class _VitalDoctor extends State<VitalDoctor> {
  VitalModel vitalModel = VitalModel();

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
  List<bool> error = [false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Vitals"),
          backgroundColor: Color(0xFF0F6CE1)),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xFFf2f3f7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: const Color(0xFFf2f3f7),
                  child: Column(
                    children: [
                      Material(
                        elevation: 1,
                        color: const Color(0xFFf2f3f7),
                        borderRadius: BorderRadius.circular(0.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "KFT",
                                  style: TextStyle(
                                      color: Color(0xFF3a3b3f),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  "Reading",
                                  style: TextStyle(
                                      color: Color(0xFF3a3b3f),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Creatinine",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: formField(0, "mg/dL"),
                                  //     TextField(
                                  // // controller: textEditingController[index],
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xFF767676),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Urea",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: formField(1, "mg/dL"),
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xFF767676),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 25),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Uric Acid",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: formField(2, "mg/dL"),
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xFF767676),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "BUN",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: formField(3, "mg/dL"),
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xFF767676),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 25),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "EGFR",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: formField(4, "mg/dL"),
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //lft
                SizedBox(height: 10),
                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "LFT",
                                style: TextStyle(
                                    color: Color(0xff3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Albumin",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(5, "mg/dL")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Alkaline ",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(6, "mg/dL")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Phosphate",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(7, "mg/dL")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Direct Bilirubin",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(8, "mg/dL")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Indriect Bilirubin",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(9, "mg/dL")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Total Bilirubin",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(10, "mg/dL")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "AST(SGOT)",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(11, "mg/dL")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "ALT(SGPT)",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(12, "mg/dL")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Total Protine",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(13, " % ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "AG Ratio",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(14, "  mg")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Globulin",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(15, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                //LFT
                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "LIPID PROFILE",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Cholesterol",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(16, "  ")
                                  //   TextField(
                                  //     keyboardType: TextInputType.text,
                                  //     decoration: InputDecoration(
                                  //         border: InputBorder.none, hintText: 'mg/dL'),
                                  //   ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "HDL ",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(17, " ")
                                  //   TextField(
                                  //     keyboardType: TextInputType.text,
                                  //     decoration: InputDecoration(
                                  //         border: InputBorder.none, hintText: 'mg/dL'),
                                  //   ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Triglyceride",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(18, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "LDL",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(19, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "LDL Calculative",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(20, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "VLDL",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(21, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "HDL/LDL Ratio",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(22, " ")

                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "HDL Ratio",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(23, " ")
                                  //     TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                //lipid profile
                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "ELECTROLYTES",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Sodium",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(24, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Potassium ",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(25, "  ")
                                  //  TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Chloride",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: formField(26, " "),
                                // TextField(
                                //   keyboardType: TextInputType.text,
                                //   decoration: InputDecoration(
                                //       border: InputBorder.none, hintText: 'mg/dL'),
                                // ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Calcium",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(27, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Magnesium",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(28, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Phosphorus",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(29, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
//electrolytes
                SizedBox(height: 10),
                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "HEMATOLOGY",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Haemoglobin",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(30, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "RBC ",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(31, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "PCV",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(32, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "MCV",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(33, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "MCH",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(34, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "MCHC",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(35, " ")
                                  //     TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //hematology

                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "SUGER",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(width: 25),
                          Container(
                            width: 150,
                            child: Text(
                              "Glucose",
                              style: TextStyle(
                                  color: Color(0xFF515151), fontSize: 15),
                            ),
                          ),
                          Container(
                              height: 50,
                              child: VerticalDivider(color: Color(0xFF767676))),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(child: formField(36, " ")
                              // TextField(
                              //   keyboardType: TextInputType.text,
                              //   decoration: InputDecoration(
                              //       border: InputBorder.none, hintText: 'mg/dL'),
                              // ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Container(
                  color: const Color(0xFFf2f3f7),
                  child: Column(
                    children: [
                      Material(
                        elevation: 1,
                        color: const Color(0xFFf2f3f7),
                        borderRadius: BorderRadius.circular(0.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Basic",
                                  style: TextStyle(
                                      color: Color(0xFF3a3b3f),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  "Reading",
                                  style: TextStyle(
                                      color: Color(0xFF3a3b3f),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Blood Pressure",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: formField(37, "mmHg")
                                    // TextField(
                                    //   keyboardType: TextInputType.text,
                                    //   decoration: InputDecoration(
                                    //       border: InputBorder.none, hintText: 'mg/dL'),
                                    // ),
                                    ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xFF767676),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Temperature",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: formField(38, " C ")
                                    // TextField(
                                    //   keyboardType: TextInputType.text,
                                    //   decoration: InputDecoration(
                                    //       border: InputBorder.none, hintText: 'mg/dL'),
                                    // ),
                                    ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xFF767676),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "SpO2",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: formField(39, " % ")
                                    // TextField(
                                    //   keyboardType: TextInputType.text,
                                    //   decoration: InputDecoration(
                                    //       border: InputBorder.none, hintText: 'mg/dL'),
                                    // ),
                                    ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xFF767676),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Height",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: formField(40, " cm ")
                                    // TextField(
                                    //   keyboardType: TextInputType.text,
                                    //   decoration: InputDecoration(
                                    //       border: InputBorder.none, hintText: 'mg/dL'),
                                    // ),
                                    ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: Color(0xFF767676),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 25),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Weight",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Color(0xFF767676))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: formField(41, " Kg ")
                                    // TextField(
                                    //   keyboardType: TextInputType.text,
                                    //   decoration: InputDecoration(
                                    //       border: InputBorder.none, hintText: 'mg/dL'),
                                    // ),
                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Body Analyser",
                                style: TextStyle(
                                    color: Color(0xff3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Protein",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(42, " % ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "BMR ",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(43, "Kcal")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "BMI",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(44, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Body Fat",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(45, " % ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Fat-Free Body",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(46, "Kg")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Visceral Fat",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(47, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Body Water",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(48, " % ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Subcutaneous Fat",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(49, " % ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Skeletal Muscie",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(50, " % ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Muscle Mass",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(51, " Kg ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  )
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Metabolic Age",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(52, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Rapid Test",
                                style: TextStyle(
                                    color: Color(0xff3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Urinalysis",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(53, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Malaria ",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(54, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Pregnancy",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(55, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Hba1c",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(56, "  ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Hepatitis B & C",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(57, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Blood Grouping",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(58, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "RH Factor",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(59, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Syphilis(VDRL)",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(60, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "CRP",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(61, "")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Otoscope",
                                style: TextStyle(
                                    color: Color(0xff3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Ear",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(62, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Nose ",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(63, "")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Throat",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(64, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Mouth",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(65, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Others",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(66, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Material(
                      elevation: 1,
                      color: const Color(0xFFf2f3f7),
                      borderRadius: BorderRadius.circular(0.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Pulmonary Function Test",
                                style: TextStyle(
                                    color: Color(0xff3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "Reading",
                                style: TextStyle(
                                    color: Color(0xFF3a3b3f),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "FEV1",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(67, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "FVC ",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(68, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "FEV1/FCV%",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(69, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "FEV6",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(70, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "FEF 25-75",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(71, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xFF767676),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "PEF",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(
                                  height: 50,
                                  child: VerticalDivider(
                                      color: Color(0xFF767676))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: formField(72, " ")
                                  // TextField(
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none, hintText: 'mg/dL'),
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                submitButton1(),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget formField(
    int index,
    String hint,
  ) {
    return TextFieldContainer(
      child: TextFormField(
        controller: textEditingController[index],
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        /* decoration: BoxDecoration(11
          color: AppData.kPrimaryLightColor,
          //color: Color(0x45283e81),
          borderRadius: BorderRadius.circular(29),
        ),*/
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "",
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        onChanged: (newValue) {},
      ),
    );
  }

  Widget submitButton1() {
    return GestureDetector(
      onTap: () {
        // textEditingController.forEach((element) {
        //
        //   AppData.showInSnackBar(context, "Please Fill Up Atleast One Field ");
        // });
        for (int i = 0; i < 72; i++) {
          if (textEditingController[i] == null ||
              textEditingController[i] == null ||
              textEditingController[i].text.isEmpty ||
              textEditingController[i].text.isEmpty) {
            AppData.showInSnackBar(context, "Please Fill Up Atleast One Field ");
          }
          else {
            String creatinine = textEditingController[0].text;
            String urea = textEditingController[1].text;
            String uricacid = textEditingController[2].text;
            String bun = textEditingController[3].text;
            String egfr = textEditingController[4].text;
            String albumin = textEditingController[5].text;
            String alkaline = textEditingController[6].text;
            String phosphate = textEditingController[7].text;
            String directbilirubin = textEditingController[8].text;
            String indirectbilirubin = textEditingController[9].text;
            String totalbilirubin = textEditingController[10].text;
            String ast = textEditingController[11].text;
            String alt = textEditingController[12].text;
            String TotalProtine = textEditingController[13].text;
            String AGRatio = textEditingController[14].text;
            String Globulin = textEditingController[15].text;
            String Cholesterol = textEditingController[16].text;
            String hdl = textEditingController[17].text;
            String Triglyceride = textEditingController[18].text;
            String ldl = textEditingController[19].text;
            String ldl_calculative = textEditingController[20].text;
            String vldl = textEditingController[21].text;
            String hdlldlratio = textEditingController[22].text;
            String hdlratio = textEditingController[23].text;
            String sodium = textEditingController[24].text;
            String potassium = textEditingController[25].text;
            String chloride = textEditingController[26].text;
            String calcium = textEditingController[27].text;
            String magnesium = textEditingController[28].text;
            String phosphorus = textEditingController[29].text;
            String hemoglobin = textEditingController[30].text;
            String rbc = textEditingController[31].text;
            String pcv = textEditingController[32].text;
            String mcv = textEditingController[33].text;
            String mch = textEditingController[34].text;
            String mchc = textEditingController[35].text;
            String glucose = textEditingController[36].text;
            String bloodpressure = textEditingController[37].text;
            String temperature = textEditingController[38].text;
            String spo2 = textEditingController[39].text;
            String height = textEditingController[40].text;
            String weight = textEditingController[41].text;
            String protine = textEditingController[42].text;
            String bmr = textEditingController[43].text;
            String bmi = textEditingController[44].text;
            String bodyfat = textEditingController[45].text;
            String fat_free_body = textEditingController[46].text;
            String visceral_fat = textEditingController[47].text;
            String body_water = textEditingController[48].text;
            String subcutaneous_fat = textEditingController[49].text;
            String skeletal_muscie = textEditingController[50].text;
            String muscle_mass = textEditingController[51].text;
            String metabolic_age = textEditingController[52].text;
            String urinalysis = textEditingController[53].text;
            String malaria = textEditingController[54].text;
            String pregnancy = textEditingController[55].text;
            String hba1c = textEditingController[56].text;
            String hepatitis = textEditingController[57].text;
            String blood_grouping = textEditingController[58].text;
            String rh_factor = textEditingController[59].text;
            String syphilis = textEditingController[60].text;
            String crp = textEditingController[61].text;
            String ear = textEditingController[62].text;
            String nose = textEditingController[63].text;
            String throat = textEditingController[64].text;
            String mouth = textEditingController[65].text;
            String others = textEditingController[66].text;
            String fev1 = textEditingController[67].text;
            String fvc = textEditingController[68].text;
            String fev1_fcv = textEditingController[69].text;
            String fev6 = textEditingController[70].text;
            String fef25_75 = textEditingController[71].text;
            String pef = textEditingController[72].text;
            log(" VITAL  MODEL SEND>>>>" + jsonEncode(vitalModel.toJson()));
            MyWidgets.showLoading(context);
            var sendData = {
              "medteluniqueid":"MANUAL_ENTER",
              "thp_id": "MANUAL_ENTER",
              "thp_name": "MANUAL_ENTER",
              "name": widget.model.bodyUser.patientName,
              "mobile": widget.model.bodyUser.mob??"",
              "gender": widget.model.bodyUser.gender,
              "age": widget.model.bodyUser.age.toString(),
              "screening_date": widget.model.bodyUser.appntmntDate,
              "patient_uniqueid": widget.model.bodyUser.regNo,
              "report_url": "N/A",
              "screening_details": [
                {
                  "pocType": "KFT",
                  "pocResult": {
                    "creatinine": creatinine,
                    "urea": urea,
                    "uric_acid": uricacid,
                    "bun": bun,
                    "egfr": egfr
                  }
                },
                {
                  "pocType": "LFT",
                  "pocResult": {
                    "albumin":albumin,
                    "alkaline": alkaline,
                    "phosphate": phosphate,
                    "directbilirubin": directbilirubin,
                    "indirectbilirubin": indirectbilirubin,
                    "totalbilirubin": totalbilirubin,
                    "ast": ast,
                    "alt": alt,
                    "TotalProtine": TotalProtine,
                    "AGRatio": AGRatio,
                    "Globulin": Globulin
                  }
                },
                {
                  "pocType": "LIPIDPROFILE",
                  "pocResult": {
                    "Cholesterol":Cholesterol,
                    "hdl": hdl,
                    "Triglyceride": Triglyceride,
                    "ldl": ldl,
                    "ldl_calculative": ldl_calculative,
                    "vldl": vldl,
                    "hdlldlratio": hdlldlratio,
                    "hdlratio": hdlratio
                  }
                },
                {
                  "pocType": "ELECTROLYTES",
                  "pocResult": {
                    "sodium":sodium,
                    "potassium": potassium,
                    "chloride": chloride,
                    "calcium": calcium,
                    "magnesium": magnesium,
                    "phosphorus": phosphorus
                  }
                },
                {
                  "pocType": "HEMATOLOGY",
                  "pocResult": {
                    "hemoglobin":hemoglobin,
                    "rbc": rbc,
                    "pcv": pcv,
                    "mcv": mcv,
                    "mch": mch,
                    "phosphorus": mchc
                  }
                },
                {
                  "pocType":"SUGER",
                  "pocResult":{
                    "glucose":glucose
                  }
                },
                {
                  "pocType": "BASIC",
                  "pocResult": {
                    "bloodpressure":bloodpressure,
                    "temperature": temperature,
                    "spo2": spo2,
                    "height": height,
                    "weight": weight
                  }
                },
                {
                  "pocType": "BODYANALYSER",
                  "pocResult": {
                    "protine":protine,
                    "bmr": bmr,
                    "bmi": bmi,
                    "bodyfat": bodyfat,
                    "fat_free_body": fat_free_body,
                    "visceral_fat": visceral_fat,
                    "body_water": body_water,
                    "subcutaneous_fat": subcutaneous_fat,
                    "skeletal_muscie": skeletal_muscie,
                    "muscle_mass": muscle_mass,
                    "metabolic_age": metabolic_age,
                  }
                },
                {
                  "pocType": "RAPIDTEST",
                  "pocResult": {
                    "urinalysis":urinalysis,
                    "malaria": malaria,
                    "pregnancy": pregnancy,
                    "hba1c": hba1c,
                    "hepatitis": hepatitis,
                    "blood_grouping": blood_grouping,
                    "rh_factor": rh_factor,
                    "syphilis": syphilis,
                    "crp": crp,
                  }
                },
                {
                  "pocType": "OTOSCOPE",
                  "pocResult": {
                    "ear":ear,
                    "nose": nose,
                    "throat": throat,
                    "mouth": mouth,
                    "others": others,
                  }
                },
                {
                  "pocType": "PULMONARYFUNCTIONTEST",
                  "pocResult": {
                    "fev1":fev1,
                    "fvc": fvc,
                    "fev1_fcv": fev1_fcv,
                    "fev6": fev6,
                    "fef25_75": fef25_75,
                    "pef": pef,
                  }
                }

              ]
            };
            log("Value should be"+sendData.toString());
            widget.model.POSTMETHOD(
                api: ApiFactory.VITALS_REPORT,
                json: sendData,
                fun: (Map<String, dynamic> map) {
                  Navigator.pop(context);
                  if (map[Const.STATUS] == Const.SUCCESS) {
                    popup(context, map[Const.MESSAGE]);
                  } else {
                    AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  }
                });
          }
        }
      },

      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 180, right: 0),
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
            MyLocalizations.of(context).text("SUBMIT"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
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
}
