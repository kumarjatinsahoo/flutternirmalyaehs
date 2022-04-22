import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AbhaTokenModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import '../Doctor/Dashboard/DoctorMedicationlist.dart';

class AadharRegistration extends StatefulWidget {
  // MainModel _model = MainModel();
  // LoginScreen(this._model);

  final MainModel model;

  const AadharRegistration({Key key, this.model,}) : super(key: key);

  @override
  _AadharRegistrationState createState() => _AadharRegistrationState();
}

class _AadharRegistrationState extends State<AadharRegistration> {
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

  validateAadhar() {
    MyWidgets.showLoading(context);
    log(">>>>>>>>>"+ApiFactory.VALIDATE_AADHAR+controller[1].text);
    widget.model.GETMETHODCAL(
        api: ApiFactory.VALIDATE_AADHAR+controller[1].text,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response>>>>>" + jsonEncode(map));
          if (map.containsKey("result") && !map["result"]) {
            getSessionAbha();
          } else {
            AppData.showInSnackBar(
                context, "This aadhaar no is already registered");
          }
        },
        );
  }

  getSessionAbha() {
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
  }

  validateAdharNo() {
    MyWidgets.showLoading(context);
    var postData = {"aadhaar": controller[1].text};
    widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.GET_ADHAR_OTP,
        token: "Bearer " + abhaTokenModel.accessToken,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response Token>>>" + jsonEncode(map));
          if (map.containsKey("txnId")) {
            widget.model.txnId = map["txnId"];
            widget.model.abhaadhar = controller[1].text;
            widget.model.abhaTokenModel = abhaTokenModel;

            //Navigator.pushNamed(context, "/adharOtp");
            Navigator.pushNamed(context, "/adharOtppinview");
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
            padding: const EdgeInsets.only(bottom: 80),
            child: Align(
              alignment: Alignment.center,
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
                      "Step 1",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              formField1(1, "Please Enter Aadhar No"),
              SizedBox(height: 8),
              //nextButton(),
              InkWell(
                onTap: () {
                  // getSessionAbha();
                  validateAadhar();
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
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: Container(
        height: 45,
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
