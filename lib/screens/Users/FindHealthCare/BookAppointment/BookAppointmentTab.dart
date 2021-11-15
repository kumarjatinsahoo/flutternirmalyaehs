import 'package:flutter/gestures.dart';
import 'package:user/localization/localizations.dart';
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
        title: Text(MyLocalizations.of(context).text("BOOK_APPOINTMENT")),
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
              text:MyLocalizations.of(context).text("REGISTERED_DOCTOR"),

            ),
            Tab(
              text:MyLocalizations.of(context).text("OTHER_DOCTOR"),
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
