import 'dart:convert';
import 'dart:developer';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/FamilyDetails.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/Immunization.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/LifestyleHistory.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/Medication.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/MobileUpload/MobileUpload.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/PatientDetail.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/PatientHistory.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/TestReport.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/UploadDocumentTab.dart';

import 'Showemr/MobileUpload/DoctorUploadDocumentTab.dart';

class ShowEmr extends StatefulWidget {
  MainModel model;
  String uhid;

  ShowEmr({Key key, this.model, this.uhid}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowEmr();
}

class _ShowEmr extends State<ShowEmr> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  String _ratingController;
  String eHealthCardno, eHealthCardnoo;
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
    widget.uhid = widget.model.patientseHealthCard;

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 8,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.0), // here the desired height
            child: AppBar(
              backgroundColor: AppData.kPrimaryColor,
            title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(MyLocalizations.of(context).text("MEDICAL_RECORD")),
            ),
            leading: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/Newdashboard");
                  },
                child: Icon(Icons.arrow_back)),
            /*  title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                    onTap: () async {
                      */
              /*Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new WalkPatient()));*/
              /*
                      //Navigator.pushNamed(context, "/docWalkInReg");
                      Navigator.of(context).pop();
                      //Navigator.of(context).pop();
                    },
                  ),

                ],
              ),*/
             /* leading: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
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
              ),*/
              /*actions: <Widget>[
                PopupMenuButton<int>(
                  onSelected: (item) => handleClick(item),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(value: 0, child: Text('Add Immunization')),
                  ],
                ),
              ],*/

              bottom: new PreferredSize(
                preferredSize: new Size(200.0, 50.0),
                child: Column(
                  children: [
                    new Container(
                      // width: 200.0,

                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        indicatorColor:Colors.white,
                        //isScrollable: true,
                        labelStyle: TextStyle(fontSize: 15),
                        tabs: [
                          new Container(
                              //  width: 70,
                              height: 50.0,
                              child: new Tab(
                                text:MyLocalizations.of(context).text("PATIENT_DETAILS").toUpperCase(),
                              )),
                          new Container(
                            // width: 100,
                            height: 50.0,
                            child: new Tab(
                                text:MyLocalizations.of(context).text("PATIENT_HISTORY").toUpperCase()),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(
                                text:MyLocalizations.of(context).text("TEST_REPORT").toUpperCase()),
                          ),
                          new Container(
                            // width: 80,
                            height: 50.0,
                            child: new Tab(
                                text:MyLocalizations.of(context).text("MEDICATION").toUpperCase()),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(
                                text:MyLocalizations.of(context).text("LIFESTYLE_HISTORY").toUpperCase()),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(
                                text:MyLocalizations.of(context).text("FAMILY_DETAILS").toUpperCase()),
                          ),
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(
                                text:MyLocalizations.of(context).text("IMMUNIZATION").toUpperCase()),
                          ),
                          /* new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(text: 'TREATMENT TRACKER'),
                          ),*/
                          new Container(
                            //  width: 100,
                            height: 50.0,
                            child: new Tab(
                                text:MyLocalizations.of(context).text("MEDICAL_DATA_UPLOAD").toUpperCase()),
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
              PatientDetail(
                model: widget.model,
              ),
              PatientHistory(
                model: widget.model,
              ),
              TestReport(
                model: widget.model,
              ),
              Medication(
                model: widget.model,
              ),
              LifeStylehistory(
                model: widget.model,
              ),
              FamilyDetails(
                model: widget.model,
              ),
              Immunization(
                model: widget.model,
              ),
              DocterUploadDocumentTab(
                model: widget.model,
              ),

            /*  MobileUpload(
                model: widget.model,
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  popup(BuildContext context) {
    return Alert(
        context: context,
        // title: "Add Immunization",
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
              "Add Immunization",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              //Navigator.pop(context, true);
              // Navigator.pop(context, true);
              //callAPI();
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(
          context,
          "/addimmunization",
        );
        break;
    }
  }
}
