import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
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

  UpdateEmergencyModel updateEmergencyModel = UpdateEmergencyModel();
  EmergencyMessageModel emergencyMessageModel = EmergencyMessageModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.EMERGENCY_HELP + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          log("Response>>>"+jsonEncode(map));
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
    title: Text('Setup Contacts'),
      ),
      body: Container(
    child: Column(
      children: [
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
                                                    : "Add Emergency Contact",
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
                                                      : "Add Emergency Contact",
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
                                                      : "Add Emergency Contact",
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
                                                      : "Add Emergency Contact",
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
                                                      : "Add Emergency Contact",
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
                          child: InkWell(
                            onTap: () {
                              // (emergencyHelpModel != null)
                              //     ? _displayTextInputDialog1(
                              //     context, emergencyHelpModel, 5)
                              //     : _displayTextInputDialog2(
                              //     context, emergencyHelpModel);
                             // _displayTextInputDialog2(context);
                            },
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
                                child: Container(
                                    height: tileSize,
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
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  // (emergencyHelpModel != null)
                                                  emger_ms ??
                                                      "Emergency Alert ! \n I need help.",
                                                  textAlign:
                                                      TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.blue),
                                                ),
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
    );
  }

  _displayTextInputDialog1(
      BuildContext context, emergencyHelpModel, int index) async {
    _fname.text = emergencyHelpModel.emergency[index].name;
    _mobile.text = emergencyHelpModel.emergency[index].mobile;
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
                          "Relation", ApiFactory.RELATION_API, "relation",
                          (KeyvalueModel model) {
                        setState(() {
                          // emergencyHelpModel.body.eRelation= model.name;
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
                  'UPDATE',
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {
                    updateEmergencyModel = UpdateEmergencyModel();
                    updateEmergencyModel.name = _fname.text;
                    updateEmergencyModel.mobile = _mobile.text;
                    updateEmergencyModel.id =
                        emergencyHelpModel.emergency[index].id;
                    updateEmergencyModel.userid = widget.model.user;
                    updateEmergencyModel.relation =
                        emergencyHelpModel.emergency[index].relId;
                    print("Value json>>" +
                        updateEmergencyModel.toJson().toString());
                    widget.model.POSTMETHOD_TOKEN(
                        api: ApiFactory.UPDATE_EMERGENCY_CONTACT,
                        json: updateEmergencyModel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          if (map[Const.STATUS1] == Const.SUCCESS) {
                            // popup(context, map[Const.MESSAGE]);
                            callAPI();
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);
                          } else {
                            // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
                  });
                },
              ),
            ],
          );
        });
  }

  _displayTextInputDialog(
    BuildContext context,
    emergencyHelpModel,
  ) async {
    _fname.text = "";
    _mobile.text = "";
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
                        "Add Emergency Contact",
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
                            hintText: "Emergency Contact No.", counterText: ""),
                      ),
                      DropDown.networkDropdown(
                          "Relation", ApiFactory.RELATION_API, "relation",
                          (KeyvalueModel model) {
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
                    setState(() {
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
                            Navigator.pop(context);
                            if (map[Const.STATUS1] == Const.SUCCESS) {
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
                    });
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayTextInputDialog2(
    BuildContext context,
  ) async {
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
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            emergencyMessageModel.msg = value;
                          });
                        },
                        controller: _message,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        decoration: InputDecoration(hintText: " Enter Message"),
                      ),
                      Divider(height: 2, color: Colors.black),
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
                          Navigator.pop(context);
                          if (map[Const.STATUS1] == Const.SUCCESS) {
                            // popup(context, map[Const.MESSAGE]);
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
}
