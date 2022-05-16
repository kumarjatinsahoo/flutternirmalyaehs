import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/NewDashboardDoctor.dart';

class NewDashboardDoctor extends StatefulWidget {
  MainModel model;

  NewDashboardDoctor({Key key, this.model}) : super(key: key);

  @override
  _NewDashboardDoctorState createState() => _NewDashboardDoctorState();
}

SharedPref sharedPref = SharedPref();

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
                      _Tilered(
                        // icon: Icons.calendar_today,
                        icon: CupertinoIcons.calendar_today,
                        title: "Health Screening",
                        fun: () {
                          //Navigator.pushNamed(context, "/medicalrecordpage");
                        },
                      ),
                      Divider(),
                      _Tilered(
                        // icon: Icons.calendar_today,
                        icon: CupertinoIcons.calendar_today,
                        title: "Health Check-up",
                        fun: () {
                          //Navigator.pushNamed(context, "/qrViewExample1");
                        },
                      ),
                      Divider(),
                      _Tilered(
                        // icon: Icons.calendar_today,
                        icon: CupertinoIcons.calendar_today,
                        title: "Doctor Appointment",
                        fun: () {
                          Navigator.pushNamed(context, "/doctorAppointment");
                          // Navigator.pushNamed(context, "/doctorconsultationPage");
                          // Navigator.pop(context);
                        },
                      ),
                     /* ListTile(
                          leading: Image.asset(
                            "assets/images/changepassword.png",
                            height: 30,
                          ),
                          title: Text("Change Password"),
                          selected: _selectedDestination == 8,
                          onTap: () {
                            selectDestination(8);
                            Navigator.pushNamed(context, "/changePassword");
                          }),*/
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

class _NewDashboardDoctorState extends State<NewDashboardDoctor> {
  LoginResponse1 loginResponse;
  PageController _controller = PageController(
    initialPage: 0,
  );

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


  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    // checkApiCallOrNot();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(MyLocalizations.of(context).text("DASHBOARD")),
          backgroundColor: AppData.kPrimaryColor),
      body: Stack(
       // fit: StackFit.expand,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Container(
               child: Image.asset(
                 "assets/images/doctorbanner.jpg",
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
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildTileblue(
                                  icon: "assets/images/dprofile.png",
                                  fun: () {
                                    //AppData.showInSnackBar(context, "Coming soon");
                                    // Navigator.pushNamed(context, "/medicalrecordpage");
                                    Navigator.pushNamed(context, "/docMyProf");
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
                                    MyLocalizations.of(context).text("MY_PROFILE"),
                                    // MyLocalizations.of(context).text("MY_PROFILE"),
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
                                  icon: "assets/images/appointment.png",
                                  fun: () {
                                    // Navigator.pushNamed(context, "/myAppointment");
                                    Navigator.pushNamed(
                                        context, "/doctorAppointment");
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
                                    MyLocalizations.of(context).text("APPOINTMENT"),
                                    // MyLocalizations.of(context).text("APPOINTMENT"),
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
                                  icon: "assets/images/walk.png",
                                  fun: () {
                                    //chooseAppointment(context, model);
                                    //Navigator.pushNamed(context, "/userAppoint");
                                    // Navigator.pushNamed(context, "/myAppointment");
                                    /*Navigator.pushNamed(
                                                context, "/medipedia");*/
                                    // AppData.showSnack(
                                    //     context, "Coming soon", Colors.green);
                                    widget.model.regNoValue="";
                                    Navigator.pushNamed(context, "/docWalkInReg");
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
                                    MyLocalizations.of(context).text("WALK_IN_PATIENT"),
                                    // MyLocalizations.of(context).text("WALK_IN_PATIENT"),
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
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildTilered(
                                  icon: "assets/images/emergency.png",
                                  fun: () {
                                    widget.model.regNoValue="";
                                    Navigator.pushNamed(context, "/emegencyAccess");
                                    // AppData.showInSnackDone(context, "Coming Soon");
                                    // Navigator.pushNamed(context, "/discountoffer");
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
                                    MyLocalizations.of(context).text("EMERGENCY_ACCESS"),
                                    textAlign: TextAlign.center,
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
                                  icon: "assets/images/shareapnt.png",
                                  //icon: Icons.alarm,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Share_appointment",
                                  fun: () {
                                    // AppData.showInSnackDone(context, "Coming Soon");
                                    Navigator.pushNamed(context, "/shareappointment");
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
                                    MyLocalizations.of(context).text("SHARE_APPOINTMENT"),
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
                                  icon: "assets/images/mypatient.png",
                                  fun: () {
                                    // AppData.showInSnackDone(context, "Coming Soon");
                                    Navigator.pushNamed(context, "/myPatientlist");
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
                                    MyLocalizations.of(context).text("MY_PATIENT"),
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
                                _buildTileblue(
                                  icon: "assets/images/monthlyoverview.png",
                                  fun: () {

                                    // AppData.showInSnackDone(context, "Coming Soon");
                                    Navigator.pushNamed(context, "/monthlyoverview");
                                    //AppData.showInSnackBar(context, "Coming soon");
                                  },
                                  //color: AppData.BG2BLUE,
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
                                  child: Text(
                                   MyLocalizations.of(context).text("MONTHLY_OVERVIEW"),
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
                                _buildTilered(
                                  icon: "assets/images/video.png",
                                  //icon: Icons.alarm,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Video Consulation",
                                  fun: () {
                                    // AppData.showInSnackDone(context, "Coming Soon");
                                    // Navigator.pushNamed(context, "/medicinereminder");
                                    // AppData.showSnack(
                                    //     context, "Coming soon", Colors.green);
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
                                MyLocalizations.of(context).text("VIDEO_CONSULTATION"),
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
                                _buildTileblue(
                                  icon: "assets/images/medical.png",
                                  fun: () {
                                    Navigator.pushNamed(context, "/refferedpatients");
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
                                  child: Text(MyLocalizations.of(context).text("REFFERED_PATIENT"),
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
                              ])
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            // Important: Remove any padding from the ListView.
            children: <Widget>[
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
                          /* Container(
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
                            radius: 25,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              "assets/images/user.png",
                              // 'assets/images/Dashboardprofile.png',
                              height: size.height * 0.05,
                              width: size.width * 0.10,
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
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.dashboard,color:AppData.menublueColor, size: 27),
                      // Container(
                      //     width: 30,
                      //     height: 30,
                      //     child: Image.asset('assets/images/dash.png',
                      //         fit: BoxFit.cover)),
                      // VerticalDivider(
                      //   thickness: 1,
                      //   color: Colors.grey,
                      // ),
                    ],
                  ),
                ),
                title: Text(MyLocalizations.of(context).text("DASHBOARD")),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 8,
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/images/myprofile.png',
                              fit: BoxFit.cover)),
                      // VerticalDivider(
                      //   thickness: 1,
                      //   color: Colors.grey,
                      // ),
                    ],
                  ),
                ),
                title: Text(MyLocalizations.of(context).text("MY_PROFILE")),
                onTap: () {
                  Navigator.pushNamed(
                      context, "/docMyProf");
                },
              ),
              SizedBox(
                height: 8,
              ),

              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/images/aboutus.png',
                              fit: BoxFit.cover)),
                      // VerticalDivider(
                      //   thickness: 1,
                      //   color: Colors.grey,
                      // ),
                    ],
                  ),
                ),
                title: Text(MyLocalizations.of(context).text("ABOUT_US")),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/aboutus');

                },
              ),
              SizedBox(
                height: 8,
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/images/share.png',
                              fit: BoxFit.cover)),
                      // VerticalDivider(
                      //   thickness: 1,
                      //   color: Colors.grey,
                      // ),
                    ],
                  ),
                ),
                title: Text(MyLocalizations.of(context).text("SHARE")),
                onTap: () {
                  //Navigator.pushNamed(context, "/emergencydetails");
                  //Navigator.pushNamed(context, "/myopdpage");
                },
              ),
              SizedBox(
                height: 8,
              ),
              ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: 30,
                            height: 30,
                            child: Image.asset( "assets/images/contact us.png",
                                fit: BoxFit.cover)),
                        // VerticalDivider(
                        //   thickness: 1,
                        //   color: Colors.grey,
                        // ),
                      ],
                    ),
                  ),
                  title: Text(MyLocalizations.of(context).text("CONTACT_US")),
                  onTap: () {
                   // widget.model.contactscreen = "Contact Screen";
                    Navigator.pushNamed(context, "/contactus");
                    //Navigator.pushNamed(context, "/discountoffer");
                  }),
             /* ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: 30,
                            height: 30,
                            child: Image.asset( "assets/images/support.png",
                                fit: BoxFit.cover)),
                        // VerticalDivider(
                        //   thickness: 1,
                        //   color: Colors.grey,
                        // ),
                      ],
                    ),
                  ),
                  title: Text(MyLocalizations.of(context).text("SUPPORT")),
                  onTap: () {
                    widget.model.contactscreen = "Support Screen";
                    Navigator.pushNamed(context, "/contactus");
                  }),*/

              SizedBox(
                height: 8,
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
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
                ),
                title: Text(MyLocalizations.of(context).text("CHANGE_PASSWORD")),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/changePassword");
                },
              ),

              SizedBox(
                height: 8,
              ),
           /*   ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: *//*Image.asset('assets/images/aboutus.png',fit: BoxFit.cover)*//*
                            Icon(
                          Icons.qr_code,
                          color: AppData.menublueColor,
                          size: 30.0,
                        ),
                      ),
                      VerticalDivider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                title: Text("Qr Search"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/qrViewExample1");
                  //Navigator.pop(context);
                },
              ),*/
            /*  SizedBox(
                height: 8,
              ),*/
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/images/logout.png',
                              fit: BoxFit.cover)),
                      // VerticalDivider(
                      //   thickness: 1,
                      //   color: Colors.grey,
                      // ),
                    ],
                  ),
                ),
                title: Text(MyLocalizations.of(context).text("LOGOUT")),
                onTap: () {
                  // selectDestination(9);
                  sharedPref.save(Const.IS_LOGIN, false.toString());
                  sharedPref.save(Const.IS_REGISTRATION, false.toString());
                  sharedPref.remove(Const.IS_REGISTRATION);
                  sharedPref.remove(Const.IS_LOGIN);
                  sharedPref.remove(Const.LOGIN_DATA);
                  sharedPref.remove(Const.IS_REG_SERVER);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                  //  _exitApp();
                },
              ),
            ],
          ),
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
                    height: 70.0,
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
                      height: 70.0,
                      color: AppData.kPrimaryColor,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
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

  Widget _buildTilewhite(
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
        height: 1,
        width: 1,
        decoration: BoxDecoration(

            /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(0.0),
            ),
            color: color,
            border: Border.all(
              color: AppData.white,
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
                      width: 1,
                      height: 1,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

abstract class MyPage1Widget extends StatelessWidget {
  var widget;
  double _height = 85;
  double _width;

  final MainModel model;

  MyPage1Widget({Key key, this.model}) : super(key: key);

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
                        ListTile(
                            leading: Image.asset(
                              "assets/images/changepassword.png",
                              height: 30,
                            ),
                            title: Text("Change Password"),

                            onTap: () {
                              //selectDestination(8);
                              Navigator.pushNamed(context, "/changePassword");
                            }),

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
}
