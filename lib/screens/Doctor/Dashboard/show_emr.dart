import 'dart:convert';
import 'dart:developer';
import 'package:user/models/LoginResponse1.dart';
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
  String uhid;

  ShowEmr({Key key, this.model,this.uhid}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowEmr();
}

class _ShowEmr extends State<ShowEmr> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  String _ratingController;
  String eHealthCardno,eHealthCardnoo;
  String comeFrom;
  LoginResponse1 loginResponse;

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
    eHealthCardno = widget.uhid;
    widget.uhid=widget.model.patientseHealthCard;
    // eHealthCardnoo= widget.model.userid;
    //print('userrrrrrrrr>>>>>>>>>>>>>>>>>>>:$eHealthCardnoo');
   // eHealthCardnoo=widget.model.userid;
    //callPERSONALAPI(eHealthCardno);
   // callLabtastAPI(eHealthCardno);
    //callMadicationAPI(eHealthCardno);
   // print('userrriddddtesting>>>>>>>>>>>>>>>>>>: $eHealthCardnoo');

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
        length: 8,
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
                 /* Center(
                    child: Text(
                      " Visit On Aug 09,2021",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  )*/
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
                    /*  Icon(
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
*/                      Icon(
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
                                text: 'PATIENT DETAILS',
                              )),
                          new Container(
                            // width: 100,
                            height: 50.0,
                            child: new Tab(text: 'PATIENT HISTORY'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'TEST REPORT'),
                          ),
                          new Container(
                            // width: 80,
                            height: 50.0,
                            child: new Tab(text: 'MEDICATION'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'LIFE STYLE HISTORY'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'FAMILY DETAILS'),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'IMMUNIZATION'),
                          ),
                         /* new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'TREATMENT TRACKER'),
                          ),*/
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'MEDICAL DATA UPLOAD'),
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
             // TreatmentTracker(model: widget.model,),
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
}
