import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/MedicineReminder.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class SetReminderOther extends StatefulWidget {
 MainModel model;
 SetReminderOther({Key key, this.model}) : super(key: key);

  @override
  _SetReminderOtherState createState() => _SetReminderOtherState();
}

class _SetReminderOtherState extends State<SetReminderOther> {
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }
 

  String _setTime, _setDate;
  String _setTime2, _setTime3;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedTime2 = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
   TextEditingController _timeController2 = TextEditingController();
    TextEditingController _timeController3 = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  Future<Null> _selectTime2(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
    );
    if (picked != null)
      setState(() {
        selectedTime2 = picked;
        _hour = selectedTime2.hour.toString();
        _minute = selectedTime2.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController2.text = _time;
        _timeController2.text = formatDate(
            DateTime(2019, 08, 1, selectedTime2.hour, selectedTime2.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

   List<KeyvalueModel> schemeList = [
    KeyvalueModel(name: "Scheme1", key: "1"),
     KeyvalueModel(name: "Scheme2", key: "2"),
    KeyvalueModel(name: "Scheme3", key: "3"),
  ];
   List<KeyvalueModel> timesList = [
    KeyvalueModel(name: "1", key: "1"),
    KeyvalueModel(name: "2", key: "2"),
    KeyvalueModel(name: "3", key: "3"),
    KeyvalueModel(name: "4", key: "4"),
    KeyvalueModel(name: "5", key: "5"),
  ];

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
        _timeController2.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    dateTime = DateFormat.yMd().format(DateTime.now());
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                        )),
                    Text(
                      'Set Reminder',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Type',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // SizedBox(height: 5),
                     DropDown.staticDropdown2(
                                MyLocalizations.of(context).text("SELECT_TYPE"),
                                "type",
                                schemeList, (KeyvalueModel data) {
                              setState(() {
                                
                              });
                            }),
                      SizedBox(
                        height: 15,
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Title',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Please Enter Title',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),                     
                     
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Reminder Time',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'How Many Times a Day',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                   
                     DropDown.staticDropdown2(
                                "1",
                                "times",
                                timesList, (KeyvalueModel data) {
                              setState(() {
                                
                              });
                            }),

                     SizedBox(
                        height: 15,
                      ),
                      Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                                    'Timings',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                      ),
                                SizedBox(height: 5,),
                      Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: 
                              InkWell(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: TextFormField(
                          onSaved: (String val) {
                            _setTime = val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController,
                         
                        ),
                    ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: 
                              InkWell(
                        onTap: () {
                          _selectTime2(context);
                        },
                        child: TextFormField(
                          onSaved: (String val) {
                            _setTime2= val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController2,
                         
                        ),
                    ),
                            ),
                            SizedBox(width: 10,),
                             Expanded(
                              child: 
                              InkWell(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: TextFormField(
                          onSaved: (String val) {
                            _setTime3 = val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController,
                         
                        ),
                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                         child: Text(
                                    'Frequency',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                       ),
                        SizedBox(height: 5,),
    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Daily',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Weekly',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        new Radio(
                          value: 2,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Monthly',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),

                    SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start Date',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: TextFormField(
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _dateController,
                                      onSaved: (String val) {
                                        _setDate = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'End Date',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: TextFormField(
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _dateController,
                                      onSaved: (String val) {
                                        _setDate = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                       SizedBox(
                        height: 15,
                      ),
                       Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                         child: Text(
                                    'Add Instruction',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                       ),
                        SizedBox(height: 5,),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10),
                           child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Add Doctor Instructions',
                        ),
                      ),
                         ),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "set reminder".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        Navigator.pushNamed(context, "/medicinereminderother");
        //}
       
      },
    );
  }
}
