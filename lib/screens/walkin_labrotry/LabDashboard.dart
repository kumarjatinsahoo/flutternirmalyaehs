import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';

//import 'dart:html';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/MyWidget.dart';

class LabDashboard extends StatefulWidget {
  final MainModel model;

  const LabDashboard({Key key, this.model}) : super(key: key);

  @override
  _LabDashboardState createState() => _LabDashboardState();
}

class _LabDashboardState extends State<LabDashboard> {
  LoginResponse1 loginResponse;
  SharedPref sharedPref = SharedPref();
  File pathUsr = null;
  List<String> strOrders = [
    'My Orders',
    'Confirm Orders',
    'Processed Orders',
    'Delivered Orders'
  ];
  List<String> strOthers = [
    'Invoices',
    'Monthly Review',
    'Offers and Discount',
    'Online Chat',
    'Daily Sales'
  ];

  static final List<String> languageCodesList = application.supportedLanguagesCodes;
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


  int _selectedDestination = -1;


  static const platform = AppData.channel;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  Future<void> _callLabApp(String data) async {
    try {
      final int result = await platform.invokeMethod('lab2', data);
    } on PlatformException catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    checkApiCallOrNot();
  }

  checkApiCallOrNot() async {
    String isAlreadyReg = await sharedPref.getKey(Const.IS_REG_SERVER);
    if (isAlreadyReg != null) {
      if (isAlreadyReg.replaceAll("\"", "") == "false") {
        if (Platform.isAndroid) initUniqueIdentifierState();
      }
    } else {
      if (Platform.isAndroid) initUniqueIdentifierState();
    }
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = await UniqueIdentifier.serial;
      if (identifier != null) {
        Map<String, dynamic> postData = {
          "apid": Const.APP_ID,
          "deviceId": identifier,
          "action": "add"
        };
        print("POST DATA>>>MEDTEL" + jsonEncode(postData).toString());
        widget.model.POSTMETHOD(
          api: ApiFactory.REG_DEVICE,
          json: postData,
          fun: (Map<String, dynamic> map) {
            if (map["code"] == 200) {
              //AppData.showInSnackDone(context, map["msg"]);
              sharedPref.save(Const.IS_REG_SERVER, "true");
            } else {
              //if(map["msg"]!="")
              //AppData.showInSnackBar(context, map["msg"]??"");
            }
          },
        );
      }
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    print("Another ID>>>>>" + identifier);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).text("DASHBOARD"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.kPrimaryColor,
        elevation: 0,
      ),
      body:
      Stack(
        children: [
        Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Image.asset(
              "assets/images/labbanner.jpg",
              // width: size.width,
              // fit: BoxFit.cover,
            ),
          ),
          SizedBox(height:3),
        ],
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTileblue(
                          icon:"assets/images/registerpatient.png",
                          fun: () {
                            //AppData.showInSnackBar(context, "Coming soon");
                            // Navigator.pushNamed(context, "/medicalrecordpage");
                            Navigator.pushNamed(context, "/walkRegList");
                          },
                          color: AppData.BG2BLUE,
                          bordercolor: AppData.BG2BLUE,
                          // ,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          /* child: Expanded(*/
                          child: Text(MyLocalizations.of(context).text("REGISTER_PATIENT"),
                            // MyLocalizations.of(context).text("My Orders"),
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                  SizedBox(
                    width: 5,
                  ),

                  /* Expanded(*/
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTilered(
                          icon: "assets/images/appointmentlab.png",
                          fun: () {
                            chooseAppointment(context);
                            // Navigator.pushNamed(context, "/myAppointment");
                            //Navigator.pushNamed(context, "/ordersPharma");
                          },
                          color: AppData.BG1RED,
                          bordercolor: AppData.BG1RED,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          /* child: Expanded(*/
                          child: Text(MyLocalizations.of(context).text("APPOINTMENT"),
                            // MyLocalizations.of(context).text("Confirmed Order"),
                            textAlign: TextAlign.center,
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTileblue(
                          icon: "assets/images/pocreports.png",
                          fun: () {
                            //chooseAppointment(context, model);
                            //Navigator.pushNamed(context, "/userAppoint");
                            // Navigator.pushNamed(context, "/myAppointment");
                            /*Navigator.pushNamed(
                                      context, "/medipedia");*/
                            // AppData.showSnack(
                            //     context, "Coming soon", Colors.green);
                            Navigator.pushNamed(context, "/pocreportlist");
                          },
                          color: AppData.BG2BLUE,
                          bordercolor: AppData.BG2BLUE,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          /* child: Expanded(*/
                          child: Text(
                            MyLocalizations.of(context).text("POC_REPORTS"),
                            // MyLocalizations.of(context).text("Processed Orders"),
                            textAlign: TextAlign.center,
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

                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTilered(
                          icon: "assets/images/testlab.png",
                          fun: () {
                            // AppData.showInSnackDone(context, "Coming Soon");
                            Navigator.pushNamed(context, "/testappointmentpage");
                            //AppData.showInSnackBar(context, "Coming soon");
                          },
                          //color: AppData.BG2BLUE,
                          color: AppData.BG1RED,
                          bordercolor: AppData.BG1RED,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          child: Text(
                            MyLocalizations.of(context).text("TEST"),
/*
                            MyLocalizations.of(context).text("Deliverd Order").toString(),
*/
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        /*Align(
                                          alignment: Alignment.center,
                                          child: Expanded(
                                            child: Text(
                                              "Health               chat",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),*/
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
                          icon:"assets/images/orderslab.png",
                          //icon: FontAwesomeIcons.accusoft,
                          title: "My Orders",
                          fun: () {
                            // AppData.showInSnackDone(context, "/myOrderTest");
                            Navigator.pushNamed(context, "/myOrderTest");
                            // AppData.showSnack(
                            //     context, "Coming soon", Colors.green);
                          },
                          color: AppData.BG2BLUE,
                          bordercolor: AppData.BG2BLUE,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          /* child: Expanded(*/
                          child: Text(
                            MyLocalizations.of(context).text("MY_ORDERS"),
                            // MyLocalizations.of(context).text("Invoices"),
                            textAlign: TextAlign.center,
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
                          icon: "assets/images/datalab.png",
                          fun: () {
                            // AppData.showInSnackDone(context, "Coming Soon");
                            Navigator.pushNamed(context, "/testappointmentpage1");
                            //AppData.showInSnackBar(context, "Coming soon");
                          },
                          //color: AppData.BG2BLUE,
                          color: AppData.BG1RED,
                          bordercolor: AppData.BG1RED,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          child: Text(
                            MyLocalizations.of(context).text("UPDATION_DATA"),
                            // MyLocalizations.of(context).text("Monthly Overview"),
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      ]),
                ],
              ),
              SizedBox(height: 50),
              // _buildTile(
              //   icon: "assets/images/labbanner.jpg",
              //   fun: () {
              //     // AppData.showInSnackDone(context, "Coming Soon");
              //     // Navigator.pushNamed(context, "/discountoffer");
              //     //AppData.showInSnackBar(context, "Coming soon");
              //   },
              //   //color: AppData.BG2BLUE,
              //   color: AppData.white,
              //   bordercolor: AppData.white,
              // ),

            ],
          ),
        ),
      ]
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // height: 120,
                    color: AppData.kPrimaryColor,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 40.0, bottom: 20.0),
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
                          CircleAvatar(
                            radius: 35,
                            foregroundColor:
                            Colors
                                .white,
                            backgroundColor: Colors.white,
                            child:
                            Image.asset(
                              'assets/images/user.png',
                              height:
                              size.height *
                                  0.07,
                              width:
                              size.width *
                                  0.13,
                              //fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "Hi " + loginResponse.body.userName ?? "N/A",
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

                  Positioned(right: 0,
                    child:  Container(
                      width: size.width,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      margin: EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                    ),),
                ],
              ),
              ListTile(
                  leading: Icon(Icons.dashboard,
                      color: AppData.menublueColor, size: 27),
                  title: Text(MyLocalizations.of(context).text("DASHBOARD"),),
                  selected: _selectedDestination == 0,
                  onTap: () {
                    selectDestination(0);
                    Navigator.pop(context);
                    //Navigator.pushNamed(context, "/dashboard");
                    // Navigator.pushNamed(context, "/dashboard1");
                  }
                // onTap: (){},

              ),
              ListTile(
                leading: Image.asset(
                  "assets/images/myprofile.png",
                  height: 30,
                  //color: Colors.redAccent,
                ),
                title: Text(MyLocalizations.of(context).text("MY_PROFILE"),),
                selected: _selectedDestination == 1,
                onTap: () {
                  selectDestination(1);
                  //Navigator.pushNamed(context, "/labprofile");
                  Navigator.pushNamed(context, "/labMyProfile");
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
                  //Navigator.pushNamed(context, "/biomedicalimplants");
                },
              ),
              ListTile(
                  leading: Image.asset(
                    "assets/images/share.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("SHARE")),
                  selected: _selectedDestination == 5,
                  onTap: () {
                    selectDestination(5);
                    //Navigator.pushNamed(context, "/dashboard1");
                    Navigator.pushNamed(context, "/emergencydetails");
                  }),
              ListTile(
                  leading: Image.asset(
                    "assets/images/contact us.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("CONTACT_US")),
                  selected: _selectedDestination == 6,
                  onTap: () {
                    selectDestination(6);
                    widget.model.contactscreen = "Contact Screen";
                    Navigator.pushNamed(context, "/contactus");
                    //Navigator.pushNamed(context, "/discountoffer");
                  }),
             /* ListTile(
                  leading: Image.asset(
                    "assets/images/support.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("SUPPORT")),
                  selected: _selectedDestination == 7,
                  onTap: () {
                    selectDestination(7);
                    widget.model.contactscreen = "Support Screen";
                    Navigator.pushNamed(context, "/contactus");
                  }),*/
              ListTile(
                  leading: Image.asset(
                    "assets/images/support.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("PEAK_FLOW_APP")),
                  selected: _selectedDestination == 8,
                  onTap: () {
                    selectDestination(8);
                    _callLabApp("");
                  }),

              ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 30,
                        height: 30,
                        child: Image.asset( "assets/images/changepassword.png",
                            fit: BoxFit.cover)),
                    // VerticalDivider(
                    //   thickness: 1,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
                title: Text(MyLocalizations.of(context).text("CHANGE_PASSWORD")),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/changePassword");
                },
              ),
              ListTile(
                leading: Image.asset(
                  "assets/images/logout.png",
                  height: 30,
                ),
                title: Text(MyLocalizations.of(context).text("LOGOUT")),
                selected: _selectedDestination == 10,
                onTap: () {
                  selectDestination(10);
                  //Navigator.pushNamed(context, "/dashboard");
                  // if (loginResponse.body.roles[0].toString().toLowerCase() == "4")
                  //   _exitApp();
                  /* else
                    initUniqueIdentifierState();*/
                  _exitApp();
                },
                /*  onTap: () {

                  selectDestination(10);
                  Navigator.pushNamed(context, "/login");
                },*/
              ),

            ],
          ),
    ),
      ),
    //    body: _dashboardnew(context),
    );
  }
  /* Future<void> initUniqueIdentifierState() async {
    if(Platform.isAndroid) {
      MyWidgets.showLoading(context);
      String identifier;
      try {
        identifier = await UniqueIdentifier.serial;
        if (identifier != null) {
          Map<String, dynamic> postData = {
            "apid": Const.APP_ID,
            "deviceId": identifier,
            "action": "remove"
          };
          widget.model.POSTMETHOD(
            api: ApiFactory.REG_DEVICE,
            json: postData,
            fun: (Map<String, dynamic> map) {
              if (map["code"] == 200) {
                AppData.showInSnackDone(context, map["msg"] ?? "Offline");
                //if (map["msg"] == "device id added") {
                sharedPref.save(Const.IS_REG_SERVER, "false");
                _exitApp();
                //}
              } else {
                AppData.showInSnackBar(context, map["msg"] ?? "Offline");
              }
            },
          );
        }
      } on PlatformException {
        identifier = 'Failed to get Unique Identifier';
      }
      if (!mounted) return;
    }else{
      _exitApp();
    }
  }*/
  Widget _dashboardnew(context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: double.maxFinite,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTile1(
                                icon: Icons.people,
                                title: "Register Patient",
                                fun: () {
                                  /*Navigator.pushNamed(
                                      context, "/patientRegistration");*/
                                  Navigator.pushNamed(context, "/walkRegList");
                                },
                                color: AppData.BG2BLUE,
                                bordercolor: AppData.BG2BLUE,
                                // ,
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTile2(
                                icon: Icons.alarm,
                                title: "Appointment",
                                fun: () {
                                  chooseAppointment(context);
                                  // Navigator.pushNamed(context, "/medicalrecordpage");
                                },
                                color: AppData.BG1RED,
                                bordercolor: AppData.BG1RED,
                                // ,
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTile2(
                                //icon: Icons.document_scanner,
                                icon: CupertinoIcons.doc_append,
                                title: "POC Reports",
                                fun: () {
                                  Navigator.pushNamed(
                                      context, "/pocreportlist");
                                },
                                color: AppData.BG1RED,
                                bordercolor: AppData.BG1RED,
                                // ,
                              ),
                            ]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTile1(
                              icon: Icons.edit_attributes,
                              title: "Test",
                              fun: () {
                                //chooseAppointment1(context);
                                Navigator.pushNamed(
                                    context, "/testappointmentpage");
                              },
                              color: AppData.BG2BLUE,
                              bordercolor: AppData.BG2BLUE,
                              // ,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTile1(
                          //icon: Icons.document_scanner,
                          icon: CupertinoIcons.bag,
                          title: "My Orders",
                          fun: () {
                            Navigator.pushNamed(context, "/myOrderTest");
                          },
                          color: AppData.BG2BLUE,
                          bordercolor: AppData.BG2BLUE,
                          // ,
                        ),
                        _buildTile2(
                          //icon: Icons.document_scanner,
                          icon: CupertinoIcons.settings_solid,
                          title: "Updation Data",
                          fun: () {
                            Navigator.pushNamed(context, "/testappointmentpage1");
                          },
                          color: AppData.BG1RED,
                          bordercolor: AppData.BG1RED,
                          // ,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

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
        height: 145,
        width: (MediaQuery.of(context).size.width - 60) / 2,
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
              color: AppData.kPrimaryColor,
              width: 1.0,
            )),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /* Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    */ /*"assets/logo1.png"*/ /*icon,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 70.0,
                  ),),*/
                Icon(icon, color: AppData.kPrimaryColor, size: 40.0),
                /*Text(
                  title,
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
                            color: Colors.black,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 15.0,
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
            /*Positioned(
              top: 6,
              right: 6,
              child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.black12,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '67',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ))),
              */ /*Positioned(
            top: 20,
            left: 15,
            child:Text('Heart Rate', style: TextStyle(color: Colors.black),)),*/ /*
              */
            /*Positioned(
            bottom: 20,
            right: 15,
            child:Column(
              children: [
                Text('Daily Goal', style: TextStyle(color: Colors.white),),
                 Text('900 kcal', style: TextStyle(color: Colors.white),),
              ],
            ))*/ /*
            )*/
          ],
        ),
      ),
    );
  }

  Widget _buildTile2(
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
        height: 145,
        width: (MediaQuery.of(context).size.width - 60) / 2,
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
              color: AppData.kPrimaryRedColor,
              width: 1.0,
            )),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /* Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    */
                /*"assets/logo1.png"*/
                /*icon,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 70.0,
                  ),),*/
                Icon(icon, color: AppData.kPrimaryRedColor, size: 40.0),
                /*Text(
                  title,
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
                            color: Colors.black,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Monte",
                            fontSize: 15.0,
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
            /*Positioned(
              top: 6,
              right: 6,
              child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.black12,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '67',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ))),
              */
            /*Positioned(
            top: 20,
            left: 15,
            child:Text('Heart Rate', style: TextStyle(color: Colors.black),)),*/ /*
              */
            /*Positioned(
            bottom: 20,
            right: 15,
            child:Column(
              children: [
                Text('Daily Goal', style: TextStyle(color: Colors.white),),
                 Text('900 kcal', style: TextStyle(color: Colors.white),),
              ],
            ))*/
            /*
            )*/
          ],
        ),
      ),
    );
  }

  chooseAppointment(BuildContext context) {
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
                          title: Text(MyLocalizations.of(context).text("HEALTH_SCREENING")),
                          onTap: () {
                            widget.model.apntUserType =
                                Const.HEALTH_SCREENING_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                            // AppData.showInSnackBar(context,"hi");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text(MyLocalizations.of(context).text("HEALTH_CHECKUP")),
                          onTap: () {
                            widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text(MyLocalizations.of(context).text("DOCTOR_APPOINTMENT")),
                          onTap: () {
                            widget.model.apntUserType = Const.DOC_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
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

  chooseAppointment1(BuildContext context) {
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
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            widget.model.apntUserType =
                                Const.HEALTH_SCREENING_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                            // AppData.showInSnackBar(context,"hi");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(child: Text("Health Check-up")),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(child: Text("Doctor Visit")),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            widget.model.apntUserType = Const.DOC_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
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

  Widget _buildTilered({String icon,
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
        height: 85,
        //width: (MediaQuery.of(context).size.width - 80) / 3,
        width: 100,
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
                    height: 50.0,
                    color: AppData.kPrimaryRedColor,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }



  Widget _buildTileblue({
    /*IconData icon,*/
    String icon,
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
        height: 85,
        width: 100,
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
                      height: 50.0,
                      color:AppData.kPrimaryColor,
                    )),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTile({String icon,
    /*IconData icon,*/
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

        /* decoration: BoxDecoration(

          /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.0),
              topRight: Radius.circular(2.0),
              bottomLeft: Radius.circular(2.0),
              bottomRight: Radius.circular(2.0),
            ),
            color: color,
            border: Border.all(
              color: AppData.kPrimaryColor,
              width: 0.5,
            )
        ),*/
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,

              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      /* "assets/logo1.png"*/
                      icon,
                      fit: BoxFit.fitWidth,

                    )),
              ],
            ),

          ],
        ),
      ),
    );
  }}
