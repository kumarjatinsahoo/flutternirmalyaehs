import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/ImmunizationListModel.dart' as immunization;
import 'package:user/models/ImmunizationPostModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/TokenToID.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class Immunization extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;
  static KeyvalueModel immunizationmodel = null;

  const Immunization({Key key, this.model}) : super(key: key);

  @override
  _ImmunizationState createState() => _ImmunizationState();
}

class _ImmunizationState extends State<Immunization> {
  LoginResponse1 loginResponse1;
  bio.BiomedicalModel biomedicalModel;
  immunization.ImmunizationListModel immunizationListModel;
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = true;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');

  TextEditingController _date = TextEditingController();

  //TextEditingController _reason = TextEditingController();
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
  GlobalKey _one = GlobalKey();
  BuildContext myContext;

  bool isShown = true;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ShowCaseWidget.of(myContext).startShowCase([_one]);
    });
    super.initState();

    loginResponse1 = widget.model.loginResponse1;
    callApi();
  }

  callApi() {
    /*Map<String, dynamic> map = TokenToID.parseJwt(widget.model.token);
    log("Token>>>"+jsonEncode(map));*/
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.IMMUNIZATION_LIST + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Immunisation>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {              
              // setState(() {
                isdata = false;
                immunizationListModel =
                    immunization.ImmunizationListModel.fromJson(map);
              // });
            } else {
              setState(() {
                isdata = false;
                //isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  static String toDate(String date) {
    if (date != null && date != "") {
      DateTime formatter = new DateFormat("yyyy-MM-dd").parse(date);
      // final DateTime formatter =
      //DateFormat("yyyy-MM-dd\'T\'HH:mm:ss.SSSZ\'").parse(date);
      //DateFormat("dd/MM/yyyy").parse(date);
      DateFormat toNeed = DateFormat("dd-MM-yyyy");
      final String formatted = toNeed.format(formatter);
      return formatted;
    } else {
      return "";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppData.kPrimaryColor,
              title: Text(MyLocalizations.of(context).text("IMMUNIZATION")),
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    _date.text = "";
                    displayTextInputDialog(context);
                    // application.logoutCallBack();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
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
              : immunizationListModel == null
              ? Container(
            child: Center(
              child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
              )
            ),
          )
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              child: SingleChildScrollView(
                child: (immunizationListModel != null) //builder
                    ? ListView.separated(
                  itemCount:
                  immunizationListModel.body.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder:
                      (BuildContext context, int index) =>
                  const Divider(color: Colors.grey),
                  itemBuilder: (context, i) {
                    immunization.Body body =
                    immunizationListModel.body[i];
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 0),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        child: InkWell(
                          onTap: () {
                            String slno = body.slno;
                            String status = body.status;
                            displayStatushangeDialog(
                                context, slno, status);
                          },
                          child: Container(
                            /*decoration: (i % 2 == 0)
                                              ?  BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              left: BorderSide(
                                                  color:
                                                  AppData.kPrimaryRedColor,
                                                  width: 5)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 6.0,
                                              ),
                                            ],

                                          ): BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                                left: BorderSide(
                                                    color:
                                                    AppData.kPrimaryColor,
                                                    width: 5)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 6.0,
                                              ),
                                            ],

                                          ),*/

                            width: double.maxFinite,
                            /*height: 80,*/
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    // Navigator.pop(context);
                                  },
                                  child: (body.status ==
                                      "No")
                                      ? Padding(
                                      padding:
                                      const EdgeInsets
                                          .only(
                                          left: 0.0,
                                          right:
                                          0.0),
                                      child:
                                      Image.asset(
                                        "assets/redinjection40.png",
                                        color: AppData
                                            .kPrimaryRedColor,
                                        height: 35,
                                      ))
                                      : Padding(
                                      padding:
                                      const EdgeInsets
                                          .only(
                                          left: 0.0,
                                          right:
                                          0.0),
                                      child:
                                      Image.asset(
                                        "assets/redinjection40.png",
                                        color: Colors
                                            .green,
                                        height: 35,
                                      ))),
                              subtitle: Padding(
                                padding:
                                const EdgeInsets.only(
                                    top: 10.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      'Prescribed by: ' +
                                          body.doctorName,
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color:
                                          Colors.black,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    /* Text(
                                                    'Prescribed by: '+
                                                        body.doctorName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),*/
                                    Text(
                                      /*body.immunizationDate,*/
                                      toDate(body
                                          .immunizationDate) ??
                                          "N/A",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize: 14),
                                    ),
                                    (body.status == "No")
                                        ? Text(
                                      body.immunizationId,
                                      overflow:
                                      TextOverflow
                                          .clip,
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color: AppData
                                              .kPrimaryRedColor,
                                          fontSize:
                                          14),
                                    )
                                        : Text(
                                      body.immunizationId,
                                      overflow:
                                      TextOverflow
                                          .clip,
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color: Colors
                                              .green,
                                          fontSize:
                                          14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              trailing: (body.status ==
                                  "No")
                                  ? Icon(
                                Icons.cancel_rounded,
                                color: AppData
                                    .kPrimaryRedColor,
                                size: 26.0,
                              )
                                  : Icon(
                                Icons
                                    .check_circle_rounded,
                                color: Colors.green,
                                size: 26.0,
                              ),
                            ),
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
            top: 18,
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


  displayStatushangeDialog(BuildContext context, String slno, String status) {
    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 5),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 5),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*Positioned(
                        right: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.close, color: Colors.red,size: 25,),
                            ),
                          ),
                        ),
                      ),*/
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          MyLocalizations.of(context).text("VACCINATED"),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                              // light
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  MyLocalizations.of(context).text("CANCEL"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: Colors.deepOrange),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  /* widget.model.GETMETHODCALL_TOKEN(
                      api: ApiFactory
                          .IMMUNIZATION_STATUS + slno +
                          "&status=" + */ /*status*/ /*"yes",
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        setState(() {
                          log("Value>>>" +
                              jsonEncode(map));
                          String msg = map[Const.MESSAGE];
                          if (map[Const.CODE] ==
                              Const.SUCCESS) {
                            setState(() {
                              callApi();
                              Navigator.of(context).pop();
                            });
                          } else {
                            setState(() {
                              isDataNoFound = true;
                            });
                            //AppData.showInSnackBar(context, msg);
                          }
                        });
                      });
*/
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("NO"),
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  widget.model.GETMETHODCALL_TOKEN(
                      api: ApiFactory.IMMUNIZATION_STATUS +
                          slno +
                          "&status=" + /*status*/ "No",
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        setState(() {
                          log("Value>>>" + jsonEncode(map));
                          String msg = map[Const.MESSAGE];
                          if (map[Const.CODE] == Const.SUCCESS) {
                            setState(() {
                              callApi();
                              Navigator.of(context).pop();
                            });
                          } else {
                            setState(() {
                              isDataNoFound = true;
                            });
                            //AppData.showInSnackBar(context, msg);
                          }
                        });
                      });
                  /*setState(() {
                    Navigator.pop(context);
                  });*/
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  MyLocalizations.of(context).text("YES"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  widget.model.GETMETHODCALL_TOKEN(
                      api: ApiFactory.IMMUNIZATION_STATUS +
                          slno +
                          "&status=" + /*status*/ "yes",
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        setState(() {
                          log("Value>>>" + jsonEncode(map));
                          String msg = map[Const.MESSAGE];
                          if (map[Const.CODE] == Const.SUCCESS) {
                            setState(() {
                              callApi();
                              Navigator.of(context).pop();
                            });
                          } else {
                            setState(() {
                              isDataNoFound = true;
                            });
                            //AppData.showInSnackBar(context, msg);
                          }
                        });
                      });
                },
              ),
            ],
          );
        },
        context: context);
  }

  displayTextInputDialog(BuildContext context) {
    //_date.text = "";
    textEditingController[1].text = "";
    textEditingController[2].text = "";
    Immunization.immunizationmodel = null;
    // = "";
    //_reason.text = "";
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
                                child: Text(
                                  MyLocalizations.of(context)
                                      .text("ADD_DETAILS"),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                            MyLocalizations.of(context)
                                .text("IMMUNIZATION_TYPE"),
                            ApiFactory.IMMUNIZATION_API,
                            "immunization",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.IMMUNIZATION_API);
                            Immunization.immunizationmodel = data;
                          });
                        }),
                        SizedBox(height: 8),
                        dob(),
                        SizedBox(height: 8),
                        formField(1,
                            MyLocalizations.of(context).text("PRESCRIBED_BY")),
                        SizedBox(height: 8),
                        formField(
                            2,
                            MyLocalizations.of(context)
                                .text("IMMUNIZATION_DETAILS")),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
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
                  if (Immunization.immunizationmodel == null ||
                      Immunization.immunizationmodel == "") {
                    AppData.showInSnackBar(
                        context, "Please select immunization type ");
                  } else if (_date.text == "" || _date.text == null) {
                    AppData.showInSnackBar(
                        context, "Please enter immunization date");
                  } else if (textEditingController[1].text == "" ||
                      textEditingController[1].text == null) {
                    AppData.showInSnackBar(
                        context, "Please enter prescribed by");
                  } else if (textEditingController[2].text == "" ||
                      textEditingController[2].text == null) {
                    AppData.showInSnackBar(
                        context, "Please enter immunization details ");
                  } else {
                    MyWidgets.showLoading(context);
                    ImmunizationPostModel immunizationmodel =
                        ImmunizationPostModel();
                    immunizationmodel.patientId = loginResponse1.body.user;
                    immunizationmodel.immunizationId =
                        Immunization.immunizationmodel.key;
                    immunizationmodel.immunizationDate = _date.text;
                    immunizationmodel.doctorName =
                        textEditingController[1].text;
                    immunizationmodel.immunizationDetails =
                        textEditingController[2].text;
                    immunizationmodel.status = "yes";
                    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                        immunizationmodel.toJson().toString());
                    widget.model.POSTMETHOD2(
                      api: ApiFactory.ADD_IMMUNIZATION,
                      json: immunizationmodel.toJson(),
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        Navigator.pop(context);
                        if (map["code"] == Const.SUCCESS) {
                          Navigator.pop(context);
                          callApi();
                          AppData.showInSnackDone(context, map["message"]);
                        } else {
                          AppData.showInSnackBar(context, map[Const.MESSAGE]);
                        }
                      },
                    );
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
            padding: EdgeInsets.symmetric(horizontal: 10),
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
                hintText:
                    (MyLocalizations.of(context).text("IMMUNIZATION_DATE")),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 15,
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
        lastDate: DateTime
            .now() /*.add(new Duration(days: 5)*/); //18 years is 6570 days
    /*if (picked != null && picked != selectedDate)*/
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
        padding: EdgeInsets.symmetric(horizontal: 10),
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
            hintStyle: TextStyle(color: AppData.hintColor),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          // controller: _reason,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z . ]")),
          ],
        ),
      ),
    );
  }
}
