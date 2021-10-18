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

class GovetListPage6 extends StatefulWidget {
  MainModel model;
  static KeyvalueModel labModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  GovetListPage6({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _AboutUs createState() => _AboutUs();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _AboutUs extends State<GovetListPage6> {
  void initState() {
    // TODO: implement initState
    super.initState();
    GovetListPage6.labModel = null;
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
                    "National Programme for Health Care of the Elderly NPHCE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
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
                      AppData.govtschem6,
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
                      AppData.govtschem61,
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
                    "Sub-Centre  ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                showText("Health Education related to healthy ageing"),
                showText("Domiciliary visits for attention and care to home bound/ bed ridden elderly persons and provide training to the family care providers in look in after the disabled elderly persons."),
                showText("Arrange for suitable callipers and supportive devices from the PHC to the elderly disabled person stomake them ambulatory."),
                showText("Linkage with other support groups and day care centres etc. operational in the area"),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Primary Health Centre  :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                showText("Weekly geriatric clinic run by a trained Medical Officer"),
                showText("Maintain record of the Elderly using standard format during their first visit"),
                showText("Conducting a routine health assessment of the elderly persons based on simple clinical examination relating to eye, BP, bloodsugar,etc."),
                showText("Provision of medicines and proper advice on chronic ailments"),
                showText("Public awareness on promotional, preventive and rehabilitative aspects of geriatrics during health and village sanitation day/camps. Referral for diseases needing further investigation and treatment, to Community Health Centre or the District Hospital as per need."),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Community Health Centre  :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                showText("First Referral Unit(FRU)for the Elderly from PHCs and below."),
                showText("Geriatric Clinic for the elderly persons twice a week."),
                showText("Rehabilitation Unit for physiotherapy and counselling"),
                showText("Domiciliary visits by the rehabilitation worker for bed ridden elderly and counselling of the family member, son their home-based care."),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      AppData.govtschem62,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "District Hospital  :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),

                showText("Geriatric Clinic for regular dedicated OPD services to the Elderly."),
                showText("Facilities for laboratory investigations for diagnosis and provision of medicines for geriatric medical and health problems"),
                showText("Ten-bedded Geriatric Ward for in-patient care of the Elderly"),
                showText("Existing specialties like General Medicine; Orthopedics, Ophthalmology; ENT services etc.will provide services needed by elderly patients."),
                showText("Provide services for the elderly patients referred by the CHCs/PHCs etc."),
                showText("Conducting camps for Geriatric Services in PHCs/CHCs and other sites Referral services for severe cases to tertiary level hospitals"),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Regional Geriatric Centre  :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                showText("Geriatric Clinic (Specialized OPD for the Elderly)"),
                showText("30-bedded Geriatric Ward for in-patient care and dedicated beds for the elderly patients in the various specialties viz. Surgery, Orthopedics, Psychiatry, Urology, Ophthalmology, Neurologyetc."),
                showText("Laboratory investigation required for elderly with a special sample collection entre in the OPD block."),
                showText("Tertiary health care to the cases referred from medical colleges, district hospital sand below."),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: Text(
                    "Required Documents :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
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
                    "Contact Details :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      AppData.govtschem63,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      AppData.govtschem64,
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
