import 'dart:convert';
import 'dart:developer';
import 'package:user/models/MadicationlistModel.dart'as apnt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/PatientsDetailsModel.dart';
import 'package:user/models/UserlabtestreportModel.dart';

import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/FamilyDetails.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/Immunization.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/LifestyleHistory.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/Medication.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/MobileUpload.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/PatientDetail.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/PatientHistory.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/TestReport.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/TreatmentTracker.dart';

class ShowEmr extends StatefulWidget {
  MainModel model;

  ShowEmr({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowEmr();
}

class _ShowEmr extends State<ShowEmr> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  String _ratingController;
  String eHealthCardno;
  String comeFrom;
 // PatientsDetailsModel patientsDetails = PatientsDetailsModel();
 // UserlabtestreportModel userlabtestreportModel = UserlabtestreportModel();
//  apnt.MadicationlistModel madicationlistModel =apnt.MadicationlistModel();
  bool isDataNotAvail = false;

  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
    //eHealthCardno="5093626841904641";
    eHealthCardno = widget.model.patientseHealthCard;
    //callPERSONALAPI(eHealthCardno);
   // callLabtastAPI(eHealthCardno);
    //callMadicationAPI(eHealthCardno);
  }

  // callPERSONALAPI(String eHealthCardno) {
  //   widget.model.GETMETHODCALL_TOKEN(
  //       api: ApiFactory.PERSONAL_DETAILS + eHealthCardno,
  //       token: widget.model.token,
  //       fun: (Map<String, dynamic> map) {
  //         log("Personal deatils API>>>" + jsonEncode(map));
  //         setState(() {
  //           String msg = map[Const.MESSAGE];
  //           if (map[Const.CODE] == Const.SUCCESS) {
  //             patientsDetails = PatientsDetailsModel.fromJson(map);
  //           } else {
  //             isDataNotAvail = true;
  //             AppData.showInSnackBar(context, msg);
  //           }
  //         });
  //       });
  // }

  // callLabtastAPI(String eHealthCardno) {
  //   widget.model.GETMETHODCALL_TOKEN(
  //       api: ApiFactory.IABTEST_REPORTDOCTER + eHealthCardno,
  //       token: widget.model.token,
  //       fun: (Map<String, dynamic> map) {
  //         log("Error in>>>"+jsonEncode(map));
  //         setState(() {
  //           String msg = map[Const.MESSAGE];
  //           if (map[Const.CODE] == Const.SUCCESS) {
  //             userlabtestreportModel = UserlabtestreportModel.fromJson(map);
  //           } else {
  //             isDataNotAvail = true;
  //             AppData.showInSnackBar(context, msg);
  //           }
  //         });
  //       });
  // }

  // callMadicationAPI(String eHealthCardno) {
  //   widget.model.GETMETHODCALL_TOKEN(
  //       api: ApiFactory.MEDICATION_DOCTER + eHealthCardno,
  //       token: widget.model.token,
  //       fun: (Map<String, dynamic> map) {
  //         setState(() {
  //           String msg = map[Const.MESSAGE];
  //           if (map[Const.CODE] == Const.SUCCESS) {
  //             madicationlistModel =apnt.MadicationlistModel.fromJson(map);
  //           } else {
  //             isDataNotAvail = true;
  //             AppData.showInSnackBar(context, msg);
  //           }
  //         });
  //       });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 9,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.0), // here the desired height

            child: AppBar(
              backgroundColor: Color(0xFF0F6CE1),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "SHOW EMR",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      " Visit On Aug 09,2021",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  )
                ],
              ),
              leading: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                          onTap: () async {
                            /*Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new WalkPatient()));*/
                            //Navigator.pushNamed(context, "/docWalkInReg");
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        // Container(
                        //   height: 20,
                        //   width: 1,
                        //   child: VerticalDivider(
                        //     thickness: 2,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(children: <Widget>[
                      Icon(
                        Icons.print,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.event_note_sharp,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ]),
                  ],
                )
              ],
              bottom: new PreferredSize(
                preferredSize: new Size(200.0, 50.0),
                child: Column(
                  children: [
                    new Container(
                      // width: 200.0,

                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        indicatorColor: Color(0xFF0F6CE1),
                        labelStyle: TextStyle(fontSize: 15),
                        tabs: [
                          new Container(
                              //  width: 70,
                              height: 50.0,
                              child: new Tab(
                                text: 'PATIENTDETAILS',
                              )),
                          new Container(
                            // width: 100,
                            height: 50.0,
                            child: new Tab(text: 'PATIENTHISTORY'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'TESTREPORT'),
                          ),
                          new Container(
                            // width: 80,
                            height: 50.0,
                            child: new Tab(text: 'MEDICATION'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'LIFESTYLEHISTORY'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'FAMILYDETAILS'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'IMMUNIZATION'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'TREATMENTTRACKER'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'MEDICALDATAUPLOAD'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              PatientDetail(model: widget.model,),
              PatientHistory(model: widget.model,),
              TestReport(model: widget.model,),
              Medication(model: widget.model,),
              LifeStylehistory(model: widget.model,),
              FamilyDetails(model: widget.model,),
              Immunization(model: widget.model,),
              TreatmentTracker(model: widget.model,),
              MobileUpload(model: widget.model,),
        //      PatientDetails(),
        //      patientHistory(),
       //       testReport(),
        //      medication(),
         //     lifestyleHistory(),
         //     familyDetails(),
         //     immunization(),
         //     treatmentTracker(),
        //      medicaldataUpload(),
              // SecondScreen(),
            ],
          ),
        ),
      ),
    );
  }

//   Widget PatientDetails() {
//     Size size = MediaQuery.of(context).size;
//     return
//       Container(
//       height: double.maxFinite,
//       width: double.maxFinite,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: (patientsDetails != null && patientsDetails.body!=null && patientsDetails.body.isNotEmpty)
//               ? Container(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
//                         child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 colors: [Colors.blue[400], Colors.blue[200]]),
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.grey[200]),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 20.0, right: 20, top: 10, bottom: 10),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                     child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(55),
//                                         child: Container(
//                                             height: 50,
//                                             width: 50,
//                                             child: Image.asset(
//                                                 'assets/images/profile.png',
//                                                 fit: BoxFit.cover))
//                                         // height: 95,
//                                         )),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   patientsDetails?.body[0]?.firstname??"N/A",
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Center(
//                         child: Text(
//                           "PERSONAL INFORMATION",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "First Name",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].firstname,
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Last Name",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].lastname,
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "UHID Card No",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].uhidcardno,
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Blood Group",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   (patientsDetails.body[0].bloodgroup!="null")?patientsDetails.body[0].bloodgroup:"N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "DOB",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   (patientsDetails.body[0].dob!="null")?patientsDetails.body[0].dob:"N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Age",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].age,
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Gender",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].gender,
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Maritial Status",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].maritalstatus ??
//                                       "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Occupation",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].occupation ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       //personal information
//                       SizedBox(height: 10),
//                       Center(
//                         child: Text(
//                           "Address",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "At",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   (patientsDetails?.body[0]?.address1 == null ||
//                                           patientsDetails?.body[0]?.address1 ==
//                                               "null")
//                                       ? "N/A"
//                                       : (patientsDetails?.body[0]?.address1 ??
//                                           "N/A"),
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Post ",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   (patientsDetails?.body[0]?.address2 == null ||
//                                           patientsDetails?.body[0]?.address2 ==
//                                               "null")
//                                       ? "N/A"
//                                       : (patientsDetails?.body[0]?.address2 ??
//                                           "N/A"),
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Pin",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   (patientsDetails?.body[0]?.pin == null ||
//                                           patientsDetails?.body[0]?.pin ==
//                                               "null")
//                                       ? "N/A"
//                                       : (patientsDetails?.body[0]?.pin ??
//                                           "N/A"),
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Dist",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   (patientsDetails?.body[0]?.disctrict ==
//                                               null ||
//                                           patientsDetails?.body[0]?.disctrict ==
//                                               "null")
//                                       ? "N/A"
//                                       : (patientsDetails?.body[0]?.disctrict ??
//                                           "N/A"),
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             // Row(
//                             //   children: [
//                             //     Container(
//                             //       width: 100,
//                             //       child: Text(
//                             //         "Date",
//                             //         style: TextStyle(color: Colors.black, fontSize: 15),
//                             //       ),
//                             //     ),
//                             //     Text(
//                             //       "   :   ",
//                             //       style: TextStyle( color: Colors.black, fontSize: 15),
//                             //     ),
//                             //     Text(
//                             //       patientsDetails.body[12].,
//                             //       style: TextStyle(color: Colors.black, fontSize: 15),
//                             //     ),
//                             //   ],
//                             // ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "city",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   (patientsDetails?.body[0]?.city == null ||
//                                           patientsDetails?.body[0]?.city ==
//                                               "null")
//                                       ? "N/A"
//                                       : (patientsDetails?.body[0]?.city ??
//                                           "N/A"),
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "State",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     patientsDetails.body[0].state ?? "N/A",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Country",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].country ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       //Address
//                       SizedBox(height: 10),
//                       Center(
//                         child: Text(
//                           "EMERGENCY CONTACT",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Name",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails?.body[0]?.emrgncyname??"N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Relation ",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails?.body[0]?.emrgncyrelation??"N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Mobile no",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails?.body[0]?.emrgncymob??"N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       //emergency contact
//                       SizedBox(height: 10),
//                       Center(
//                         child: Text(
//                           "FAMILY DOCTOR",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Name",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails?.body[0]?.famdctrname??"N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Speciality ",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails?.body[0]?.famdctrsepeciality??"N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text(
//                                     "Mobile no",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails?.body[0]?.famdctrmob??"N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
// //family doctor
//                       SizedBox(height: 10),
//                       Center(
//                         child: Text(
//                           "VITAL SIGN",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Height (cm)",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails?.body[0]?.height ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Weight (kg) ",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].weight ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "BMI kg/m2s",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].bmi ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Temperature in celsius",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].celcius ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Temperature in Fahrenheit",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].farenheit ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Blood Pressure in mmHg",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].bldpressure ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Systolic / Diastolic",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].systolic ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Pulse per minute",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].pulse ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Respiration bpm",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].bmi ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 200,
//                                   child: Text(
//                                     "Oxygen Saturation percentage",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 15),
//                                   ),
//                                 ),
//                                 Text(
//                                   "   :   ",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                                 Text(
//                                   patientsDetails.body[0].oxygen ?? "N/A",
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                       //vital sign
//                       SizedBox(height: 5),
//                       Center(
//                         child: Text(
//                           "ALLERGIES",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(children: [
//                           Expanded(
//                             child: Container(
//                               width: 80,
//                               child: Text(
//                                 "Name",
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 15),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Expanded(
//                             child: Container(
//                               width: 80,
//                               child: Text(
//                                 "Allergies ",
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 15),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Expanded(
//                             child: Container(
//                               width: 80,
//                               child: Text(
//                                 "Severity",
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 15),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Expanded(
//                             child: Container(
//                               width: 80,
//                               child: Text(
//                                 "Reaction",
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 15),
//                               ),
//                             ),
//                           ),
//                         ]),
//                       ),
//                       Divider(height: 1,),
//                       (patientsDetails!=null && patientsDetails.body.isNotEmpty && patientsDetails.body[0].allergies.isNotEmpty)?Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Expanded(
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             // scrollDirection: Axis.horizontal,
//                             itemCount: patientsDetails.body[0].allergies.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 0),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         width: 80,
//                                         child: Text(
//                                           patientsDetails.body[0].allergies[index].allName,
//                                           style: TextStyle(
//                                               color: Colors.grey[700],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         width: 80,
//                                         child: Text(
//                                           patientsDetails.body[0].allergies[index].allFood,
//                                           style: TextStyle(
//                                               color: Colors.grey[700],),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         width: 80,
//                                         child: Text(
//                                           patientsDetails.body[0].allergies[index].severity,
//                                           style: TextStyle(
//                                               color: Colors.grey[700],),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         width: 80,
//                                         child: Text(
//                                           patientsDetails.body[0].allergies[index].reaction,
//                                           style: TextStyle(
//                                               color: Colors.grey[700],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ):Container(),
//                       //alergic
//                       SizedBox(height: 10),
//                       Center(
//                         child: Text(
//                           "BIO MEDICAL IMPLANTS",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(children: [
//                           Expanded(
//                             child: Text(
//                               "Name",
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 15),
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Expanded(
//                             child: Text(
//                               "Reason ",
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 15),
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Expanded(
//                             child: Text(
//                               "Implanted Date",
//                               style:
//                                   TextStyle(color: Colors.black, fontSize: 15),
//                             ),
//                           ),
//                         ]),
//                       ),
//                       (patientsDetails!=null && patientsDetails.body.isNotEmpty && patientsDetails.body[0].bioMedical.isNotEmpty)?ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.vertical,
//                         itemCount: patientsDetails.body[0].bioMedical.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     patientsDetails.body[0].bioMedical[index].bioMName,
//                                     style: TextStyle(
//                                         color: Colors.grey[700]),
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                                 Expanded(
//                                   child: Text(
//                                     patientsDetails.body[0].bioMedical[index].bioMReason,
//                                     style: TextStyle(
//                                         color: Colors.grey[700]),
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                                 Expanded(
//                                   child: Text(
//                                     patientsDetails.body[0].bioMedical[index].bioMDate,
//                                     style: TextStyle(
//                                         color: Colors.grey[700], ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ):Container(),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 )
//               : Container(),
//         ),
//       ),
//     );
//   }

  Widget patientHistory() {
    return
      SingleChildScrollView(
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
                child: ListView.builder(
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
    );
  }

  // Widget testReport() {
  //   Size size = MediaQuery.of(context).size;
  //   return
  //     SingleChildScrollView(
  //     child: Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: Container(
  //         child: Column(children: [
  //           SizedBox(height: 5),
  //           Center(
  //             child: Text(
  //               "LABS TEST REPORT LIST",
  //               style: TextStyle(
  //                   color: Colors.blue,
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           SizedBox(height: 5),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Expanded(
  //               child: (userlabtestreportModel != null && userlabtestreportModel.body!=null && userlabtestreportModel.body.isNotEmpty)
  //                   ? ListView.builder(
  //                       shrinkWrap: true,
  //                       // scrollDirection: Axis.horizontal,
  //                       itemCount: userlabtestreportModel.body.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return Card(
  //                           color: Color(0xFFD2E4FC),
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.only(
  //                                 topLeft: Radius.circular(5),
  //                                 topRight: Radius.circular(5),
  //                                 bottomRight: Radius.circular(5),
  //                                 bottomLeft: Radius.circular(5),
  //                               ),
  //                               side: BorderSide(
  //                                   width: 1, color: Color(0xFFD2E4FC))),
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(10.0),
  //                             child: Column(
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     Container(
  //                                       width: 100,
  //                                       child: Text(
  //                                         "Patient Id",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: 15),
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       "   :   ",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                     Text(
  //                                       /*"121448674403477"*/
  //                                       userlabtestreportModel?.body[0]?.patientid ??
  //                                           "N/A",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 5),
  //                                 Row(
  //                                   children: [
  //                                     Container(
  //                                       width: 100,
  //                                       child: Text(
  //                                         "Patient Name",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: 15),
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       "   :   ",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                     Text(
  //                                       /*"Ipsita Sahoo"*/
  //                                       userlabtestreportModel
  //                                               .body[0].patientname ??
  //                                           "N/A",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 5),
  //                                 Row(
  //                                   children: [
  //                                     Container(
  //                                       width: 100,
  //                                       child: Text(
  //                                         "Age",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: 15),
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       "   :   ",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                     Text(
  //                                       userlabtestreportModel.body[0].age ??
  //                                           "N/A",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 5),
  //                                 Row(
  //                                   children: [
  //                                     Container(
  //                                       width: 100,
  //                                       child: Text(
  //                                         "Gender",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: 15),
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       "   :   ",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                     Text(
  //                                       userlabtestreportModel.body[0].gender ??
  //                                           "N/A",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 5),
  //                                 Row(
  //                                   children: [
  //                                     Container(
  //                                       width: 100,
  //                                       child: Text(
  //                                         "Weight",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: 15),
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       "   :   ",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                     Text(
  //                                       userlabtestreportModel.body[0].weight ??
  //                                           "N/A",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 5),
  //                                 Row(
  //                                   children: [
  //                                     Container(
  //                                       width: 100,
  //                                       child: Text(
  //                                         "Height",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: 15),
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       "   :   ",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                     Text(
  //                                       userlabtestreportModel.body[0].height ??
  //                                           "N/A",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 5),
  //                                 Row(
  //                                   children: [
  //                                     Container(
  //                                       width: 100,
  //                                       child: Text(
  //                                         "Test Date",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: 15),
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       "   :   ",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                     Text(
  //                                       userlabtestreportModel
  //                                               .body[0].testdate ??
  //                                           "N/A",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 5),
  //                                 Row(
  //                                   children: [
  //                                     Container(
  //                                       width: 100,
  //                                       child: Text(
  //                                         "Phc",
  //                                         style: TextStyle(
  //                                             color: Colors.black,
  //                                             fontSize: 15),
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       "   :   ",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                     Text(
  //                                       userlabtestreportModel.body[0].phc ??
  //                                           "N/A",
  //                                       style: TextStyle(
  //                                           color: Colors.black, fontSize: 15),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     )
  //                   : Container(),
  //             ),
  //           ),
  //         ]),
  //       ),
  //     ),
  //   );
  // }

  // Widget medication() {
  //   Size size = MediaQuery.of(context).size;
  //   return
  //     SingleChildScrollView(
  //     child: Padding(
  //       padding: const EdgeInsets.all(15.0),
  //       child: Container(
  //         child: Column(children: [
  //           SizedBox(height: 5),
  //           Center(
  //             child: Text(
  //               "CURRENT MEDICINES",
  //               style: TextStyle(
  //                   color: Colors.blue,
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(0.0),
  //             child: Expanded(
  //               child:(madicationlistModel != null && madicationlistModel.body!=null && madicationlistModel.body.isNotEmpty)
  //                   ? ListView.builder(
  //                 shrinkWrap: true,
  //                 // scrollDirection: Axis.horizontal,
  //                /* itemCount: 2,
  //                 itemBuilder: (BuildContext context, int index) {*/
  //                 itemBuilder: (context, i) {
  //                   apnt.Body medition = madicationlistModel.body[i];
  //                   return Card(
  //                     color: Color(0xFFD2E4FC),
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: Radius.circular(5),
  //                           topRight: Radius.circular(5),
  //                           bottomRight: Radius.circular(5),
  //                           bottomLeft: Radius.circular(5),
  //                         ),
  //                         side: BorderSide(width: 1, color: Color(0xFFD2E4FC))),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Column(
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width: 100,
  //                                 child: Text(
  //                                   "Doctor",
  //                                   style: TextStyle(
  //                                       color: Colors.black, fontSize: 15),
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "   :   ",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                               Text(
  //                                 /*"Paracetmol"*/medition.doctor,
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(height: 5),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width: 100,
  //                                 child: Text(
  //                                   "Type",
  //                                   style: TextStyle(
  //                                       color: Colors.black, fontSize: 15),
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "   :   ",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                               Text(
  //                                 /*"Tablet"*/medition.medname,
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(height: 5),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width: 100,
  //                                 child: Text(
  //                                   "Dosage",
  //                                   style: TextStyle(
  //                                       color: Colors.black, fontSize: 15),
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "   :   ",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                               Text(
  //                                 /*"5 Days From 12-08-2021"*/medition.dosage,
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(height: 5),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width: 100,
  //                                 child: Text(
  //                                   "Morning",
  //                                   style: TextStyle(
  //                                       color: Colors.black, fontSize: 15),
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "   :   ",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                               Text(
  //                                 /*"1"*/medition.morning,
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(height: 5),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width: 100,
  //                                 child: Text(
  //                                   "Afternoon",
  //                                   style: TextStyle(
  //                                       color: Colors.black, fontSize: 15),
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "   :   ",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                               Text(
  //                                 medition.afternoon,
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(height: 5),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width: 100,
  //                                 child: Text(
  //                                   "Evening",
  //                                   style: TextStyle(
  //                                       color: Colors.black, fontSize: 15),
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "   :   ",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                               Text(
  //                                 /*"1"*/ medition.evening,
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                             ],
  //                           ),
  //                          /* SizedBox(height: 5),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width: 100,
  //                                 child: Text(
  //                                   "Doctor",
  //                                   style: TextStyle(
  //                                       color: Colors.black, fontSize: 15),
  //                                 ),
  //                               ),
  //                               Text(
  //                                 "   :   ",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                               Text(
  //                                 "Mr.Neraj Desai",
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 15),
  //                               ),
  //                             ],
  //                           ),*/
  //                           SizedBox(height: 5),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },itemCount: madicationlistModel.body.length,
  //               ) : Container(),
  //             ),
  //           ),
  //         ]),
  //       ),
  //     ),
  //   );
  // }

  Widget lifestyleHistory() {
    Size size = MediaQuery.of(context).size;
    return
      SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            SizedBox(height: 5),
            Center(
              child: Text(
                "LIFE STYLE HISTORY",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Card(
              color: Color(0xFFD2E4FC),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  side: BorderSide(width: 1, color: Color(0xFFD2E4FC))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Smoking",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Very Frequently 25/day",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Alcohol",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Very Frequently",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Diet",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "veg",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Exercise",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Twice a Day",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Occupation",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Software Developer",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Height",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "5'3",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Pets",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Yes",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget familyDetails() {
    Size size = MediaQuery.of(context).size;
    return
      SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
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
                    "RELATION",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 110,
                  child: Text(
                    "AGE ",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 110,
                  child: Text(
                    "BIRTH Date",
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
                                  "Mother",
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
                              "35 ",
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
                              "11-08-1987",
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
          ]),
        ),
      ),
    );
  }

  Widget immunization() {
    Size size = MediaQuery.of(context).size;
    return
      SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
            SizedBox(height: 5),
            Center(
              child: Text(
                "IMMUNIZATION",
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
                  width: 90,
                  child: Text(
                    "VACCINE",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 110,
                  child: Text(
                    "PRESCRIBTED ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 60,
                  child: Text(
                    "DATE",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 90,
                  child: Text(
                    "STATUS",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
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
                                  "Hepatitis E virus",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "DR.Dinesh ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "11-08-1987",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                          Container(
                            width: 40,
                            child: Text(
                              "Done",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
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
    );
  }

  Widget treatmentTracker() {
    Size size = MediaQuery.of(context).size;
    return
      SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
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
                    "MEDICINE",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 110,
                  child: Text(
                    "DOES ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 110,
                  child: Text(
                    "DAYS",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
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
                                  "Paracetmol",
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
                              "3 ",
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
                              "30",
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
          ]),
        ),
      ),
    );
  }

  Widget medicaldataUpload() {
    Size size = MediaQuery.of(context).size;
    return
      SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(children: [
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.22,
                                  child: Image.asset(
                                      'assets/images/appointment.png',
                                      fit: BoxFit.cover))
                              // height: 95,

                              )),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Ipsita Sahoo",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
/*
class MyPage2Widget extends StatelessWidget {
  double _height = 85;
  double _width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    _width = (MediaQuery
        .of(context)
        .size
        .width - 80) / 3;
    return
  }}*/
