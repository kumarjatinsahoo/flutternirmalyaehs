import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class BiomediImplants extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const BiomediImplants({Key key, this.model}) : super(key: key);

  @override
  _BiomediImplantsState createState() => _BiomediImplantsState();
}

class _BiomediImplantsState extends State<BiomediImplants> {
  LoginResponse1 loginResponse1;
  bio.BiomedicalModel biomedicalModel;
  bool isDataNotAvail = false;


  TextEditingController _date = TextEditingController();
  TextEditingController _reason = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.BIOMEDICAL_IMPLANTS  +
            loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              biomedicalModel = bio.BiomedicalModel.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Biomedical Implants"),
              Spacer(),
              InkWell(
                  onTap: () {
                    _displayTextInputDialog(context);
                  },
                  child: Icon(Icons.add_circle_outline)),
            ],
          ),
        ),
        body: Container(
          alignment: (biomedicalModel != null)
              ? Alignment.topCenter
              : Alignment.center,
          child: (biomedicalModel != null)
              ? ListView.builder(
                  itemCount: biomedicalModel.body.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    bio.Body body = biomedicalModel.body[i];
                    return Card(
                      child: Column(
                        children: [
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
                          //   child: Row(
                          //     children: [
                          //       Spacer(),
                          //      Icon(Icons.edit),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 20, right: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 65),
                                Text(
                                  body.bioMName,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 20, right: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 75),
                                Text(
                                  body.bioMDate,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 20, right: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Reason",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 50),
                                Text(
                                  body.bioMReason,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         "Updated By",
                          //         style:
                          //             TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          //       ),
                          //       SizedBox(width: 35),
                          //       Text(
                          //         "Dr.Sourav Kumar",
                          //         style: TextStyle(fontSize: 16),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(),
        ));
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.symmetric(horizontal: 3),
            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Add Details",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // TextField(
                      //   onChanged: (value) {
                      //     setState(() {
                      //       // valueText = value;
                      //     });
                      //   },
                      //   //controller: _fname,
                      //   inputFormatters: [
                      //     WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                      //   ],
                      //   decoration: InputDecoration(hintText: " Name"),
                      // ),
                      DropDown.networkDropdown(
                          "Name", ApiFactory.ADM_EQUIPMENT_API, "bloodgroup",
                          (KeyvalueModel model) {
                        setState(() {
                          // patientProfileModel.body.bloodGroup= model.key;
                          // patientProfileModel.body.bloodGroup = model.name;
                          BiomediImplants.admequipmentmodel = model;
                          // updateProfileModel.bloodGroup = model.key;
                        });
                      }),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            // valueText = value;
                            // updateProfileModel.lName = value;
                          });
                        },
                        // controller: _lname,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(
                              RegExp("[0-9a-zA-Z-/]")),
                        ],
                        decoration: InputDecoration(hintText: "Date"),
                      ),

                      // dob(),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            // valueText = value;
                            // updateProfileModel.fName = value;
                          });
                        },
                        // controller: _fDoctor,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        decoration: InputDecoration(hintText: "Reason"),
                      ),
                      // TextField(
                      //   onChanged: (value) {
                      //     setState(() {
                      //       // valueText = value;
                      //       // updateProfileModel.fName = value;
                      //     });
                      //   },
                      //   // controller: _fDoctor,
                      //   inputFormatters: [
                      //     WhitelistingTextInputFormatter(RegExp("[a-zA-Z. ]")),
                      //   ],
                      //   decoration: InputDecoration(hintText: "Updated by"),
                      // ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text('CANCEL',
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  'SUBMIT',
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  // setState(() {
                  //   updateProfileModel.fName = _fname.text;
                  //   updateProfileModel.lName = _lname.text;
                  //   updateProfileModel.eCardNo = patientProfileModel.body.id;
                  //   updateProfileModel.fDoctor = _fDoctor.text;
                  //   updateProfileModel.fDoctor = _fDoctor.text;
                  //
                  //   updateProfileModel.id = patientProfileModel.body.id;
                  //   widget.model.POSTMETHOD_TOKEN(
                  //       api: ApiFactory.USER_UPDATEPROFILE,
                  //       json: updateProfileModel.toJson(),
                  //       token: widget.model.token,
                  //       fun: (Map<String, dynamic> map) {
                  //         Navigator.pop(context);
                  //         if (map[Const.STATUS] == Const.SUCCESS) {
                  //           // popup(context, map[Const.MESSAGE]);
                  //           callApi();
                  //           AppData.showInSnackDone(
                  //               context, map[Const.MESSAGE]);
                  //         } else {
                  //           // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  //         }
                  //       });
                  //   // }
                  // }
                },
              ),
            ],
          );
        });
  }
}
