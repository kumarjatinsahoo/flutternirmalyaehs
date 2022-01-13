import 'package:user/localization/localizations.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class AYUSHDoctors extends StatefulWidget {
  MainModel model;

  AYUSHDoctors({Key key, this.model}) : super(key: key);

  @override
  _AYUSHDoctorsState createState() => _AYUSHDoctorsState();
}

class _AYUSHDoctorsState extends State<AYUSHDoctors> {
  var selectedMinValue;
  double tileSize = 80;
  double spaceTab = 20;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(MyLocalizations.of(context).text("AYUSH_DOCTOR"),
            style: TextStyle(color: AppData.white),
          ),
          centerTitle: true,
          backgroundColor:AppData.kPrimaryColor,
      ),

      body: Column(
        children: [
          Container(
            child: Expanded(
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
                            InkWell(
                              onTap: () {
                                widget.model.medicallserviceType = MyLocalizations.of(context).text("AYURVEDA");
                                Navigator.pushNamed(
                                    context, "/medicalsServiceOngooglePage");

                                // AppData.showInSnackBar(context,"hi");
                              },

                              /*widget.model.apntUserType = "ayurvada";
                                                 Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(color: AppData.kPrimaryRedColor,
                                            padding: EdgeInsets.all(3),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                  "assets/ayurveda.png",
                                                  ),
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
                                                Text(MyLocalizations.of(context).text("AYURVEDA"),
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
                                            height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                widget.model.medicallserviceType = MyLocalizations.of(context).text("HOMEOPATHY");
                                Navigator.pushNamed(
                                    context, "/medicalsServiceOngooglePage");
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
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(color: AppData.kPrimaryBlueColor,
                                            padding: EdgeInsets.all(3),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/homeopathy.png",
                                              ),
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
                                                Text(MyLocalizations.of(context).text("HOMEOPATHY"),
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
                                            height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                widget.model.medicallserviceType = MyLocalizations.of(context).text("SIDDHA_TREATMENT");
                                Navigator.pushNamed(
                                    context, "/medicalsServiceOngooglePage");
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
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(color: AppData.kPrimaryRedColor,
                                            padding: EdgeInsets.all(3),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/diagnostic.png",
                                              ),
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
                                                Text(MyLocalizations.of(context).text("SIDDHA_TREATMENT"),
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
                                            height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.model.medicallserviceType = MyLocalizations.of(context).text("UNANI");
                                Navigator.pushNamed(
                                    context, "/medicalsServiceOngooglePage");
                              },
                              //onTap: () =>   Navigator.pushNamed(context, "/setdiscount"),
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
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(color: AppData.kPrimaryBlueColor,
                                            padding: EdgeInsets.all(3),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/repatriation.png",
                                              ),
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
                                                  MyLocalizations.of(context).text("UNANI"),
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
                                            height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  widget.model.medicallserviceType =
                                      MyLocalizations.of(context).text("YOGA_NATUROPATHY");
                                  Navigator.pushNamed(
                                      context, "/medicalsServiceOngooglePage");
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
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(color: AppData.kPrimaryRedColor,
                                              padding: EdgeInsets.all(3),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  "assets/yoga.png",
                                                ),
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
                                                    MyLocalizations.of(context).text("YOGA_NATUROPATHY"),
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
                                              height: 25,)
                                          ],
                                        ),
                                      )),
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
            ),
          ),
        ],
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
