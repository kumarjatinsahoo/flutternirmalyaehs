import 'package:flutter/gestures.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/ChemistsPage.dart';



class ChemistsTabview extends StatefulWidget {
  final MainModel model;

  ChemistsTabview({Key key, this.model}) : super(key: key);

  @override
  _ChemistsTabviewState createState() => _ChemistsTabviewState();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _ChemistsTabviewState extends State<ChemistsTabview> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chemists'),
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
                text: "Location-wise",

              ),
              Tab(
                text: "City-wise",
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            ChemistsPage(model:widget.model),
            ChemistsPage(model:widget.model),

          ],
        ),
      ),
    );
  }
}
