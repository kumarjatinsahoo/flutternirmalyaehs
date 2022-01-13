import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';


class PreventiveHealthcareList extends StatefulWidget {
  MainModel model;
  PreventiveHealthcareList({Key key, this.model}) : super(key: key);

  @override
  _PreventiveHealthcareListState createState() => _PreventiveHealthcareListState();
}

class _PreventiveHealthcareListState extends State<PreventiveHealthcareList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preventive Health Care List"),
      ),
    );
  }
}
