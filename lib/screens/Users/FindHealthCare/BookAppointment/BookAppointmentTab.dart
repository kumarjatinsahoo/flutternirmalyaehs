import 'package:flutter/gestures.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Users/FindHealthCare/BookAppointment/BookAppointmentPage.dart';
import 'package:user/screens/Users/FindHealthCare/BookAppointment/DoctorconsultationPage.dart';
class BookAppointmentTab extends StatefulWidget {
  final MainModel model;

  BookAppointmentTab({Key key, this.model}) : super(key: key);

  @override
  _BookAppointmentTab createState() => _BookAppointmentTab();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _BookAppointmentTab extends State<BookAppointmentTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
              text:"Registered Doctor",

            ),
            Tab(
              text:"Other Doctor",
            ),
          ],
        ),
        //title: Text(widget.model.saloonName),
      ),
        body: TabBarView(
          children: [
            DoctorconsultationPage(model:widget.model,),
            BookAppointmentPage(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
