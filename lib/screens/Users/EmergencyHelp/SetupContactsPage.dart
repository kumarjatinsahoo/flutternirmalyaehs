import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/EmergencyHelpModel.dart';
import 'package:user/models/EmergencyMessageModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/UpdateEmergencyModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import '../../Doctor/Dashboard/DasboardDoctor.dart';

class SetupContactsPage extends StatefulWidget {
  MainModel model;

  static KeyvalueModel relationmodel = null;
  static KeyvalueModel relationmodel1 = null;

  SetupContactsPage({Key key, this.model}) : super(key: key);

  @override
  _SetupContactsPageState createState() => _SetupContactsPageState();
}

class _SetupContactsPageState extends State<SetupContactsPage> {
  var selectedMinValue;
  String valueText = null;
  String emger_ms;
  EmergencyHelpModel emergencyHelpModel;
  bool isDataNotAvail = false;

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  TextEditingController _fname = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _relation = TextEditingController();
  TextEditingController _message = TextEditingController();

  LoginResponse1 loginResponse1;
  String value1;
  String value2;
  String value3;
  String value4;
  String value5;

  List<Contact> contacts;

  UpdateEmergencyModel updateEmergencyModel = UpdateEmergencyModel();
  EmergencyMessageModel emergencyMessageModel = EmergencyMessageModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI();
    // SetupContactsPage.relationmodel=null;
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.EMERGENCY_HELP + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          log("Response>>>" + jsonEncode(map));
          String msg = map[Const.MESSAGE];
          emger_ms = map["emer_msg"];
          if (map[Const.STATUS1] == Const.SUCCESS) {
            setState(() {
              print("VAHUUU>>>" + JsonEncoder().convert(map));
              emergencyHelpModel = EmergencyHelpModel.fromJson(map);
              for (int i = 0; i < emergencyHelpModel.emergency.length; i++) {
                switch (i) {
                  case 0:
                    value1 = emergencyHelpModel?.emergency[0]?.name ?? null;
                    break;
                  case 1:
                    value2 = emergencyHelpModel?.emergency[1]?.name ?? null;
                    break;
                  case 2:
                    value3 = emergencyHelpModel?.emergency[2]?.name ?? null;
                    break;
                  case 3:
                    value4 = emergencyHelpModel?.emergency[3]?.name ?? null;
                    break;
                  case 4:
                    value5 = emergencyHelpModel?.emergency[4]?.name ?? null;
                    break;
                }
              }
              //value5=emergencyHelpModel?.emergency[4]?.name??null;
            });
          } else {
            isDataNotAvail = true;
            AppData.showInSnackBar(context, msg);
          }

          // });
        });
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = 100;
    double spaceTab = 20;
    double edgeInsets = 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        //backgroundColor: AppData.kPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(MyLocalizations.of(context).text("SETUP_CONTACT")),
      ),
      body: Container(
        child: Padding(
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
                                borderRadius:
                                    BorderRadius.circular(5))),
                        child: InkWell(
                          onTap: () {
                            (value1 != null)
                                ? _displayTextInputDialog1(
                                    context, emergencyHelpModel, 0)
                                : _displayTextInputDialog(
                                    context, emergencyHelpModel);
                          },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color:
                                            AppData.kPrimaryRedColor,
                                        width: 5))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(3),
                                      child: Image.asset(
                                        "assets/Add.png",
                                        height: 30,
                                        color: Colors.red,
                                      )),
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
                                          (value1 != null)
                                              ? value1
                                              : MyLocalizations.of(
                                                      context)
                                                  .text(
                                                      "ADD_EMERGENCY_CONTACT"),
                                          style: TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Image.asset("assets/Forwordarrow.png",height: 25,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
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
                                borderRadius:
                                    BorderRadius.circular(5))),
                        child: InkWell(
                          onTap: () {
                            (value2 != null)
                                ? _displayTextInputDialog1(
                                    context, emergencyHelpModel, 1)
                                : _displayTextInputDialog(
                                    context, emergencyHelpModel);
                          },
                          child: Container(
                              height: 60,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color:
                                              AppData.kPrimaryColor,
                                          width: 5))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        //color: Colors.red,
                                        padding: EdgeInsets.all(3),
                                        child: Image.asset(
                                          "assets/Add.png",
                                          height: 30,
                                          color: Colors.blue,
                                        )),
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
                                            (value2 != null)
                                                ? value2
                                                : MyLocalizations.of(
                                                        context)
                                                    .text(
                                                        "ADD_EMERGENCY_CONTACT"),
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 15),
                                          ),
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
                  ),
                  SizedBox(
                    height: 8,
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
                                borderRadius:
                                    BorderRadius.circular(5))),
                        child: InkWell(
                          onTap: () {
                            /* _displayTextInputDialog1(
                            context, emergencyHelpModel, 2);*/
                            (value3 != null)
                                ? _displayTextInputDialog1(
                                    context, emergencyHelpModel, 2)
                                : _displayTextInputDialog(
                                    context, emergencyHelpModel);
                          },
                          child: Container(
                              height: 60,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: AppData
                                              .kPrimaryRedColor,
                                          width: 5))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(3),
                                        child: Image.asset(
                                          "assets/Add.png",
                                          height: 30,
                                          color: Colors.red,
                                        )),
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
                                            (value3 != null)
                                                ? value3
                                                : MyLocalizations.of(
                                                        context)
                                                    .text(
                                                        "ADD_EMERGENCY_CONTACT"),
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 15),
                                          ),
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
                  ),
                  SizedBox(
                    height: 8,
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
                                borderRadius:
                                    BorderRadius.circular(5))),
                        child: InkWell(
                          onTap: () {
                            (value4 != null)
                                ? _displayTextInputDialog1(
                                    context, emergencyHelpModel, 3)
                                : _displayTextInputDialog(
                                    context, emergencyHelpModel);
                          },
                          child: Container(
                              height: 60,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color:
                                              AppData.kPrimaryColor,
                                          width: 5))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(3),
                                        child: Image.asset(
                                          "assets/Add.png",
                                          height: 30,
                                          color: Colors.blue,
                                        )),
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
                                            (value4 != null)
                                                ? value4
                                                : MyLocalizations.of(
                                                        context)
                                                    .text(
                                                        "ADD_EMERGENCY_CONTACT"),
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 15),
                                          ),
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
                  ),
                  SizedBox(
                    height: 8,
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
                                borderRadius:
                                    BorderRadius.circular(5))),
                        child: InkWell(
                          onTap: () {
                            if (value5 != null)
                              _displayTextInputDialog1(
                                  context, emergencyHelpModel, 4);
                            else
                              _displayTextInputDialog(
                                  context, emergencyHelpModel);
                          },
                          child: Container(
                              height: 60,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: AppData
                                              .kPrimaryRedColor,
                                          width: 5))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(3),
                                        child: Image.asset(
                                          "assets/Add.png",
                                          height: 30,
                                          color: Colors.red,
                                        )),
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
                                            (value5 != null)
                                                ? value5
                                                : MyLocalizations.of(
                                                        context)
                                                    .text(
                                                        "ADD_EMERGENCY_CONTACT"),
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 15),
                                          ),
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
                  ),
                  // Expanded(
                  //   child: SizedBox(
                  //     height: 15,
                  //   ),
                  // ),
                 
                  // GestureDetector(
                  //   // onTap: () =>   Navigator.pushNamed(context, "/medicalService"),
                  //   child: InkWell(
                  //     onTap: () {
                  //       // (emergencyHelpModel != null)
                  //       //     ? _displayTextInputDialog1(
                  //       //     context, emergencyHelpModel, 5)
                  //       //     : _displayTextInputDialog2(
                  //       //     context, emergencyHelpModel);
                  //       // _displayTextInputDialog2(context);
                  //     },
                  //     child: Card(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(5.0),
                  //       ),
                  //       elevation: 5,
                  //       child: ClipPath(
                  //         clipper: ShapeBorderClipper(
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius:
                  //                     BorderRadius.circular(5))),
                  //         child: Container(
                  //             height: tileSize,
                  //             width: double.maxFinite,
                  //             decoration: BoxDecoration(
                  //                 border: Border(
                  //                     left: BorderSide(
                  //                         color:
                  //                             AppData.kPrimaryColor,
                  //                         width: 5))),
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(10.0),
                  //               child: Row(
                  //                 crossAxisAlignment:
                  //                     CrossAxisAlignment.center,
                  //                 children: [
                  //                   SizedBox(
                  //                     width: spaceTab,
                  //                   ),
                  //                   // Expanded(
                  //                   //   child: Column(
                  //                   //     crossAxisAlignment:
                  //                   //         CrossAxisAlignment.center,
                  //                   //     mainAxisAlignment:
                  //                   //         MainAxisAlignment.center,
                  //                   //     children: [
                  //                   //       Text(
                  //                   //         // (emergencyHelpModel != null)
                  //                   //         emger_ms ??
                  //                   //             "Emergency Alert ! \n I need help.",
                  //                   //         textAlign:
                  //                   //             TextAlign.center,
                  //                   //         style: TextStyle(
                  //                   //             fontWeight:
                  //                   //                 FontWeight.bold,
                  //                   //             fontSize: 18,
                  //                   //             color: Colors.blue),
                  //                   //       ),
                  //                   //     ],
                  //                   //   ),
                  //                   // ),
                  //                   //   Image.asset("assets/Forwordarrow.png",height: 25,)
                  //                 ],
                  //               ),
                  //             )),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // SizedBox(
              //   height: 22,
              // ),
          Expanded(child: Container()),
               Expanded(
                 child: Container(
                      child: Text(
                      "Hey "+ " \" ${loginResponse1?.body?.userName??"N/A"} \"  " +
                         "please add emergency contact !",
                                                textAlign:
                                                    TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17,
                                                    ),
                                              ),
                    ),
               ),
            ],
          ),
        ),
      ),
    );
  }

  _displayTextInputDialog1(
      BuildContext context, emergencyHelpModel, int index) async {
    _fname.text = emergencyHelpModel.emergency[index].name;
    _mobile.text = emergencyHelpModel.emergency[index].mobile;
    SetupContactsPage.relationmodel = KeyvalueModel(
        key: emergencyHelpModel.emergency[index].relId,
        name: emergencyHelpModel.emergency[index].type);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 3),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Update Emergency Contact",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            updateEmergencyModel.name = value;
                            //emergencyHelpModel.
                          });
                        },
                        controller: _fname,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        decoration: InputDecoration(hintText: "Name"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            //emergencyHelpModel. = value;
                            updateEmergencyModel.mobile = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: _mobile,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[0-9]")),
                        ],
                        maxLength: 10,
                        decoration: InputDecoration(
                            hintText: "Emergency Contact No.", counterText: ""),
                      ),
                      DropDown.networkDropdown(
                          "Relation", ApiFactory.RELATION_API, "relation1",
                          (KeyvalueModel model) {
                        setState(() {
                          // emergencyHelpModel.body.eRelation= model.name;
                          SetupContactsPage.relationmodel = model;
                          updateEmergencyModel.relation = model.key;

                          emergencyHelpModel.emergency[index].relId = model.key;
                          emergencyHelpModel.emergency[index].type = model.name;
                        });
                      }),
                      Divider(height: 2, color: Colors.black),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                /* child: Text('CANCEL',
                    style: TextStyle(color: AppData.kPrimaryRedColor)),*/
                child: Text(MyLocalizations.of(context).text("CANCEL"),
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
                  'Update',
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {
                    if (_fname.text == null || _fname.text == "") {
                      AppData.showInSnackBar(context, "Please enter name");
                    } else if (_fname.text != "" && _fname.text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter a valid name");
                    } else if (_mobile.text == "" || _mobile.text == null) {
                      AppData.showInSnackBar(
                          context, "Please enter emergency contact no.");
                    } else if (_mobile.text != "" &&
                        _mobile.text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid emergency contact no.");
                    } else if (SetupContactsPage.relationmodel == "" ||
                        SetupContactsPage.relationmodel == null) {
                      AppData.showInSnackBar(
                          context, "Please select relation ");
                    } else {
                      updateEmergencyModel = UpdateEmergencyModel();
                      updateEmergencyModel.name = _fname.text;
                      updateEmergencyModel.mobile = _mobile.text;
                      updateEmergencyModel.id =
                          emergencyHelpModel.emergency[index].id;
                      updateEmergencyModel.userid = widget.model.user;
                      updateEmergencyModel.relation =
                          SetupContactsPage.relationmodel.key;
                      //updateEmergencyModel.relation =SetupContactsPage.relationmodel.key;
                      log("Value json>>" +
                          updateEmergencyModel.toJson().toString());
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.UPDATE_EMERGENCY_CONTACT,
                          json: updateEmergencyModel.toJson(),
                          token: widget.model.token,
                          fun: (Map<String, dynamic> map) {
                            // Navigator.pop(context);

                            if (map[Const.STATUS1] == Const.SUCCESS) {
                              Navigator.pop(context);
                              // popup(context, map[Const.MESSAGE]);
                              callAPI();
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);
                            } else {
                              // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                            }
                          });
                    }
                  });
                },
              ),
            ],
          );
        });
  }

  _displayTextInputDialog(BuildContext context, emergencyHelpModel) async {
    _fname.text = "";
    _mobile.text = "";
    // updateEmergencyModel=null;
    SetupContactsPage.relationmodel = null;
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
                      Text(MyLocalizations.of(context).text("ADD_EMERGENCY_CONTACT"),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            updateEmergencyModel.name = value;
                            //emergencyHelpModel.
                          });
                        },
                        controller: _fname,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        decoration: InputDecoration(
                            hintText: MyLocalizations.of(context).text("NAME"),
                            suffixIcon: InkWell(
                              onTap: () {
                               // Navigator.pop(context);
                                getContactDetails();
                              },
                              child: Icon(Icons.contacts),
                            )),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            updateEmergencyModel.mobile = value;
                            //emergencyHelpModel. = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: _mobile,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[0-9]")),
                        ],
                        maxLength: 10,
                        decoration: InputDecoration(
                            hintText: MyLocalizations.of(context)
                                .text("EMERGENCY_CONTACT_NO"),
                            counterText: ""),
                      ),
                      DropDown.networkDropdown(
                          MyLocalizations.of(context).text("RELATION"),
                          ApiFactory.RELATION_API,
                          "relation2", (KeyvalueModel model) {
                        setState(() {
                          // patientProfileModel.body.eRelation= model.name;
                          // ProfileScreen.relationmodel = model;
                          // updateProfileModel.eRelation = model.key;
                          SetupContactsPage.relationmodel = model;
                          updateEmergencyModel.relation = model.key;
                        });
                      }),
                      Divider(height: 2, color: Colors.black),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
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
                  MyLocalizations.of(context).text("SUBMIT"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");

                  setState(() {
                    if (_fname.text == null || _fname.text == "") {
                      AppData.showInSnackBar(context, "Please enter name");
                    } else if (_fname.text != "" && _fname.text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter a valid name");
                    } else if (_mobile.text == "" || _mobile.text == null) {
                      AppData.showInSnackBar(
                          context, "Please enter emergency contact no.");
                    } else if (_mobile.text != "" &&
                        _mobile.text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid emergency contact no.");
                    } else if (SetupContactsPage.relationmodel == "" ||
                        SetupContactsPage.relationmodel == null) {
                      AppData.showInSnackBar(
                          context, "Please select relation ");
                    } else {
                      updateEmergencyModel = UpdateEmergencyModel();
                      updateEmergencyModel.name = _fname.text;
                      updateEmergencyModel.mobile = _mobile.text;
                      updateEmergencyModel.userid = widget.model.user;
                      updateEmergencyModel.relation =
                          SetupContactsPage.relationmodel.key;
                      print("Value json>>" +
                          updateEmergencyModel.toJson1().toString());
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.UPDATE_EMERGENCY_CONTACT,
                          json: updateEmergencyModel.toJson1(),
                          token: widget.model.token,
                          fun: (Map<String, dynamic> map) {
                            // Navigator.pop(context);
                            if (map[Const.STATUS1] == Const.SUCCESS) {
                              Navigator.pop(context);
                              // popup(context, map[Const.MESSAGE]);
                              callAPI();
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);
                            } else {
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);
                              // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                            }
                          });
                    }
                  });
                  /*callAPI();
                  Navigator.of(context).pop();*/
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayContact(BuildContext context, List<Contact> list) async {
    List<Contact> foundUser=[];
    foundUser=list;
    // List<Contact> myList;


    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.symmetric(horizontal: 3),
            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {

                void _runFilter(String enteredKeyword) {
                  List<Contact> results = [];
                  if (enteredKeyword.isEmpty) {
                    results = list;
                  } else {
                    results = list
                        .where((user) => user.displayName.toLowerCase()
                        .contains(enteredKeyword.toLowerCase()))
                        .toList();
                  }
                  setState(() {
                    foundUser = results;
                  });
                }
                return Container(
                  height: 400,
                  width: double.maxFinite-50,
                  child:(list!=null && list.isNotEmpty)?Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          child: TextField(
                            onChanged: (value) => _runFilter(value),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                hintText: "Search"),
                          ),
                        ),
                      ),
                Expanded(
                    child:ListView.builder(
                      shrinkWrap: true,
                        itemBuilder: (c, i) {
                          return ListTile(
                            title: Text(foundUser[i].displayName),
                            subtitle: Text((foundUser[i]?.phones[0]?.number??"")),
                            onTap: (){

                              log("Selected Response>>>"+list[i].toString());
                              log("Selected Response>>>"+list[i]?.phones[0]?.number??"");
                              widget.model.contMobileno=list[i]?.phones[0]?.number??"";
                              _fname.text=foundUser[i].displayName.toString();
                              //_mobile.text=list[i]?.phones[0]?.number.replaceAll("- ", "")??"".toString();
                              _mobile.text=foundUser[i]?.phones[0]?.number.replaceAll(" ", "").replaceAll("-", "").replaceAll("+91", "")??"".replaceAll("+", "")??"".toString();
                             //_mobile.text=list[i]?.phones[0]?.number.replaceAll(" ":"", "").replaceAll("-", "")??"".toString();
                              Navigator.pop(context);
                            },
                          );
                        },
                        itemCount: foundUser.length,
                      ),
                ),
                    ],
                  ):Container(),
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
                  setState(() {
                    emergencyMessageModel = EmergencyMessageModel();
                    emergencyMessageModel.msg = _message.text;
                    emergencyMessageModel.userid = widget.model.user;

                    print("Value json>>" +
                        emergencyMessageModel.toJson().toString());
                    widget.model.POSTMETHOD_TOKEN(
                        api: ApiFactory.POST_EMERGENCY_MESSAGE,
                        json: emergencyMessageModel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          //Navigator.pop(context);
                          if (map[Const.STATUS1] == Const.SUCCESS) {
                            // popup(context, map[Const.MESSAGE]);
                            Navigator.pop(context);
                            callAPI();
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);
                          } else {
                            // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
                    /*codeDialog = valueText;
                    Navigator.pop(context);*/
                  });
                },
              ),
            ],
          );
        });
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

  void getContactDetails() async {
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      MyWidgets.showLoading(context);
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      Navigator.pop(context);

      _displayContact(context, contacts);
     /* if(contacts!=null && contacts.isNotEmpty) {

          contacts = await FlutterContacts.getContacts(
              withProperties: true, withPhoto: true);
          setState(() {});
          _displayContact(context, contacts);
      }else{
        _displayContact(context, contacts);
      }*/

    }
  }
}
