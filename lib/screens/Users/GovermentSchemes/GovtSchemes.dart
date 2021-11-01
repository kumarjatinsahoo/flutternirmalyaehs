import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Users/GenericMedicine/GovtSchemesList.dart';
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
      body: Stack(
        children: [
        Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(

            child: Image.asset(
              "assets/images/govtschemes.jpg",
              // width: size.width,
              fit: BoxFit.cover,
              height: 230,
              width: double.maxFinite,
            ),
          ),
          SizedBox(height:3),

        ],
      ),
         Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70,),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Find Health Schemes',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  /*  Text(
                      'Request your doctor to prescribe Generic Medicine.',
                      style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),*/
                    SizedBox(height: 35),
                    /*DropDown.staticDropdown2('India', "country", countryList,
                    (KeyvalueModel data) {
                  setState(() {
                    GenericStores.stateModel = data;
                    GenericStores.stateModel = null;
                  });
                }),
                SizedBox(
                  height: 25,
                ),

                DropDown.networkDropdownGetpartUserundreline(
                    "State",
                    ApiFactory.STATE_API +"99",
                        // (GenericStores?.countryModel?.key ?? ""),
                    "state", (KeyvalueModel data) {
                  setState(() {
                    print(ApiFactory.STATE_API);
                    GenericStores.stateModel = data;
                    GenericStores.districtModel = null;
                  });
                }),
                SizedBox(
                  height: 25,
                ),
                DropDown.networkDropdownGetpartUserundreline(
                    "District", ApiFactory.DISTRICT_API +(GenericStores?.stateModel?.key??""), "district",
                        (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.DISTRICT_API);
                        GenericStores.districtModel = data;
                        GenericStores.cityModel = null;
                      });
                    }),
                SizedBox(
                  height: 25,
                ),
                DropDown.networkDropdownGetpartUserundreline(
                    "Select City", ApiFactory.CITY_API + (GenericStores?.districtModel?.key??""), "city",
                        (KeyvalueModel data) {
                      setState(() {
                        print(ApiFactory.CITY_API);
                        GenericStores.cityModel = data;
                        // LabSignUpForm3.districtModel = null;
                      });
                    }),*/
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
      ]
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
