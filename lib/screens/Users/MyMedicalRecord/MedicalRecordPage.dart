import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/notification/TokenMonitor.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class MedicalRecordPage extends StatefulWidget {
  MainModel model;

  MedicalRecordPage({Key key, this.model}) : super(key: key);

  @override
  _MedicalRecordPageState createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
  var selectedMinValue;

  var _token;
  LoginResponse1 loginResponse1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
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
        title: Text(MyLocalizations.of(context).text("MEDICAL_RECORD1")),
      ),
      body: Container(
        child: Column(
          children: [
           /* TokenMonitor((token) {
              _token = token;
              return token == null
                  ? const CircularProgressIndicator()
                  : Text(token, style: const TextStyle(fontSize: 12));
            }),*/
            /* Container(
          color: AppData.kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white)),
                Text(
                  'Medical Records ',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Icon(Icons.search, color: Colors.white),
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
        ),*/
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
                            GestureDetector(
                              onTap: () =>

                                  Navigator.pushNamed(context, "/userTab1"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 45,
                                              width: 45,
                                              color: AppData.kPrimaryRedColor,
                                              padding: EdgeInsets.all(6),
                                              child: Image.asset(
                                                "assets/intro/generic_medicine2.png",
                                                height: 25,
                                                width: 25,
                                                color: Colors.white,
                                              )),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Text(MyLocalizations.of(context).text("MEDICATION"),
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .normal,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, "/vitalSigns"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              color:AppData.kPrimaryBlueColor,
                                              padding: EdgeInsets.all(3),
                                              child: Image.asset(
                                                "assets/images/Vitalsigns.png",
                                                height: 40,
                                              )),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Text(MyLocalizations.of(context).text("VITAL_SIGNS"),
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .normal,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, "/immunizationlist"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              color: AppData.kPrimaryRedColor,
                                              padding: EdgeInsets.all(3),
                                              child: Image.asset(
                                                "assets/images/Immunizationimg.png",
                                                height: 40,
                                              )),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("IMMUNIZATION"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, "/allergicListList"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              color: AppData.kPrimaryBlueColor,
                                              padding: EdgeInsets.all(3),
                                              child: Image.asset(
                                                "assets/images/Allergicimg.png",
                                                height: 40,
                                              )),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("ALLERGIC"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, "/biomedicalimplants"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              color: AppData.kPrimaryRedColor,
                                              padding: EdgeInsets.all(3),
                                              child: Image.asset(
                                                "assets/images/Biomedicalimg.png",
                                                height: 40,
                                              )),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("BIOMEDICAL"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                Navigator.pushNamed(context, "/healthchart"),
                              //Navigator.pushNamed(context, "/healthChaatlist"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              color: AppData.kPrimaryBlueColor,
                                              padding: EdgeInsets.all(3),
                                              child: Image.asset(
                                                "assets/images/userhealth.png",
                                                height: 40,
                                              )),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("HEALTH_CHART"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                /*AppData.launchURL(
                                "http://docs.google.com/gview?embedded=true&url=https://ehealthsystem.com/user/view-patient-test-report-pdf-download?id=" +
                                    "");*/
                                Navigator.pushNamed(
                                    context, "/testReportListUser1");
                              },
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 5,
                                    child: Container(
                                        height: tileSize,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.grey[300],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                8)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                color: AppData.kPrimaryRedColor,
                                                padding: EdgeInsets.all(3),
                                                child: Image.asset(
                                                  "assets/images/usertest.png",
                                                  height: 40,
                                                ),
                                              ),
                                              SizedBox(
                                                width: spaceTab,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(MyLocalizations.of(context).text("TEST_REPORT"),
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.normal,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Image.asset(
                                                "assets/Forwordarrow.png",
                                                height: 25,
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                  (loginResponse1.body?.userStateId != null&&loginResponse1.body.userStateId == "21" )?
                                  Positioned(right: 5,top: 5,
                                      child: Image.asset("assets/images/premium1.png",width: 35,)):Container(),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //String userrole="1";
                                widget.model.uploadbyrole="1";
                                widget.model.patientseHealthCard=widget.model.loginResponse1.body.user;
                                Navigator.pushNamed(context, "/uploaddocument");
                                /*AppData.launchURL(
                                "http://docs.google.com/gview?embedded=true&url=https://ehealthsystem.com/user/view-patient-test-report-pdf-download?id=" +
                                    "");*/
                               /* Navigator.pushNamed(
                                    context, "/testReportListUser1");*/
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: AppData.kPrimaryBlueColor,
                                            padding: EdgeInsets.all(3),
                                            child: Image.asset(
                                              "assets/images/up-arrow.png",
                                              height: 40,
                                            ),
                                          ),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("UPLOAD_DOCUMENT"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                /*AppData.launchURL(
                                "http://docs.google.com/gview?embedded=true&url=https://ehealthsystem.com/user/view-patient-test-report-pdf-download?id=" +
                                    "");*/
                                 Navigator.pushNamed(
                                    context, "/lifeStyleHistory");
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: AppData.kPrimaryRedColor,
                                            padding: EdgeInsets.all(3),
                                            child: Image.asset(
                                              "assets/lifestyle.png",
                                              height: 40,
                                            ),
                                          ),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(MyLocalizations.of(context).text("LIFESTYLE_HISTORY"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                           /*  GestureDetector(
                              //onTap: () =>   Navigator.pushNamed(context, "/medicalService"),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: tileSize,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              color: Colors.blue,
                                              padding: EdgeInsets.all(3),
                                              child: Image.asset(
                                                "assets/images/Insuranceimg.png",
                                                height: 40,
                                              )),
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Insurance',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Forwordarrow.png",
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),*/
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
}
