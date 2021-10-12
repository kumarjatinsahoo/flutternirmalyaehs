import 'dart:math';

import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginwithOTP extends StatefulWidget {
  final MainModel model;
  final String mobNo, aadharNo;

  LoginwithOTP({Key key, this.model, this.mobNo, this.aadharNo})
      : super(key: key);

  @override
  _LoginwithOTPState createState() => _LoginwithOTPState();
}

class _LoginwithOTPState extends State<LoginwithOTP> {
  TextEditingController beniTextController = new TextEditingController();
  TextEditingController aadharTextController = new TextEditingController();
  TextEditingController mobileTextController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController _loginId = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;
  static final List<String> languagesList = application.supportedLanguages;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1]
  };
  final Map<dynamic, dynamic> languageCodeMap = {
    languageCodesList[0]: languagesList[0],
    languageCodesList[1]: languagesList[1]
  };

  void _update(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Lan", locale.toString());
    application.onLocaleChanged(locale.toString());
  }

  bool isLoginLoading = false;

  // LoginResponse loginResponse;
  SharedPref sharedPref = SharedPref();
  bool isPassShow = false;

  //  String phoneNumber = "; //enter your 10 digit number
  int minNumber = 1000;
  int maxNumber = 6000;
  String countryCode = "+91";
  bool isotpVisible = true;
  bool ispassVisible = true;
  bool isloginButton = true;
  var rng = new Random();
  var code;

  var pin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    code = rng.nextInt(9000) + 1000;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/back_logo.jpg",
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              margin: EdgeInsets.only(
                top: 120.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ListView(shrinkWrap: true, children: <Widget>[
                SizedBox(height: size.height * 0.10),
                /* SizedBox(
                  height: size.height * 0.14,
                ),*/
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                MyLocalizations.of(context).text("WELCOMEBACK"),
                            /* "Welcome back",*/
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: "Monte",
                              fontSize: 25.0,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )),
                ),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: fromFieldNumber(),
                      ),

                      Visibility(
                        visible: isotpVisible,
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              OTPTextField(
                                length: 4,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldWidth: 55,
                                fieldStyle: FieldStyle.underline,
                                // outlineBorderRadius: 15,
                                style: TextStyle(fontSize: 17),
                                onChanged: (value) {
                                  print("Changed: " + value);
                                },
                                onCompleted: (value) {
                                  pin = value;
                                  print("Completed: " + pin);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      _getOTPButton(),
                      // SizedBox(height: 60),
                      // Visibility(
                      //   visible: isloginButton,
                      //   child: _loginButton()),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '- OR -',
                        style: TextStyle(color: Colors.black54),
                      ),
                      Visibility(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            _otpButton(),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 14.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/signUp");
                            // Navigator.pushNamed(context, "/registration1");
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: MyLocalizations.of(context)
                                        .text("DIDHAVEACC"),
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: MyLocalizations.of(context)
                                        .text("CREATEACC"),
                                    style: TextStyle(
                                        color: AppData.matruColor,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/forgotpassword");
                          },
                          child: Text('Forgot Password?')),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ]),
            ),
            Positioned(
              top: 100,
              //left: 0,
              child: Container(
                width: size.width,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin: EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  // color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      //color:Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      alignment: Alignment.center,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          // hint: Text("Select Device"),
                          value: AppData.selectedLanguage,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              AppData.setSelectedLan(newValue);
                              _update(Locale(languagesMap[newValue]));
                            });
                            print(AppData.selectedLanguage);
                          },
                          items: languagesList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isLoginLoading
                ? Stack(
                    children: [
                      new Opacity(
                        opacity: 0.1,
                        child: const ModalBarrier(
                            dismissible: false, color: Colors.grey),
                      ),
                      new Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Container()
          ],
        ));
  }

  Widget fromFieldNumber() {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: _loginId,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.phone,
        autofocus: false,
        maxLength: 10,
        decoration: InputDecoration(
            /*prefix:
                Padding(padding: EdgeInsets.only(top: 10), child: Text('+91 ')),*/
            //hintText: "Enter number",
            labelText: MyLocalizations.of(context).text("MOBILENO"),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: ''),
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value.isEmpty) {
            return 'please enter mobile number';
          } else if (value.length != 10) {
            return 'Mobile no. should be 10 digit';
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          AppData.fieldFocusChange(context, fnode3, null);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

  Widget _getOTPButton() {
    return MyWidgets.nextButton(
      text: "Get OTP".toUpperCase(),
      context: context,
      fun: () {
        if (!_formKey.currentState.validate()) {
          return true;
        }
        //  _formKey.currentState.validate();
        // widget.model.phnNo = _loginId.text;
        Navigator.pushNamed(context, "/dashboard");

        //  otp.sendOtp(_loginId.text, 'OTP is : $code',
        //     minNumber, maxNumber, countryCode);
      },
    );
  }

  Widget _otpButton() {
    return MyWidgets.outlinedButton(
      text: "Login with Password".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/
        widget.model.phnNo = _loginId.text;
        Navigator.pushNamed(context, "/login");

        //}
      },
    );
  }
}
