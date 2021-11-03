import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class RIPScreen extends StatefulWidget {
  MainModel model;

  RIPScreen({Key key, this.model}) : super(key: key);

  @override
  _RIPScreenState createState() => _RIPScreenState();
}

class _RIPScreenState extends State<RIPScreen> {
  var selectedMinValue;
  double tileSize = 80;
  double spaceTab = 20;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RIP',
          style: TextStyle(color: AppData.white),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            ListView(
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
                            onTap: () {
                              widget.model.medicallserviceType =
                                  "Book a Hearse Van";
                              Navigator.pushNamed(
                                  context, "/medicalsServiceOngooglePage");

                              // AppData.showInSnackBar(context,"hi");
                            },
                            /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                              "assets/hearse.png",),
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
                                                'Book a Hearse Van',
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
                                  "Book a Mortuary Freezer";
                              Navigator.pushNamed(
                                  context, "/medicalsServiceOngooglePage");

                              // AppData.showInSnackBar(context,"hi");
                            },
                            /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                              "assets/morgue.png",),
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
                                                'Book a Mortuary Freezer',
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
                                  "Book a Priest";
                              Navigator.pushNamed(
                                  context, "/medicalsServiceOngooglePage");

                              // AppData.showInSnackBar(context,"hi");
                            },
                            /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                              "assets/priest.png",),
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
                                                'Book a Priest',
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
                                  "Book a Repatriation";
                              Navigator.pushNamed(
                                  context, "/medicalsServiceOngooglePage");

                              // AppData.showInSnackBar(context,"hi");
                            },
                            /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                              "assets/repatriation.png",),
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
                                                'Book a Repatriation',
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
                                  "Book a Funeral Hall ";
                              Navigator.pushNamed(
                                  context, "/medicalsServiceOngooglePage");

                              // AppData.showInSnackBar(context,"hi");
                            },
                            /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                              "assets/funeral-hall.png",),
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
                                                'Book a Funeral Hall',
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
                                  "Dispersal of Ashes & Ums";
                              Navigator.pushNamed(
                                  context, "/medicalsServiceOngooglePage");

                              // AppData.showInSnackBar(context,"hi");
                            },
                            /* onTap: () =>   Navigator.pushNamed(context, "/bookanAppointmentlist"),*/
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
                                              "assets/dispersion-of-nanotubes.png",),
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
                                                'Dispersal of Ashes & Ums',
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
