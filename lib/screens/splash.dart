import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:package_info/package_info.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MasterLoginResponse.dart';
import 'package:user/providers/ConnectionStatusSingleton.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/MyWidget.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  final MainModel model;
  final String mobNo, passWord;

  const SplashScreen({Key key, this.model, this.mobNo, this.passWord})
      : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPref sharedPref = SharedPref();
  bool isFirstTym = true;
  StreamSubscription _connectionChangeStream;
  bool isOffline = true;
  bool isOnline = false;
  Color color = Colors.transparent;
  num myVerCode = 0;
  var myVer;
  var login; //= await sharedPref.getKey(Const.IS_LOGIN);
  var loginData; //= await sharedPref.getKey(Const.LOGIN_DATA);
  var masterResponse; //= await sharedPref.getKey(Const.LOGIN_DATA);
  LoginResponse1 loginResponse1;
  String value;
  var phnNostr, passWordstr;
  String selectedLan = "";
  String androidVersion;
  String iosVersion;

  /*@override
  void initState() {
    super.initState();

  }*/
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    //getVersion();
    fetchLocalData();
    isFirstTimes();
    _initPackageInfo();
    // callResourceTimer();
    // ConnectionStatusSingleton connectionStatus =
    //     ConnectionStatusSingleton.getInstance();
    // _connectionChangeStream =
    //     connectionStatus.connectionChange.listen(connectionChanged);

   /* setState(() {
      isOffline = !connectionStatus.hasConnection;
      if (!connectionStatus.hasConnection) {
        color = Colors.green;
      }
    });*/

  }
  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  getVersion() {
    try {
      widget.model.GETMETHODCALL(
          api: ApiFactory.GET_VERSION,
          fun: (Map<String, dynamic> map) {
            log("Response>>>" + jsonEncode(map));
            if (map["code"] == "success") {
              setState(() {
                androidVersion = map["body"]["android"];
                iosVersion = map["body"]["ios"];
                log("Version>>>" + androidVersion + "<>>" + iosVersion);
                callResourceTimer();
              });
            } else {
              callResourceTimer();
            }
          });
    }catch(e){
      _exitApp();
    }
  }

  Widget dialogVersionUpdate(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              androidVersion = null;
              navigationPage();
            });
          },
          child: Text("Cancel"),
        ),
        MaterialButton(
          onPressed: () {
            // Navigator.pop(context);
            // if(PlatForm.)
            if (Platform.isAndroid) {
              AppData.launchURL(
                  "https://play.google.com/store/apps/details?id=com.ehealthsystem.user");
            } else if (Platform.isIOS) {
              AppData.launchURL(
                  "https://apps.apple.com/in/app/ehealthsystems/id1588667912");
            }
          },
          child: Text("Update"),
        ),
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            // padding: EdgeInsets.only(left: 5, right: 5, top: 20),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "New features added on the latest app please update your app.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void connectionChanged(dynamic hasConnection) {
    if (mounted)
      setState(() {
        isOffline = !hasConnection;
      });
  }

  Future<Null> isFirstTimes() async {
    String isFirstTime = await sharedPref.getKey('first_time');
    if (isFirstTime != null) {
      if (isFirstTime.replaceAll("\"", "") == "false") {
        // callResourceTimer();
        // if(isOffline){
        //   log("Offline mode");
        //   callResourceTimer();
        // }else {
          log("Online mode");
          getVersion();
        // }
        setState(() => isFirstTym = false);
      } else {
        getVersion();
        setState(() => isFirstTym = true);
      }
    } else {
      getVersion();
      // getVersion();
      setState(() => isFirstTym = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Image.asset(
                        //"assets/logo_matru.png",
                        "assets/images/eHealthlogo1.png",
                        fit: BoxFit.fitWidth,
                        //width: 120,
                        height: 210.0,
                      ),
                    ),
                    /*SizedBox(
                      height: 170.0,
                    ),*/
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Text(
                        "Version :"+ _packageInfo.version,
                        style: TextStyle(
                            color: AppData.kPrimaryColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            /* Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  "assets/mobile_bg.png",
                  fit: BoxFit.fitWidth,
                  height: 140,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
  /*PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  });*/
  fetchLocalData() async {
    try {
      login = await sharedPref.getKey(Const.IS_LOGIN);
      loginData = await sharedPref.getKey(Const.LOGIN_DATA);
      phnNostr = await sharedPref.getKey(Const.LOGIN_phoneno);
      passWordstr = await sharedPref.getKey(Const.LOGIN_password);
      masterResponse = await sharedPref.getKey(Const.MASTER_RESPONSE);
      bool isMultiUser = (masterResponse != null) ? true : false;

      if (loginData != null &&
          (login.replaceAll("\"", "") == "true" ||
              login.toString() == "true") &&
          (isMultiUser == null || isMultiUser == false)) {
        _exitApp();
      }

      String phnNostr1 = phnNostr.replaceAll("\"", "");
      String passWordstr1 = passWordstr.replaceAll("\"", "");

      //passWordstr = await sharedPref. getValue() ;
      /*if (login != null && login.replaceAll("\"", "") == "true") {

      setState(() {

     //MyWidgets.showLoading(context);
        */ /*String phnNostr = sharedPref.getKey("phnNo");
        String passWordstr = sharedPref.getKey("passWord");*/ /*
        widget.model.GETMETHODCALL(
            api: ApiFactory.LOGIN_PASS(phnNostr1,passWordstr1),
            fun: (Map<String, dynamic> map) {
              //Navigator.pop(context);
              log("LOGIN RESPONSE>>>>" + jsonEncode(map));
              //AppData.showInSnackBar(context, map[Const.MESSAGE]);
              if (map[Const.CODE] == Const.SUCCESS) {
                setState(() {
                 loginResponse1 = LoginResponse1.fromJson(map);
                  widget.model.token = loginResponse1.body.token;
                  widget.model.user = loginResponse1.body.user;
                  sharedPref.save(Const.LOGIN_DATA, loginResponse1);
                  widget.model.setLoginData1(loginResponse1);
                  //sharedPref.save(Const.IS_LOGIN, "true");
                  FirebaseMessaging.instance.subscribeToTopic(loginResponse1.body.user);
                  FirebaseMessaging.instance.subscribeToTopic(loginResponse1.body.userMobile);
                });
              } else {
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
              }
            });
        //loginResponse1 = LoginResponse1.fromJson(jsonDecode(loginData));
      });
    }*/
    }catch(e){
      log("Error>>>>"+e.getMessage());
      _exitApp();
    }
  }

  void callResourceTimer() {
    // if(androidVersion!=null)
    Timer(Duration(seconds: 2), navigationPage);
  }

  _exitApp() async {
     sharedPref.save(Const.IS_LOGIN, false.toString());
    sharedPref.save(Const.IS_REGISTRATION, false.toString());
    sharedPref.remove(Const.IS_REGISTRATION);
    sharedPref.remove(Const.IS_LOGIN);
    sharedPref.remove(Const.LOGIN_DATA);
    sharedPref.remove(Const.IS_REG_SERVER);
    sharedPref.remove(Const.MASTER_RESPONSE);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  void navigationPage() async {
    //SharedPref sharedPref = SharedPref();
    try {
      if (androidVersion != null && iosVersion!=null &&
          int.tryParse((Platform.isAndroid)?androidVersion:iosVersion) > int.tryParse((Platform.isAndroid)?Const.ANDROID:Const.IOS)) {
        // log("Out login>>>>>>>");
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              dialogVersionUpdate(context),
        );
      } else {
        log("In Login>>>>>>>");
        //////////////////////////////////////////////////////////
        var login = await sharedPref.getKey(Const.IS_LOGIN);
        if (login != null) {
          if (login.replaceAll("\"", "") == "true" ||
              login.toString() == "true") {
            LoginResponse1 loginResponse1 =
            LoginResponse1.fromJson(jsonDecode(loginData));
            MasterLoginResponse master =
            MasterLoginResponse.fromJson(jsonDecode(masterResponse));
            widget.model.setLoginData1(loginResponse1);
            widget.model.token = loginResponse1.body.token;
            widget.model.masterResponse = master;
            widget.model.user = loginResponse1.body.user;

            /*if (androidVersion != null &&
            int.tryParse(androidVersion) > int.tryParse(Const.ANDROID)) {
          dialogVersionUpdate(context);
        } else {*/
            if (loginResponse1.body.roles[0] == "8".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/labDash', (Route<dynamic> route) => false);
            } else if (loginResponse1.body.roles[0] == "1".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboard', (Route<dynamic> route) => false);
            } else if (loginResponse1.body.roles[0] == "7".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboardpharmacy', (Route<dynamic> route) => false);
            } else if (loginResponse1.body.roles[0] == "2".toLowerCase()) {
              /*widget.model.token = loginResponse.body.token;widget.model.user = loginResponse.body.user;*/
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashDoctor', (Route<dynamic> route) => false);
            } else if (loginResponse1.body.roles[0] == "5".toLowerCase()) {
              /*widget.model.token = loginResponse.body.token;widget.model.user = loginResponse.body.user;*/
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboardreceptionlist', (Route<dynamic> route) => false);
            } else if (loginResponse1.body.roles[0] == "12".toLowerCase()) {
              /*widget.model.token = loginResponse.body.token;widget.model.user = loginResponse.body.user;*/
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/ambulancedash', (Route<dynamic> route) => false);
            } else if (loginResponse1.body.roles[0] == "13".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/bloodBankDashboard', (Route<dynamic> route) => false);
            } else if (loginResponse1.body.roles[0] == "22".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/syndicateDashboard', (Route<dynamic> route) => false);
            } else if (loginResponse1.body.roles[0] == "24".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/admin', (Route<dynamic> route) => false);
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          }
        } else {
          if (isFirstTym)
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/intro', (Route<dynamic> route) => false);
          else
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
        }
        //////////////////////////////////////////////////////////
      }
    }catch(e){
      log("Error>>>>"+e.getMessage());
      _exitApp();
    }
  }
/*void navigationPage() async {
    //Navigator.of(context)
    //.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    Navigator.of(context).pushReplacementNamed('/login');
    SharedPref sharedPref = SharedPref();
    var login = await sharedPref.getKey(Const.IS_LOGIN);
    if (login != null) {
      String isLogin = await sharedPref.read(Const.IS_LOGIN);
      if (isLogin == Const.TRUE) {
        //widget.model.dashData(loginData.referenceNo);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/patientDashboard', (Route<dynamic> route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/intro', (Route<dynamic> route) => false);
    }
  }*/
/*void navigationPage() async {
    if (isFirstTym) {
      Navigator.pushNamed(context, "/intro");
    } else {
      Navigator.pushNamed(context, "/login");
    }
  }*/
}
