import 'package:flutter/gestures.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Users/MyMedicalRecord/Medication/UserMedicineList1.dart';
import 'UserTestList1.dart';
class UserMedicineTab1 extends StatefulWidget {
  final MainModel model;

  UserMedicineTab1({Key key, this.model}) : super(key: key);

  @override
  _UserMedicineList createState() => _UserMedicineList();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _UserMedicineList extends State<UserMedicineTab1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(MyLocalizations.of(context).text("MEDICATION")),
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
                text:MyLocalizations.of(context).text("MEDICINE"),

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
            UserMedicineList1(model:widget.model,),
            UserTestList1(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
