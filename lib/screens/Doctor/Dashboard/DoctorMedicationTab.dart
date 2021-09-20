import 'package:flutter/gestures.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Doctor/Dashboard/Medicationlist.dart';

import 'DoctorAppointment_Requested.dart';
import 'DoctorAppointment_Confirmed.dart';
import 'DoctorAppointment_Cancel.dart';
import 'DoctorAppointment_Treated.dart';

class DoctorMedicationTab extends StatefulWidget {
  final MainModel model;

  DoctorMedicationTab({Key key, this.model}) : super(key: key);

  @override
  _DoctorMedicationTabState createState() => _DoctorMedicationTabState();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _DoctorMedicationTabState extends State<DoctorMedicationTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medication'),
          backgroundColor: AppData.kPrimaryColor,
          actions: <Widget>[

          ],

          bottom: TabBar(
            //indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppData.kPrimaryRedColor,
            //isScrollable: true,
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Tab(
                text:"Medication",

              ),
              Tab(
                text:"Test",
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            Medicationlist(model:widget.model,),
            Medicationlist(model:widget.model,),

          ],
        ),
      ),
    );
  }
}
