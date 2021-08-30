import 'dart:async';
import 'dart:math';

import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/text_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
 MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;

  SignupScreen({ Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model})
      : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();

bool ispartnercode = false;
bool _checkbox = false;

   List<bool> error = [false, false, false, false, false, false];
  bool _isSignUpLoading = false;
  
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;

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
   String countryCode ="+91"; 
   bool isotpVisible = false;
   bool ispassVisible= true;
   bool isloginButton = true;
   var rng = new Random();
var code ;
var pin ;
bool fromLogin = false;

  StreamSubscription _connectionChangeStream;
  bool isOnline = false;

  @override
  void initState() {
    super.initState();
     SignupScreen.districtModel = null;
    SignupScreen.blockModel = null;
    SignupScreen.genderModel = null;
  }

   void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
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
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
              child:
               
                   ListView(
                    shrinkWrap: true,                   
                                  children: [
                                     SizedBox(height: size.height * 0.10),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                       child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Sign Up".toUpperCase(),
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
                      Form(
                        key: _formKey,
                        // ignore: deprecated_member_use
                        autovalidate: _autovalidate,
                        child: Column(
                          children: <Widget>[
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 25),
                            //   child: DropDown.staticDropdown2(
                            //       MyLocalizations.of(context)
                            //           .text("SELECT_TITLE"),
                            //       "genderSignup",
                            //       genderList, (KeyvalueModel data) {
                            //     setState(() {
                            //       SignUpForm.genderModel = data;
                            //     });
                            //   }),
                            // ),

                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 25),
                            //   child: TextFormField(
                            //     decoration: InputDecoration(
                            //         hintText: MyLocalizations.of(context)
                            //                 .text("FIRST_NAME") +
                            //             "*",
                            //         hintStyle: TextStyle(color: Colors.grey)),
                            //     textInputAction: TextInputAction.next,
                            //     keyboardType: TextInputType.text,
                            //     inputFormatters: [
                            //       WhitelistingTextInputFormatter(
                            //           RegExp("[a-zA-Z ]")),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 25),
                            //   child: TextFormField(
                            //     decoration: InputDecoration(
                            //         hintText: MyLocalizations.of(context)
                            //                 .text("LAST_NAME") +
                            //             "*",
                            //         hintStyle: TextStyle(color: Colors.grey)),
                            //     textInputAction: TextInputAction.next,
                            //     keyboardType: TextInputType.text,
                            //     inputFormatters: [
                            //       WhitelistingTextInputFormatter(
                            //           RegExp("[a-zA-Z ]")),
                            //     ],
                            //   ),
                            // ),

                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 25),
                            //   child: DropDown.staticDropdown2(
                            //       'India',
                            //       // MyLocalizations.of(context).text("SELECT_GENDER"),
                            //       "genderSignup",
                            //       genderList, (KeyvalueModel data) {
                            //     setState(() {
                            //       SignUpForm.genderModel = data;
                            //     });
                            //   }),
                            // ),

                            // // dob(),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(right:4.0),
                              child: mobileNoOTPSearch(),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'OTP',
                                    hintStyle: TextStyle(color: Colors.grey)),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                //           inputFormatters: [
                                //  WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                                //           ],
                              ),
                            ),
                           SizedBox(
                              height: size.height * 0.02,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    ispartnercode = !ispartnercode;
                                  });
                                },
                                child: Text(
                                  MyLocalizations.of(context)
                                          .text("HAVE_PARTNERCODE") +
                                      "?",
                                  style: TextStyle(color: Colors.indigo),
                                )),

                            
                            Visibility(
                              visible: ispartnercode,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: MyLocalizations.of(context)
                                          .text("PARTNERCODE"),
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  //           inputFormatters: [
                                  //  WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                                  //           ],
                                ),
                              ),
                            ),
 SizedBox(
                              height: size.height * 0.01,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: _checkbox,
                                    onChanged: (value) {
                                      setState(() {
                                        _checkbox = !_checkbox;
                                      });
                                    },
                                  ),
                                 
                                  RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'I agree to NCORDS ',
                                            /* "Welcome back",*/
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w800,
                                              fontFamily: "Monte",
                                              // fontSize: 25.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Terms and Conditions',
                                            /* "Welcome back",*/
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w500,
                                              fontFamily: "Monte",
                                              // fontSize: 25.0,
                                              color: Colors.indigo,
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                           SizedBox(
                              height: size.height * 0.01,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: nextButton(),
                            ),
                           SizedBox(
                              height: size.height * 0.02,
                            ),
                            InkWell(
                              onTap: (){
                               Navigator.pop(context);
                              },
                              child: Text('Back to login'.toUpperCase(),
                               style: TextStyle(color:AppData.kPrimaryColor, fontWeight: FontWeight.w600),)),
                               SizedBox(
                              height: size.height * 0.06,
                            ),
                          ],
                        ),
                      ),
                    ],
              ),
                         
              
            ),
            Positioned(
              top: 100,
              //left: 0,
              child: Container(
                width: size.width,
                height: 60,
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

 Widget mobileNumber() {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 0.0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: AppData.kPrimaryLightColor,
        //   borderRadius: BorderRadius.circular(29),
        //   /*border: Border.all(
        //        color: Colors.black,width: 0.3)*/
        // ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButton<String>(
                // hint: Text("Select Device"),
                underline: Container(
                  color: Colors.grey,
                ),
                value: AppData.currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    AppData.currentSelectedValue = newValue;
                  });
                  print(AppData.currentSelectedValue);
                },
                items: AppData.phoneFormat.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 35.0,
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            new Expanded(
              child: TextFormField(
                enabled: widget.isConfirmPage ? false : true,
                controller: textEditingController[4],
                focusNode: fnode7,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  counterText: "",
                  hintText:
                      MyLocalizations.of(context).text("PHONE_NUMBER") + "*",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    error[4] = true;
                    return null;
                  }
                  error[4] = false;
                  return null;
                },
                onFieldSubmitted: (value) {
                  // print(error[2]);
                  error[4] = false;
                  setState(() {});
                  AppData.fieldFocusChange(context, fnode7, fnode8);
                },
                onSaved: (value) {
                  //userPersonalForm.phoneNumber = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mobileNoOTPSearch() {
    return Row(
      children: <Widget>[
        Expanded(
          //flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 7.0),
            child: Container(
              // padding: EdgeInsets.only(left: 2),
              height: 50.0,
              // decoration: BoxDecoration(
              //     color: AppData.kPrimaryLightColor,
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(color: Colors.black, width: 0.3)),
              child: mobileNumber(),
            ),
          ),
        ),
      ],
    );
  }
 
 Widget errorMsg(text) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget inputFieldContainer(child) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // decoration: BoxDecoration(
        //     // color: AppData.kPrimaryLightColor,
        //     borderRadius: BorderRadius.circular(29),
        //     border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }

  Widget fromField(int index, String hint, bool enb, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type) {
    // print(index);
    // print(currentfn);
    return TextFieldContainer(
      //color: error[index] ? Colors.red : AppData.kPrimaryLightColor,
      child: TextFormField(
        enabled: !enb,
        controller: textEditingController[index],
        focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          // ignore: deprecated_member_use
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value.isEmpty) {
            error[index] = true;
            return null;
          } else {
            error[index] = false;
            return null;
          }
        },
        onFieldSubmitted: (value) {
          print("ValueValue" + error[index].toString());

          setState(() {
            error[index] = false;
          });
          AppData.fieldFocusChange(context, currentfn, nextFn);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

   Widget continueButton() {
    return InkWell(
      child: Center(
        child: CircleAvatar(
          radius: 20.0,
          //backgroundColor: Colors.amber.shade600,
          backgroundColor: AppData.kPrimaryColor,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        setState(() {});
        validate();
      },
    );
  }

  validate() async {
    _formKey.currentState.validate();

    // if (error[0] == true) {
    //   AppData.showInSnackBar(
    //       context, MyLocalizations.of(context).text("PLEASE_ENTER_FIRST_NAME"));
    //   FocusScope.of(context).requestFocus(fnode1);
    // } else if (error[1] == true) {
    //   AppData.showInSnackBar(
    //       context, MyLocalizations.of(context).text("PLEASE_ENTER_lAST_NAME"));
    //   FocusScope.of(context).requestFocus(fnode2);
    // } else if (SignupScreen.genderModel == null || SignupScreen.genderModel == "") {
    //   AppData.showInSnackBar(
    //       context, MyLocalizations.of(context).text("PLEASE_SELECT_GENDER"));
    //   FocusScope.of(context).requestFocus(fnode4);
    // } else if (textEditingController[5].text == '') {
    //   AppData.showInSnackBar(context,
    //       MyLocalizations.of(context).text("PLEASE_ENTER_AADHAAR_NUMBER"));
    //   FocusScope.of(context).requestFocus(fnode4);
    // } else if (error[3] == true) {
    //   AppData.showInSnackBar(context,
    //       MyLocalizations.of(context).text("PLEASE_ENTER_FATHER_NAME"));
    //   FocusScope.of(context).requestFocus(fnode6);
    // }
    //  else if (error[2] == true) {
    //   AppData.showInSnackBar(
    //       context, MyLocalizations.of(context).text("PLEASE_ENTER_DOB"));
    //   FocusScope.of(context).requestFocus(fnode3);
    // }
      if (error[4] == true) {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_PHONE_NUMBER"));
      FocusScope.of(context).requestFocus(fnode7);
    } 
    // else if (SignupScreen.districtModel == null) {
    //   AppData.showInSnackBar(context, "PLEASE SELECT DISTRICT");
    // }
    //  else if (SignupScreen.blockModel == null) {
    //   AppData.showInSnackBar(context, "PLEASE SELECT BLOCK/ULB");
    // }
     else {
      _formKey.currentState.save();
      Navigator.pushNamed(context, "/login");

      // if (isOnline) {
      //   setState(() {
      //     _isSignUpLoading = true;
      //   });
      //   await Future.delayed(const Duration(seconds: 2), () {
      //     setState(() {
      //       _isSignUpLoading = false;
      //     });
      //   });
      // } else {
      //   AppData.showInSnackBar(context, "INTERNET_CONNECTION");
      // }
    }
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            MyLocalizations.of(context).text("SIGN_BTN"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

 
  
 
 
}
