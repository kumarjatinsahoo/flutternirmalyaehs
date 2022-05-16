import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AllergicModel.dart' as allergic;
import 'package:user/models/AllergicPostModel.dart';

import 'package:user/models/BloodbanklistModel.dart' as ambulance;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class BookBloodBanklist extends StatefulWidget {
  MainModel model;
  static KeyvalueModel nameModel = null;
  static KeyvalueModel typeModel = null;
  static KeyvalueModel severitylistModel = null;

  BookBloodBanklist({Key key, this.model}) : super(key: key);

  @override
  _BookBloodBanklistState createState() => _BookBloodBanklistState();
}

class _BookBloodBanklistState extends State<BookBloodBanklist> {
  var selectedMinValue;
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
  ];
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();

  List<KeyvalueModel> severitylist = [
    KeyvalueModel(name: "High", key: "High"),
    KeyvalueModel(name: "Medium", key: "Medium"),
    KeyvalueModel(name: "Low", key: "Low"),
  ];
  LoginResponse1 loginResponse;
  bool isDataNoFound = false;
  ambulance.BloodbanklistModel bloodbanklistModel;
  bool isdata = true;
  bool isShown = true;
  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.BLDBANK_LIST + loginResponse.body.user,
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              isdata = false;
              // pocReportModel = PocReportModel.fromJson(map);
              bloodbanklistModel = ambulance.BloodbanklistModel.fromJson(map);
            } else {
              setState(() {
                isdata = false;
                //isDataNoFound = true;
                // AppData.showInSnackBar(context, msg);
              });
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
              title: Text(MyLocalizations.of(context).text("BLOOD_BANK")),
              /* leading: Icon(
              Icons.menu,
            ),*/
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/bookBloodBankPage");
                        /* showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            dialogaddnomination(context),
                      );*/
                        // callAPI();
                      },
                      child: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 26.0,
                      ),
                    )),
                /*Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                        Icons.more_vert
                    ),
                  )
              ),*/
              ],
            ),
            body: isdata == true
                ? Center(
                    child: CircularProgressIndicator(
                        //backgroundColor: AppData.matruColor,
                        ),
                  )
                : bloodbanklistModel == null || bloodbanklistModel == null
                    ? Container(
                        child: Center(
      child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            ),)
                      )
                    : SingleChildScrollView(
                        child: (bloodbanklistModel != null)
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                // controller: _scrollController,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  if (i == bloodbanklistModel.body.length) {
                                    return (bloodbanklistModel.body.length % 10 ==
                                            0)
                                        ? CupertinoActivityIndicator()
                                        : Container();
                                  }
                                  ambulance.Body body = bloodbanklistModel.body[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    child: Card(
                                      child: Container(
                                        //height: height * 0.30,
                                        // color: Colors.grey[200],
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(colors: [
                                                Colors.blueGrey[50],
                                                Colors.blue[50]
                                              ])),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 10,
                                                    bottom: 5),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            width: 120,
                                                            child: Text(
                                                              MyLocalizations.of(context).text("BLOOD_BANK_NAME"),
                                                              /*'Confirmed'*/
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(" : "),
                                                          Text(
                                                            /*'23-Nov-2020-11:30AM'*/
                                                            body.bloodBankName,
                                                            overflow:
                                                                TextOverflow.clip,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            width: 120,
                                                            child: Text(
                                                              MyLocalizations.of(context).text("BLOODGROUP"),
                                                              /*'Confirmed'*/
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(" : "),
                                                          Text(
                                                            /*'23-Nov-2020-11:30AM'*/
                                                            body.bloodGrName,
                                                            overflow:
                                                                TextOverflow.clip,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            width: 120,
                                                            child: Text(
                                                              MyLocalizations.of(context).text("DATE"),
                                                              /*'Confirmed'*/
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(" : "),
                                                          Text(
                                                            /*'23-Nov-2020-11:30AM'*/
                                                            body.bookedDate,
                                                            overflow:
                                                                TextOverflow.clip,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            width: 120,
                                                            child: Text(
                                                              MyLocalizations.of(context).text("PATIENT_NOTES"),
                                                              /*'Confirmed'*/
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(" : "),
                                                          Expanded(
                                                            child: Text(
                                                              /*'23-Nov-2020-11:30AM'*/
                                                              body.patientNote,
                                                              overflow:
                                                                  TextOverflow.clip,
                                                              style: TextStyle(
                                                                  color:
                                                                      Colors.black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            ' ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Spacer(),
                                                          InkWell(
                                                            /*onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext
                                        context) =>
                                            changeStatus(context,body.orderId),
                                      );
                                      // widget.model.userappointment = appointmentlist;


                                      //  Navigator.pushNamed(context, "/usermedicinelist");
                                    },*/
                                                            child: MaterialButton(
                                                              child: Text(
                                                                /*'Confirmed'*/
                                                                body.status,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 15,
                                                                    color: AppData
                                                                        .kPrimaryBlueColor),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                //itemCount:5,
                                itemCount: bloodbanklistModel.body.length,
                              )
                            : Container(),
                      ) /* :Container(
  child: Center(
        child: Column(
          children: [
            SizedBox(height: 300,),
            (isdata)? Text(
              'No Data Found',
              style:
              TextStyle(color: Colors.black, fontSize: 15),
            ):CircularProgressIndicator(),
          ],
        ),
  ),

),*/

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
            right: 22,
            top: 8,
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
                          Image.asset("assets/images/Indicationbook.png")))),
            ))
      ],
    );
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

  Widget dialogaddnomination(BuildContext context) {
    textEditingController[1].text = "";
    textEditingController[2].text = "";

    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.86,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //_buildAboutText(),
                  //_buildLogoAttribution(),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            MyLocalizations.of(context).text("ADD_ALLERGIC"),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropDown.networkDropdownGetpartUser1(
                            "Name",
                            ApiFactory.TYPE_API,
                            "typelist",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.TYPE_API);
                            BookBloodBanklist.typeModel = data;
                          });
                        }),
                        /*SizedBox(
                          height: 5,
                        ),*/
                        DropDown.networkDropdownGetpartUser1(
                            MyLocalizations.of(context).text("ALLERGEN"),
                            ApiFactory.NAME_API,
                            "namelist",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.NAME_API);
                            BookBloodBanklist.nameModel = data;
                          });
                        }),
                        /* SizedBox(
                          height: 5,
                        ),*/
                        DropDown.networkDrop(
                            MyLocalizations.of(context).text("SEVERTY"),
                            "SEVERITY",
                            severitylist, (KeyvalueModel data) {
                          setState(() {
                            BookBloodBanklist.severitylistModel = data;
                          });
                        }),
                        SizedBox(
                          height: 8,
                        ),
                        formField(1, "   Reaction"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(2, "   Updated By"),
                      ],
                    ),
                  ),

                  // fromAddress(0, "Remark", TextInputAction.next,
                  //     TextInputType.text, "remark"),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            BookBloodBanklist.nameModel.key = "";
            BookBloodBanklist.typeModel.key = "";
            BookBloodBanklist.severitylistModel.key = "";
            textEditingController[1].text = "";
            textEditingController[2].text = "";

            // textEditingController[0].text = "";
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(MyLocalizations.of(context).text("CANCEL")),
        ),
        new FlatButton(
          onPressed: () {
            if (BookBloodBanklist.nameModel == null ||
                BookBloodBanklist.nameModel == "") {
              AppData.showInSnackBar(context, "Please select Name ");
            } else if (BookBloodBanklist.typeModel == null ||
                BookBloodBanklist.typeModel == "") {
              AppData.showInSnackBar(context, "Please select Type ");
            } else if (BookBloodBanklist.severitylistModel == null ||
                BookBloodBanklist.severitylistModel == "") {
              AppData.showInSnackBar(context, "Please select Severity ");
            } else if (textEditingController[1].text == "" ||
                textEditingController[1].text == null) {
              AppData.showInSnackBar(context, "Please enter Reaction");
              FocusScope.of(context).requestFocus(fnode1);
            } else if (textEditingController[2].text == "" ||
                textEditingController[2].text == null) {
              AppData.showInSnackBar(context, "Please enter Updated by");
              FocusScope.of(context).requestFocus(fnode2);
            } else {
              MyWidgets.showLoading(context);
              AllergicPostModel allergicmodel = AllergicPostModel();
              allergicmodel.userid = loginResponse.body.user;
              allergicmodel.allnameid = BookBloodBanklist.nameModel.key;
              allergicmodel.alltypeid = BookBloodBanklist.typeModel.key;
              allergicmodel.severity = BookBloodBanklist.severitylistModel.key;
              allergicmodel.reaction = textEditingController[1].text;
              allergicmodel.updatedby = textEditingController[2].text;
              print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                  allergicmodel.toJson().toString());
              widget.model.POSTMETHOD2(
                api: ApiFactory.ALLERGIC_POST,
                json: allergicmodel.toJson(),
                token: widget.model.token,
                fun: (Map<String, dynamic> map) {
                  Navigator.pop(context);
                  setState(() {
                    if (map[Const.STATUS1] == Const.SUCCESS) {
                      callAPI();
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);
                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  });
                },
                /*fun: (Map<String, dynamic> map) {
                    Navigator.pop(context);
                    callAPI();
                    if (map[Const.STATUS] == Const.SUCCESS) {
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);
                    } else {
                      AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    }
                  }*/
              );
              //AppData.showInSnackBar(context, "add Successfully");
            }
            Navigator.of(context).pop();

            // Navigator.of(context).pop();
            // AllergicListList.nameModel.key="";
            // AllergicListList.typeModel.key="";
            // AllergicListList.severitylistModel.key="";
            // textEditingController[1].text="";
            // textEditingController[2].text="";
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(MyLocalizations.of(context).text("SAVE")),
        ),
      ],
    );
  }

  Widget formField(
    int index,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
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
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }

  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              callAPI();
              //  Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
}
