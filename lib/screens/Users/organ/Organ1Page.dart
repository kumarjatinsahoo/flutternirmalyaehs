import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:geolocator/geolocator.dart';
import 'package:user/models/DocterMedicationlistModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MedicinModel.dart';
import 'package:user/models/MedicineListModel.dart' as medicine;
import 'package:user/models/ResultsServer.dart';
import 'package:user/models/UserListModel.dart' as test;
import 'package:user/models/UserListModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/widgets/text_field_address.dart';

class Organ1Page extends StatefulWidget {
  MainModel model;
  static KeyvalueModel labModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  Organ1Page({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _AboutUs createState() => _AboutUs();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _AboutUs extends State<Organ1Page> {

  void initState() {
    // TODO: implement initState
    super.initState();
    Organ1Page.labModel = null;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Organ Donation'),
            backgroundColor: AppData.kPrimaryColor,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 /* Container(
                    height: 150,
                    width: 500,
                    child: Image.asset(
                      "assets/bg_img.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),*/
                  //
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 20),
                    child: Text("Organ Donation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(child: Text(AppData.organ1,style:TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.justify,),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 5),
                    child: Text("What is Organ Donation?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(child: Text(AppData.organ11,style:TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.justify,),),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

}