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


  @override
  Widget build(BuildContext context) {
    double tileSize = 80;
    double spaceTab = 20;
    double edgeInsets = 3;

    return SafeArea(
        child: Scaffold(

          appBar: AppBar(
            backgroundColor: AppData.kPrimaryColor,
            title: Text('Medical Records'),
            /* leading: Icon(
            Icons.menu,
          ),*/
            actions: <Widget>[
              /*  Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )
              ),*/
              /*Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                      Icons.more_vert
                  ),
                )
            ),*/
            ],
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

                                      Navigator.pushNamed(
                                          context, "/vitalSigns"),
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
                                                  color: Colors.red,
                                                  padding: EdgeInsets.all(3),
                                                  child: Image.asset(
                                                    "assets/images/Vitalsigns.png",
                                                    height: 40,
                                                  )),
                                              SizedBox(
                                                width: spaceTab,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Vital Signs',
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
                                  onTap: () =>
                                      Navigator.pushNamed(
                                          context, "/immunizationlist"),
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
                                                    Text(
                                                      'Immunization',
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
                                                  color: Colors.red,
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
                                                    Text(
                                                      'Allergic',
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
                                                  color: Colors.blue,
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
                                                    Text(
                                                      'Biomedical Implant',
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
                                  // onTap: () =>   Navigator.pushNamed(context, "/medicalService"),
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
                                                  color: Colors.red,
                                                  padding: EdgeInsets.all(3),
                                                  child: Image.asset(
                                                    "assets/images/Healthchartimg.png",
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
                                                      'Health Chart',
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
                                                color: Colors.red,
                                                padding: EdgeInsets.all(3),
                                                child: Image.asset(
                                                  "assets/images/Healthchartimg.png",
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
                                                    Text(
                                                      'Test Report',
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
                                ),
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
        ));
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
