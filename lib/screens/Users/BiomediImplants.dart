import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

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
  String valueText = null;

  TextEditingController _date = TextEditingController();
  TextEditingController _reason = TextEditingController();

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  AddBioMedicalModel addBioMedicalModel = AddBioMedicalModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.BIOMEDICAL_IMPLANTS + loginResponse1.body.user,
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
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(5.0),
                      // ),
                      // shadowColor: Colors.grey,
                      // elevation: 10,
                      child: Column(
                        children: [
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
                                  body?.bioMName ?? "N/A",
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
                                  body?.bioMDate ?? "N/A",
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
                                  body?.bioMReason ?? "N/A",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
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
    // _date.text = biomedicalModel.body.bioMDate;
    // _reason.text = biomedicalModel.body.bioMReason;
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
                      DropDown.networkDropdownGet(
                          "Name", ApiFactory.ADM_EQUIPMENT_API, "admequipment",
                          (KeyvalueModel model) {
                        setState(() {
                          // patientProfileModel.body.bloodGroup= model.key;
                          //   biomedicalModel.body.bioMName = model.name;
                          //  BiomediImplants.admequipmentmodel = model;
                          // addBioMedicalModel.bioMName = model.key;
                          print(ApiFactory.ADM_EQUIPMENT_API);
                          BiomediImplants.admequipmentmodel = model;
                        });
                      }),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            addBioMedicalModel.bioMDate = value;
                          });
                        },
                        controller: _date,
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
                            valueText = value;
                            addBioMedicalModel.bioMReason = value;
                          });
                        },
                        controller: _reason,
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
                  if (BiomediImplants.admequipmentmodel == null ||
                      BiomediImplants.admequipmentmodel == "") {
                    AppData.showInSnackBar(context, "Please select Name ");
                  } else if (_date.text == "" || _date.text == null) {
                    AppData.showInSnackBar(context, "Please enter date");
                  } else if (_reason.text == "" || _reason.text == null) {
                    AppData.showInSnackBar(context, "Please enter reason");
                  } else {
                    MyWidgets.showLoading(context);
                    AddBioMedicalModel biomedicalModel = AddBioMedicalModel();
                    biomedicalModel.userid = loginResponse1.body.user;
                    biomedicalModel.bioMName =
                        BiomediImplants.admequipmentmodel.key;
                    biomedicalModel.bioMDate = _date.text;
                    biomedicalModel.bioMReason = _reason.text;
                    addBioMedicalModel.bioMDate = _date.text;
                    addBioMedicalModel.bioMReason = _reason.text;

                    widget.model.POSTMETHOD2(
                      api: ApiFactory.ADD_BIOMEDICAL_IMPLANTS,
                      json: biomedicalModel.toJson(),
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        Navigator.pop(context);
                        setState(() {
                          if (map[Const.STATUS] == Const.SUCCESS) {
                            Navigator.pop(context);
                          } else {
                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
                      },
                    );
                  }
                },
              ),
            ],
          );
        });
  }
}
