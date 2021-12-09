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
  TimeOfDay selectedTime = TimeOfDay.now();
  //TimeOfDay selectedTime;

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];
  TextEditingController stdob = TextEditingController();
  TextEditingController endate = TextEditingController();
  TextEditingController stime = TextEditingController();
  TextEditingController endtime = TextEditingController();
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
                                      child: Row(
                                        children: const <Widget>[
                                          Expanded(
                                            child: Text(
                                              'Start Time :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          //SizedBox(width: 75),
                                          Expanded(
                                            child: Text(
                                              '  End Time :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(height: 5,),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Row(
                                        children: [
                                          Expanded(child: stTime()),
                                          SizedBox(width: 8),
                                          Expanded(child: stTime()),
                                        ],
                                      )),
                                  SizedBox(height: 10),
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
                                                hintText: "Time 1",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey)),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: textEditingController[2],
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
                                                hintText: "Time 2",
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
                                                hintText: "Time 3",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey)),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: textEditingController[4],
                                            keyboardType: TextInputType.text,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter(
                                                  RegExp("[a-zA-Z0-9 .]")),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                      controller: textEditingController[5],
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
        validate(
        );
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
        // validate(
        // );
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
    if (textEditingController[0].text == "" ||
        textEditingController[0].text == null) {
      AppData.showInSnackBar(context, "Please enter Typr");
    }else if (textEditingController[1].text == "" ||
        textEditingController[1].text == null) {
      AppData.showInSnackBar(context, "Please enter Medicine Name");
    } else if (SetReminder.genderModel == null) {
  AppData.showInSnackBar(context, "Please Select Dosage");
  } else if (SetReminder.districtModel == null) {
  AppData.showInSnackBar(context, "Please Select How Many Times");
  }else if (textEditingController[2].text == "" ||
        textEditingController[2].text == null) {
      AppData.showInSnackBar(context, "Please enter Time 1");
    }else if (textEditingController[3].text == "" ||
        textEditingController[3].text == null) {
      AppData.showInSnackBar(context, "Please enter Time 2");
    }else if (textEditingController[4].text == "" ||
        textEditingController[4].text == null) {
      AppData.showInSnackBar(context, "Please enter Time 3");
    }else if (stdob.text == "" || stdob.text == null) {
      AppData.showInSnackBar(context, "Please enter Start Date");
    }else if (endate.text == "" || endate.text == null) {
      AppData.showInSnackBar(context, "Please enter End Date");
    } else if (textEditingController[5].text == "" ||
        textEditingController[5].text == null) {
      AppData.showInSnackBar(context, "Please enter Doctor Instruction");
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

  Widget stTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => _selectTime(context),
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
              controller: stime,
              // textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Time",
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

  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
        stime.text=timeOfDay.toString();
      });
    }
  }

 Widget endTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => _selectTime1(context),
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
                hintText: "Time",
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

  _selectTime1(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
        stime.text=timeOfDay.toString();
      });
    }
  }

}
