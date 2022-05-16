import 'package:flutter/gestures.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Pharmacists/screens/ConfirmedOrders.dart';
import 'package:user/screens/Users/Medication/UserMedicineList.dart';
import 'package:user/screens/Users/Medication/UserTestList.dart';
import 'package:user/screens/walkin_labrotry/Screen/ConfirmOrdersLab.dart';

import 'CancelledOrdersLab.dart';
class OrdersTabLab extends StatefulWidget {
  final MainModel model;

  OrdersTabLab({Key key, this.model}) : super(key: key);

  @override
  _UserMedicineList createState() => _UserMedicineList();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _UserMedicineList extends State<OrdersTabLab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(MyLocalizations.of(context).text("ORDER_DETAILS")),
          centerTitle: true,
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
                text:MyLocalizations.of(context).text("CONFIRMED_ORDER"),
              ),
              Tab(
                text:MyLocalizations.of(context).text("CANCELLED_ORDER"),
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            ConfirmOrdersLab(model:widget.model,),
            CancelledOrdersLab(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
