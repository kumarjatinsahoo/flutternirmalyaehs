import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class EmergencyDetails extends StatefulWidget {
  final MainModel model;

  const EmergencyDetails({Key key, this.model}) : super(key: key);

  @override
  _EmergencyDetailsState createState() => _EmergencyDetailsState();
}

class _EmergencyDetailsState extends State<EmergencyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppData.black1,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(
                  Icons.warning_amber_outlined,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "EMERGENCY",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Kind attention ! Mr. Swapnil Nevale, 9011118424.\n Met with an Medical Emergency. ",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Automatic call will be initiated within 60 second",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Name :",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 130),
                      child: Text(
                        "Swapnil ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Mobile No :",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Text(
                        " 9011118424",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Gender :",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 145),
                      child: Text(
                        "Male ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Blood Group :",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 143),
                      child: Text(
                        "A+ve ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "UHID No :",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: Text(
                        "111122223333",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Location :",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 120),
                      child: Text(
                        "location ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Emergency Contacts :",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              "Type",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 100),
                        Text(
                          "Name",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 70),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "Mobile No.",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Family Doctor",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                        Text(
                          "Dr.Sagar",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(width: 60),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "9100200300",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Family Friend",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                        Text(
                          "Mr.Sagar",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(width: 60),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "9100200300",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Wife/Mother",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 45),
                        Text(
                          "Demo11",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(width: 60),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "9100200300",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
