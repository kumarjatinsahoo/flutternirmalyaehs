import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';

import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';

// ignore: must_be_immutable
class SetReminder extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;

  SetReminder({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  SetReminderState createState() => SetReminderState();
}

enum PayMode1 { cash, cheque, online }

class SetReminderState extends State<SetReminder> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  PayMode1 payMode1 = PayMode1.cash;
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];
  TextEditingController stdob = TextEditingController();
  TextEditingController endate = TextEditingController();
  List<bool> error = [false, false, false, false, false, false];
  bool _isSignUpLoading = false;

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();

  TextEditingController _email = TextEditingController();
  FocusNode emailFocus_ = FocusNode();

  List<bool> dropdownError = [false, false, false];
  var color = Colors.black;
  var strokeWidth = 3.0;
  File _imageCertificate;
  bool selectGallery = false;
  var image;
  var pngBytes;
  String selectDob;
  KeyvalueModel selectedKey = null;
  final df = new DateFormat('dd/MM/yyyy');
  bool ispartnercode = false;
  bool _checkbox = false;
  DateTime _selectedDate;
  bool fromLogin = false;

  StreamSubscription _connectionChangeStream;
  bool isOnline = false;
  List<KeyvalueModel> genderList = [
    KeyvalueModel(name: "0.5", key: "1"),
    KeyvalueModel(name: "0.6", key: "2"),
    KeyvalueModel(name: "0.7", key: "3"),
  ];
  List<KeyvalueModel> districtList = [
    KeyvalueModel(name: "1", key: "1"),
    KeyvalueModel(name: "2", key: "1"),
    KeyvalueModel(name: "3", key: "1"),
    KeyvalueModel(name: "4", key: "1"),
    KeyvalueModel(name: "5", key: "1"),
    KeyvalueModel(name: "6", key: "1"),
  ];

  @override
  void initState() {
    super.initState();
    SetReminder.districtModel = null;
    SetReminder.blockModel = null;
    SetReminder.genderModel = null;
    /*setState(() {
      masterClass = widget.model.masterDataResponse;
    });
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    setState(() {
      isOnline = connectionStatus.hasConnection;
    });*/
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Row(
          children: [Text("Set Reminder"), Spacer(), Icon(Icons.search)],
        ),
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
                      left: 1.0,
                      //right: 8.0,
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
                            Form(
                              key: _formKey,
                              // ignore: deprecated_member_use
                              autovalidate: _autovalidate,
                              /*child: Expanded(*/
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Type",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                      controller: textEditingController[0],
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter(
                                            RegExp("[a-zA-Z ]")),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Medicine Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                      controller: textEditingController[1],
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter(
                                            RegExp("[a-zA-Z ]")),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: DropDown.staticDropdown2(
                                        "Dosager", "genderSignup", genderList,
                                        (KeyvalueModel data) {
                                      setState(() {
                                        SetReminder.genderModel = data;
                                      });
                                    }),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Reminder Time',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: DropDown.staticDropdown2(
                                        'How Many Times a Day  ',
                                        // MyLocalizations.of(context).text("SELECT_GENDER"),
                                        "genderSignup",
                                        districtList, (KeyvalueModel data) {
                                      setState(() {
                                        SetReminder.districtModel = data;
                                      });
                                    }),
                                  ),
                                  SizedBox(height: 10) ,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Timings',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, right: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                hintText: "Time",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey)),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: textEditingController[3],
                                            keyboardType: TextInputType.text,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter(
                                                  RegExp("[a-zA-Z0-9 .]")),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                hintText: "Time",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey)),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter(
                                                  RegExp("[a-zA-Z0-9 .]")),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                hintText: "Time",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey)),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter(
                                                  RegExp("[a-zA-Z0-9 .]")),
                                            ],
                                          ),
                                        ),
                                      ],
                                      // children: const <Widget>[
                                      //   Expanded(
                                      //     child: Text('07:25 PM',
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //           decoration:
                                      //               TextDecoration.underline,
                                      //           color: Colors.blueGrey,
                                      //         )),
                                      //   ),
                                      //   Expanded(
                                      //     child: Text('08:25 PM',
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //           decoration:
                                      //               TextDecoration.underline,
                                      //           color: Colors.blueGrey,
                                      //         )),
                                      //   ),
                                      //   Expanded(
                                      //     child: Text('09:25 PM',
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //           decoration:
                                      //               TextDecoration.underline,
                                      //           color: Colors.blueGrey,
                                      //         )),
                                      //   ),
                                      // ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Frequency',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  viewMode(),
                                  SizedBox(height: 5),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Row(
                                        children: const <Widget>[
                                          Expanded(
                                            child: Text(
                                              'Start Date :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          SizedBox(width: 75),
                                          Expanded(
                                            child: Text(
                                              'End Date :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(height: 5),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Row(
                                        children: [
                                          Expanded(child: stdate()),
                                          SizedBox(width: 8),
                                          Expanded(child: endatee()),
                                        ],
                                      )),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Add Docter Instruction",
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter(
                                            RegExp("[a-zA-Z ]")),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: _submitButton(),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                            /* )*/
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
    ));
  }

  Widget viewMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.cash,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Daily"),
        SizedBox(
          width: 10,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.cheque,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Weekly"),
        SizedBox(
          width: 10,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.online,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Monthly"),
      ],
    );
  }


  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "Set Reminder".toUpperCase(),
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

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            MyLocalizations.of(context).text("SIGN_BTN"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  validate() async {
    _formKey.currentState.validate();

    if (error[0] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_FIRST_NAME"));
      FocusScope.of(context).requestFocus(fnode1);
    } else if (error[1] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_lAST_NAME"));
      FocusScope.of(context).requestFocus(fnode2);
    } else if (SetReminder.genderModel == null ||
        SetReminder.genderModel == "") {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_SELECT_GENDER"));
      FocusScope.of(context).requestFocus(fnode4);
    } else if (textEditingController[5].text == '') {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_AADHAAR_NUMBER"));
      FocusScope.of(context).requestFocus(fnode4);
    } else if (error[3] == true) {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_FATHER_NAME"));
      FocusScope.of(context).requestFocus(fnode6);
    } else if (error[2] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_DOB"));
      FocusScope.of(context).requestFocus(fnode3);
    } else if (error[4] == true) {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_PHONE_NUMBER"));
      FocusScope.of(context).requestFocus(fnode7);
    } else if (SetReminder.districtModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT DISTRICT");
    } else if (SetReminder.blockModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT BLOCK/ULB");
    } else {
      _formKey.currentState.save();

      if (isOnline) {
        setState(() {
          _isSignUpLoading = true;
        });
        await Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _isSignUpLoading = false;
          });
        });
      } else {
        AppData.showInSnackBar(context, "INTERNET_CONNECTION");
      }
    }
  }

  Widget stdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              enabled: false,
              controller: stdob,
              //textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Date ",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget endatee() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate1(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              enabled: false,
              controller: endate,
              // textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Date",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                // prefixIcon: Icon(
                //   Icons.calendar_today,
                //   size: 18,
                //   color: AppData.kPrimaryColor,
                // ),
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
      // initialDate: DateTime.now().subtract(Duration(days: 6570)),
      //firstDate: DateTime(1901, 1),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      // lastDate: DateTime.now()
      //     .subtract(Duration(days: 6570))
    ); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        stdob.value = TextEditingValue(text: df.format(picked));
      });
  }

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: Locale("en"),
      // initialDate: DateTime.now().subtract(Duration(days: 6570)),
      //firstDate: DateTime(1901, 1),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      // lastDate: DateTime.now()
      //     .subtract(Duration(days: 6570))
    ); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        endate.value = TextEditingValue(text: df.format(picked));
      });
  }
}
