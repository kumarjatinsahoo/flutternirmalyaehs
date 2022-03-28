import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/PatientmedicalhistoryModel%20.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';

class PatientHistory extends StatefulWidget {
  MainModel model;

  PatientHistory({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatientHistory();
}

class _PatientHistory extends State<PatientHistory> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  String _ratingController;
  final myController = TextEditingController();
  final myControllerpass = TextEditingController();
  String eHealthCardno;
  PatientmedicalhistoryModel patientmedicalhistoryModel = PatientmedicalhistoryModel();
  bool isdata = true;
  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
    eHealthCardno = widget.model.patientseHealthCard;
    callPERSONALAPI(eHealthCardno);
  }
  callPERSONALAPI(String eHealthCardno) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.GET_PATIENT_MEDICAL_HISTORY + eHealthCardno,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          log("Personal deatils API>>>" + jsonEncode(map));
          setState(() {
            isdata = false;
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              patientmedicalhistoryModel = PatientmedicalhistoryModel.fromJson(map);
            } else {
              isdata = false;
              ///isDataNotAvail = true;
            //  AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),

      body:isdata == true
          ?
      Center(
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
      ) : patientmedicalhistoryModel == null || patientmedicalhistoryModel.body!=null||patientmedicalhistoryModel.body?.medicalHistory==null
          ? Container(
        child: Center(
          child: Image.asset("assets/NoRecordFound.png",
            // height: 25,
          ),
        ),
      ):Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: (patientmedicalhistoryModel != null && patientmedicalhistoryModel.body!=null )
                ? Container(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      "MEDICAL CONDITION",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "Medical Condition",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),

                    ]),
                  ),
                  (patientmedicalhistoryModel!=null && patientmedicalhistoryModel.body!="" && patientmedicalhistoryModel.body.medicalCondition.isNotEmpty&&patientmedicalhistoryModel.body != null &&
                      patientmedicalhistoryModel.body.medicalCondition.length > 0  )?SingleChildScrollView(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: patientmedicalhistoryModel.body.medicalCondition.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    patientmedicalhistoryModel.body.medicalCondition[index].description??"N/A",
                                    style: TextStyle(
                                        color: Colors.grey[700]),
                                  ),
                                ),


                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ):Container(),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "MEDICAL HISTOTORY",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "DoctorName",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "Date",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                     /* Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "OPDName",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),*/
                    ]),
                  ),
                  Divider(height: 1,),
                  (patientmedicalhistoryModel!=null && patientmedicalhistoryModel.body!="" && patientmedicalhistoryModel.body.medicalHistory.isNotEmpty&&patientmedicalhistoryModel.body != null &&
                      patientmedicalhistoryModel.body.medicalHistory.length > 0  ) ?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child:
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // scrollDirection: Axis.horizontal,
                        itemCount: patientmedicalhistoryModel.body.medicalHistory.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 80,
                                    child: Text(
                                      patientmedicalhistoryModel.body.medicalHistory[index].uname??"N/A",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    width: 80,
                                    child: Text(
                                      patientmedicalhistoryModel.body.medicalHistory[index].drName??"N/A",
                                      style: TextStyle(
                                        color: Colors.grey[700],),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    width: 80,
                                    child: Text(
                                      patientmedicalhistoryModel.body.medicalHistory[index].date??"N/A",
                                      style: TextStyle(
                                        color: Colors.grey[700],),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                /*Expanded(
                                  child: Container(
                                    width: 80,
                                    child: Text(
                                      patientmedicalhistoryModel.body.medicalHistory[index].opName??"N/A",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ):Container(),
                  //alergic

                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "MAJOR SURGERY",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Row(children: [
                      Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "DoctorName",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "Date",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      /*Expanded(
                        child: Container(
                          width: 80,
                          child: Text(
                            "OPDName",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),*/
                    ]),
                  ),
                  Divider(height: 1,),
                  (patientmedicalhistoryModel!=null && patientmedicalhistoryModel.body!="" && patientmedicalhistoryModel.body.majorsurgery.isNotEmpty&&patientmedicalhistoryModel.body != null &&
                      patientmedicalhistoryModel.body.majorsurgery.length > 0  )?SingleChildScrollView(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: patientmedicalhistoryModel.body.majorsurgery.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    patientmedicalhistoryModel.body.majorsurgery[index].uname??"N/A",
                                    style: TextStyle(
                                        color: Colors.grey[700]),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    patientmedicalhistoryModel.body.majorsurgery[index].drName??"N/A",
                                    style: TextStyle(
                                        color: Colors.grey[700]),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    patientmedicalhistoryModel.body.majorsurgery[index].date??"N/A",
                                    style: TextStyle(
                                      color: Colors.grey[700], ),
                                  ),
                                ),
                                /*SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    patientmedicalhistoryModel.body.majorsurgery[index].opName??"N/A",
                                    style: TextStyle(
                                      color: Colors.grey[700], ),
                                  ),
                                ),*/
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ):Container(),
                ],
              ),
            )
                : Container(),
          ),
        ),
      ),
      /*SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(children: [
              SizedBox(height: 5),
              Center(
                child: Text(
                  "MEDICAL CONDITION",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Center(
                    child: Container(
                      width: 200,
                      child: Text(
                        "Medical Condition",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child:
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),

                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Thyroid",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  "MAJOR ILLNESS",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                    width: 110,
                    child: Text(
                      "Name",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 110,
                    child: Text(
                      "Date ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 110,
                    child: Text(
                      "Doctor",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 110,
                                  child: Text(
                                    "Ipsita",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 110,
                              child: Text(
                                "11-08-2021 ",
                                style:
                                TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 110,
                              child: Text(
                                "sarat",
                                style:
                                TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  "MAJOR SURGERY",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                    width: 130,
                    child: Text(
                      "Major Surgery Id",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      "Name ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      "Date",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "1001",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 130,
                              child: Text(
                                "Major Surgery ",
                                style:
                                TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                "11-08-2021",
                                style:
                                TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  "TRANSCRIPTED MAJOR SURGERY",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Container(
                    width: 200,
                    child: Center(
                      child: Text(
                        "Transcripted Major Surgery",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    "no records found",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),*/
    );
  }
}
