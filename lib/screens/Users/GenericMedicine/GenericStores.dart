import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/UserRegistrationModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Users/GenericMedicine/GenericStoresList.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class GenericStores extends StatefulWidget {
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel bloodgroupModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel cityModel = null;
  static KeyvalueModel countryModel = null;

  GenericStores({Key key, this.model}) : super(key: key);

  @override
  _GenericStoresState createState() => _GenericStoresState();
}

class _GenericStoresState extends State<GenericStores> {
  var selectedMinValue;
  String country = "", state = "", district = "", city = "";
  UserRegistrationModel userModel = UserRegistrationModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GenericStores.countryModel = null;
    GenericStores.stateModel = null;
    GenericStores.districtModel = null;
    GenericStores.cityModel = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).text("GENERIC_MEDICAL_STORE"),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/generictop.png",
                            // width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      MyLocalizations.of(context).text("FIND_GENERIC_STORE"),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Request your doctor to prescribe generic medicine.',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
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
                            MyLocalizations.of(context).text("COUNTRY"),
                            ApiFactory.COUNTRY_API,
                            "country",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.COUNTRY_API);
                            GenericStores.countryModel = data;
                            GenericStores.stateModel = null;
                            GenericStores.districtModel = null;
                            GenericStores.cityModel = null;
                          });
                        }),
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                      child: SizedBox(
                        height: 58,
                        child: DropDown.genericMedicine(
                            context,
                            MyLocalizations.of(context).text("STATE"),
                            ApiFactory.STATE_API +
                                (GenericStores?.countryModel?.key ?? ""),
                            "state",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            GenericStores.stateModel = data;
                            GenericStores.districtModel = null;
                            GenericStores.cityModel = null;
                          });
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: SizedBox(
                        height: 58,
                        child: DropDown.genericMedicine(
                            context,
                            MyLocalizations.of(context).text("DIST"),
                            ApiFactory.DISTRICT_API +
                                (GenericStores?.stateModel?.key ?? ""),
                            "district1",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.COUNTRY_API);
                            GenericStores.districtModel = data;
                            GenericStores.cityModel = null;
                          });
                        }),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                      child: SizedBox(
                        height: 58,
                        child: DropDown.genericMedicine(
                            context,
                            MyLocalizations.of(context).text("CITY"),
                            ApiFactory.CITY_API +
                                (GenericStores?.districtModel?.key ?? ""),
                            "city",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            GenericStores.cityModel = data;
                            /*userModel.state=data.key;
                                  userModel.stateCode=data.code;*/
                          });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    _submitButton(),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/genericbottom.jpg",
                            // width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
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

  /* Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        */ /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/ /*

        Navigator.pushNamed(context, "genericstoreslist");
        //}

      },
    );
  }*/

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text:  MyLocalizations.of(context).text("SEARCH").toUpperCase(),
      context: context,
      fun: () {
        if (GenericStores.countryModel == null ||
            GenericStores.countryModel == "") {
          AppData.showInSnackBar(context, "Please select country");
        } else if (GenericStores.stateModel == null ||
            GenericStores.stateModel == "") {
          AppData.showInSnackBar(context, "Please select state");
        } else if (GenericStores.districtModel == null ||
            GenericStores.districtModel == "") {
          AppData.showInSnackBar(context, "Please select district");
        } else if (GenericStores.cityModel == null ||
            GenericStores.cityModel == "") {
          AppData.showInSnackBar(context, "Please select city");
        } else {
          //country = "99";
          country = GenericStores.countryModel.name;
          state = GenericStores.stateModel.name;
          district = GenericStores.districtModel.name;
          city = GenericStores?.cityModel?.name ?? "";
          widget.model.medicineStore = "generic medicine store," +
              city +
              "," +
              district +
              "," +
              state +
              "," +
              country;

          Navigator.pushNamed(context, "/genericMed");
        }
      },
    );
  }
}
