import 'dart:async';
import 'dart:developer';
import 'dart:io';

// import 'package:add_2_calendar/add_2_calendar.dart';
// import 'package:device_calendar/device_calendar.dart' as cal;
// import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';

// ignore: must_be_immutable
class EditReminder extends StatefulWidget {
  final MainModel model;
  final String type;
  static KeyvalueModel timeDayModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel dosageModel = null;

  EditReminder({
    Key key,
    this.model,
    this.type,
  }) : super(key: key);

  @override
  EditReminderState createState() => EditReminderState();
}

enum PayMode1 { cash, cheque, online }

class EditReminderState extends State<EditReminder> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  PayMode1 payMode1 = PayMode1.cash;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedStartTime;
  TimeOfDay selectedEndTime;
  SharedPref sharedPref = SharedPref();
  LoginResponse1 loginResponse;

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

  // DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();

  List<KeyvalueModel> days=[];

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    EditReminder.timeDayModel = null;
    EditReminder.blockModel = null;
    EditReminder.dosageModel = null;
    textEditingController[0].text = widget.type;
    getList();
    //getStaticValue();
  }

 /* getStaticValue(){
    Event event=widget.model.selectEvent;
    textEditingController[0].text=event.title;
    textEditingController[1].text=event.description.split(", ")[0];
    EditReminder.dosageModel=KeyvalueModel(key: event.description.split(", ")[0].replaceAll(" dosage", ''),name: event.description.split(", ")[1].replaceAll(" dosage", ''));
  }
*/
  getList(){
    for(int i=1;i<=31;i++){
      days.add(KeyvalueModel(key: i,name: i.toString()));
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
    //recurrenceRule.
    // event.start=DateTime.now().add(Duration(minutes: 15));
    // event.end=DateTime.now().add(Duration(minutes: 35));
    event.title = widget.type;
    event.description = descrption +
        " " +
        EditReminder.dosageModel.name +
        " dosage " +
        textEditingController[5].text;
    event.location = "Home";
    event.allDay = false;
    // event.recurrenceRule=recurrenceRule;
    //event.n="Home";
    // event.url=Uri(path: "https://pub.dev/packages/device_calendar/versions");
    // event.recurrenceRule=RecurrenceRange.noEndDate;
    event.reminders = [cal.Reminder(minutes: 20)];
    // event.

    for (int i = 0; i < int.tryParse(EditReminder.timeDayModel.name); i++) {
      event.start = DateTime(
          selectedStartDate.year,
          selectedStartDate.month,
          selectedStartDate.day,
          actualTime[i].hour,
          actualTime[i].minute);
      event.end = DateTime(selectedEndDate.year, selectedEndDate.month,
          selectedEndDate.day, actualTime[i].hour, actualTime[i].minute);

      final createEventResult =
          await _deviceCalendarPlugin.createOrUpdateEvent(event);
      if (createEventResult.isSuccess &&
          (createEventResult.data?.isNotEmpty ?? false)) {
        AppData.showInSnackDone(context, "Added done");
      } else {
        AppData.showInSnackBar(context, "Something went wrong");
      }
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
        title: Text("Edit Reminder"),
      ),
      body: SingleChildScrollView(
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
                  "Dosage", "dosage", dosageList, (KeyvalueModel data) {
                setState(() {
                  EditReminder.dosageModel = data;
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
                  'How Many Times a Day',
                  // MyLocalizations.of(context).text("SELECT_GENDER"),
                  "genderSignup",
                  districtList, (KeyvalueModel data) {
                setState(() {
                  EditReminder.timeDayModel = data;
                  timePicker.forEach((element) {
                    element.text = "";
                  });
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
            (EditReminder.timeDayModel != null)
                ? Column(
                    children: [
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
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              int.tryParse(EditReminder.timeDayModel.name),
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
            /* Padding(
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
            ),*/
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
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Start Date :',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    // SizedBox(width: 75),
                    SizedBox(width: 16),
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
           /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: DropDown.staticDropdown2(
                  "Days", "genderSignup", days, (KeyvalueModel data) {
                setState(() {
                  SetReminder.dosageModel = data;
                });
              }),
            ),
            SizedBox(height: 5),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Add Doctor Instruction",
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
    //setReminder();
    //setReminder1(textEditingController[1].text);
    // _formKey.currentState.validate();
    if (textEditingController[0].text == "" ||
        textEditingController[0].text == null) {
      AppData.showInSnackBar(context, "Please enter type");
    } else if (textEditingController[1].text == "" ||
        textEditingController[1].text == null) {
      AppData.showInSnackBar(context, "Please enter title");
    } else if (EditReminder.dosageModel == null) {
      AppData.showInSnackBar(context, "Please Select Dosage");
    } else if (EditReminder.timeDayModel == null) {
      AppData.showInSnackBar(context, "Please Select How Many Times");
    } else if (stime.text == "" || stime.text == null) {
      AppData.showInSnackBar(context, "Please enter start time");
    } else if (endtime.text == "" || endtime.text == null) {
      AppData.showInSnackBar(context, "Please enter end time");
    } else if (stdob.text == "" || stdob.text == null) {
      AppData.showInSnackBar(context, "Please enter Start Date");
    } else if (endate.text == "" || endate.text == null) {
      AppData.showInSnackBar(context, "Please enter End Date");
    } else {
      // _formKey.currentState.save();
      // Navigator.pop(context);
      bool isAllAccept = true;
      for (int i = 0; i < int.tryParse(EditReminder.timeDayModel.name); i++) {
        if (timePicker[i].text == "") {
          isAllAccept = false;
        }
      }
      if (isAllAccept) {
       /* setReminder1(
          textEditingController[1].text,
        );*/
      } else {
        AppData.showInSnackBar(context, "Please input timings");
      }
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
                hintText: "Time",
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
    // if (timeOfDay != null && timeOfDay != selectedTime) {
    setState(() {
      // selectedTime = timeOfDay;
      // selectedStartTime = timeOfDay;
      actualTime[v] = timeOfDay;
      timePicker[v].text = formatTimeOfDay(timeOfDay);
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
}
