import 'dart:convert';
import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:date_format/date_format.dart';
// import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MedicineReminderDTO1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Users/MedicineReminder/SetReminder.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class MedicineReminder extends StatefulWidget {
  MainModel model;

  MedicineReminder({Key key, this.model}) : super(key: key);

  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  var selectedMinValue;
  TextEditingController dob = TextEditingController();
MedicineReminderDTO1 medicineReminderDTO1;

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];

  final df = new DateFormat('dd/MM/yyyy');
  final df1 = new DateFormat('dd-MM-yyyy');
  DateTime _selectedDate;
  String dateData;
  var childButtons = List<UnicornButton>();
  // DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();
  // List<Calendar> _calendars;
  // List<Event> _calendarEvents;

  LoginResponse1 loginResponse;

  @override
  void initState() {
    // TODO: implement initState
    dateData=df1.format(new DateTime.now());
    super.initState();

    // _retrieveCalendars();
    loginResponse = widget.model.loginResponse1;

    // setState(() {

      callApi(dateData);
      // deleteApi();
    // });
    // _retrieveCalendarEvents();
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Medicine",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: AppData.kPrimaryBlueColor,
          mini: true,
          child: Icon(
            Icons.medical_services_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigator.pushNamed(context, '/setreminder');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SetReminder(model: widget.model, type: "Medicine"),
              ),
            );
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Other",
        currentButton: FloatingActionButton(
          heroTag: "other",
          backgroundColor: AppData.kPrimaryRedColor,
          mini: true,
          onPressed: () {
            // Navigator.pushNamed(context, '/setreminder');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SetReminder(model: widget.model, type: "Other"),
              ),
            );
          },
          child: Icon(Icons.task, color: Colors.white),
        )));

    /*     heroTag: "directions",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.directions_car))
    )
    );*/
    _resetSelectedDate();
  }

  callApi(String date){
    medicineReminderDTO1=null;
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.REMINDER_LIST(loginResponse.body.user, date),
        token: widget.model.token,
        fun: (Map<String, dynamic> map){
          print("Fetch Response is>>>>" + JsonEncoder().convert(map));
      setState(() {
        if (map[Const.CODE] == Const.SUCCESS) {
          medicineReminderDTO1 = MedicineReminderDTO1.fromJson(map);
        }/*else{
          String msg = map[Const.MESSAGE];
          AppData.showInSnackBar(context, msg);
        }*/
      });
        }
    );
  }

  deleteApi(String id){
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.DELETE_REMINDER +id,
        token: widget.model.token,
        fun: (Map<String,dynamic> map){
          log("DElete api"+jsonEncode(map));
          // setState(() {
            if(map[Const.STATUS1] == Const.SUCCESS){
              callApi(dateData);
            }
          // });
        });
  }

  void _resetSelectedDate() {
    // _selectedDate = DateTime.now().add(Duration(days: 5));
    _selectedDate = DateTime.now();
    // _retrieveCalendarEvents();
  }

  /*void _retrieveCalendars() async {
    //Retrieve user's calendars from mobile device
    //Request permissions first if they haven't been granted
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
          return;
        }
      }

      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      setState(() {
        _calendars = calendarsResult?.data;
      });
    } catch (e) {
      print(e);
    }
  }*/

 /* Future _retrieveCalendarEvents() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
          return;
        }
      }

      if (loginResponse.body.calenderId != null) {
        DateTime startDate = DateTime(
            _selectedDate.year, _selectedDate.month, _selectedDate.day, 0, 0);
        DateTime endDate = DateTime(
            _selectedDate.year, _selectedDate.month, _selectedDate.day, 23, 59);
        // DateTime endDate = DateTime.now().add(Duration(days: 30));
        var calendarEventsResult = await _deviceCalendarPlugin.retrieveEvents(
            loginResponse.body.calenderId,
            RetrieveEventsParams(startDate: startDate, endDate: endDate));
        setState(() {
          _calendarEvents = calendarEventsResult.data as List<Event>;
        });
      } else {}
    } on PlatformException catch (e) {
      print(e);
      AppData.showInSnackDone(context, "Please accept permission");
    }
  }*/

  /*Future _deleteEvent(String eventId) async {
    try {
      var calendarEventsResult = await _deviceCalendarPlugin.deleteEvent(
          loginResponse.body.calenderId, eventId);
      if (calendarEventsResult.data) {
        AppData.showInSnackDone(context, "Deleted Successfully");
        _retrieveCalendarEvents();
      } else {
        AppData.showInSnackBar(context, "Something went wrong");
      }
    } on PlatformException catch (e) {
      print(e);
      AppData.showInSnackDone(context, "Something went wrong");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        centerTitle: true,
        title: Text(MyLocalizations.of(context).text("MEDICINE_REMINDER")),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UnicornDialer(
            backgroundColor: Colors.transparent,
            // parentButtonBackground: Colors.redAccent,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: childButtons),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        children: [
          CalendarTimeline(
            //showYears: true,
            initialDate: _selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
                // _retrieveCalendarEvents();
                dateData=df1.format(date);
                callApi(dateData);
              });
            },
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.teal[200],
            dayNameColor: Color(0xFF333A47),
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            //selectableDayPredicate: (date) => date.day != 23,
            locale: 'en',
          ),
          //SizedBox(height: 100),
          (medicineReminderDTO1 == null || medicineReminderDTO1.body.isEmpty)
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, '/setreminder');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(MyLocalizations.of(context).text("SET_MEDICINE_WATER"),
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (c, i) {
                      return ListTile(
                          contentPadding:EdgeInsets.only(bottom: 8,left: 12),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(MyLocalizations.of(context).text("MEDICINE_NAME"))),
                                SizedBox(width: 15),
                                Expanded(
                                    child: Text(medicineReminderDTO1.body[i].medName)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(MyLocalizations.of(context).text("DOSAGE"))),
                                SizedBox(width: 15),
                                Expanded(
                                    child: Text(medicineReminderDTO1.body[i].medDosage)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(MyLocalizations.of(context).text("DOSAGE_TIME"))),
                                SizedBox(width: 15),
                                Expanded(
                                    child: Text(medicineReminderDTO1.body[i].dosageTime??"")),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          // widget.model.title = _calendars[i].id;
                         // Navigator.pushNamed(context, '/setreminder');
                        },
                        trailing: SizedBox(
                          height: 30,
                          width: 30,
                          child: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                              size: 26,
                            ),
                            padding: EdgeInsets.zero,
                            onSelected: (value) {
                              switch (value) {
                                case 1:
                                  // widget.model.selectEvent = _calendarEvents[i];
                                  Navigator.pushNamed(context, '/editReminder');
                                  break;
                                case 2:
                                  deleteApi(medicineReminderDTO1.body[i].id);
                                  break;
                                default:
                                  AppData.showInSnackBar(context, "Hey1");
                              }
                            },
                            //elevation: 50,
                            itemBuilder: (context) => [
                            /*  PopupMenuItem(
                                child: Text("EDIT"),
                                value: 1,
                                height: 30,
                              ),*/
                              PopupMenuItem(
                                child: Text(MyLocalizations.of(context).text("DELETE")),
                                value: 2,
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: medicineReminderDTO1.body.length,
                    shrinkWrap: true,
                  ),
                )
        ],
      ),
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
      },
    );
  }

// Widget dobBirth() {
//   return Padding(
//     //padding: const EdgeInsets.symmetric(horizontal: 8),
//     padding: const EdgeInsets.symmetric(horizontal: 8),
//     child: GestureDetector(
//       onTap: () => _selectDate(context),
//       child: AbsorbPointer(
//         child: Container(
//           // margin: EdgeInsets.symmetric(vertical: 10),
//           height: 50,
//           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//           // width: size.width * 0.8,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(color: Colors.black, width: 0.3)),
//           child: TextFormField(
//             //focusNode: fnode4,
//             enabled:  false,
//             controller: dob,
//             textAlignVertical: TextAlignVertical.center,
//             keyboardType: TextInputType.datetime,
//             textAlign: TextAlign.left,
//             decoration: InputDecoration(
//               hintText: "Date Of Birth",
//               border: InputBorder.none,
//               //contentPadding: EdgeInsets.symmetric(vertical: 10),
//               prefixIcon: Icon(
//                 Icons.calendar_today,
//                 size: 18,
//                 color: AppData.kPrimaryColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
//
// Future<Null> _selectDate(BuildContext context) async {
//   final DateTime picked = await showDatePicker(
//       context: context,
//       locale: Locale("en"),
//       /*initialDate: DateTime.now(),
//       firstDate: DateTime.now().subtract(Duration(days: 100)),
//       lastDate: DateTime.now(),*/
//       initialDate: DateTime.now().subtract(Duration(days: 6570)),
//       firstDate: DateTime(1901, 1),
//       lastDate: DateTime.now()
//           .subtract(Duration(days: 6570))); //18 years is 6570 days
//   // if (picked != null && picked != selectedDate)
//     setState(() {
//       // selectedDate = picked;
//       // error[5] = false;
//       textEditingController[5].value =
//           TextEditingValue(text: df.format(picked));
//     });
// }

}
