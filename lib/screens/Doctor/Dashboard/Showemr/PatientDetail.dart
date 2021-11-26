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

class PatientDetail extends StatefulWidget {
  MainModel model;

  PatientDetail({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatientDetail();
}

class _PatientDetail extends State<PatientDetail> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  String _ratingController;
  final myController = TextEditingController();
  final myControllerpass = TextEditingController();
  String eHealthCardno;
  bool isDataNotAvail = false;

  PatientsDetailsModel patientsDetails = PatientsDetailsModel();

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
        api: ApiFactory.PERSONAL_DETAILS + eHealthCardno,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          log("Personal deatils API>>>" + jsonEncode(map));
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              patientsDetails = PatientsDetailsModel.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
      body:
      Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
        //  physics: ScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: (patientsDetails != null && patientsDetails.body!=null && patientsDetails.body.isNotEmpty)
                ? Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.blue[400], Colors.blue[200]]),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[200]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(55),
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/profile.png',
                                            fit: BoxFit.cover))
                                  // height: 95,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              patientsDetails?.body[0]?.firstname??"N/A",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      "PERSONAL INFORMATION",
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
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "First Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].firstname,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Last Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].lastname,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "UHID Card No",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].uhidcardno,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Blood Group",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              (patientsDetails.body[0].bloodgroup!="null")?patientsDetails.body[0].bloodgroup:"N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "DOB",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              (patientsDetails.body[0].dob!="null")?patientsDetails.body[0].dob:"N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Age",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].age,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Gender",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].gender,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Maritial Status",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].maritalstatus ??
                                  "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Occupation",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].occupation ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //personal information
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Address",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "At",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              (patientsDetails?.body[0]?.address1 == null ||
                                  patientsDetails?.body[0]?.address1 ==
                                      "null")
                                  ? "N/A"
                                  : (patientsDetails?.body[0]?.address1 ??
                                  "N/A"),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Post ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              (patientsDetails?.body[0]?.address2 == null ||
                                  patientsDetails?.body[0]?.address2 ==
                                      "null")
                                  ? "N/A"
                                  : (patientsDetails?.body[0]?.address2 ??
                                  "N/A"),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Pin",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              (patientsDetails?.body[0]?.pin == null ||
                                  patientsDetails?.body[0]?.pin ==
                                      "null")
                                  ? "N/A"
                                  : (patientsDetails?.body[0]?.pin ??
                                  "N/A"),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Dist",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              (patientsDetails?.body[0]?.disctrict ==
                                  null ||
                                  patientsDetails?.body[0]?.disctrict ==
                                      "null")
                                  ? "N/A"
                                  : (patientsDetails?.body[0]?.disctrict ??
                                  "N/A"),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       width: 100,
                        //       child: Text(
                        //         "Date",
                        //         style: TextStyle(color: Colors.black, fontSize: 15),
                        //       ),
                        //     ),
                        //     Text(
                        //       "   :   ",
                        //       style: TextStyle( color: Colors.black, fontSize: 15),
                        //     ),
                        //     Text(
                        //       patientsDetails.body[12].,
                        //       style: TextStyle(color: Colors.black, fontSize: 15),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "city",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              (patientsDetails?.body[0]?.city == null ||
                                  patientsDetails?.body[0]?.city ==
                                      "null")
                                  ? "N/A"
                                  : (patientsDetails?.body[0]?.city ??
                                  "N/A"),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "State",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Expanded(
                              child: Text(
                                patientsDetails.body[0].state ?? "N/A",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Country",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].country ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //Address
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "EMERGENCY CONTACT",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails?.body[0]?.emrgncyname??"N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Relation ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails?.body[0]?.emrgncyrelation??"N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Mobile no",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails?.body[0]?.emrgncymob??"N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //emergency contact
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "FAMILY DOCTOR",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails?.body[0]?.famdctrname??"N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Speciality ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails?.body[0]?.famdctrsepeciality??"N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                "Mobile no",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails?.body[0]?.famdctrmob??"N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
//family doctor
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "VITAL SIGN",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Height (cm)",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails?.body[0]?.height ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Weight (kg) ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].weight ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "BMI kg/m2s",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].bmi ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Temperature in celsius",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].celcius ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Temperature in Fahrenheit",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].farenheit ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Blood Pressure in mmHg",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].bldpressure ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Systolic / Diastolic",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].systolic ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Pulse per minute",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].pulse ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Respiration bpm",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].bmi ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Oxygen Saturation percentage",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              "   :   ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              patientsDetails.body[0].oxygen ?? "N/A",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  //vital sign
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      "ALLERGIES",
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
                            "Allergies ",
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
                            "Severity",
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
                            "Reaction",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Divider(height: 1,),
                  (patientsDetails!=null && patientsDetails.body.isNotEmpty && patientsDetails.body[0].allergies.isNotEmpty&&patientsDetails.body != null &&
                      patientsDetails.body.length > 0) ?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // scrollDirection: Axis.horizontal,
                      itemCount: patientsDetails.body[0].allergies.length,
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
                                    patientsDetails.body[0].allergies[index].allName??"N/A",
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
                                    patientsDetails.body[0].allergies[index].allFood??"N/A",
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
                                    patientsDetails.body[0].allergies[index].severity??"N/A",
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
                                    patientsDetails.body[0].allergies[index].reaction??"N/A",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ):Container(),
                  //alergic
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "BIO MEDICAL IMPLANTS",
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
                        child: Text(
                          "Name",
                          style:
                          TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "Reason ",
                          style:
                          TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "Implanted Date",
                          style:
                          TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ]),
                  ),
                  (patientsDetails!=null && patientsDetails.body.isNotEmpty && patientsDetails.body[0].bioMedical.isNotEmpty)?SingleChildScrollView(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: patientsDetails.body[0].bioMedical.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  patientsDetails.body[0].bioMedical[index].bioMName??"N/A",
                                  style: TextStyle(
                                      color: Colors.grey[700]),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  patientsDetails.body[0].bioMedical[index].bioMReason??"N/A",
                                  style: TextStyle(
                                      color: Colors.grey[700]),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  patientsDetails.body[0].bioMedical[index].bioMDate??"N/A",
                                  style: TextStyle(
                                    color: Colors.grey[700], ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ):Container(),
                  SizedBox(height: 10),
                ],
              ),
            )
                : Container(),
          ),
        ),
      ),
    );
  }
}
