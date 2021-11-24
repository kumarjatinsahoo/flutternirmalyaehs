import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/FamilyDetailsModel.dart'as family;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class FamilyDetails extends StatefulWidget {
  MainModel model;

  FamilyDetails({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FamilyDetails();
}

class _FamilyDetails extends State<FamilyDetails> {
  FocusNode _descriptionFocus, _focusNode;
  family.FamilyDetailsModel familyDetailsModel;
  String eHealthCardno;
  bool isdata = false;
  @override
  void initState() {
    super.initState( );
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
    eHealthCardno = widget.model.patientseHealthCard;
    callApi(eHealthCardno);
  }
  callApi(String eHealthCardno) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.FAMILY_DOCTER + eHealthCardno,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              familyDetailsModel =family.FamilyDetailsModel.fromJson(map);
            } else {
              //AppData.showInSnackBar(context, msg);
            }
          });
        });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
          body:
          isdata == true
              ? Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                CircularProgressIndicator(),
              ],
            ),
          )
          /* Center(
                child: CircularProgressIndicator(),
              )*/
              : familyDetailsModel == null || familyDetailsModel == null
              ? Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  Text(
                    "Data Not Found",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          )
              :
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(children: [
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      "FAMILY DETAILS",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Expanded(
                      child:(familyDetailsModel != null)
                          ? ListView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        /* itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {*/
                        itemBuilder: (context, i) {
                          family.Body familydetails = familyDetailsModel.body[i];
                          return Card(
                            color: Color(0xFFD2E4FC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                side: BorderSide(width: 1, color: Color(0xFFD2E4FC))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Name",
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        "   :   ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      Text(
                                        familydetails.memeberName,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Relation",
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        "   :   ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      Text(
                                      familydetails.relation,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Age",
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        "   :   ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      Text(
                                        familydetails.age,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: familyDetailsModel.body.length,
                      ) : Container(),
                    ),
                  ),
                ]),
              ),
            ),
          ),
    );
  }
}
