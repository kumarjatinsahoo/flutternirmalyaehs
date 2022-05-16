import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
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
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = true;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd-MM-yyyy');

  TextEditingController _date = TextEditingController();
  TextEditingController _reason = TextEditingController();
  TextEditingController _name = TextEditingController();

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  List<bool> error = [false, false, false, false, false, false];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  AddBioMedicalModel addBioMedicalModel = AddBioMedicalModel();

  bool isShown = true;

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
              setState(() {
                biomedicalModel = bio.BiomedicalModel.fromJson(map);
                isdata = false;
              });
              if (biomedicalModel?.body[0].bioMName != null) {
                BiomediImplants.admequipmentmodel = KeyvalueModel(
                    key: biomedicalModel.body[0].bioid,
                    name: biomedicalModel.body[0].bioMName);
              } else {
                BiomediImplants.admequipmentmodel = null;
              }
              
            } else {
              setState(() {
                isdata = false;
                // isDataNoFound = true;
                
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppData.kPrimaryColor,
              title: Text(MyLocalizations.of(context).text("BIOMEDICAL")),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: InkWell(
                    onTap: () {
                      displayTextInputDialog(context);
                    },
                    child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 26.0,
                    ),
                  ),
                ),
              ]),
          body: isdata == true
              ? Center(
                child: CircularProgressIndicator(
                    backgroundColor: AppData.matruColor,
                  ),
              )
              : (biomedicalModel.body.length.toString() == "0" || biomedicalModel == null)
                  ? Container(
                      child: Center(
                        child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
                      ),
                    )
                  : Container(
                      child: SingleChildScrollView(
                        child: (biomedicalModel != null)
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: biomedicalModel.body.length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  bio.Body body = biomedicalModel.body[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      shadowColor: Colors.grey,
                                      elevation: 10,
                                      child: ClipPath(
                                        clipper: ShapeBorderClipper(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        child: Container(
                                          decoration: (i % 2 == 0)
                                              ? BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          color: AppData
                                                              .kPrimaryRedColor,
                                                          width: 5)))
                                              : BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          color:
                                                              AppData.kPrimaryColor,
                                                          width: 5))),
                                          //width: double.maxFinite,
                                          child: Stack(
                                              children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10.0, right: 10.0,top: 8,),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                     children: [
                                                      Expanded(
                                                        flex: 1,
                                                         child: Text(MyLocalizations.of(context).text("NAME"),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right:6.0),
                                                          child: Text(
                                                            body?.bioMName ?? "N/A",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10.0,
                                                      top: 10,
                                                      right: 10.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(MyLocalizations.of(context).text("DATE"),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          body?.bioMDate ?? "N/A",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // SizedBox(height: 5),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10.0,
                                                      top: 10,
                                                      right: 10.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(MyLocalizations.of(context).text("REASON"),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          body?.bioMReason ?? "N/A",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            BiomedicaldisplayDialog(
                                                                context,
                                                                biomedicalModel,
                                                                i);
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                      ),
                      /* ): Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: (isDataNoFound) ? Text("Data Not Found"):callApi(),
*/
                    ),
        ),
        (isShown)?Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black54,
          child: MaterialButton(
            onPressed: () {
              setState(() {
                isShown = false;
              });
            },
          ),
        ):Container(),
        Positioned(
            right: 25,
            top: 22,
            child: Visibility(
              visible: isShown,
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      isShown = false;
                    });
                  },
                  enableFeedback: false,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Visibility(
                      visible: isShown,
                      child: SafeArea(
                          child:
                          Image.asset("assets/images/indication.png")))),
            ))
      ],
    );
  }

  displayTextInputDialog(BuildContext context) {
    _date.text = "";
    _reason.text = "";
    BiomediImplants.admequipmentmodel = null;

    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(MyLocalizations.of(context).text("ADD_DETAILS"),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // DropDown.networkDropdownGet(
                        //     "Name", ApiFactory.ADM_EQUIPMENT_API, "admequipment",
                        //     (KeyvalueModel model) {
                        //   setState(() {
                        //     print(ApiFactory.ADM_EQUIPMENT_API);
                        //     BiomediImplants.admequipmentmodel = model;
                        //   });
                        // }),

                        DropDown.networkDropdownGetpartUser1(
                            MyLocalizations.of(context).text("NAME"),
                            ApiFactory.ADM_EQUIPMENT_API,
                            "typelist",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.ADM_EQUIPMENT_API);
                            BiomediImplants.admequipmentmodel = data;
                          });
                        }),
                        SizedBox(height: 8),
                        dob(),
                        SizedBox(height: 8),
                        formField(
                            1, MyLocalizations.of(context).text("REASON")),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: AppData.kPrimaryRedColor,
                child: Text(
                  MyLocalizations.of(context).text("CANCEL"),
                ),
                onPressed: () {
                  setState(() {
                    BiomediImplants.admequipmentmodel = null;
                    _date.text = "";
                    _reason.text = "";
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
                  if (BiomediImplants.admequipmentmodel == null ||
                      BiomediImplants.admequipmentmodel == "") {
                    AppData.showInSnackBar(context, "Please select name ");
                  } else if (_date.text == "" || _date.text == null) {
                    AppData.showInSnackBar(context, "Please enter date");
                  } else if (_reason.text.trim() == "" || _reason.text.trim() == null) {
                    AppData.showInSnackBar(context, "Please enter reason");
                  } else if (_reason.text.trim() != "" && _reason.text.trim().length <= 2) {
                    AppData.showInSnackBar(
                        context, "Please enter valid reason");
                  } else {
                    MyWidgets.showLoading(context);
                    AddBioMedicalModel biomedicalModel = AddBioMedicalModel();
                    biomedicalModel.userid = loginResponse1.body.user;
                    biomedicalModel.bioMName =
                        BiomediImplants.admequipmentmodel.key;
                    biomedicalModel.bioMDate = _date.text;
                    biomedicalModel.bioMReason = _reason.text;
                    log("Value json>>" + biomedicalModel.toJson().toString());
                    widget.model.POSTMETHOD2(
                        api: ApiFactory.ADD_BIOMEDICAL_IMPLANTS,
                        json: biomedicalModel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          if (map[Const.STATUS1] == Const.SUCCESS) {
                            Navigator.pop(context);
                            //  Navigator.pop(context);
                            // popup(context, map[Const.MESSAGE]);
                            callApi();
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);
                          } else {
                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
                  }
                },
              ),
            ],
          );
        },
        context: context);
  }

  Widget dob() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: _date,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              onSaved: (value) {
                //userPersonalForm.dob = value;
                selectDob = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  error[2] = true;
                  return null;
                }
                error[2] = false;
                return null;
              },
              onFieldSubmitted: (value) {
                error[2] = false;
                // print("error>>>" + error[2].toString());

                setState(() {});
                AppData.fieldFocusChange(context, fnode3, fnode4);
              },
              decoration: InputDecoration(
                hintText: (MyLocalizations.of(context).text("DATE")),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate:
            DateTime.now().add(new Duration(days: 0))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        _date.value = TextEditingValue(text: df.format(picked));
        addBioMedicalModel.bioMDate = df.format(picked);
      });
  }

  Widget formField(
    int index,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: _reason,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }

  BiomedicaldisplayDialog(
      BuildContext context, bio.BiomedicalModel biomedicalModel, int i) {
    _date.text = biomedicalModel.body[i].bioMDate ?? "";
    _reason.text = biomedicalModel.body[i].bioMReason ?? "";

    if (biomedicalModel.body[i].bioMName == null ||
        biomedicalModel.body[i].bioMName == "") {
      BiomediImplants.admequipmentmodel = null;
    } else {
      BiomediImplants.admequipmentmodel = KeyvalueModel(
          key: biomedicalModel.body[i].bioid,
          name: biomedicalModel.body[i].bioMName);
    }

    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(MyLocalizations.of(context).text("ADD_DETAILS"),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropDown.networkDropdownGetpartUser1(
                            MyLocalizations.of(context).text("NAME"),
                            ApiFactory.ADM_EQUIPMENT_API,
                            "biotype",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.ADM_EQUIPMENT_API);
                            BiomediImplants.admequipmentmodel = data;
                            BiomediImplants.admequipmentmodel = data.key;
                          });
                        }),
                        SizedBox(height: 8),
                        dob(),
                        SizedBox(height: 8),
                        formField(
                            1, MyLocalizations.of(context).text("REASON")),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: AppData.kPrimaryRedColor,
                child: Text(
                  MyLocalizations.of(context).text("CANCEL"),
                ),
                onPressed: () {
                  setState(() {
                    BiomediImplants.admequipmentmodel = null;
                    _date.text = "";
                    _reason.text = "";
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
                  if (BiomediImplants.admequipmentmodel == null ||
                      BiomediImplants.admequipmentmodel == "") {
                    AppData.showInSnackBar(context, "Please select Name ");
                  } else if (_date.text == "" || _date.text == null) {
                    AppData.showInSnackBar(context, "Please enter Date");
                  } else if (_reason.text == "" || _reason.text == null) {
                    AppData.showInSnackBar(context, "Please enter Reason");
                  } else if (_reason.text != "" && _reason.text.length <= 2) {
                    AppData.showInSnackBar(
                        context, "Please enter valid Reason");
                  } else {
                    MyWidgets.showLoading(context);
                    AddBioMedicalModel biomedicalModell = AddBioMedicalModel();
                    biomedicalModell.userid = loginResponse1.body.user;
                    biomedicalModell.bioMName =
                        BiomediImplants.admequipmentmodel.key;
                    biomedicalModell.bioMDate = _date.text;
                    biomedicalModell.bioMReason = _reason.text;
                    biomedicalModell.id = biomedicalModel.body[i].id;
                    log("Value json>>" + biomedicalModell.toJson().toString());

                    widget.model.POSTMETHOD2(
                        api: ApiFactory.ADD_BIOMEDICAL_IMPLANTS,
                        json: biomedicalModell.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          if (map[Const.STATUS1] == Const.SUCCESS) {
                            Navigator.pop(context);
                            //  Navigator.pop(context);
                            // popup(context, map[Const.MESSAGE]);
                            callApi();
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);
                          } else {
                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
                  }
                },
              ),
            ],
          );
        },
        context: context);
  }
}
