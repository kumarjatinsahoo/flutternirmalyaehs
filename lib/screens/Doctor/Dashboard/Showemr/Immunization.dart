import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';

class Immunization extends StatefulWidget {
  MainModel model;

  Immunization({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Immunization();
}

class _Immunization extends State<Immunization> {
  FocusNode _descriptionFocus, _focusNode;

  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
      body:
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
      ),
    );
  }
}
