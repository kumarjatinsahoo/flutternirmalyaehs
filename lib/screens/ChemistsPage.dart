import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class ChemistsPage extends StatefulWidget {
  MainModel model;

  ChemistsPage({Key key, this.model}) : super(key: key);

  @override
  _ChemistsPageState createState() => _ChemistsPageState();
}

class _ChemistsPageState extends State<ChemistsPage> {
  var selectedMinValue;

  @override
  Widget build(BuildContext context) {
    double tileSize = 100;
    double spaceTab = 20;
    double edgeInsets = 3;

    return SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Container(
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
                          'Chemists ',
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
                ),
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
                                  // onTap: () =>   Navigator.pushNamed(context, "/vitalSigns"),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 5,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5))),
                                      child: Container(
                                          height: tileSize,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              border: Border(left: BorderSide(color: AppData.kPrimaryRedColor, width: 5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/medicine_reminder.png",
                                                  height: 40,
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
                                                        'Frank Ross Pharmacy - Wipro Campus  ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "Wipro building,Salt Lake Bypass,DM Block\n"
                                                                "Sector V,Kolkata,West Bengal 700091,India ",
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                // Image.asset("assets/Forwordarrow.png",height: 25,)
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  // onTap: () =>   Navigator.pushNamed(context, "/immunizationlist"),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 5,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5))),
                                      child: Container(
                                          height: tileSize,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              border: Border(left: BorderSide(color: AppData.kPrimaryColor, width: 5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/medicine_reminder.png",
                                                  height: 40,
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
                                                        'Apollo Pharmacy',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "No 43,CF Block,Sector III,Bidhannagar\n"
                                                            "Kolkata,West Bengal 700091,India",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                //Image.asset("assets/Forwordarrow.png",height: 25,)
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  // onTap: () =>   Navigator.pushNamed(context, "/findScreen"),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 5,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5))),
                                      child: Container(
                                          height: tileSize,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: AppData.kPrimaryRedColor,
                                                      width: 5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/medicine_reminder.png",
                                                  height: 40,
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
                                                        'MedPlus',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "N.225,Nayapali,IRC Village,Bhubaneswar,753003,India",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                // Image.asset("assets/Forwordarrow.png",height: 25,)
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  // onTap: () =>   Navigator.pushNamed(context, "/medicalService"),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 5,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5))),
                                      child: Container(
                                          height: tileSize,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: AppData.kPrimaryColor,
                                                      width: 5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/medicine_reminder.png",
                                                  height: 40,
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
                                                        'Apollo Pharmacy',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "N.225,Nayapali,IRC Village,Bhubaneswar,753003,India",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                //Image.asset("assets/Forwordarrow.png",height: 25,)
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  // onTap: () =>   Navigator.pushNamed(context, "/medicalService"),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 5,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5))),
                                      child: Container(
                                          height: tileSize,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: AppData.kPrimaryRedColor,
                                                      width: 5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/medicine_reminder.png",
                                                  height: 40,
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
                                                        'Frank Ross Pharmacy - Wipro Campus ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                          "No 43,CF Block,Sector III,Bidhannagar\n"
                                                          "Kolkata,West Bengal 700091,India",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                //Image.asset("assets/Forwordarrow.png",height: 25,)
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  // onTap: () =>   Navigator.pushNamed(context, "/medicalService"),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 5,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5))),
                                      child: Container(
                                          height: tileSize,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: AppData.kPrimaryColor,
                                                      width: 5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/medicine_reminder.png",
                                                  height: 40,
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
                                                        'MedPlus',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "N.225,Nayapali,IRC Village,Bhubaneswar,753003,India",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                //   Image.asset("assets/Forwordarrow.png",height: 25,)
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  // onTap: () =>   Navigator.pushNamed(context, "/medicalService"),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 5,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5))),
                                      child: Container(
                                          height: tileSize,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color: AppData.kPrimaryRedColor,
                                                      width: 5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/medicine_reminder.png",
                                                  height: 40,
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
                                                        'Apollo Pharmacy',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "N.225,Nayapali,IRC Village,Bhubaneswar,753003,India",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ), //Image.asset("assets/Forwordarrow.png",height: 25,)
                                              ],
                                            ),
                                          )),
                                    ),
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

