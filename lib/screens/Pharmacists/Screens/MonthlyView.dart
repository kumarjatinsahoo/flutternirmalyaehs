import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthlyView extends StatefulWidget {
  final MainModel model;

  const MonthlyView({Key key, this.model}) : super(key: key);

  @override
  _MonthlyViewState createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  Widget _showNeedHelpButton() {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)))),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.call,
                size: 16,
              ),
              SizedBox(
                width: 2,
              ),
              Text('Call'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).text("MONTHLY_OVERVIEW"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: SfCalendar(
                view: CalendarView.month,
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),
              )),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Done')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Pending')
                ],
              ),
            ),
            Divider(),
            Container(
              height: size.height * 0.35,
              child: Image.asset(
                'assets/piechart.png',
                fit: BoxFit.cover,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
