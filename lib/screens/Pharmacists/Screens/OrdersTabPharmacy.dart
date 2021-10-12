import 'package:flutter/gestures.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Pharmacists/screens/ConfirmOrdersPharmacy.dart';

import 'CancelledOrdersPharmacy.dart';

class OrdersTabPharmacy extends StatefulWidget {
  final MainModel model;

  OrdersTabPharmacy({Key key, this.model}) : super(key: key);

  @override
  _UserMedicineList createState() => _UserMedicineList();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _UserMedicineList extends State<OrdersTabPharmacy> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
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
                text:"Confirmed Orders",
              ),
              Tab(
                text:"Cancelled Orders",
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            ConfirmOrdersPharmacy(model:widget.model,),
            CancelledOrdersPharmacy(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
