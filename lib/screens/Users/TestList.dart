import 'package:flutter/gestures.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Doctor/Dashboard/Medicationlist.dart';
import 'package:user/screens/Users/MedicineList.dart';


class TestList extends StatefulWidget {
  final MainModel model;

  TestList({Key key, this.model}) : super(key: key);

  @override
  _TestList createState() => _TestList();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _TestList extends State<TestList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(


    );
  }
}
