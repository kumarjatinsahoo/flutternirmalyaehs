import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';

class FamilyDetails extends StatefulWidget {
  MainModel model;

  FamilyDetails({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FamilyDetails();
}

class _FamilyDetails extends State<FamilyDetails> {
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
      ),
    );
  }
}
