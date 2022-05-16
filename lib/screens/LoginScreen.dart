import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MasterLoginResponse.dart' as master;
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/OTPTextfield.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class LoginScreen extends StatefulWidget {
  final MainModel model;
  final String mobNo, aadharNo;

  LoginScreen({Key key, this.model, this.mobNo, this.aadharNo})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;
  static final List<String> languagesList = application.supportedLanguages;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2],
    languagesList[3]: languageCodesList[3],
  };
  final Map<dynamic, dynamic> languageCodeMap = {
    languageCodesList[0]: languagesList[0],
    languageCodesList[1]: languagesList[1],
    languageCodesList[2]: languagesList[3],
    languageCodesList[3]: languagesList[3],
  };
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  void _update(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Lan", locale.toString());
    application.onLocaleChanged(locale.toString());
  }

  // String  identifier;
  String deviceid;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  dynamic currentTime = DateFormat.jm().format(DateTime.now());

  /* var now = new DateTime.now();
  DateFormat formatter1 = new DateFormat('dd-MM-yyyy');
  String formattedDate = formatter1.format(now);
*/
  bool isLoginLoading = false;

  SharedPref sharedPref = SharedPref();
  bool isPassShow = true;

  // String deviceid = await DeviceId.getID  ;
  // String deviceid = await DeviceId.getID;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  int minNumber = 1000;
  int maxNumber = 6000;
  String countryCode = "+91";
  bool isotpVisible = false;
  bool ispassVisible = true;
  bool isloginButton = true;
  bool _rememberMe = false;
  var rng = new math.Random();
  var code;

  var pin;
  String token = "";
  String imei = "";
  String formattedDate;

  master.MasterLoginResponse masterResponse;

// String imeiNo = await DeviceInformation.deviceIMEINumber;

  @override
  void initState() {
    rememberMe();
    super.initState();
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(now);
    // print(formattedDate);

    tokenCall();
    getDeviceSerialNumber();
    _initPackageInfo();
  }

  _displayTextInputDialog(BuildContext context) async {
    bool _rememberMe = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  //height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "You are dhan Arogya Kranti User.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),

                          /*  Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = !_rememberMe;
                                  });
                                },
                              ),
                              Text("I accept terms & condition")
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
*/
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child:
                    Text("OK", style: TextStyle(color: AppData.kPrimaryColor)),
              ),
            ],
          );
        });
  }

  rememberMe() async {
    var userId = await sharedPref.getKey(Const.REMEMBER_USERID);
    var password = await sharedPref.getKey(Const.REMEMBER_PASSWORD);
    if (userId != null && password != null) {
      _loginId.text = json.decode(userId);
      passController.text = json.decode(password);
      setState(() {
        _rememberMe = true;
      });
    }
  }

  Future<void> _initPackageInfo() async {
    if (Platform.isAndroid) {
      final PackageInfo info = await PackageInfo.fromPlatform();
      setState(() {
        _packageInfo = info;
      });
    }
  }

  Future<String> getDeviceSerialNumber() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        // deviceName = build.model;
        // deviceVersion = build.version.toString();
        // identifier = build.androidId;  //UUID for Android
        setState(() {
          // deviceid=build.model;
          imei = build.androidId;
        });
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        // deviceName = data.name;
        // deviceVersion = data.systemVersion;
        // identifier = data.identifierForVendor;  //UUID for iOS
        setState(() {
          // deviceid=data.name;
          imei = data.identifierForVendor;
        });
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  deviceInfooo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
      deviceid = androidInfo.androidId;
    }
    // e.g. "Moto G (4)"
  }

  tokenCall() {
    FirebaseMessaging.instance.getToken().then((value) {
      String token = value;
      print("token dart locale>>>" + token);
      widget.model.activitytoken = token;
      //sendDeviceInfo();
    });
    /*FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      setState(() {
        token = event;
        log(">>>>>>>>Token>>>>>>>" + token);
      });
    });*/
  }

  dialogGender1() {
    return Alert(
      context: context,
      //title: "Success",
      title: "Gender",
      //type: AlertType.info,
      onWillPopActive: true,
      closeIcon: Icon(
        Icons.info_outline,
        color: Colors.transparent,
      ),
      buttons: [
        DialogButton(
          color: Colors.grey[200],
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.black45),
          ),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          /*Text(
            "Dana Arogya kranti ",
            style: TextStyle(color: Colors.black, fontSize: 13,fontStyle: FontStyle.normal),
            textAlign: TextAlign.center,
          ),*/
          /* IntrinsicHeight(

            child: Row(
              mainAxisSize: MainAxisSize.max,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                      */ /*  selectGender = "1";
                        callingAPI(selectGender, salID);
                        Navigator.pop(context);
                        _selectDate(context);
                        Navigator.pop(context);*/ /*
                      });
                    },
                      child:DialogButton(
                        color: Colors.grey[200],
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.black45),
                        ),
                      )
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey[400],
                ),
               */ /* Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        */ /**/ /*selectGender = "2";
                        callingAPI(selectGender, salID);
                        Navigator.pop(context);
                        _selectDate(context);*/ /**/
          /*
                      });
                    },
                    child: Container(
                      //width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [


                          Text(
                            "FEMALE",
                            style: TextStyle(color: Colors.black, fontSize: 13,fontStyle: FontStyle.normal),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/ /*
              ],
            ),
          ),*/
          SizedBox(
            height: 10,
          )
        ],
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    code = rng.nextInt(9000) + 1000;
    // log(token ?? "jj");
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: body(context),
    );
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/bg_img.jpg",
              fit: BoxFit.cover,
              //centerSlice: ,
              height: 200,
              width: double.maxFinite,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              margin: EdgeInsets.only(
                top: 200.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Spacer(),
                      Container(
                        width: size.width,
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        margin: EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          // color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              alignment: Alignment.center,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
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
                      SizedBox(
                         height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: MyLocalizations.of(context)
                                    .text("WELCOMENACK"),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Monte",
                                  fontSize: 25.0,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      // Image.asset("assets/congrat1.gif"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: fromFieldNumber(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: fromFieldPass(),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = !_rememberMe;
                              });
                            },
                          ),
                          Text(
                            MyLocalizations.of(context).text("REMEMBER_ME"),
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      _loginButton(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            InkWell(
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, "/createUserIDScreen");
                                //FlutterPhoneDirectCaller.callNumber("7008553233");
                              },
                              child: Text(
                                MyLocalizations.of(context).text("CREATE_ID"),
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //Navigator.pushNamed(context, "/docDash");
                        },
                        child: Text(
                          MyLocalizations.of(context).text("OR"),
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      _otpButton(),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 5.0),
                        child: InkWell(
                          onTap: () {
                            dashOption(context);
                            // Navigator.pushNamed(context, "/loginFBandGooglePage");
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: MyLocalizations.of(context)
                                            .text("DIDHAVEACC") +
                                        "\n\n",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                                TextSpan(
                                    text: " ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: MyLocalizations.of(context)
                                        .text("CREATE_ACCOUNT"),
                                    style: TextStyle(
                                        color: AppData.matruColor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/forgotpassword");
                            //Navigator.pushNamed(context, "/dashDoctor");
                          },
                          child: Text(
                            MyLocalizations.of(context).text("FORGOT_PASSWORD"),
                            style: TextStyle(
                                fontSize: 17, color: AppData.kPrimaryColor),
                          )),

                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Image.asset("assets/intro/main_logo.bmp"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
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
        keyboardType: TextInputType.text,
        autofocus: false,
        // maxLength: 10,
        decoration: InputDecoration(
            prefix: Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            //hintText: "Enter number",
            labelText: MyLocalizations.of(context).text("USER_NAME"),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: ''),
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
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

  Widget fromFieldPass() {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: passController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        autofocus: false,
        //maxLength: 7,
        decoration: InputDecoration(
            /* prefix:
                Padding(padding: EdgeInsets.only(top: 10), child: Text('+91 ')),*/
            //hintText: "Enter password",
            //contentPadding: EdgeInsets.only(top: ),
            /*filled: true,
            fillColor: Colors.red.withOpacity(.5),*/
            labelText: MyLocalizations.of(context).text("PASSWORD"),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: '',
            suffixIcon: IconButton(
              icon: Icon(
                !isPassShow ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPassShow = !isPassShow;
                });
              },
            )),
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: isPassShow,

        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
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

  Widget dialogUserView(BuildContext context, List<master.Body> data) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 20),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 450,
            child: Column(
              children: [
                Text(
                  "Login Users",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //_buildAboutText(),
                        //_buildLogoAttribution(),
                        ListView.separated(
                          separatorBuilder: (c, i) {
                            return Divider();
                          },
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return ListTile(
                              leading: Icon(
                                CupertinoIcons.person_alt_circle,
                                size: 44,
                              ),
                              title: Text(data[i]?.userName ?? ""),
                              subtitle: Text(data[i].user),
                              onTap: () {
                                /*  sharedPref.save(Const.LOGIN_phoneno, _loginId.text);
                                sharedPref.save(Const.LOGIN_password, passController.text);
                                LoginResponse1 loginResponse = LoginResponse1();
                                // loginResponse.acceptValue(data[i]);
                                Body body=Body();
                                body.user=data[i].user;
                                body.userName=data[i].userName;
                                body.userAddress=data[i].userAddress;
                                body.userPassword=data[i].userPassword;
                                body.userMobile=data[i].userMobile;
                                body.userStatus=data[i].userStatus;
                                body.token=data[i].token;
                                body.roles.add(value)
                                loginResponse.body=body;
                                widget.model.token = data[i].token;
                                widget.model.user = data[i].user;
                                log("Response after assign>>>>"+jsonEncode(loginResponse.toJson()));
                                sharedPref.save(Const.LOGIN_DATA, loginResponse);
                                widget.model.setLoginData1(loginResponse);
                                sharedPref.save(Const.IS_LOGIN, "true");*/
                                roleUpdateApi(data[i].user, data[i]);
                              },
                              trailing: Icon(Icons.arrow_right),
                            );
                          },
                          itemCount: data.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      /*actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("Cancel"),
        ),
        new FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: const Text('SEARCH'),
        ),
      ],*/
    );
  }

  roleUpdateApi(userId, master.Body data) {
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
        api: ApiFactory.GET_ROLE + userId,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Response for role>>>>>" + jsonEncode(map));
          if (map["code"] == "success") {
            // sharedPref.save(Const.LOGIN_phoneno, _loginId.text);
            // sharedPref.save(Const.LOGIN_password, passController.text);
            LoginResponse1 loginResponse = LoginResponse1();
            Body body = Body();
            body.user = data.user;
            body.userName = data.userName;
            body.userAddress = data.userAddress;
            body.userPassword = data.userPassword;
            body.userMobile = data.userMobile;
            body.userStatus = data.userStatus;
            body.userStateId = data.userStateId;
            body.userState = data.userState;
            body.userCountry = data.userCountry;
            body.userCountryId = data.userCountryId;
            body.userPic = data.userPic;
            body.token = data.token;
            body.roles = [];
            body.roles.add(map["body"]["roleid"]);
            loginResponse.body = body;
            widget.model.token = data.token;
            widget.model.masterResponse = masterResponse;
            widget.model.user = data.user;
            log("Response after assign>>>>" +
                jsonEncode(loginResponse.toJson()));
            sharedPref.save(Const.LOGIN_DATA, loginResponse);
            sharedPref.save(Const.MASTER_RESPONSE, masterResponse);
            if (_rememberMe) {
              sharedPref.save(Const.REMEMBER_USERID, _loginId.text);
              sharedPref.save(Const.REMEMBER_PASSWORD, passController.text);
            } else {
              sharedPref.remove(Const.REMEMBER_USERID);
              sharedPref.remove(Const.REMEMBER_PASSWORD);
            }
            widget.model.setLoginData1(loginResponse);
            sharedPref.save(Const.IS_LOGIN, "true");

            FirebaseMessaging.instance.subscribeToTopic(data.user);
            FirebaseMessaging.instance.subscribeToTopic(data.userMobile);

            sendDeviceInfo("SUCCESS", userId);

            if (map["body"]["roleid"] == "1".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "2".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashDoctor', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "5".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboardreceptionlist', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "7".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboardpharmacy', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "8".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/labDash', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "12".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/ambulancedash', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "13".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/bloodBankDashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "22".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/syndicateDashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "24".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/admin', (Route<dynamic> route) => false);
            } else {
              AppData.showInSnackBar(context, "No Role Assign");
            }
          }
        });
  }

  Widget _loginButton() {
    return MyWidgets.nextButton(
      text: MyLocalizations.of(context).text("LOGIN"),
      context: context,

      ///_loginId,passController
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(
              context, "Please enter mobile no/Email id/User id/User name");
        } else if (passController.text == "" || passController.text == null) {
          AppData.showInSnackBar(context, "Please enter password");
        } else {
          widget.model.phnNo = _loginId.text;
          widget.model.passWord = passController.text;
          MyWidgets.showLoading(context);
          widget.model.GETMETHODCALL(
              api: ApiFactory.LOGIN_PASS_MULTIPLE(
                  _loginId.text, passController.text),
              fun: (Map<String, dynamic> map) {
                Navigator.pop(context);
                log("LOGIN RESPONSE>>>>" + jsonEncode(map));
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                if (map[Const.CODE] == Const.SUCCESS) {
                  setState(() {
                    widget.model.phnNo = _loginId.text;
                    widget.model.passWord = passController.text;
                    masterResponse = master.MasterLoginResponse.fromJson(map);
                    widget.model.user = masterResponse.body[0].user;

                    /*FirebaseMessaging.instance.getToken().then((value) {
                      String token = value;
                      print("token dart locale>>>" + token);
                      widget.model.activitytoken=token;


                    });*/

                    showDialog(
                      context: context,                      builder: (BuildContext context) =>

                          dialogUserView(context, masterResponse.body),
                    );

                    /* Map<String, dynamic> postmap = {
                      "userId": widget.model.user,
                      "imeiNo": imei,
                      "version": Platform.isAndroid
                          ? _packageInfo.version
                          : Const.IOS_VERSION,
                      "deviceId": deviceid,
                      "activityDate": */ /*"26-1-2021"*/
                    /* formattedDate,
                      "activityTime": currentTime,
                      "type": "LOGIN",
                      "status": "SUCCESS",
                      "deviceToken": widget.model.activitytoken
                    };

                    log("Print data>>>>" + jsonEncode(postmap));
                    MyWidgets.showLoading(context);
                    widget.model.POSTMETHOD(
                        //api: ApiFactory.POST_APPOINTMENT,
                        api: ApiFactory.POST_ACTIVITYLOG,
                        //token: widget.model.token,
                        json: postmap,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          log("Json Response activity log>>" + jsonEncode(map));
                          if (map["code"] == Const.SUCCESS) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  dialogUserView(context, masterResponse.body),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  dialogUserView(context, masterResponse.body),
                            );
                            Navigator.pop(context);
                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });*/
                  });
                } else {
                  AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  String failed = "FAILED";
                  sendDeviceInfo(failed, _loginId.text);
                }
              });
        }
      },
    );
  }

  sendDeviceInfo(String sTATUS, data) {
    Map<String, dynamic> postmap = {
      "userId": data,
      "imeiNo": imei ?? "",
      "version": Platform.isAndroid ? _packageInfo.version : Const.IOS_VERSION,
      "deviceId": deviceid ?? "",
      "activityDate": /*"26-1-2021"*/ formattedDate,
      "activityTime": currentTime,
      "type": "LOGIN",
      "status": sTATUS,
      "deviceToken": widget.model.activitytoken
    };

    log("DEVICE DATA>>>>" + jsonEncode(postmap));
    // MyWidgets.showLoading(context);
    widget.model.POSTMETHOD(
        //api: ApiFactory.POST_APPOINTMENT,
        api: ApiFactory.POST_ACTIVITYLOG,
        //token: widget.model.token,
        json: postmap,
        fun: (Map<String, dynamic> map) {});
  }

  Widget _otpButton() {
    return MyWidgets.outlinedButton(
      text: MyLocalizations.of(context).text("LOGIN_WITH_OTP"),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {
          widget.model.phnNo = _loginId.text;
          MyWidgets.showLoading(context);
          widget.model.GETMETHODCALL(
              api: ApiFactory.LOGIN_Otp(_loginId.text),
              fun: (Map<String, dynamic> map) async {
                Navigator.pop(context);
                log("LOGIN RESPONSE>>>>" + jsonEncode(map));
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                if (map[Const.CODE] == Const.SUCCESS) {
                  masterResponse = master.MasterLoginResponse.fromJson(map);
                  final signature = await SmsAutoFill().getAppSignature;
                  widget.model.empid = signature;
                  print('signature ' + signature);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => OTPTextfield(
                              masterLoginResponse: masterResponse,
                              model: widget.model,
                              token: widget.model.activitytoken,
                            )),
                  );
                } else {
                  // masterResponse = master.MasterLoginResponse.fromJson(map);
                  Map<String, dynamic> postmap = {
                    "userId": _loginId.text,
                    "imeiNo": imei ?? "",
                    "version": Platform.isAndroid
                        ? _packageInfo.version
                        : Const.IOS_VERSION,
                    "deviceId": deviceid ?? "",
                    "activityDate": /*"26-1-2021"*/ formattedDate,
                    "activityTime": currentTime,
                    "type": "LOGIN",
                    "status": "FAILED",
                    "deviceToken": widget.model.activitytoken
                  };
                  widget.model.POSTMETHOD(
                      api: ApiFactory.POST_ACTIVITYLOG,
                      json: postmap,
                      fun: (Map<String, dynamic> map) {
                        // Navigator.pop(context);
                        log("Json Response activity log>>" + jsonEncode(map));
                      });
                  AppData.showInSnackBar(
                      context,
                      map.containsKey([Const.MESSAGE])
                          ? map[Const.MESSAGE]
                          : "Mobile number is not registered");
                }
              });
          // widget.model.phnNo = _loginId.text;
          //Navigator.pushNamed(context, "/otpView");
          // Navigator.pushNamed(context, "/pinView");
        }
      },
    );
  }

  userRegSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialog
                /*You can rename this!*/) {
          return FractionallySizedBox(
            heightFactor: 0.34,
            child: Container(
              child: ListView(
                children: [
                  SizedBox(height: 10,),
                  Center(
                      child: Text("Registration option",
                    style: TextStyle(color: Colors.black,
                        fontSize: 22,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/aadharregistration");
                    },
                    child: ListTile(
                      title: Text("BY AADHAR "),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/abhapan");
                    },
                    child: ListTile(
                      title: Text("BY PAN "),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                  ListTile(
                    title: Text("BY MOBILE "),
                    trailing: Icon(Icons.arrow_right),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }


  dashOption(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding: EdgeInsets.only(top: 18, left: 18, right: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("USER_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.pushNamed(context, "/userSignUpForm");
                            Navigator.pushNamed(context, "/aadharregistration");
                            //userRegSheet();
                            //dashOption1(context);
                            //_validate();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("DOCTOR_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(context, "/doctorsignupform2");
                            //Navigator.pop(context);
                            //Navigator.pushNamed(context, "/doctorsignupform2");
                            // Navigator.pushNamed(context, "/doctorsignupform");
                            //_validate();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("LAB_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(context, "/labsignupform");
                            //Navigator.pushNamed(context, "/labsignupform");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("PHARMACISTS"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            // Navigator.pop(context);
                            organisationDialog(context, "/pharmacists");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("AMBULANCE"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            // Navigator.pop(context);
                            organisationDialog(context, "/ambulance");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(
                                  MyLocalizations.of(context).text("NGO"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            // Navigator.pop(context);
                            organisationDialog(context, "/ngo");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("BLOOD_BANK"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(context, "/bloodbank");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("RECEPTIONIST"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(
                                context, "/receptionlistsignUpformm");
                            // Navigator.pushNamed(context, "/doctorsignupform");
                            //_validate();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("SYNDICATE_PARTNER"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            organisationDialog(
                                context, "/syndicatesignUpformm");
                            // Navigator.pushNamed(context, "/doctorsignupform");
                            //_validate();
                          },
                        ),
                        Divider(),
                        MaterialButton(
                          child: Text(
                            MyLocalizations.of(context).text("CANCEL"),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  organisationDialog(BuildContext context, String organisation) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(MyLocalizations.of(context).text("CANCEL"),
          style: TextStyle(color: AppData.kPrimaryRedColor)),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.pushNamed(context, "/organisationSignUpForm");
      },
    );
    Widget noButton = TextButton(
      child: Text(MyLocalizations.of(context).text("NO"),
          style: TextStyle(color: AppData.kPrimaryRedColor)),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.pop(context);
        //Navigator.pop(context);
        Navigator.pushNamed(context, "/organisationSignUpForm");
      },
    );
    Widget continueButton = TextButton(
      child: Text(MyLocalizations.of(context).text("YES"),
          style: TextStyle(color: AppData.matruColor)),
      onPressed: () {
        Navigator.pop(context);
        //Navigator.pop(context);

        //Navigator.pushNamed(context, "/doctorsignupform2");
        Navigator.pushNamed(context, organisation);
        // String listid = patientProfileModel.body.familyDetailsList[index].famid;
        // String familydetails="3";

        //  FamilyDeleteApi(listid,familydetails);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(MyLocalizations.of(context).text("HAVE_REG_YOUR_ORG")),
      // content: Text("Do You Want to Delete ?"),
      actions: [
        cancelButton,
        noButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

/*
    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 5),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 5),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     */ /* Positioned(
                        right: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.close, color: Colors.red,size: 25,),
                            ),
                          ),
                        ),
                      ),*/ /*
                   Align(
                  alignment: Alignment.center,
                    child: Text(
                        "Have you register your organisation in our eHealthSystems?",
                        style: TextStyle(
                            color: Colors.black, fontSize: 20,fontWeight: FontWeight.w400, // light
                            fontStyle: FontStyle.normal ),
                      ),
                   ),
                      SizedBox(height: 10),

                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text("No", style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                 // Navigator.pushNamed(context, "/doctorsignupform2");

                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  "Yes", style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  Navigator.pushNamed(context,organisation */ /*"/doctorsignupform2"*/ /*);


                },
              ),
            ],
          );
        },
        context: context);*/
  }
}
