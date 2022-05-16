import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/SetReminderModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/localization/localizations.dart';

import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';

class SetReminder extends StatefulWidget {
  final MainModel model;
  final String type;
  static KeyvalueModel timeDayModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel dosageModel = null;

  SetReminder({
    Key key,
    this.model,
    this.type,
  }) : super(key: key);

  @override
  SetReminderState createState() => SetReminderState();
}

enum PayMode1 { Daily, Weekly, Monthly }

class SetReminderState extends State<SetReminder> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = true;
  DateTime selectedDate = DateTime.now();
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  PayMode1 payMode1 = PayMode1.Daily;

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedStartTime;
  TimeOfDay selectedEndTime;
  SharedPref sharedPref = SharedPref();
  LoginResponse1 loginResponse;
  List<String> doseTimeList = [];

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

  List<TextEditingController> timePicker = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  List<TimeOfDay> actualTime = [
    new TimeOfDay(minute: null, hour: null),
    new TimeOfDay(minute: null, hour: null),
    new TimeOfDay(minute: null, hour: null),
    new TimeOfDay(minute: null, hour: null),
    new TimeOfDay(minute: null, hour: null),
    new TimeOfDay(minute: null, hour: null),
    new TimeOfDay(minute: null, hour: null),
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
  final df = new DateFormat('dd-MM-yyyy');
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

  // DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();

  List<KeyvalueModel> days = [];
  var frequncyText = 'Days';

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    SetReminder.timeDayModel = null;
    SetReminder.blockModel = null;
    SetReminder.dosageModel = null;
    textEditingController[0].text = widget.type;
    stime.text = "04:55 AM";
    endtime.text = "12:55 PM";
    getList();
  }

  getList() {
    for (int i = 1; i <= 31; i++) {
      days.add(KeyvalueModel(key: i, name: i.toString()));
    }
    setState(() {
      days;
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }

  setReminder({title}) {
    /* final Event event = Event(
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
    Add2Calendar.addEvent2Cal(event);*/
  }

  /*setReminder1(descrption) async {
    String calenderId;
    if (loginResponse.body.calenderId == null) {
      Result<String> result = await _deviceCalendarPlugin.createCalendar(
        'eHealthSystem',
        calendarColor: AppData.kPrimaryRedColor,
        localAccountName: (Platform.isAndroid) ? 'eHealthSystem' : '',
      );
      log("Calender value" + result.data);
      loginResponse.body.calenderId = result.data.toString();
      sharedPref.save(Const.LOGIN_DATA, loginResponse);
      calenderId = result.data;
    } else {
      calenderId = loginResponse.body.calenderId;
    }

    cal.Event event = cal.Event(
      calenderId,
    );
    RecurrenceRule recurrenceRule =
        cal.RecurrenceRule(RecurrenceFrequency.Daily);
    // recurrenceRule.recurrenceFrequency=cal.RecurrenceFrequency.Daily;
    // recurrenceRule.endDate
    //recurrenceRule.
    // event.start=DateTime.now().add(Duration(minutes: 15));
    // event.end=DateTime.now().add(Duration(minutes: 35));
    event.title = widget.type;
    event.description = descrption +
        ", " +
        SetReminder.dosageModel.name +
        " dosage, " +
        textEditingController[5].text;
    event.location = "Home";
    event.allDay = false;
    // event.recurrenceRule=recurrenceRule;
    //event.n="Home";
    // event.url=Uri(path: "https://pub.dev/packages/device_calendar/versions");

    event.reminders = [cal.Reminder(minutes: 20)];
    // event.

    bool isAllAdded = false;
    for (int i = 0; i < int.tryParse(SetReminder.timeDayModel.name); i++) {
      // event.recurrenceRule=recurrenceRule;
      event.start = DateTime(selectedStartDate.year, selectedStartDate.month,
          selectedStartDate.day, actualTime[i].hour, actualTime[i].minute);
      event.end = DateTime(selectedEndDate.year, selectedEndDate.month,
          selectedEndDate.day, actualTime[i].hour, actualTime[i].minute);

      final createEventResult =
          await _deviceCalendarPlugin.createOrUpdateEvent(event);
      if (createEventResult.isSuccess &&
          (createEventResult.data?.isNotEmpty ?? false)) {
        //AppData.showInSnackDone(context, "Added done");
        isAllAdded = true;
      } else {
        AppData.showInSnackBar(context, "Something went wrong");
        isAllAdded = false;
      }
    }
    if (isAllAdded) {
      Navigator.pop(context);
      AppData.showInSnackDone(context, "Added successfully");
    }
  }*/

  /* Future _retrieveCalendarEvents() async {
    final startDate = DateTime.now().add(Duration(days: -30));
    final endDate = DateTime.now().add(Duration(days: 30));
    var calendarEventsResult = await _deviceCalendarPlugin.retrieveEvents(
        _calendar.id,
        RetrieveEventsParams(startDate: startDate, endDate: endDate));
    setState(() {
      _calendarEvents = calendarEventsResult.data as List<Event>;
      _isLoading = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        centerTitle: true,
        title: Text(MyLocalizations.of(context).text("SET_REMINDER")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MyLocalizations.of(context).text("TYPE"),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ),
            ),
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MyLocalizations.of(context).text("MEDICINE_NAME"),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: MyLocalizations.of(context).text("MEDICINE_NAME"),
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: textEditingController[1],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9- , ]")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: DropDown.staticDropdown2(
                  MyLocalizations.of(context).text("DOSAGE"),
                  "genderSignup",
                  dosageList, (KeyvalueModel data) {
                setState(() {
                  SetReminder.dosageModel = data;
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
                  MyLocalizations.of(context).text("REMINDER_TIME"),
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
                  MyLocalizations.of(context).text("HOW_MANY_TIMES"),
                  // MyLocalizations.of(context).text("SELECT_GENDER"),
                  "genderSignup",
                  districtList, (KeyvalueModel data) {
                setState(() {
                  SetReminder.timeDayModel = data;
                  timePicker.forEach((element) {
                    element.text = "";
                  });
                });
              }),
            ),
            SizedBox(height: 10),
            /* Padding(
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
                )),*/
            SizedBox(height: 10),
            (SetReminder.timeDayModel != null)
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            MyLocalizations.of(context).text("TIMINGS"),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              int.tryParse(SetReminder.timeDayModel.name),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 0.0,
                                  // childAspectRatio: 2.8,
                                  mainAxisExtent: 50,
                                  mainAxisSpacing: 15.0),
                          itemBuilder: (BuildContext context, int i) {
                            return dynamicTiming(i);
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MyLocalizations.of(context).text("FREQUENCY"),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children:  <Widget>[
                  SizedBox(width: 8),
                  Text(
                    MyLocalizations.of(context).text("START_DATE"),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                  // SizedBox(width: 75),
                  SizedBox(width: 16),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Container(child: stdate()),
                    SizedBox(width: 8),
                    // Expanded(child: endatee()),
                  ],
                )),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(MyLocalizations.of(context).text(frequncyText),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText:MyLocalizations.of(context).text(frequncyText),
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: textEditingController[2],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
                  FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: MyLocalizations.of(context).text("ADD_DOCTOR_INSTRUCTION"),
                    hintStyle: TextStyle(color: Colors.grey)),
                textInputAction: TextInputAction.next,
                controller: textEditingController[5],
                keyboardType: TextInputType.text,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
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
          value: PayMode1.Daily,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
              frequncyText = 'Days';
            });
          },
        ),
        Text(MyLocalizations.of(context).text("DAILY")),
        SizedBox(
          width: 10,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.Weekly,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
              frequncyText = 'Week';
            });
          },
        ),
        Text(MyLocalizations.of(context).text("WEEKLY")),
        SizedBox(
          width: 10,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.Monthly,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
              frequncyText = 'Month';
            });
          },
        ),
        Text(MyLocalizations.of(context).text("MONTHLY")),
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
    //setReminder();
    //setReminder1(textEditingController[1].text);
    // _formKey.currentState.validate();

    bool isAllDateFill = true;
    if (SetReminder.timeDayModel != null) {
      for (int i = 0; i < int.tryParse(SetReminder.timeDayModel.name); i++) {
        if (timePicker[i].text == "") {
          isAllDateFill = false;
          break;
        }
      }
    }

    if (textEditingController[0].text.trim() == "" ||
        textEditingController[0].text.trim() == null) {
      AppData.showInSnackBar(context, "Please enter type");
    } else if (textEditingController[1].text.trim() == "" ||
        textEditingController[1].text.trim() == null) {
      AppData.showInSnackBar(context, "Please enter medicine name");
    } else if (SetReminder.dosageModel == null) {
      AppData.showInSnackBar(context, "Please select dosage");
    } else if (SetReminder.timeDayModel == null) {
      AppData.showInSnackBar(context, "Please select reminder time");
    } else if (!isAllDateFill) {
      AppData.showInSnackBar(context, "Please enter timings");
    } else if (stdob.text == "" || stdob.text == null) {
      AppData.showInSnackBar(context, "Please enter start date");
    } else if (textEditingController[2].text.trim() == "" ||
        textEditingController[2].text.trim() == null) {
      AppData.showInSnackBar(context, "Please enter days");
    } else if (int.parse(textEditingController[2].text) < 1) {
      AppData.showInSnackBar(context, "Days should not be less than 1");
    } else {
      SetReminderModel setReminderModel = SetReminderModel();
      setReminderModel.userId = loginResponse.body.user;
      setReminderModel.medType = textEditingController[0].text;
      setReminderModel.medName = textEditingController[1].text;
      setReminderModel.medDosage = SetReminder.dosageModel.name;
      setReminderModel.dosagePerDay = SetReminder.timeDayModel.name;
      setReminderModel.startTime = stime.text;
      setReminderModel.endTime = endtime.text;
      setReminderModel.startDate = stdob.text;
      setReminderModel.totalDays = textEditingController[2].text;
      setReminderModel.instructions = textEditingController[5].text;
      setReminderModel.frequency = payMode1.toString().substring(9);
      setReminderModel.doseTime = doseTimeList;
      log("Post json>>>>" + jsonEncode(setReminderModel.toJson()));
      MyWidgets.showLoading(context);
      widget.model.POSTMETHOD1(
          api: ApiFactory.POST_REMINDER,
          token: widget.model.token,
          json: setReminderModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
      // _formKey.currentState.save();
      // Navigator.pop(context);
      /*  bool isAllAccept = true;
      for (int i = 0; i < int.tryParse(SetReminder.timeDayModel.name); i++) {
        if (timePicker[i].text == "") {
          isAllAccept = false;
        }
      }
      if (isAllAccept) {
        setReminder1(
          textEditingController[1].text,
        );
      } else {
        AppData.showInSnackBar(context, "Please input timings");
      }*/
    }
  }

  Widget dynamicTiming(v) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDynamicTime(context, v),
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
              controller: timePicker[v],
              //textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: MyLocalizations.of(context).text("TIME"),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget stdate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            width: 170,
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
                hintText:MyLocalizations.of(context).text("DATE"),
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
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      // lastDate: DateTime.now()
      //     .subtract(Duration(days: 6570))
    ); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        selectedStartDate = picked;
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
        selectedEndDate = picked;
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
        selectedStartTime = timeOfDay;
        stime.text = formatTimeOfDay(timeOfDay);
      });
    }
  }

  _selectDynamicTime(BuildContext context, v) async {
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
    setState(() {
      // selectedTime = timeOfDay;
      // selectedStartTime = timeOfDay;
      actualTime[v] = timeOfDay;
      timePicker[v].text = formatTimeOfDay(timeOfDay);
      if (doseTimeList.contains(timePicker[v].text)) {
        selectedTime = TimeOfDay.now();
        timePicker[v].text = "";
        AppData.showInSnackBar(context, 'Time is already added');
      }

      doseTimeList.add(timePicker[v].text.toString());
    });

    // }
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
        selectedEndTime = timeOfDay;
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
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
}
