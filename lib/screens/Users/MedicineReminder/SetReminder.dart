import 'dart:async';
import 'dart:io';
import 'package:add_2_calendar/add_2_calendar.dart';
// import 'package:device_calendar/device_calendar.dart' as cal;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';

// ignore: must_be_immutable
class SetReminder extends StatefulWidget {
  final MainModel model;
  final String type;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;

  SetReminder({
    Key key,
    this.model,
    this.type,
  }) : super(key: key);

  @override
  SetReminderState createState() => SetReminderState();
}

enum PayMode1 { cash, cheque, online }

class SetReminderState extends State<SetReminder> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  PayMode1 payMode1 = PayMode1.cash;
  TimeOfDay selectedTime = TimeOfDay.now();

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
  bool selectGallery = false;
  var image;
  var pngBytes;
  String selectDob;
  KeyvalueModel selectedKey = null;
  final df = new DateFormat('dd/MM/yyyy');
  bool ispartnercode = false;
  bool fromLogin = false;

  bool isOnline = false;
  List<KeyvalueModel> dosageList = [
    KeyvalueModel(name: "0.5", key: "1"),
    KeyvalueModel(name: "1", key: "2"),
    KeyvalueModel(name: "1.5", key: "2"),
    KeyvalueModel(name: "2", key: "2"),
    KeyvalueModel(name: "2.5", key: "2"),
    KeyvalueModel(name: "3", key: "2"),
    KeyvalueModel(name: "3.5", key: "2"),
    KeyvalueModel(name: "4", key: "2"),
    KeyvalueModel(name: "4.5", key: "2"),
    KeyvalueModel(name: "5", key: "2"),
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
    textEditingController[0].text = widget.type;
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }

  setReminder({title}) {
    final Event event = Event(
      title: widget.type,
      description: 'Sanjaya Jena',
      location: 'Home',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 6)),
      recurrence: Recurrence(
        frequency: Frequency.daily,
        ocurrences: 3,
      ),
      iosParams: IOSParams(
        reminder: Duration(
            minutes:
                10), // on iOS, you can set alarm notification after your event.
      ),
      androidParams: AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
    );
    Add2Calendar.addEvent2Cal(event);
  }

  setReminder1() {
    /*cal.Event event = cal.Event(
      "1",
    );*/

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        centerTitle: true,
        title: Text("Set Reminder"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Type", hintStyle: TextStyle(color: Colors.grey)),
                controller: textEditingController[0],
                textInputAction: TextInputAction.next,
                enabled: false,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: textEditingController[1],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: DropDown.staticDropdown2(
                  "Dosager", "genderSignup", dosageList, (KeyvalueModel data) {
                setState(() {
                  SetReminder.genderModel = data;
                });
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
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
              padding: const EdgeInsets.symmetric(horizontal: 18),
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
            SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
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
            SizedBox(
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Expanded(child: stTime()),
                    SizedBox(width: 8),
                    Expanded(child: endTime()),
                  ],
                )),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
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
              padding: const EdgeInsets.only(left: 18.0, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Time 1",
                          hintStyle: TextStyle(color: Colors.grey)),
                      textInputAction: TextInputAction.next,
                      controller: textEditingController[2],
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 .]")),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Time 2",
                          hintStyle: TextStyle(color: Colors.grey)),
                      textInputAction: TextInputAction.next,
                      controller: textEditingController[3],
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 .]")),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Time 3",
                          hintStyle: TextStyle(color: Colors.grey)),
                      textInputAction: TextInputAction.next,
                      controller: textEditingController[4],
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 .]")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
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
                padding: const EdgeInsets.symmetric(horizontal: 18),
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
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Expanded(child: stdate()),
                    SizedBox(width: 8),
                    Expanded(child: endatee()),
                  ],
                )),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Add Docter Instruction",
                    hintStyle: TextStyle(color: Colors.grey)),
                textInputAction: TextInputAction.next,
                controller: textEditingController[5],
                keyboardType: TextInputType.text,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _submitButton(),
            ),
            SizedBox(
              height: 25,
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
        validate();
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
    setReminder();
    /*_formKey.currentState.validate();
    if (textEditingController[0].text == "" ||
        textEditingController[0].text == null) {
      AppData.showInSnackBar(context, "Please enter Typr");
    } else if (textEditingController[1].text == "" ||
        textEditingController[1].text == null) {
      AppData.showInSnackBar(context, "Please enter Medicine Name");
    } else if (SetReminder.genderModel == null) {
      AppData.showInSnackBar(context, "Please Select Dosage");
    } else if (SetReminder.districtModel == null) {
      AppData.showInSnackBar(context, "Please Select How Many Times");
    } else if (textEditingController[2].text == "" ||
        textEditingController[2].text == null) {
      AppData.showInSnackBar(context, "Please enter Time 1");
    } else if (textEditingController[3].text == "" ||
        textEditingController[3].text == null) {
      AppData.showInSnackBar(context, "Please enter Time 2");
    } else if (textEditingController[4].text == "" ||
        textEditingController[4].text == null) {
      AppData.showInSnackBar(context, "Please enter Time 3");
    } else if (stdob.text == "" || stdob.text == null) {
      AppData.showInSnackBar(context, "Please enter Start Date");
    } else if (endate.text == "" || endate.text == null) {
      AppData.showInSnackBar(context, "Please enter End Date");
    } else if (textEditingController[5].text == "" ||
        textEditingController[5].text == null) {
      AppData.showInSnackBar(context, "Please enter Doctor Instruction");
    } else {
      // _formKey.currentState.save();

    }*/
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
              controller: endtime,
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
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        stime.text = formatTimeOfDay(timeOfDay);
      });
    }
  }

  _selectTime1(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        endtime.text = formatTimeOfDay(timeOfDay);
      });
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    print("Value is>>>>>>\n\n\n\n" + tod.toString());
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }
}
