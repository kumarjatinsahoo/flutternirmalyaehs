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

class GovetListPage2 extends StatefulWidget {
  MainModel model;
  static KeyvalueModel labModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  GovetListPage2({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _AboutUs createState() => _AboutUs();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _AboutUs extends State<GovetListPage2> {
  void initState() {
    // TODO: implement initState
    super.initState();
    GovetListPage2.labModel = null;
    setState(() {});
  }

  Widget showText(msg) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "- ",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Expanded(
              child: Text(
            msg,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ))
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
                    "Janani Shishu Suraksha Karyakram",
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
                      AppData.govtschem2,
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
                      AppData.govtschem21,
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
                    "1.	Entitlement for Pregnant/ Delivered Women:",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                showText("Free & zero expense Delivery & Caesarean section."),
                showText("Free drugs & consumables."),
                showText(
                    "Free essential diagnostics (blood, urine tests & ultra Sonography etc.)"),
                showText(
                    "Free diet during stay in the health institutions. (up to 3 days for normal delivery & 7days for caesarean section.)"),
                showText(" Free provision of blood."),
                showText(
                    "Free transport from Home to Health Institutions, between facilities in case of referral & drop back from institutions to home."),
                showText("Exemption from all kinds of user charges."),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "2.	Entitlement for Sick Neonates till 30 days after birth:",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                showText("Free & zero expense treatment."),
                showText("Free drugs & consumables."),
                showText("Free essential diagnostics"),
                showText("Free provision of blood."),
                showText(
                    "Free transport from Home to Health Institutions, between facilities in case of referral & drop back from institutions to home."),
                showText("Exemption from all kinds of user charges."),
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
                    "Contact Details: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      AppData.govtschem23,
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
