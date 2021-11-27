import 'package:flutter/gestures.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Users/Medication/UserMedicineList.dart';
import 'package:user/screens/Users/Medication/UserTestList.dart';
class UserMedicineTab extends StatefulWidget {
  final MainModel model;

  UserMedicineTab({Key key, this.model}) : super(key: key);

  @override
  _UserMedicineList createState() => _UserMedicineList();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _UserMedicineList extends State<UserMedicineTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Medication'),
          backgroundColor: AppData.kPrimaryColor,
          actions: <Widget>[

          ],

          bottom: TabBar(
            //indicatorSize: TabBarIndicatorSize.label,
            indicatorColor:Colors.white,
            //isScrollable: true,
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Tab(
                text:"Medicine",

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
            UserMedicineList(model:widget.model,),
            UserTestList(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
