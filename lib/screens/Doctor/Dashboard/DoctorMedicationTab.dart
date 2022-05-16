import 'package:flutter/gestures.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Doctor/Dashboard/DoctorMedicationlist.dart';
import 'package:user/screens/Doctor/Dashboard/DoctorTestlist.dart';

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
  LoginResponse1 loginResponse;
  String userid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text(MyLocalizations.of(context).text("MEDICATION")),

              //Spacer(),
            /*  InkWell(
                  onTap: (){
                     userid=widget.model.appointmentlist.userid;
                    Navigator.pushNamed(context, "/showemr");
                  },
                  child: Text('Show Emr',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
              ),*/

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
                text:MyLocalizations.of(context).text("MEDICATION"),

              ),
              Tab(
                text:MyLocalizations.of(context).text("TEST"),
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            Medicationlist(model:widget.model,),
            DoctorTestlist(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
