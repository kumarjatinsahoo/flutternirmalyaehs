import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:intl/intl.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
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

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];

  final df = new DateFormat('dd/MM/yyyy');
  DateTime _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Choo choo",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.train),
          onPressed: () {},
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            heroTag: "airplane",
            backgroundColor: Colors.greenAccent,
            mini: true,
            child: Icon(Icons.airplanemode_active))));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            heroTag: "directions",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.directions_car))));
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(Duration(days: 5));
  }

  var childButtons = List<UnicornButton>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Row(
          children: [Text("Medicine Reminder"), Spacer(), Icon(Icons.search)],
        ),
      ),
      floatingActionButton: UnicornDialer(
           backgroundColor: Colors.transparent,
          // parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        children: [
          CalendarTimeline(
            //showYears: true,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
            leftMargin: 20,
            monthColor: Colors.white70,
            dayColor: Colors.teal[200],
            dayNameColor: Color(0xFF333A47),
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en',
          ),
          SizedBox(height: 100),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/setreminder');
            },
            child: Text(
              "Set Reminder for Medicines,Water Intake or any other Medical Needs",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
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
