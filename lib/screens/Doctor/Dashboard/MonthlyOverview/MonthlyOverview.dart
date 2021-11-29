import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
class MonthlyOverview extends StatefulWidget {
  MainModel model;
  MonthlyOverview({Key key, this.model,}) :
        super(key: key);

  @override
  State<StatefulWidget> createState() => _MonthlyOverview();
}

class _MonthlyOverview extends State<MonthlyOverview> {

  DateTime selectedDate = DateTime.now();
 // apnt.AppointmentlistModel appointmentlistModel;
  //LoginResponse1 loginResponse;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  bool isdata = false;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();


  @override
  void initState() {
    super.initState();
  }
  leftArrow() {
    setState(() {
      selectedDate = selectedDate.subtract(Duration(days: 1));
      fromThis_.value = TextEditingValue(text: df.format(selectedDate));
      selectedDatestr = df.format(selectedDate).toString();
     // callAPI(selectedDatestr);
    });
  }

  rightArrow() {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: 1));
      fromThis_.value = TextEditingValue(text: df.format(selectedDate));
      selectedDatestr = df.format(selectedDate).toString();
      //callAPI(selectedDatestr);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          leftArrow();
                        },
                        child: Icon(
                          CupertinoIcons.arrow_left_circle,
                          size: 38,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appointdate(),
                        ],
                      ),
                      Spacer(),

                      InkWell(
                        onTap: () {
                          rightArrow();
                        },
                        child: Icon(
                          CupertinoIcons.arrow_right_circle,
                          size: 38,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget appointdate() {
    return Container(
      height: 40,
      width: 190,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: InkWell(
        onTap: () {
          print("Click done");
          _selectDate(context);
        },
        child: AbsorbPointer(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              autofocus: false,
              controller: fromThis_,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'From this',
                //labelText: 'Booking Date',
                alignLabelWithHint: false,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
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
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
      /*.add(Duration(days: 60))*/); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(selectedDate));
        selectedDatestr = df.format(selectedDate).toString();
        //callAPI(selectedDatestr);
      });
  }
}
