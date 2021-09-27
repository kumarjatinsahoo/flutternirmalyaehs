import 'package:flutter/gestures.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/models/LoginResponse1.dart' as session;
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'ChemistsPage.dart';

import 'ChemistsOngooglePage.dart';



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
  session.LoginResponse1 loginResponse1;
  String longi,lati,city,addr,healthpro,type,healthproname,typename;
  @override
  void initState() {
    super.initState();
    loginResponse1=widget.model.loginResponse1;
    longi = widget.model.longi;
    lati = widget.model.lati;
    city = widget.model.city;
    addr = widget.model.addr;
    healthpro = widget.model.healthpro;
    healthproname = widget.model.healthproname;
    type=widget.model.type;
    typename=widget.model.typename;

    //callAPI();
  }
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
                text: "Our service",

              ),
              Tab(
                text: "On google",
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            ChemistsPage(model:widget.model),
            ChemistsOngooglePage(model:widget.model),

          ],
        ),
      ),
    );
  }
}
