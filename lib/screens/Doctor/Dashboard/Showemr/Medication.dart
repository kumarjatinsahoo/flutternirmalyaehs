import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';
import 'package:user/models/MadicationlistModel.dart' as apnt;

class Medication extends StatefulWidget {
  MainModel model;

  Medication({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Medication();
}

class _Medication extends State<Medication> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  apnt.MadicationlistModel madicationlistModel = apnt.MadicationlistModel();
  bool isDataNotAvail = false;
  String eHealthCardno;
  bool isdata = false;

  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
    eHealthCardno = widget.model.patientseHealthCard;
    callMadicationAPI(eHealthCardno);
  }

  callMadicationAPI(String eHealthCardno) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.MEDICATION_DOCTER + eHealthCardno,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              madicationlistModel = apnt.MadicationlistModel.fromJson(map);
            } else {
              isDataNotAvail = true;
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),

      body: madicationlistModel != null
          ? SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(children: [
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            "CURRENT MEDICINES",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: (madicationlistModel != null &&
                                  madicationlistModel.body != null &&
                                  madicationlistModel.body.isNotEmpty)
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),

                                  shrinkWrap: true,
                                  // scrollDirection: Axis.horizontal,
                                  /* itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {*/
                                  itemBuilder: (context, i) {
                                    apnt.Body medition =
                                        madicationlistModel.body[i];
                                    return Card(
                                      color: Color(0xFFD2E4FC),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                          ),
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFFD2E4FC))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Doctor",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  /*"Paracetmol"*/
                                                  medition.doctor,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Med. name",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  /*"Tablet"*/
                                                  medition.medname,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Dosage",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    /*"5 Days From 12-08-2021"*/
                                                    medition.dosage,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Morning",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  /*"1"*/
                                                  medition.morning,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Afternoon",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  medition.afternoon,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Evening",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Text(
                                                  "   :   ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  /*"1"*/
                                                  medition.evening,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            /* SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  "Doctor",
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
                                "Mr.Neraj Desai",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),*/
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: madicationlistModel.body.length,
                                )
                              : Container(),
                        ),
                      ]),
                    ),
                  ),
                ): isDataNotAvail
          ? Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height:
                MediaQuery.of(context).size.height * 0.35,
              ),
              //CircularProgressIndicator()
              Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
            ],
          ),
        ),
      ):Center(
        child: Column(
          children: [
            SizedBox(
              height:
              MediaQuery.of(context).size.height * 0.35,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
