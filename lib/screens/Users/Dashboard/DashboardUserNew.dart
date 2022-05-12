import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:pageview_indicator_plugins/pageview_indicator_plugins.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/EmergencyHelpModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/NewsupdateModel.dart' as news;
import 'package:user/models/TakeMedModel.dart';
import 'package:user/models/UserDashboardModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import '../../../main.dart';
import '../../../providers/app_data.dart';

// import 'package:add_2_calendar/add_2_calendar.dart';

class DashboardUserNew extends StatefulWidget {
  final MainModel model;

  DashboardUserNew({Key key, this.model}) : super(key: key);

  @override
  _DashboardUserNewState createState() => _DashboardUserNewState();
}

class _DashboardUserNewState extends State<DashboardUserNew> {
  EmergencyHelpModel emergencyHelpModel;
  int _currentIndex = 0;
  int _selectedIndex = 0;
  String motherName, lastPerioddt, deliverydt, id;
  String dateLeft = "0";
  double _height = 75;
  int _selectedDestination = -1;
  UserDashboardModel userDashboardModel;
  bool isDataNotAvail = false;
  news.NewsupdateModel newsupdatemodel;
  String identifier;
  String deviceid;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//List<String>imageSliders;
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

  void _update(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Lan", locale.toString());
    application.onLocaleChanged(locale.toString());
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  PageController _controller = PageController(
    initialPage: 0,
  );
  List<String> imageSliders = [
    "assets/intro/banner3.jpg",
    "assets/intro/banner4.jpg",
  ];

  SharedPref sharedPref = SharedPref();
  LoginResponse1 loginResponse1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callApi();
    callNewsApi();
    // callEmergencyAPI();
    if (loginResponse1.body.userStateId == "21") {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        /*await showDialog(
        context: context,
        barrierDismissible: false,
        builder: dialogGender,
      );*/
        //dialogGender1();
        _displayTextInputDialog1(context);
      });
    }
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      /*  if (message != null) {
        Navigator.pushNamed(context, '/aboutus');
      }*/
      if (message != null &&
          message.data != null &&
          message.data.containsKey("id")) {
        TakeMedModel model = TakeMedModel.fromJson(message.data);
        widget.model.medicineData = model;
        Navigator.pushNamed(context, '/takenpage');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message != null &&
          message.data != null &&
          message.data.containsKey("id")) {
        TakeMedModel model = TakeMedModel.fromJson(message.data);
        widget.model.medicineData = model;
        Navigator.pushNamed(context, '/takenpage');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/aboutus');
      if (message != null &&
          message.data != null &&
          message.data.containsKey("id")) {
        TakeMedModel model = TakeMedModel.fromJson(message.data);
        widget.model.medicineData = model;
        Navigator.pushNamed(context, '/takenpage');
      }
    });
  }

  callEmergencyAPI() {
    print(ApiFactory.EMERGENCY_HELP +
        loginResponse1.body.user +
        "\n" +
        loginResponse1.body.token);

    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.EMERGENCY_HELP + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          print("Value is>>>>" + JsonEncoder().convert(map));
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.STATUS1] == Const.SUCCESS) {
              emergencyHelpModel = EmergencyHelpModel.fromJson(map);
              widget.model.emergencyContact =
                  emergencyHelpModel.emergency.length;
              print(
                  '---Narmada---- ' + widget.model.emergencyContact.toString());
            } else {
              // isDataNotAvail = true;
              // AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  _displayTextInputDialog1(BuildContext context) async {
    bool _rememberMe = false;
    return showDialog(
        context: context,
        barrierDismissible: false,
        /*closeFunction: () {},*/

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
                          /* Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = !_rememberMe;
                                  });
                                },
                              ),
                              //Text("I accept terms & condition",),
                              Expanded(child:
                              Text("log in as Dhan Arogya Kranti User.",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                                  )
                            ],
                          ),*/
                          Row(children: [
                            InkWell(
                                onTap: () {
                                  //Navigator.pop(context);
                                },
                                child: Container(
                                    child: Column(
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = !_rememberMe;
                                        });
                                      },
                                    ),
                                  ],
                                ))),
                            SizedBox(width: 5),
                            Expanded(
                                child: Column(
                              children: [
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: "Log in as Dhan Arogya Kranti User",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      )),
                                  TextSpan(
                                      text: " Know More",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12))
                                ])),
                                /*Text("Log in as Dhan Arogya Kranti User.",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(color: Colors.black, fontSize: 20),
                                        ),*/
                              ],
                            )),
                          ]),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppData.kPrimaryColor,
                                    ),
                                    child: Text(
                                      "CANCEL",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppData.kPrimaryColor,
                                    ),
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          /* InkWell(
                            onTap: (){
                              Navigator.pop(context);

                            },

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(color: AppData.kPrimaryColor),
                                child: Text("CANCEL",style: TextStyle(
                                    color: Colors.white,fontSize: 15),),
                                alignment: Alignment.center,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            /*actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text("OK",
                    style: TextStyle(color: AppData.kPrimaryColor)),

              ),
            ],*/
          );
        });
  }

  /*callProfApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.PATIENT_PROFILE + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          //setState(() {
            log("Value>>>" + jsonEncode(map));
            if (map[Const.CODE] == Const.SUCCESS) {
              log("Value is>>"+map["body"]["profileImage"]);
              */ /*setState(() {*/ /*
                loginResponse1.body.userPic = map["body"]["profileImage"];
              //});
            }
         // });
        });
  }*/

  popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        title: "Success",
        desc: msg,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.USER_DASHBOARD + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          String msg = map[Const.MESSAGE];
          if (map[Const.CODE] == Const.SUCCESS) {
            userDashboardModel = UserDashboardModel.fromJson(map);
            if (!userDashboardModel.body.isEContactAdded ||
                !userDashboardModel.body.isEContactAdded) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (!mounted) dashOption1(context);
              });
            }
          } else {
            isDataNotAvail = true;
            //AppData.showInSnackBar(context, msg);
          }
        });
  }

  callNewsApi() {
    widget.model.GETMETHODCALL(
        api: ApiFactory.NEWSUPDATE_VIEW + loginResponse1.body.user,
        fun: (Map<String, dynamic> map) {
          log("Json Response>>>" + JsonEncoder().convert(map));
          // String msg = map[Const.MESSAGE];
          if (map[Const.CODE] == Const.SUCCESS) {
            // pocReportModel = PocReportModel.fromJson(map);
            setState(() {
              newsupdatemodel = news.NewsupdateModel.fromJson(map);
            });
          } else {}
        });
  }

  String getTime(String date) {
    List<String> split = date.split("-");
    int dt = int.tryParse(split[2]);
    int mon = int.tryParse(split[1]);
    int year = int.tryParse(split[0]);
    //return DateTime(dt, mon, year);
    DateTime dateT = DateTime(year, mon, dt).add(Duration(days: 280));
    int difference = daysBetween(DateTime.now(), dateT);
    return (difference > 0) ? difference.toString() : "0";
  }

  String getDateTimeFormat(String date) {
    if (date != null && date != "Null" && date != "") {
      List<String> split = date.split("-");
      int dt = int.tryParse(split[2]);
      int mon = int.tryParse(split[1]);
      int year = int.tryParse(split[0]);
      DateTime dateT = DateTime(year, mon, dt).add(Duration(days: 280));
      final df = new DateFormat('dd/MM/yyyy');
      df.format(dateT).toString();
    } else {
      return "No Schedule Found";
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Widget dialoggeneratepop(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.only(left: 1, right: 1),
          insetPadding: EdgeInsets.only(left: 1, right: 1),
          content: FittedBox(
            child: Container(
              //alignment: Alignment.center,
              //height: 400,
              child: Stack(
                //alignment: Alignment.topCenter,
                //fit: ,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/banner_pop.jpeg",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.95,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    //alignment: Alignment.bottomRight,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.highlight_remove,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  dashOption1(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding:
                    EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.asset("assets/logo1.png")),
                        ),
                        Text(
                          "Please Complete Your Profile Data",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        MaterialButton(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/profile");
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      backgroundColor: Colors.white,
      appBar: AppBar(
        /* title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            */ /*Text(
              MyLocalizations.of(context).text("DASHBOARD"),
              style: TextStyle(color: Colors.white),
            ),*/
        /*
            //assets/images/User5.png
            //assets/images/user.png
            Image.asset("assets/images/User5.png",height: 50,width: 40,),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, "/profile");
              },
              child: Text(
                "Hi, " + loginResponse1?.body?.userName ?? "N/A",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            //SizedBox(width: 40),
            Row(
              children: [
                */
        /*Text(
                  "Hi, " + loginResponse1?.body?.userName ?? "N/A",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 20),*/
        /*
                //Spacer(),
                InkWell(onTap: (){
                  Navigator.pushNamed(context, "/medicinereminder");
                },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image.asset("assets/clock.png",height: 30,width: 30,color: Colors.white,),
                  ),
                ),
              ],
            )
          ],
        ),*/
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(25),
            //     child: (loginResponse1?.body?.userPic!=null)?
            //     Image.network(
            //       loginResponse1?.body?.userPic,
            //       width: 30,
            //       height: 30,
            //     ):Image.asset("assets/images/Dashboardimg5.png",
            //       width: 30,
            //       height: 30,),),
            ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: (loginResponse1?.body?.userPic != null)
                    ? Image.network(
                        loginResponse1?.body?.userPic,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/images/Dashboardimg5.png",
                              width: 30, height: 30);
                        },
                      )
                    : Image.asset("assets/images/Dashboardimg5.png",
                        width: 30, height: 30)
                //     Image.asset(
                //   "assets/images/user.png",
                //   // 'assets/images/Dashboardprofile.png',
                //   height: size.height * 0.05,
                //   width: size.width * 0.10,
                //   //fit: BoxFit.cover,
                // ),
                /*: Image.network(
                                    loginResponse1.body.userPic,
                                    height: size.height * 0.07,
                                    width: size.width * 0.13,
                                    //fit: BoxFit.cover,
                                  )*/
                ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
                child: Text(
                  "Hi, " + loginResponse1?.body?.userName ?? "N/A",
                  // "Hi, Suvam",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/medicinereminder");
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                "assets/clock.png",
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
        centerTitle: true,
        titleSpacing: 5,
        //iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.kPrimaryColor,
        elevation: 0,
      ),
      body: _dashboardnew(context),
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    color: AppData.kPrimaryColor,
                    width: double.infinity,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 40.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*  Container(
                            height: size.height * 0.07,
                            width: size.width * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(55),
                                border: Border.all(color: Colors.white, width: 0.5),
                                color: Colors.white),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(55),
                                child: Image.asset(
                                  'assets/images/user.png',
                                  height: size.height * 0.07,
                                  width: size.width * 0.13,
                                  //fit: BoxFit.cover,
                                )),
                          ),*/
                          ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: (loginResponse1?.body?.userPic != null)
                                  ? Image.network(
                                      loginResponse1?.body?.userPic,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            "assets/images/Dashboardimg5.png",
                                            width: 40,
                                            height: 40);
                                      },
                                    )
                                  : Image.asset(
                                      "assets/images/Dashboardimg5.png",
                                      width: 40,
                                      height: 40)
                              //     Image.asset(
                              //   "assets/images/user.png",
                              //   // 'assets/images/Dashboardprofile.png',
                              //   height: size.height * 0.05,
                              //   width: size.width * 0.10,
                              //   //fit: BoxFit.cover,
                              // ),
                              /*: Image.network(
                                    loginResponse1.body.userPic,
                                    height: size.height * 0.07,
                                    width: size.width * 0.13,
                                    //fit: BoxFit.cover,
                                  )*/
                              ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "Hi, " + loginResponse1?.body?.userName ?? "N/A",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 10,
                    child: Container(
                      width: size.width,
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15),
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
                                iconEnabledColor: Colors.white,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    AppData.setSelectedLan(newValue);
                                    _update(Locale(languagesMap[newValue]));
                                  });
                                  print(AppData.selectedLanguage);
                                },
                                dropdownColor: Colors.black,
                                items: languagesList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
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
                  )
                ],
              ),

              ListTile(
                leading: Icon(Icons.dashboard,
                    color: AppData.menublueColor, size: 27),
                title: Text(
                  MyLocalizations.of(context).text("DASHBOARD"),
                ),
                selected: _selectedDestination == 0,
                onTap: () {
                  selectDestination(0);
                  Navigator.pop(context);
                  /* final Event event = Event(
                    title: 'Event title',
                    description: 'Event description',
                    location: 'Event location',
                    startDate: DateTime.now(),
                    endDate: DateTime.now(),
                    iosParams: IOSParams(
                      reminder: Duration(minutes: 20), // on iOS, you can set alarm notification after your event.
                    ),
                    androidParams: AndroidParams(
                      emailInvites: [], // on Android, you can add invite emails to your event.
                    ),
                  );
                  Add2Calendar.addEvent2Cal(event);*/
                },
                onLongPress: () {
                  Navigator.pushNamed(context, "/razor");
                },
              ),
              ListTile(
                leading: Image.asset(
                  "assets/images/myprofile.png",
                  height: 30,
                  //color: Colors.redAccent,
                ),
                title: Text(
                  MyLocalizations.of(context).text("MY_PROFILE"),
                ),
                selected: _selectedDestination == 1,
                onTap: () {
                  selectDestination(1);
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              /* ListTile(
                leading: Image.asset(
                  "assets/images/home.png",
                  height: 30,
                ),
                // leading: Icon(Icons.person),
                title: Text('Home'),
                selected: _selectedDestination == 2,
                onTap: () {
                  selectDestination(2);
                  //Navigator.pushNamed(context, "/profile");
                 // Navigator.pushNamed(context, "/dashboardpharmacy");
                },
              ),*/
              /* ListTile(
                leading: Image.asset(
                  "assets/images/account.png",
                  height: 30,
                ),
                // leading: Icon(Icons.person),
                title: Text('Manage Account'),
                selected: _selectedDestination == 3,
                onTap: () {
                  selectDestination(3);
                  // Navigator.pushNamed(context, "/patientDashboard");
                },
              ),*/
              ListTile(
                leading: Image.asset(
                  "assets/images/aboutus.png",
                  height: 30,
                ),
                // leading: Icon(Icons.person),
                title: Text(MyLocalizations.of(context).text("ABOUT_US")),
                selected: _selectedDestination == 4,
                onTap: () {
                  selectDestination(4);
                  Navigator.pushNamed(context, "/aboutus");
                  //Navigator.pushNamed(context, "/insurancenew");
                },
              ),
              /* ListTile(
                  leading: Image.asset(
                    "assets/images/share.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("SHARE")),
                  selected: _selectedDestination == 5,
                  onTap: () {
                    selectDestination(5);
                    FlutterShare.share(
                        title: 'Example share',
                        text: 'Example share text',
                        linkUrl: 'https://flutter.dev/',
                        chooserTitle: 'Example Chooser Title'
                    );
                    //share();
                    //Navigator.pushNamed(context, "/dashboard1");
                    //Navigator.pushNamed(context, "/emergencydetails");
                  }),*/
              ListTile(
                  leading: Image.asset(
                    "assets/images/contact us.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("CONTACT_US")),
                  selected: _selectedDestination == 6,
                  onTap: () {
                    selectDestination(6);
                    //widget.model.contactscreen = MyLocalizations.of(context).text("CONTACT_SCREEN");
                    Navigator.pushNamed(context, "/contactus");
                    //Navigator.pushNamed(context, "/discountoffer");
                  }),
              /*  ListTile(
                  leading: Image.asset(
                    "assets/images/support.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("SUPPORT")),
                  selected: _selectedDestination == 7,
                  onTap: () {
                    selectDestination(7);
                    widget.model.contactscreen = MyLocalizations.of(context).text("SUPPORT_SCREEN");
                    Navigator.pushNamed(context, "/contactus");
                  }),*/

              ListTile(
                  leading: Image.asset(
                    "assets/images/changepassword.png",
                    height: 30,
                  ),
                  title:
                      Text(MyLocalizations.of(context).text("CHANGE_PASSWORD")),
                  selected: _selectedDestination == 8,
                  onTap: () {
                    selectDestination(8);
                    Navigator.pushNamed(context, "/changePassword");
                    //Navigator.pushNamed(context, "/takenpage");
                  }),
              /*  ListTile(
                  leading: Image.asset(
                    "assets/images/reminder.png",
                    height: 30,
                  ),
                  title: Text('Reminder'),
                  selected: _selectedDestination == 8,
                  onTap: () {
                    selectDestination(8);
                    //Navigator.pushNamed(context, "/share");
                  }),*/
              // ListTile(
              //   leading: Icon(Icons.person,
              //       color: AppData.kPrimaryRedColor, size: 30),
              //   title: Text('Notifications'),
              //   selected: _selectedDestination == 9,
              //   onTap: () {
              //     selectDestination(9);
              //     //   Navigator.pushNamed(context, "/patientRegistration");
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.help_center,
              //       color: AppData.menublueColor, size: 27),
              //   title: Text('Help'),
              //   selected: _selectedDestination == 10,
              //   onTap: () {
              //     selectDestination(10);
              //     //Navigator.pushNamed(context, "/help");
              //   },
              //   // onTap: () {
              //   // },
              // ),
              /* ListTile(
                  leading: Icon(Icons.collections,
                      color: AppData.kPrimaryRedColor, size: 27),
                  title: Text('My Orders'),
                  selected: _selectedDestination == 11,
                  onTap: () {
                    selectDestination(11);
                    Navigator.pushNamed(context, "/myorder");
                  }),*/
              /*ListTile(
                  leading: Icon(Icons.calendar_today,
                      color: AppData.menublueColor, size: 25),
                  title: Text('Monthly Overview'),
                  selected: _selectedDestination == 12,
                  onTap: () {
                    selectDestination(12);
                    Navigator.pushNamed(context, "/monthlyview");
                  }),
              ListTile(
                  leading: Icon(Icons.healing,
                      color: AppData.kPrimaryRedColor, size: 27),
                  title: Text('Processed Orders'),
                  selected: _selectedDestination == 13,
                  onTap: () {
                    selectDestination(13);
                    Navigator.pushNamed(context, "/processedorders");
                  }),*/
              // ListTile(
              //   leading:
              //       Icon(Icons.home, color: AppData.menublueColor, size: 27),
              //   title: Text('Set Discount and Offer'),
              //   selected: _selectedDestination == 14,
              //   onTap: () {
              //     selectDestination(14);
              //     Navigator.pushNamed(context, "/setdiscount");
              //   },
              // ),
              // ListTile(
              //   leading:
              //       Icon(Icons.home, color: AppData.kPrimaryRedColor, size: 27),
              //   title: Text('Tab Instruction'),
              //   selected: _selectedDestination == 15,
              //   onTap: () {
              //     selectDestination(15);
              //     //Navigator.pushNamed(context, "/tabinstruction");
              //   },
              // ),
              // ListTile(
              //   leading:
              //   Icon(Icons.home, color: AppData.kPrimaryRedColor, size: 27),
              //   title: Text('Setup Contacts'),
              //   selected: _selectedDestination == 15,
              //   onTap: () {
              //    // selectDestination(15);
              //     Navigator.pushNamed(context, "/setupcontacts");
              //   },
              // ),
              ListTile(
                leading: Image.asset(
                  "assets/images/logout.png",
                  height: 30,
                ),
                title: Text(MyLocalizations.of(context).text("LOGOUT")),
                selected: _selectedDestination == 16,
                onTap: () {
                  //FirebaseMessaging.instance.unsubscribeFromTopic(loginResponse1.body.user);
                  FirebaseMessaging.instance
                      .unsubscribeFromTopic(loginResponse1.body.user);
                  FirebaseMessaging.instance
                      .unsubscribeFromTopic(loginResponse1.body.userMobile);
                  selectDestination(16);
                  _exitApp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _exitApp() async {
    FirebaseMessaging.instance.unsubscribeFromTopic(loginResponse1.body.user);
    FirebaseMessaging.instance
        .unsubscribeFromTopic(loginResponse1.body.userMobile);
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

  Widget _dashboardnew(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.65,
              child: PageView(
                controller: _controller,
                children: [
                  MyPage1Widget(model: widget.model, size: size),
                  //MyPage2Widget(),
                ],
              ),
            ),
            PageIndicator(
              length: 1,
              pageController: _controller,
              currentColor: Colors.grey,
              normalColor: Colors.black12,
            ),
            CarouselSlider(
              options: CarouselOptions(
                  // height: size.height * 0.3,
                  // height: size.height * 0.27,
                  height: size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      size.height * 0.65 -
                      10,
                  autoPlay: true,
                  pageSnapping: true,
                  viewportFraction: 1,
                  scrollDirection: Axis.horizontal,
                  disableCenter: true,
                  autoPlayInterval: Duration(seconds: 10),
                  //autoPlayAnimationDuration: Duration(seconds: 90),
                  pauseAutoPlayInFiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _currentIndex = index;
                      },
                    );
                  }),
              /*items: imageSliders
        .map((item) => InkWell(
*/
              items: (newsupdatemodel != null)
                  ? newsupdatemodel.body
                      .map((item) => InkWell(
                            onTap: () {
                              // int index = imageSliders.indexOf(item);
                              AppData.launchURL(item.vdoURL);
                            },
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        item.fileName,
                                        fit: BoxFit.fill,
                                        width: 1000,
                                        height: double.maxFinite,
                                        //height: 100,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                (newsupdatemodel.body
                                                                .indexOf(item) +
                                                            1)
                                                        .toString() +
                                                    "/" +
                                                    newsupdatemodel.body.length
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      /* Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: (imageSliders.indexOf(item) == 0 ||
                                            imageSliders.indexOf(item) == 1 ||
                                            imageSliders.indexOf(item) == 2 ||
                                            imageSliders.indexOf(item) == 3 ||
                                            imageSliders.indexOf(item) == 4 ||
                                            imageSliders.indexOf(item) == 7 ||
                                            imageSliders.indexOf(item) == 9 ||
                                            imageSliders.indexOf(item) == 10)
                                        ? Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 45,
                                          )
                                        : Container(),
                                  ),*/
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList()
                  : imageSliders
                      .map((item) => InkWell(
                            onTap: () {
                              // int index = imageSliders.indexOf(item);
                              // AppData.launchURL(item.vdoURL);
                            },
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        item,
                                        fit: BoxFit.fill,
                                        width: 1000,
                                        height: double.maxFinite,
                                        //height: 100,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                (imageSliders.indexOf(item) + 1)
                                                        .toString() +
                                                    "/" +
                                                    imageSliders.length
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      /* Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: (imageSliders.indexOf(item) == 0 ||
                                            imageSliders.indexOf(item) == 1 ||
                                            imageSliders.indexOf(item) == 2 ||
                                            imageSliders.indexOf(item) == 3 ||
                                            imageSliders.indexOf(item) == 4 ||
                                            imageSliders.indexOf(item) == 7 ||
                                            imageSliders.indexOf(item) == 9 ||
                                            imageSliders.indexOf(item) == 10)
                                        ? Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 45,
                                          )
                                        : Container(),
                                  ),*/
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        Navigator.pushNamed(context, "/profile");
      } else if (index == 2) {
        Navigator.pushNamed(context, "/support");
      }
      _selectedIndex = index;
    });
  }

  Widget _buildTileblue(
      {/*String icon,*/ IconData icon,
      String title,
      double size,
      Color bordercolor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: _height,
        width: (MediaQuery.of(context).size.width - 80) / 3,
        decoration: BoxDecoration(

            /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(10.0),
            ),
            color: color,
            border: Border.all(
              color: AppData.kPrimaryColor,
              width: 1.0,
            )
            /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
            ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    /* child: Image.asset(
                    "assets/logo1.png",
                    fit: BoxFit.fitWidth,
                    //width: ,
                    height: 60.0,),*/
                    child:
                        Icon(icon, color: AppData.kPrimaryColor, size: 40.0)),

                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                /*Padding(
                      padding: const EdgeInsets.only( top: 10,left: 3,right: 3
                      ),
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                  title,
                  style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                          ),
                        ],
                      ),
                    ),*/
              ],
            ),
            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40,
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }

  Widget _buildTile1(
      {icon,
      String title,
      double size,
      Color bordercolor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: _height,
        width: (MediaQuery.of(context).size.width - 80) / 3,
        decoration: BoxDecoration(
          /// borderRadius: BorderRadius.circular(7.0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.zero,
          ),
          color: color,

          /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
/*                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTilered(
      {IconData icon,
      String title,
      double size,
      Color bordercolor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: _height,
        width: (MediaQuery.of(context).size.width - 80) / 3,
        decoration: BoxDecoration(

            /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.zero,
            ),
            color: color,
            border: Border.all(
              color: AppData.kPrimaryRedColor,
              width: 1.0,
            )
            /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
            ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    /* child: Image.asset(
                    "assets/logo1.png",
                    fit: BoxFit.fitWidth,
                    //width: ,
                    height: 60.0,

                  ),*/
                    child: Icon(icon,
                        color: AppData.kPrimaryRedColor, size: 40.0)),

                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                /*Padding(
                      padding: const EdgeInsets.only( top: 10,left: 3,right: 3
                      ),
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                  title,
                  style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                          ),
                        ],
                      ),
                    ),*/
              ],
            ),
            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40, AppData.showInSnackBar(context, "Please select State");
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }

  sendDeviceInfo() {
    Map<String, dynamic> postmap = {
      "userId": widget.model.user,
      "imeiNo": identifier,
      "version": "2.1.2",
      "deviceId": deviceid,
      "activityDate": "18-12-2021",
      "activityTime": currentTime,
      "type": "LOGIN",
      "status": "SUCCESS",
      "deviceToken": widget.model.activitytoken
    };

    log("Print data>>>>" + jsonEncode(postmap));
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        //api: ApiFactory.POST_APPOINTMENT,
        api: ApiFactory.POST_ACTIVITYLOG,
        token: widget.model.token,
        json: postmap,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          log("Json Response activity log>>" + jsonEncode(map));
          if (map["code"] == Const.SUCCESS) {
            AppData.showInSnackDone(context, map[Const.MESSAGE]);
            //AppData.showInSnackBar(context, "Chenai server hela");
            // postmap["appointid"]=map["aptid"];
            //sendLocalServer(postmap);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });
  }

  deviceInfoo() async {
    identifier = await UniqueIdentifier.serial;
    print("ideeennttiiiffieerr" + identifier);
  }

  deviceInfooo() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    deviceid = androidInfo.androidId;
    // e.g. "Moto G (4)"
  }
}

class MyPage1Widget extends StatelessWidget {
  var widget;
  double _height = 85;
  double _width;

  final MainModel model;
  final Size size;
  LoginResponse1 loginResponse1;

  MyPage1Widget({Key key, this.model, this.size}) : super(key: key);


  chooseAppointment(BuildContext context, model) {
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
                          title: Center(child: Text("Health Screening")),
                          onTap: () {
                            model.apntUserType = Const.HEALTH_SCREENING_APNT;
                            // widget.model.apntUserType = "Health Screening"/*Const.HEALTH_SCREENING_APNT*/;

                            Navigator.pushNamed(context, "/userApnt");
                            Navigator.pop(context);
                            // AppData.showInSnackBar(context,"hi");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(child: Text("Health Check-up")),
                          onTap: () {
                            model.apntUserType = Const.HEALTH_CHKUP_APNT;
                            //widget.model.apntUserType = "Health Check-up";
                            Navigator.pushNamed(context, "/userApnt");
                            Navigator.pop(context);
                          },
                        ),
                        Divider(),
                        ListTile(
                          // icon: Icons.calendar_today,
                          title: Center(child: Text("Doctor Appointment")),
                          onTap: () {
                            Navigator.pushNamed(context, "/userAppoint");
                            // Navigator.pushNamed(context, "/doctorconsultationPage");
                            // Navigator.pop(context);
                          },
                        ),
                        /* ListTile(
                          title: Text("Health Screening"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                            //widget.model.apntUserType =Const.HEALTH_SCREENING_APNT;

                            Navigator.pushNamed(context, "/docApnt");
                            Navigator.pop(context);
                            // AppData.showInSnackBar(context,"hi");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Health Check-up"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                            //widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;

                            Navigator.pushNamed(context, "/docApnt");
                            Navigator.pop(context);
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Doctor Appointment"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {

                            //widget.model.apntUserType = Const.DOC_APNT;
                            Navigator.pushNamed(context, "/doctorconsultationPage");
                            Navigator.pop(context);
                          },
                        ),*/
                        Divider(),
                        MaterialButton(
                          child: Text(
                            "CANCEL",
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

  Widget _Tilered({IconData icon, String title, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 35,
            ),
            SizedBox(
              width: 20,
            ),
            Text(title,
                style: TextStyle(
                    /*fontWeight: FontWeight.w300,*/
                    fontSize: 17,
                    color: Colors.black),
                textAlign: TextAlign.center),
            //Icon(Icons.search, color: Colors.white),
          ],
        ),
      ),
    );
  }

  _displayTextInputDialog(BuildContext context, int v) async {
    bool _rememberMe = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.45,
                  padding: EdgeInsets.all(19),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Get your health insurance & checkup done now ",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
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
                              //Text("I accept terms & condition",),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/termsandConditionPage");
                                },
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "I accept "),
                                  TextSpan(
                                      text: "terms & conditions",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ))
                                ])),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    AppData.launchURL("tel://8888825912");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppData.kPrimaryColor,
                                    ),
                                    child: Text(
                                      "Contact Sales",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    AppData.showInSnackDone(context,
                                        "Thank you ! We will get back to you with in two working days");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppData.kPrimaryColor,
                                    ),
                                    child: Text(
                                      "Get a call back",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              if (v == 2) {
                                Navigator.pushNamed(context, "/insurancenew");
                              } else {
                                Navigator.pushNamed(
                                    context, "/medicalrecordpage");
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                              ),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              // FlatButton(
              //   textColor: Colors.grey,
              //   child: Text(MyLocalizations.of(context).text("CANCEL"),
              //       style: TextStyle(color: AppData.kPrimaryRedColor)),
              // ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _width = (MediaQuery.of(context).size.width - 80) / 3;
    loginResponse1 = model.loginResponse1;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (loginResponse1.body?.userStateId != null &&
                      loginResponse1.body?.userStateId == "21")
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Expanded(
                            child: _buildTilePremium(
                              icon: "assets/folder.png",
                              fun: () {
                                //AppData.showInSnackBar(context, "Coming soon");
                                //Navigator.pushNamed(context, "/medicalrecordpage");
                                _displayTextInputDialog(context, 1);
                              },
                              color: AppData.BG2BLUE,
                              bordercolor: AppData.BG2BLUE,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            /* child: Expanded(*/
                            child: Text(
                              MyLocalizations.of(context)
                                  .text("MEDICAL_RECORD"),
                              textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                              // style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ])
                  : Container(
                      height: size.height * 0.65/4 - (size.height * 0.03 -15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTileblue(
                                icon: "assets/folder.png",
                                fun: () {
                                  //AppData.showInSnackBar(context, "Coming soon");
                                  Navigator.pushNamed(
                                      context, "/medicalrecordpage");
                                  // _displayTextInputDialog(context,1);
                                },
                                size: size
                                /*color: AppData.BG2BLUE,
                        bordercolor: AppData.BG2BLUE,*/
                                // ,
                                ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 100,
                              height: 35,
                              /* child: Expanded(*/
                              child: Text(
                                MyLocalizations.of(context)
                                    .text("MEDICAL_RECORD"),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                                //overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                    ),
              SizedBox(
                width: 5,
              ),
              (loginResponse1.body?.userStateId != null &&
                      loginResponse1.body.userStateId == "21")
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          _buildTilePremium1(
                            icon: "assets/insuranceF.png",
                            //icon: Icons.drive_folder_upload,
                            //icon: FontAwesomeIcons.accusoft,
                            title: "Upload Medical Data",
                            fun: () {
                              //AppData.showInSnackDone(context, "Coming Soon");
                              //Navigator.pushNamed(context, "/insuranceList");
                              _displayTextInputDialog(context, 2);

                              /*  AppData.showSnack(
                                    context, "Coming soon", Colors.green);*/
                            },
                            color: AppData.BG1RED,
                            bordercolor: AppData.BG1RED,
                            //size: (size.width - 130) / 3,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            /* child: Expanded(*/
                            child: Text(
                              MyLocalizations.of(context).text("INSURANCE"),
                              textAlign: TextAlign.center,

                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ])
                  : Container(
                height: size.height * 0.65/4 - (size.height * 0.03 -15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            _buildTilered(
                              icon: "assets/insuranceF.png",
                              size: size,
                              title: "Upload Medical Data",
                              fun: () {
                                //AppData.showInSnackDone(context, "Coming Soon");
                                (loginResponse1.body?.userStateId != null &&
                                        loginResponse1.body.userStateId == "21")
                                    ? Navigator.pushNamed(
                                        context, "/insurancenew")
                                    : Navigator.pushNamed(
                                        context, "/insuranceList");

                                //_displayTextInputDialog(context,2);

                                /*  AppData.showSnack(
                                      context, "Coming soon", Colors.green);*/
                              },
                              /*color: AppData.BG1RED,
                        bordercolor: AppData.BG1RED,*/
                              //size: (size.width - 130) / 3,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 100,
                              height: 35,
                              /* child: Expanded(*/
                              child: Text(
                                MyLocalizations.of(context).text("INSURANCE"),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                                //overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                  ),
              SizedBox(
                width: 5,
              ),
              /* Expanded(*/
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTile1(
                      //icon: "assets/meditate.png",
                      icon: Icons.local_offer,
                      //icon: FontAwesomeIcons.accusoft,
                      size:size,
                      title: "HELP",
                      fun: () {
                        //AppData.showInSnackBar(context, "Coming soon");
                        // AppData.showSnack(
                        //   context, "Coming soon", Colors.green);
                        print(model.emergencyContact);
                        /*if (model.emergencyContact == 0) {
                          Navigator.pushNamed(context, "/setupcontacts");
                        } else {*/
                        Navigator.pushNamed(context, "/emergencyHelp");
                        // }
                      },
                      color: AppData.kPrimaryRedColor,
                      bordercolor: AppData.kPrimaryRedColor,
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("EMERGENCY_HELP"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /*Align(
                                        alignment: Alignment.center,
                                        child: Expanded(
                                          child: Text(
                                            " Emergency Help",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),*/
                  ]),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                        size: size,
                        icon: "assets/search_icon.png",
                        fun: () {
                          Navigator.pushNamed(
                              context, "/findHealthcareService");
                          //AppData.showInSnackBar(context, "Coming soon");
                        },
                        /*  color: AppData.BG1RED,
                        bordercolor: AppData.BG1RED,*/
                        //size: (size.width - 130) / 3,
                        fun2: () {
                          Navigator.pushNamed(context, "/covidMobile");
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("HEALTHCARE_SERVICE"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              SizedBox(
                width: 5,
              ),
              /*Expanded(
                      child:*/
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      icon: "assets/generic_medicine.png",
                      //icon: Icons.animation,
                      //icon: FontAwesomeIcons.accusoft,
                      title: "Generic Medical Stores",
                      size: size,
                      fun: () {
                        //AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/geneicstores");
                        // AppData.showSnack(
                        //   context, "Coming soon", Colors.green);
                      },
                      /*color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,*/
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context)
                            .text("GENERIC_MEDICAL_STORE"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              SizedBox(
                width: 5,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                      size: size,
                      icon: "assets/ambulance.png",
                      //icon: Icons.search,
                      //icon: FontAwesomeIcons.accusoft,
                      title: "Book Ambulance",
                      fun: () {
                        //AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/bookAmbulancelist");
                      },
                      /* color: AppData.BG1RED,
                      bordercolor: AppData.BG1RED,*/
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: Text(
                        MyLocalizations.of(context).text("BOOK_AMBULANCE"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              /*Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                      icon: "assets/offers.png",
                      fun: () {
                        AppData.showInSnackDone(context, "Coming Soon");
                        // Navigator.pushNamed(context, "/discountoffer");
                        //AppData.showInSnackBar(context, "Coming soon");
                      },
                      //color: AppData.BG2BLUE,
                      color: AppData.BG1RED,
                      bordercolor: AppData.BG1RED,
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: Text(
                        MyLocalizations.of(context).text("DISCOUNT_OFFER"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  ]),*/
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /*Expanded(
                          child:*/
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      size: size,
                      icon: "assets/blooddonationuser.png",
                      //icon: Icons.search,
                      //icon: FontAwesomeIcons.accusoft,
                      title: " Order Blood ",
                      fun: () {
                        Navigator.pushNamed(context, "/bookBloodBanklist");
                        // Navigator.pushNamed(context, "/healthCheckup");
                      },
                      iconColor: AppData.kPrimaryBlueColor,
                      /*color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,*/
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: Text(
                        MyLocalizations.of(context).text("ORDER_BLOOD"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              SizedBox(
                width: 5,
              ),
              /*Expanded(*/

              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                      size: size,
                      icon: "assets/AppmntF.png",
                      fun: () {
                        //chooseAppointment(context, model);
                        //Navigator.pushNamed(context, "/userAppoint");
                        Navigator.pushNamed(context, "/myAppointment");
                        /*Navigator.pushNamed(
                                      context, "/medipedia");*/
                        // AppData.showSnack(
                        //     context, "Coming soon", Colors.green);
                      },
                      /*color: AppData.BG1RED,
                      bordercolor: AppData.BG1RED,*/
                      // size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("APPOINTMENT"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /*Align(
                                        alignment: Alignment.center,
                                        child: Expanded(
                                          child: Text(
                                            "Govternment Schemes",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),*/
                  ]),
              SizedBox(
                width: 5,
              ),
              /* Expanded(
                                child: */
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      size: size,
                      icon: "assets/clock.png",
                      //icon: Icons.alarm,
                      //icon: FontAwesomeIcons.accusoft,
                      title: "Medicine Reminder",
                      fun: () {
                        //AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/medicinereminder");
                        // AppData.showSnack(
                        //     context, "Coming soon", Colors.green);
                      },
                      /* color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,*/
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("MEDICINE_REMINDER"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /*Align(
                                        alignment: Alignment.center,
                                        child: Expanded(
                                          child: Text(
                                            "Medicine Reminder",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),*/
                  ]),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                      icon: "assets/organ_donner.png",
                      //icon: Icons.wc_rounded,
                      //icon: FontAwesomeIcons.accusoft,
                      title: "Organ  Donation",
                      fun: () {
                        Navigator.pushNamed(context, "/organdonation");
                        // AppData.showSnack(
                        //     context, "Coming soon", Colors.green);
                      },
                      /*color: AppData.BG1RED,
                      bordercolor: AppData.BG1RED,*/
                      // size: (size.width - 130) / 3,
                        size: size,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("ORGAN_DONATION"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /* Align(
                                          alignment: Alignment.center,
                                          child: Expanded(
                                            child: Text(
                                              "Organ     Donation",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),*/
                  ]),
              SizedBox(
                width: 5,
              ),

              /* Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      icon: "assets/health-careF.png",
                      fun: () {
                        //AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/preventivehealthcare");
                        // AppData.showSnack(
                        //   context, "Coming soon", Colors.green);
                      },
                      color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: Expanded(
                        child: Text(
                          MyLocalizations.of(context)
                              .text("PREVENTIVE_HEALTHCARE"),
                          textAlign: TextAlign.center,
                          //overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ]),*/

              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      size: size,
                      icon: "assets/govtscheme.png",
                      //icon: Icons.home_outlined,
                      //icon: FontAwesomeIcons.accusoft,
                      title: "Govt Schemes",
                      fun: () {
                        //AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/govtschemes");
                        //Navigator.pushNamed(context, "/govetschemeslist");
                        // AppData.showSnack(
                        //     context, "Coming soon", Colors.green);
                      },
                      /*color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,*/
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("GOVT_SCHEMES"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),

              /*
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      icon: "assets/health-careF.png",
                      fun: () {
                        //AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/vdo");
                        // AppData.showSnack(
                        //   context, "Coming soon", Colors.green);
                      },
                      color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,
                      //size: (size.width - 130) / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                       child: Expanded(
                      child: Text(
                        MyLocalizations.of(context)
                            .text("PREVENTIVE_HEALTHCARE"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    )
                  ]),
*/
              SizedBox(
                width: 5,
              ),
              /* Expanded(
                                child: */

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTilered(
                    icon: "assets/medipedia.png",
                    fun: () {
                      // AppData.showInSnackDone(context, "Coming Soon");
                      Navigator.pushNamed(context, "/medipedia");
                      // AppData.showSnack(
                      //     context, "Coming soon", Colors.green);
                    },
                    /* color: AppData.BG1RED,
                    bordercolor: AppData.BG1RED,*/
                    // size: (size.width - 130) / 3,
                      size: size,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 100,
                    height: 35,
                    /* child: Expanded(*/
                    child: Text(
                      MyLocalizations.of(context).text("MEDIPEDIA"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  /*Align(
                                          alignment: Alignment.center,
                                          child: Expanded(
                                            child: Text(
                                              "Govternment Schemes",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),*/
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  /* Future<void> shareFile() async {
    List<dynamic> docs = await DocumentsPicker.pickDocuments;
    if (docs == null || docs.isEmpty) return null;

    await FlutterShare.shareFile(
      title: 'Example share',
      text: 'Example share text',
      filePath: docs[0] as String,
    );
  }*/
  Widget _buildTileblue(
      {String icon,
      /*IconData icon,*/
      String title,
      // double size,
      Color bordercolor,
      Color iconColor,
      Color color,
      Size size,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        // padding: EdgeInsets.all(10.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: size.height * 0.1525 - 45,
        width: size.height * 0.1525 - 45,
        // width: _width,
        decoration: BoxDecoration(

            /// borderRadius: BorderRadius.circular(7.0),
            /* borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(10.0),
            ),*/
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: AppData.kPrimaryBlueColor,
              width: 1.0,
            )
            /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
            ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      /* "assets/logo1.png"*/
                      icon,
                      color: iconColor ?? null,
                      fit: BoxFit.fitWidth,
                      width: size.height * 0.05,
                      height: size.height * 0.05,
                    )),
                //child: Icon(icon, color: AppData.kPrimaryColor,size: 40.0)),

                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                /*Padding(
                      padding: const EdgeInsets.only( top: 10,left: 3,right: 3
                      ),
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                  title,
                  style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                          ),
                        ],
                      ),
                    ),*/
              ],
            ),

            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40,
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }

  Widget _buildTilePremium(
      {String icon,
      String title,
      double size,
      Color bordercolor,
      Color iconColor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          color: color,
          image:
              DecorationImage(image: AssetImage("assets/images/premium2.png")),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      /* "assets/logo1.png"*/
                      icon,
                      color: iconColor ?? null,
                      fit: BoxFit.fitWidth,
                      width: 50,
                      height: 70.0,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTilePremium1(
      {String icon,
      /*IconData icon,*/
      String title,
      double size,
      Color bordercolor,
      Color iconColor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          // /// borderRadius: BorderRadius.circular(7.0),
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(10.0),
          //   topRight: Radius.zero,
          //   bottomLeft: Radius.zero,
          //   bottomRight: Radius.circular(10.0),
          // ),
          color: color,
          image:
              DecorationImage(image: AssetImage("assets/images/premium3.png")),
          // border: Border.all(
          //   //color: AppData.kPrimaryRedColor,
          //   color: Colors.amber,
          //   width: 2.5,
          // )
          /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      /* "assets/logo1.png"*/
                      icon,
                      color: iconColor ?? null,
                      fit: BoxFit.fitWidth,
                      width: 50,
                      height: 70.0,
                    )),
                //child: Icon(icon, color: AppData.kPrimaryColor,size: 40.0)),

                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                /*Padding(
                      padding: const EdgeInsets.only( top: 10,left: 3,right: 3
                      ),
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                  title,
                  style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                          ),
                        ],
                      ),
                    ),*/
              ],
            ),
            // Positioned(
            //     right: 9,
            //     top: 3,
            //     child: Icon(
            //       /* "assets/logo1.png"*/
            //       FontAwesomeIcons.crown,
            //       color: Colors.amberAccent,
            //       size: 15,
            //     )),

            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40,
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }

  Widget _buildTile1(
      {icon,
      String title,
      Size size,
      Color bordercolor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: size.height * 0.1525 - 45,
        width: size.height * 0.1525 - 45,
        decoration: BoxDecoration(
          /// borderRadius: BorderRadius.circular(7.0),
          /* borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.zero,
          ),*/
          shape: BoxShape.circle,
          color: color,

          /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit:BoxFit.fitWidth,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.w600,
                          fontFamily: "Monte",
                          // fontSize: 22.0,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40,
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }

  Widget _buildTilered(
      {String icon,
      /*IconData icon,*/
      String title,
      Size size,
      Color bordercolor,
      Color color,
      Function fun,
      Function fun2}) {
    return InkWell(
      onTap: fun,
      onLongPress: fun2,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: size.height * 0.1525 - 45,
        width: size.height * 0.1525 - 45,
        decoration: BoxDecoration(

            /// borderRadius: BorderRadius.circular(7.0),
            // borderRadius:  BorderRadius.all(Radius.circular(60)),
            shape: BoxShape.circle,
            /*    topLeft:  Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),*/
            color: Colors.white,
            border: Border.all(
              color: AppData.kPrimaryRedColor,
              width: 1.0,
            )
            /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
            ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    /*"assets/logo1.png"*/
                    icon,
                    fit: BoxFit.fitWidth,
                    color: AppData.kPrimaryRedColor,
                    width: size.height * 0.05,
                    height: size.height * 0.05,
                  ),
                ),
                /*child: Icon(icon, color: AppData.kPrimaryRedColor,size: 40.0)),*/

                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                /*Padding(
                      padding: const EdgeInsets.only( top: 10,left: 3,right: 3
                      ),
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                  title,
                  style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                          ),
                        ],
                      ),
                    ),*/
              ],
            ),
            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40,
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }
}

class MyPage2Widget extends StatelessWidget {
  double _height = 85;
  double _width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _width = (MediaQuery.of(context).size.width - 80) / 3;
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
            /* child: SingleChildScrollView(*/
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // crossAxisAlignment: CrossAxisAlignment.center,
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTileblue(
                            icon: "assets/health_checkup.png",
                            //icon: Icons.search,
                            //icon: FontAwesomeIcons.accusoft,
                            title: "Health Checkup",
                            fun: () {
                              AppData.showInSnackDone(context, "Coming Soon");
                             //Navigator.pushNamed(context, "/healthCheckup");
                            },
                            color: AppData.BG2BLUE,
                            bordercolor: AppData.BG2BLUE,
                            //size: (size.width - 130) / 3,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            child: Text(MyLocalizations.of(context).text("HEALTH_CHECKUP"),
                              textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                    Spacer(),
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTilered(
                            icon: "assets/infomatics.png",
                            title: "Discount & Offers",
                            fun: () {
                              AppData.showInSnackDone(context, "Coming Soon");
                             //Navigator.pushNamed(context, "/emergencyroom");
                              // AppData.showSnack(
                              //     context, "Coming soon", Colors.green);
                            },
                            color: AppData.BG1RED,
                            bordercolor: AppData.BG1RED,
                            //size: (size.width - 130) / 3,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            child: Text(MyLocalizations.of(context).text("EHEALTH_INFORMATION"),
                              textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),

                              Align(
                                          alignment: Alignment.center,
                                          child:SizedBox(
                                            width:100, child: FittedBox(child:Text(
                                            "Discount & Offers",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                          )
                                        ),
                                        ),
                        ]),
                    Spacer(),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTileblue(
                            icon: "assets/ambulance.png",
                            //icon: Icons.search,
                            //icon: FontAwesomeIcons.accusoft,
                            title: "Book Ambulance",
                            fun: () {
                              //AppData.showInSnackDone(context, "Coming Soon");
                              Navigator.pushNamed(context, "/bookAmbulancelist");
                            },
                            color: AppData.BG2BLUE,
                            bordercolor: AppData.BG2BLUE,
                            //size: (size.width - 130) / 3,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            child: Text(MyLocalizations.of(context).text("BOOK_AMBULANCE"),
                              textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                  ],
                ),
                SizedBox(height: 5,),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTilered(
                            icon: "assets/blooddonationuser.png",
                            //icon: Icons.search,
                            //icon: FontAwesomeIcons.accusoft,
                            title: "Order Blood ",
                            fun: () {
                              Navigator.pushNamed(
                                  context, "/bookBloodBanklist");
                              // Navigator.pushNamed(context, "/healthCheckup");
                            },
                            color: AppData.BG1RED,
                            bordercolor: AppData.BG1RED,
                            //size: (size.width - 130) / 3,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            child: Text(
                              MyLocalizations.of(context).text("ORDER_BLOOD"),
                              textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                    SizedBox(
                      width: 15,
                    ),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTileblue(
                            icon: "assets/ambulance.png",
                            //icon: Icons.search,
                            //icon: FontAwesomeIcons.accusoft,
                            title: "Book Ambulance",
                            fun: () {
                              //AppData.showInSnackDone(context, "Coming Soon");
                              Navigator.pushNamed(
                                  context, "/bookAmbulancelist");
                            },
                            color: AppData.BG2BLUE,
                            bordercolor: AppData.BG2BLUE,
                            //size: (size.width - 130) / 3,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            child: Text(
                              MyLocalizations.of(context)
                                  .text("BOOK_AMBULANCE"),
                              textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                  ],
                ),
              ],
            ),
          ),
        ),
        /* ),*/
      ],
    );
  }

  Widget _buildTileblue(
      {String icon,
      /* IconData icon,*/
      String title,
      double size,
      Color bordercolor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: _height,
        width: _width,
        decoration: BoxDecoration(

            /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(10.0),
            ),
            color: color,
            border: Border.all(
              color: AppData.kPrimaryColor,
              width: 1.0,
            )
            /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
            ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    /*"assets/logo1.png"*/
                    icon,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 70.0,
                  ),
                  /* child: Icon(icon, color: AppData.kPrimaryColor,size: 40.0)*/
                ),

                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                /*Padding(
                      padding: const EdgeInsets.only( top: 10,left: 3,right: 3
                      ),
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                  title,
                  style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                          ),
                        ],
                      ),
                    ),*/
              ],
            ),
            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40,
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }

  // chooseAppointment(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return StatefulBuilder(
  //           builder: (context, setState) {
  //             return AlertDialog(
  //               //title: const Text("Is it your details?"),
  //               contentPadding: EdgeInsets.only(top: 18, left: 18, right: 18),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //               //contentPadding: EdgeInsets.only(top: 10.0),
  //               content: Container(
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: <Widget>[
  //                       ListTile(
  //                         title: Text("Health Screening"),
  //                         leading: Icon(
  //                           CupertinoIcons.calendar_today,
  //                           size: 40,
  //                         ),
  //                         onTap: () {
  //                           /*  widget.model.apntUserType = Const.HEALTH_SCREENING_APNT;*/
  //                           //Navigator.pop(context);
  //                           //Navigator.pushNamed(context, "/docApnt");
  //                           Navigator.pushNamed(context, "/docApnt");
  //                         },
  //                       ),
  //                       Divider(),
  //                       ListTile(
  //                         title: Text("Health Check-up"),
  //                         leading: Icon(
  //                           CupertinoIcons.calendar_today,
  //                           size: 40,
  //                         ),
  //                         onTap: () {
  //                           //widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
  //                           Navigator.pop(context);
  //                           Navigator.pushNamed(context, "/docApnt");
  //                         },
  //                       ),
  //                       Divider(),
  //                       ListTile(
  //                         title: Text("Doctor Visit"),
  //                         leading: Icon(
  //                           CupertinoIcons.calendar_today,
  //                           size: 40,
  //                         ),
  //                         onTap: () {
  //                           //widget.model.apntUserType = Const.DOC_APNT;
  //                           Navigator.pop(context);
  //                           Navigator.pushNamed(context, "/docApnt");
  //                         },
  //                       ),
  //                       Divider(),
  //                       MaterialButton(
  //                         child: Text(
  //                           MyLocalizations.of(context).text("CANCEL"),
  //                           style: TextStyle(color: Colors.black),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

  Widget _buildTile1(
      {IconData icon,
      String title,
      double size,
      Color bordercolor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: _height,

        ///width: (MediaQuery.of(context).size.width - 80) / 3,
        width: _width,
        decoration: BoxDecoration(
          /// borderRadius: BorderRadius.circular(7.0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.zero,
          ),
          color: color,

          /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40,
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }

  Widget _buildTilered(
      {String icon,
      String title,
      double size,
      Color bordercolor,
      Color color,
      Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: _height,
        //width: (MediaQuery.of(context).size.width - 80) / 3,
        width: _width,
        decoration: BoxDecoration(

            /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.zero,
            ),
            color: color,
            border: Border.all(
              color: AppData.kPrimaryRedColor,
              width: 1.0,
            )
            /* boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],*/
            ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    /* "assets/logo1.png"*/
                    icon,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 70.0,
                  ),
                ),
                //child: Icon(icon, color: AppData.kPrimaryRedColor,size: 40.0)),

                /*Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),

                ),*/
                /*Padding(
                      padding: const EdgeInsets.only( top: 10,left: 3,right: 3
                      ),
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                  title,
                  style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                          ),
                        ],
                      ),
                    ),*/
              ],
            ),
            /* Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 40,
            width: 40,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white24,),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: Colors.white,)
            )
          )
        ),*/
            //   Positioned(
            // top: 20,
            // left: 15,
            // child:Text('Heart Rate', style: TextStyle(color: Colors.white),)),
            //  Positioned(
            // bottom: 20,
            // right: 15,
            // child:Column(
            //   children: [
            //     Text('Daily Goal', style: TextStyle(color: Colors.white),),
            //      Text('900 kcal', style: TextStyle(color: Colors.white),),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }
}
