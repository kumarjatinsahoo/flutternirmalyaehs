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

class GovetListPage7 extends StatefulWidget {
  MainModel model;
  static KeyvalueModel labModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  GovetListPage7({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _AboutUs createState() => _AboutUs();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _AboutUs extends State<GovetListPage7> {
  void initState() {
    // TODO: implement initState
    super.initState();
    GovetListPage7.labModel = null;
    setState(() {});
  }

  Widget showText(msg){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("- ",style: TextStyle(color: Colors.black, fontSize: 16),),Expanded(child: Text(msg,style: TextStyle(color: Colors.black, fontSize: 16),))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Government Schemes List'),
          backgroundColor: AppData.kPrimaryColor,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    "Navsanjivani Yojana for Rural Maharashtra",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    "Objective: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      AppData.govtschem7,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Applicable to:  ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      AppData.govtschem71,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Benefits Provided: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Matrutva Anudan Yojana : ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    AppData.govtschem72,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Bharari Pathak Yojana:- ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    AppData.govtschem73,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    " Dai Meetings:- ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    AppData.govtschem74,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    " Pre Monsoon Activities:-  ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    AppData.govtschem75,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Required Documents:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      AppData.govtschem22,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Contact Details:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      AppData.govtschem76,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }
}
