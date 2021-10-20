import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Users/GenericMedicine/GovtSchemesList.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class GovtSchemes extends StatefulWidget {
  MainModel model;

  GovtSchemes({Key key, this.model}) : super(key: key);

  @override
  _GovtSchemesState createState() => _GovtSchemesState();
}

class _GovtSchemesState extends State<GovtSchemes> {
  var selectedMinValue;
  List<KeyvalueModel> countryList = [
    KeyvalueModel(name: "India", key: "1"),
    // KeyvalueModel(name: "Bhubaneswar", key: "2"),
    // KeyvalueModel(name: "Puri", key: "3"),
  ];
  List<KeyvalueModel> stateList = [
    KeyvalueModel(name: "Odisha", key: "1"),
    KeyvalueModel(name: "UP", key: "2"),
    KeyvalueModel(name: "AP", key: "3"),
  ];
  List<KeyvalueModel> schemeList = [
    KeyvalueModel(name: "Scheme1", key: "1"),
    KeyvalueModel(name: "Scheme2", key: "2"),
    KeyvalueModel(name: "Scheme3", key: "3"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppData.kPrimaryColor,
            title: Text("Government Schemes"),
            centerTitle: true,
          ),
      body: Container(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Find Health Schemes',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 30),
                  DropDown.staticDropdown2('India', "country", countryList,
                      (KeyvalueModel data) {
                    setState(() {});
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  DropDown.staticDropdown2(
                      MyLocalizations.of(context).text("SELECT_STATE"),
                      "state",
                      stateList, (KeyvalueModel data) {
                    setState(() {});
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  DropDown.staticDropdown2(
                      MyLocalizations.of(context).text("SELECT_SCHEME"),
                      "scheme",
                      schemeList, (KeyvalueModel data) {
                    setState(() {});
                  }),
                  SizedBox(
                    height: 60,
                  ),
                  _submitButton(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

       // Navigator.pushNamed(context, "/govtschemeslist");
        Navigator.pushNamed(context, "/govetschemeslist");
        //}
      },
    );
  }
}
