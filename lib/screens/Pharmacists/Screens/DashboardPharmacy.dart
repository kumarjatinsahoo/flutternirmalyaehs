import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';
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

class DashboardPharmacy extends StatefulWidget {
  final MainModel model;

  const DashboardPharmacy({Key key, this.model}) : super(key: key);

  @override
  _DashboardPharmacyState createState() => _DashboardPharmacyState();
}

class _DashboardPharmacyState extends State<DashboardPharmacy> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Dashboard",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          titleSpacing: 5,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppData.kPrimaryColor,
          elevation: 0,
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // height: 120,
                  color: AppData.kPrimaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              border:
                                  Border.all(color: Colors.white, width: 0.5),
                              color: Colors.white),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.asset(
                                'assets/images/user.png',
                                height: size.height * 0.07,
                                width: size.width * 0.13,
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "pharmacy " ,

                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              loginResponse.body.userName,

                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('Dashboard'),
                    selected: _selectedDestination == 0,
                    onTap: () {
                      selectDestination(0);
                      Navigator.pushNamed(context, "/dashboardpharmacy");
                    }
                    // onTap: (){},
                    ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('My Profile'),
                  selected: _selectedDestination == 1,
                  onTap: () {
                    selectDestination(1);
                    Navigator.pushNamed(context, "/profile");
                    //Navigator.pushNamed(context, "/profileScreen1");
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.notifications),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    selectDestination(3);
                    //Navigator.pushNamed(context, "/onlinechats");
                  },
                  title: Text('Notifications'),
                  // onTap: () {
                  // },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.help_center),
                  selected: _selectedDestination == 4,
                  onTap: () {
                    selectDestination(4);
                    // Navigator.pushNamed(context, "/onlinechats");
                  },
                  title: Text('Help'),
                  // onTap: () {
                  // },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                  selected: _selectedDestination == 5,
                  onTap: () => selectDestination(5),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
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
        body: _dashboardnew(context),
      ),
    );
  }

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
                padding: const EdgeInsets.only(
                    top: 20.0, right: 10, left: 10, bottom: 20),
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
                              _buildTileblue(
                                icon: "assets/Myorder1.png",
                                title: "My Orders",
                                fun: () {
                                  Navigator.pushNamed(context, "/myorder");
                                  //Navigator.pushNamed(context, "/walkRegList");
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
                              _buildTilered(
                                icon: "assets/ConOrder.png",
                                title: " Confirmed Order ",
                                fun: () {
                                  //chooseAppointment(context);
                                  Navigator.pushNamed(context, "/confirmorder");
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
                              _buildTilered(
                                //icon: Icons.document_scanner,
                                icon: "assets/ProcessOrder.png",
                                title: "Processed Orders",
                                fun: () {
                                  Navigator.pushNamed(context, "/processedorders");
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
                            _buildTileblue(
                              icon: "assets/DeliverdOrder.png",
                              title: "Deliverd Order",
                              fun: () {
                                //chooseAppointment1(context);
                               Navigator.pushNamed(context, "/deliverdorder");
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
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTileblue(
                                //icon: Icons.document_scanner,
                                icon: "assets/Invoices.png",
                                title: "Invoices",
                                fun: () {

                                  // Navigator.pushNamed(context, "/pocreportlist");
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
                            _buildTilered(
                              icon: "assets/monthlyoverview2.png",
                              title: "Monthly Overview",
                              fun: () {
                                 Navigator.pushNamed(context, "/monthloveryview");
                              },
                              color: AppData.BG1RED,
                              bordercolor: AppData.BG1RED,
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
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTilered(
                                //icon: Icons.document_scanner,
                                icon: "assets/Discount.png",
                                title: "Discount & Offer",
                                fun: () {
                                  Navigator.pushNamed(context, "/setdiscount");
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
                            _buildTileblue(
                              icon: "assets/chat 1.png",
                              title: "Online Chat",
                              fun: () {
                                //chooseAppointment1(context);
                                  Navigator.pushNamed(context, "/onlinechats");
                              },
                              color: AppData.BG2BLUE,
                              bordercolor: AppData.BG2BLUE,
                              // ,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     _buildTile2(
                    //       //icon: Icons.document_scanner,
                    //       icon: CupertinoIcons.settings_solid,
                    //       title: "Updation Data",
                    //       fun: () {
                    //         Navigator.pushNamed(context, "/testappointmentpage1");
                    //       },
                    //       color: AppData.BG1RED,
                    //       bordercolor: AppData.BG1RED,
                    //       // ,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            )
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
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  Widget _buildTilered(
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
                    /*"assets/logo1.png"*/
                    icon,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 70.0,
                  ),
                ),
                /*child: Icon(icon, color: AppData.kPrimaryRedColor,size: 40.0)),*/

                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Monte",
                    fontSize: 16,
                  ),
                ),
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
                      /* "assets/logo1.png"*/
                      icon,
                      fit: BoxFit.fitWidth,
                      width: 50,
                      height: 70.0,
                    )),
                //child: Icon(icon, color: AppData.kPrimaryColor,size: 40.0)),

                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Monte",
                    fontSize: 16,
                  ),
                ),
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
