import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/PatientsDetailsModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';

class VitalDoctor extends StatefulWidget {
  MainModel model;

  VitalDoctor({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VitalDoctor();
}

class _VitalDoctor extends State<VitalDoctor> {


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
  ];

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
                                  "Reading(mg/dL)",
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
                        color:Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 25,),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Creatinine",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 25,),
                                Expanded(
                                  child: TextField(
                                   // controller: textEditingController[index],
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height:1 ,color: Color(0xFF767676),),
                            Row(
                              children: [
                                SizedBox(width: 25,),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Urea",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height:1 ,color: Color(0xFF767676),),
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
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height:1 ,color: Color(0xFF767676),),
                            Row(
                              children: [
                                SizedBox(width: 25,),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "BUN",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height:1 ,color: Color(0xFF767676),),
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
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
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
                      elevation:1,
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
                                "Reading(mg/dL)",
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
                      color:Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Albumin",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Alkaline ",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),

                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Phosphate",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Direct Bilirubin",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Indriect Bilirubin",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Total Bilirubin",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "AST(SGOT)",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "ALT(SGPT)",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Total Protine",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),

                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "AG Ratio",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),                              ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Globulin",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
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
                                "Reading(mg/dL)",
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
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "HDL ",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Triglyceride",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "LDL",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "LDL Calculative",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "VLDL",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "HDL/LDL Ratio",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "HDL Ratio",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
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
                      elevation:1,
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
                                "Reading(mg/dL)",
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
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Potassium ",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Chloride",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),

                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Calcium",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),

                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Magnesium",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Phosphorus",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
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
                      elevation:1,
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
                                "Reading(mg/dL)",
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
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "RBC ",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "PCV",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),

                          Divider(height:1 ,color: Color(0xFF767676),),

                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "MCV",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),

                          Divider(height:1 ,color: Color(0xFF767676),),

                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "MCH",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),

                          Divider(height:1 ,color: Color(0xFF767676),),

                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "MCHC",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(height:1 ,color: Color(0xFF767676),),

                        ],
                      ),
                    ),
                  ],
                ),
                //hematology

                Column(
                  children: [
                    Material(
                      elevation:1,
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
                                "Reading(mg/dL)",
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
                              style: TextStyle(color: Color(0xFF515151), fontSize: 15),
                            ),
                          ),
                          Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                          SizedBox(width: 10,),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'mg/dL'),
                            ),
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
                                  "Reading(mg/dL)",
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
                        color:Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 25,),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Blood Pressure",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height:1 ,color: Color(0xFF767676),),
                            Row(
                              children: [
                                SizedBox(width: 25,),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Temperature",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height:1 ,color: Color(0xFF767676),),
                            Row(
                              children: [
                                SizedBox(width: 25,),

                                Container(
                                  width: 150,
                                  child: Text(
                                    "SpO2",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height:1 ,color: Color(0xFF767676),),
                            Row(
                              children: [
                                SizedBox(width: 25,),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "Height",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 15),
                                  ),
                                ),
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height:1 ,color: Color(0xFF767676),),
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
                                Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none, hintText: 'mg/dL'),
                                  ),
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
                      elevation:1,
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
                                "Reading(mg/dL)",
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
                      color:Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Protein",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "BMR ",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),

                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "BMI",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Body Fat",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Fat-Free Body",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Visceral Fat",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Body Water",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Subcutaneous Fat",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Skeletal Muscie",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),

                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Muscle Mass",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),                              ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "Metabolic Age",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
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
                      elevation:1,
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
                                "Reading(mg/dL)",
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
                      color:Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Urinalysis",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Malaria ",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),

                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Pregnancy",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Hba1c",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Hepatitis B & C",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Blood Grouping",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "RH Factor",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Syphilis(VDRL)",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),
                              Container(
                                width: 150,
                                child: Text(
                                  "CRP",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
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
                      elevation:1,
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
                                "Reading(mg/dL)",
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
                      color:Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Ear",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Nose ",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),

                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Throat",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Mouth",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "Others",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
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
                      elevation:1,
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
                                "Reading(mg/dL)",
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
                      color:Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "FEV1",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "FVC ",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),

                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "FEV1/FCV%",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "FEV6",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "FEF 25-75",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                          Divider(height:1 ,color: Color(0xFF767676),),
                          Row(
                            children: [
                              SizedBox(width: 25),

                              Container(
                                width: 150,
                                child: Text(
                                  "PEF",
                                  style:
                                  TextStyle(color: Color(0xFF515151), fontSize: 15),
                                ),
                              ),
                              Container(height: 50, child: VerticalDivider(color: Color(0xFF767676))),

                              SizedBox(width: 10,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: 'mg/dL'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ]),
            ),
          ),
        ),
      ),
    );
  }
}
