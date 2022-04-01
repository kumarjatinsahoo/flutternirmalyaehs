import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AbhaTokenModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import '../Doctor/Dashboard/DoctorMedicationlist.dart';

class AbhaMobileVerification extends StatefulWidget {
  // MainModel _model = MainModel();
  // LoginScreen(this._model);

  final MainModel model;

  const AbhaMobileVerification({
    Key key,
    this.model,
  }) : super(key: key);

  static KeyvalueModel countryModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel cityModel = null;

  @override
  _AbhaMobileVerificationState createState() => _AbhaMobileVerificationState();
}

class _AbhaMobileVerificationState extends State<AbhaMobileVerification> {
  // String selectedLanguage = AppData.selectedLanguage;
  // String selectedLanCode = languagesMap[AppData.selectedLanguage];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();

  void _update(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Lan", locale.toString());
  }

  List<TextEditingController> controller = [
    new TextEditingController(),
    new TextEditingController(),
  ];

  Color color = Colors.grey;
  String phoneNo;

  AbhaTokenModel abhaTokenModel;

  /*getSessionAbha() {
    MyWidgets.showLoading(context);
    var postData = {
      "clientId": "SBX_000035",
      "clientSecret": "2f59bf0b-f396-4f2a-b639-0ef8572c8618"
    };
    widget.model.POSTMETHOD(
        api: ApiFactory.SESSION,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response>>>" + jsonEncode(map));
          abhaTokenModel = AbhaTokenModel.fromJson(map);
          validateAdharNo();
        },
        json: postData);
  }*/

  validatePhoneNo() {
    MyWidgets.showLoading(context);
    // var postData = {"aadhaar": controller[1].text};
    var postData = {"mobile": controller[1].text, "txnId": widget.model.txnId};
    widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.SEND_PERSONAL_NO,
        // api: "https://healthidsbx.abdm.gov.in/api/v1/registration/aadhaar/generateMobileOTP",
        token: "Bearer " + widget.model.abhaTokenModel.accessToken,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response Token>>>" + jsonEncode(map));
          if (map.containsKey("txnId")) {
            widget.model.txnId = map["txnId"];
            widget.model.abhaphoneno = controller[1].text;
            //widget.model.abhaTokenModel=abhaTokenModel;
            //Navigator.pushNamed(context, "/adharOtp");
            Navigator.pushNamed(context, "/phoneOtp");
          } else {
            AppData.showInSnackBar(context, map["details"][0]["message"]);
          }
        },
        json: postData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AbhaMobileVerification.countryModel = null;
    AbhaMobileVerification.stateModel = null;
    AbhaMobileVerification.districtModel = null;
    AbhaMobileVerification.cityModel = null;

    // getSessionAbha();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: Image.asset(
                  "assets/logo1.png",
                  fit: BoxFit.fitWidth,
                  //width: ,
                  height: 180.0,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 9),
                child: Row(
                  children: [
                    Text(
                      "Step 3",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              formField1(1, "Please Enter Mobile No"),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: SizedBox(
                  height: 58,
                  child: DropDown.networkDropdownGetpartUserundreline1(
                      // "Country",
                      MyLocalizations.of(context).text("COUNTRY") + "*",
                      ApiFactory.COUNTRY_API,
                      "countryU",
                      Icons.location_on_rounded,
                      23.0, (KeyvalueModel data) {
                    setState(() {
                      print(ApiFactory.COUNTRY_API);
                      AbhaMobileVerification.countryModel = data;
                      AbhaMobileVerification.stateModel = null;
                      AbhaMobileVerification.districtModel = null;
                      AbhaMobileVerification.cityModel = null;
                    });
                  }),
                ),
              ),

              SizedBox(
                height: 2,
              ),

              (AbhaMobileVerification.countryModel != null)
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                      child: SizedBox(
                        height: 58,
                        child: DropDown.countryList(
                            //"State",
                            MyLocalizations.of(context).text("STATE") + "*",
                            ApiFactory.STATE_API +
                                AbhaMobileVerification.countryModel.key,
                            "stateabh",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            AbhaMobileVerification.stateModel = data;
                            AbhaMobileVerification.districtModel = null;
                            AbhaMobileVerification.cityModel = null;
                            /*userModel.state=data.key;
                                      userModel.stateCode=data.code;*/
                          });
                        }),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 2,
              ),

              (AbhaMobileVerification.stateModel != null)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: SizedBox(
                        height: 58,
                        child: DropDown.countryList(
                            //"District",
                            MyLocalizations.of(context).text("DIST") + "*",
                            ApiFactory.DISTRICT_API +
                                AbhaMobileVerification.stateModel.key,
                            "districtabh",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.COUNTRY_API);
                            AbhaMobileVerification.districtModel = data;
                            AbhaMobileVerification.cityModel = null;
                          });
                        }),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 2,
              ),

              (AbhaMobileVerification.districtModel != null)
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                      child: SizedBox(
                        height: 58,
                        child: DropDown.countryList(
                            //"City",
                            MyLocalizations.of(context).text("CITY") + "*",
                            ApiFactory.CITY_API +
                                AbhaMobileVerification.districtModel.key,
                            "cityabh",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            AbhaMobileVerification.cityModel = data;
                            /*userModel.state=data.key;
                                      userModel.stateCode=data.code;*/
                          });
                        }),
                      ),
                    )
                  : Container(),

              SizedBox(
                height: 15,
              ),
              //nextButton(),
              InkWell(
                onTap: () {
                  if (AbhaMobileVerification.countryModel == null) {
                    AppData.showInSnackBar(context, "Please select country");
                  } else if (AbhaMobileVerification.stateModel == null) {
                    AppData.showInSnackBar(context, "Please select state");
                  } else if (AbhaMobileVerification.districtModel == null) {
                    AppData.showInSnackBar(context, "Please select district");
                  } else if (AbhaMobileVerification.cityModel == null) {
                    AppData.showInSnackBar(context, "Please select city");
                  } else {
                    validatePhoneNo();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppData.kPrimaryColor,
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.black, AppData.kPrimaryColor])),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 35.0, right: 35.0, top: 14.0, bottom: 14.0),
                    child: Text(
                      "Proceed",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ],
      ),
    );
  }

  _validateMobileNumber(String mobileNo, context) async {
    //make api call
    if (mobileNo.length == 10) {
      setState(() {
        color = Colors.orange;
      });
    } else {
      setState(() {
        color = Colors.grey;
      });
      return false;
    }
  }

  void showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.center,
            child: Container(
              height: 170.0,
              width: 300.0,
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/partnerSignUp");
                      },
                      child: Padding(
                        // padding:  EdgeInsets.all(15.0),
                        padding: const EdgeInsets.only(top: 18, left: 12),
                        child: Text('Reg. as a Partner',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/signUp");
                      },
                      child: Padding(
                        //padding: EdgeInsets.all(15.0),
                        padding: const EdgeInsets.only(top: 18, left: 12),

                        child: Text('Reg. as a Customer',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          //validation(context);
                        },
                        child: Padding(
                          //padding: EdgeInsets.all(15.0),
                          padding: const EdgeInsets.only(
                              top: 25, left: 12, right: 30),
                          child: Container(
                            width: 50.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFD3D3D3),
                                    Color(0xFFD3D3D3),
                                  ],
                                ),
                                //color: Color(0xFF311B92),//#7B1FA2
                                //border: Border.all(color: Color(0xFF4527A0)),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Center(
                              child: Text("Close",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ).toList(),
              ),
              /*child: SizedBox.expand(

              ),*/
              margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  Widget formField1(
    int index,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              // prefixIcon: Icon(Icons.person_rounded),
              /* hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),*/
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            controller: controller[index],
            //focusNode: fnode1,
            textAlignVertical: TextAlignVertical.top,
            onFieldSubmitted: (value) {
              //print("ValueValue" + error[index].toString());

              setState(() {
                //error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[0-9 ]")),
            ],
          ),
        ),
      ),
    );
  }
}
