import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class GovtSchemes extends StatefulWidget {
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel bloodgroupModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel cityModel = null;
  static KeyvalueModel countryModel = null;

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Government Schemes"),
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
        child: Container(
         child: Column(
           children: [
             Column(
               children: [
                 Container(
                   child: Image.asset(
                     "assets/images/govtschemes.jpg",
                     // width: size.width,
                     fit: BoxFit.cover,
                     height: MediaQuery.of(context).size.height*0.30,
                     width: double.maxFinite,
                   ),
                 ),
                 Text(
                   'Find Health Schemes',
                   style:
                   TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                 ),
               ],

             ),
            // SizedBox(height: 70,),
             Padding(
               padding: const EdgeInsets.only(
                 left: 20.0,
                 right: 20.0,
               ),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 0, right: 0),
                     child: SizedBox(
                       height: 58,
                       child: DropDown.genericMedicine(
                           context,
                           "Country",
                           ApiFactory.COUNTRY_API,
                           "country",
                           Icons.location_on_rounded,
                           23.0, (KeyvalueModel data) {
                         setState(() {
                           print(ApiFactory.COUNTRY_API);
                           GovtSchemes.countryModel = data;
                           GovtSchemes.stateModel = null;
                           GovtSchemes.districtModel = null;
                           GovtSchemes.cityModel = null;
                         });
                       }),
                     ),
                   ),

                   Padding(
                     padding: const EdgeInsets.only(
                         left: 0, right: 0, bottom: 0),
                     child: SizedBox(
                       height: 58,
                       child: DropDown.genericMedicine(
                           context,
                           "State",
                           ApiFactory.STATE_API +
                               (GovtSchemes?.countryModel?.key??""),
                           "state",
                           Icons.location_on_rounded,
                           23.0, (KeyvalueModel data) {
                         setState(() {
                           GovtSchemes.stateModel = data;
                           GovtSchemes.districtModel = null;
                           GovtSchemes.cityModel = null;
                         });
                       }),
                     ),
                   )
                   ,

                   Padding(
                     padding: const EdgeInsets.only(left: 0, right: 0),
                     child: SizedBox(
                       height: 58,
                       child: DropDown.genericMedicine(
                           context,
                           "District",
                           ApiFactory.DISTRICT_API +
                               (GovtSchemes?.stateModel?.key??""),
                           "district1",
                           Icons.location_on_rounded,
                           23.0, (KeyvalueModel data) {
                         setState(() {
                           print(ApiFactory.COUNTRY_API);
                           GovtSchemes.districtModel = data;
                           GovtSchemes.cityModel = null;
                         });
                       }),
                     ),
                   )
                   ,

                   Padding(
                     padding:
                     const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                     child: SizedBox(
                       height: 58,
                       child: DropDown.genericMedicine(
                           context,
                           "City",
                           ApiFactory.CITY_API +
                               (GovtSchemes?.districtModel?.key??""),
                           "city",
                           Icons.location_on_rounded,
                           23.0, (KeyvalueModel data) {
                         setState(() {
                           GovtSchemes.cityModel = data;
                           /*userModel.state=data.key;
                                     userModel.stateCode=data.code;*/
                         });
                       }),
                     ),
                   ),
                   SizedBox(
                     height: 25,
                   ),
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
      ),
    );
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
