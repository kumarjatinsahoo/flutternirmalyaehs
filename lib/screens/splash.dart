import 'dart:async';
import 'dart:convert';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/ConnectionStatusSingleton.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  final MainModel model;

  const SplashScreen({
    Key key,
    this.model,
  }) : super(key: key);

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
  LoginResponse1 loginResponse1;
  String value;
  String selectedLan = "";

  /*@override
  void initState() {
    super.initState();

  }*/
  @override
  void initState() {
    super.initState();
    fetchLocalData();
    callResourceTimer();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);

    // HourlyCallApi.updateFromServer(false, widget.model);

    setState(() {
      isOffline = !connectionStatus.hasConnection;
      if (!connectionStatus.hasConnection) {
        // isFirstTime = true;
        color = Colors.green;
      }
    });
    isFirstTimes();
    // getLocal();
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
        callResourceTimer();
        setState(() => isFirstTym = false);
      } else {
        setState(() => isFirstTym = true);
      }
    } else {
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
                    SizedBox(
                      height: 5.0,
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Text(
                        "Matrujyoti",
                        style: TextStyle(
                            color: AppData.kPrimaryColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )*/
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

  fetchLocalData() async {
    login = await sharedPref.getKey(Const.IS_LOGIN);
    loginData = await sharedPref.getKey(Const.LOGIN_DATA);
    if (login != null && login.replaceAll("\"", "") == "true") {
      setState(() {
        loginResponse1 = LoginResponse1.fromJson(jsonDecode(loginData));
      });
    }
  }

  void callResourceTimer() {
    Timer(Duration(seconds: 5), navigationPage);
  }

  void navigationPage() async {
    //SharedPref sharedPref = SharedPref();
    var login = await sharedPref.getKey(Const.IS_LOGIN);
    if (login != null) {
      if (login.replaceAll("\"", "") == "true" || login.toString() == "true") {
        LoginResponse1 loginResponse1 =
            LoginResponse1.fromJson(jsonDecode(loginData));
        widget.model.setLoginData1(loginResponse1);
        widget.model.token = loginResponse1.body.token;
        widget.model.user = loginResponse1.body.user;
        if (loginResponse1.body.roles[0] == "8".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/patientDashboard', (Route<dynamic> route) => false);
        } else if (loginResponse1.body.roles[0] == "1".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboard', (Route<dynamic> route) => false);
        }else if (loginResponse1.body.roles[0] == "2".toLowerCase()) {
          /*widget.model.token = loginResponse.body.token;widget.model.user = loginResponse.body.user;*/
          Navigator.of(context).pushNamedAndRemoveUntil('/dashDoctor', (Route<dynamic> route) => false);

        } else {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    } else {
      if (isFirstTym)
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/intro', (Route<dynamic> route) => false);
      else
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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
