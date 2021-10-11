import 'package:flutter/gestures.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Users/FindHealthCare/BookAppointment/BookAppointmentPage.dart';
import 'package:user/screens/Users/FindHealthCare/BookAppointment/DoctorconsultationPage.dart';
import 'package:user/screens/Users/FindHealthCare/MyAppointment/UserMyAppointments.dart';
import 'package:user/screens/Users/MyMedicalRecord/Medication/UserMedicineList.dart';
import 'package:user/screens/Users/MyMedicalRecord/Medication/UserTestList.dart';
class MyAppointmentTab extends StatefulWidget {
  final MainModel model;

  MyAppointmentTab({Key key, this.model}) : super(key: key);

  @override
  _MyAppointmentTab createState() => _MyAppointmentTab();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _MyAppointmentTab extends State<MyAppointmentTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Appointment'),
          backgroundColor: AppData.kPrimaryColor,
          actions: <Widget>[

          ],

          bottom: TabBar(
            //indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppData.white,
            //isScrollable: true,
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Tab(
                text:"Doctor Appointment",

              ),
              Tab(
                text:"Other Appointment",
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            DoctorconsultationPage(model:widget.model,),
            UserAppointments(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
