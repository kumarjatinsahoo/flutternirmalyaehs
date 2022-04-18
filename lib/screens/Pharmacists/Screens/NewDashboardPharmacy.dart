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

//import 'dart:html';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/MyWidget.dart';

class NewDashboardPharmacy extends StatefulWidget {
  final MainModel model;

  const NewDashboardPharmacy({Key key, this.model}) : super(key: key);

  @override
  _NewDashboardPharmacyState createState() => _NewDashboardPharmacyState();
}

class _NewDashboardPharmacyState extends State<NewDashboardPharmacy> {
  LoginResponse1 loginResponse;

  double _height = 120;
  double _width = 150;
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

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
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
      body: Stack(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Image.asset(
                "assets/images/pharmacybanner.jpg",
                // width: size.width,
                // fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 3),
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
                          icon: "assets/images/pharmacyorders.png",
                          fun: () {
                            //AppData.showInSnackBar(context, "Coming soon");
                            // Navigator.pushNamed(context, "/medicalrecordpage");
                            Navigator.pushNamed(context, "/myorder");
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
                          child: Text(
                            MyLocalizations.of(context).text("MY_ORDERS"),
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
                          icon: "assets/images/pharmacyconfirm.png",
                          fun: () {
                            // Navigator.pushNamed(context, "/myAppointment");
                            Navigator.pushNamed(context, "/ordersPharma");
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
                          child: Text(
                            MyLocalizations.of(context).text("ORDER_DETAILS"),
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
                          icon: "assets/images/pharmacyprocessed.png",
                          fun: () {
                            //chooseAppointment(context, model);
                            //Navigator.pushNamed(context, "/userAppoint");
                            // Navigator.pushNamed(context, "/myAppointment");
                            /*Navigator.pushNamed(
                                      context, "/medipedia");*/
                            // AppData.showSnack(
                            //     context, "Coming soon", Colors.green);
                            Navigator.pushNamed(context, "/processedorders");
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
                            MyLocalizations.of(context).text("PROCESSED_ORDER"),
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
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTilered(
                          icon: "assets/images/pharmacydelivered.png",
                          fun: () {
                            // AppData.showInSnackDone(context, "Coming Soon");
                            Navigator.pushNamed(context, "/deliverdorder");
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
                            MyLocalizations.of(context)
                                .text("DELIVERD_ORDER")
                                .toString(),
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
                          icon: "assets/images/pharmacyinvoice.png",
                          //icon: Icons.alarm,
                          //icon: FontAwesomeIcons.accusoft,
                          title: "Invoices",
                          fun: () {
                            AppData.showInSnackDone(context, "Coming Soon");
                            // Navigator.pushNamed(context, "/medicinereminder");
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
                            MyLocalizations.of(context).text("INVOICES"),
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
                          icon: "assets/images/pharmacymonthly.png",
                          fun: () {
                            // AppData.showInSnackDone(context, "Coming Soon");
                            //Navigator.pushNamed(context, "/monthloveryview");
                            Navigator.pushNamed(context, "/monthlyOverviewPharma");
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
                            MyLocalizations.of(context)
                                .text("MONTHLY_OVERVIEW"),
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ]),
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
                          CircleAvatar(
                            radius: 35,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/images/user.png',
                              height: size.height * 0.07,
                              width: size.width * 0.13,
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
                  title: Text(
                    MyLocalizations.of(context).text("DASHBOARD"),
                  ),
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
                title: Text(
                  MyLocalizations.of(context).text("MY_PROFILE"),
                ),
                selected: _selectedDestination == 1,
                onTap: () {
                  selectDestination(1);
                  Navigator.pushNamed(context, "/docMyProf");
                },
              ),
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
        /*      ListTile(
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
    );
  }

  Widget _dashboardnew(context) {
    Size size = MediaQuery.of(context).size;
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
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      icon: "assets/Myorder1.png",
                      fun: () {
                        //AppData.showInSnackBar(context, "Coming soon");
                        // Navigator.pushNamed(context, "/medicalrecordpage");
                        Navigator.pushNamed(context, "/myorder");
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
                      child: Text(
                        MyLocalizations.of(context).text("My Orders"),
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
                      icon: "assets/ConOrder.png",
                      fun: () {
                        // Navigator.pushNamed(context, "/myAppointment");
                        Navigator.pushNamed(context, "/ordersPharma");
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
                      child: Text(
                        MyLocalizations.of(context).text("Confirmed Order"),
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
                      icon: "assets/ProcessOrder.png",
                      fun: () {
                        //chooseAppointment(context, model);
                        //Navigator.pushNamed(context, "/userAppoint");
                        // Navigator.pushNamed(context, "/myAppointment");
                        /*Navigator.pushNamed(
                                      context, "/medipedia");*/
                        // AppData.showSnack(
                        //     context, "Coming soon", Colors.green);
                        Navigator.pushNamed(context, "/processedorders");
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
                        MyLocalizations.of(context).text("Processed Orders"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                      icon: "assets/DeliverdOrder.png",
                      fun: () {
                        // AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/deliverdorder");
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
                        MyLocalizations.of(context).text("Deliverd Order"),
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
                      icon: "assets/Invoices.png",
                      //icon: Icons.alarm,
                      //icon: FontAwesomeIcons.accusoft,
                      title: "Invoices",
                      fun: () {
                        AppData.showInSnackDone(context, "Coming Soon");
                        // Navigator.pushNamed(context, "/medicinereminder");
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
                        MyLocalizations.of(context).text("Invoices"),
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
                      icon: "assets/monthlyoverview2.png",
                      fun: () {
                        // AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/monthloveryview");
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
                        MyLocalizations.of(context).text("Monthly Overview"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
            ],
          ),
          SizedBox(height: 50),
          // _buildTile(
          //   icon: "assets/images/pharmacybanner.jpg",
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
                          title: Text("Health Screening"),
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
                          title: Text("Health Check-up"),
                          onTap: () {
                            widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Doctor Appointment"),
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

  Widget _buildTile(
      {String icon,
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
            )),
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

  Widget _buildTileblue(
      {String icon,
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
            )),
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
                      color: AppData.kPrimaryColor,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
