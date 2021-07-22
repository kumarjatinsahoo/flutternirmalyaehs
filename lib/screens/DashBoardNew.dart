import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:intl/intl.dart';
import 'package:user/scoped-models/MainModel.dart';

import '../providers/app_data.dart';

class DashboardUserNew extends StatefulWidget {
  MainModel model;

  DashboardUserNew({Key key, this.model}) : super(key: key);

  @override
  _DashboardUserNewState createState() => _DashboardUserNewState();
}

class _DashboardUserNewState extends State<DashboardUserNew> {
  int _currentIndex = 0;
  int _selectedIndex = 0;
  String motherName, lastPerioddt, deliverydt, id;
  String dateLeft = "0";
  double _height = 90;
  int _selectedDestination = -1;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  List<String> imageSliders = [
    "assets/offer_ad.png",
    "assets/bannerimag1.jpeg",

    /* "assets/sstory_one.jpg",*/
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*setState(() {
      dateLeft = getDateTimeFormat("2021-01-15");
    });*/
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

          /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),*/

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
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
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Dr John',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
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
                    Navigator.pushNamed(context, "/dashboard");
                  }
                  // onTap: (){},

                  ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('My Profile'),
                selected: _selectedDestination == 1,
                onTap: () {
                  selectDestination(1);
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Notifications'),
                selected: _selectedDestination == 2,
                onTap: () {
                  selectDestination(2);
                  // Navigator.pushNamed(context, "/Notifications");
                },
              ),
              /* ListTile(
                  leading: Icon(Icons.notifications),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    selectDestination(3);
                    Navigator.pushNamed(context, "/onlinechats");
                  },

                  title: Text('Online Chat'),
                  // onTap: () {
                  // },
                ),*/
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
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                selected: _selectedDestination == 5,
                onTap: () => selectDestination(5),
              ),
              ListTile(
                  leading: Icon(Icons.collections),
                  title: Text('My Orders'),
                  selected: _selectedDestination == 6,
                  onTap: () {
                    selectDestination(6);
                    Navigator.pushNamed(context, "/myorder");
                  }),
             /* ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Monthly Overview'),
                  selected: _selectedDestination == 7,
                  onTap: () {
                    selectDestination(7);
                    Navigator.pushNamed(context, "/monthlyview");
                  }),*/
              ListTile(
                  leading: Icon(Icons.healing),
                  title: Text('Processed Orders'),
                  selected: _selectedDestination == 8,
                  onTap: () {
                    selectDestination(7);
                    Navigator.pushNamed(context, "/processedorders");
                  }),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Set Discount and Offer'),
                selected: _selectedDestination == 9,
                onTap: () {
                  selectDestination(8);
                  Navigator.pushNamed(context, "/setdiscount");
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                selected: _selectedDestination == 10,
                onTap: () {
                  selectDestination(9);
                  Navigator.pushNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
      ),
      body: _dashboardnew(context),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 9,
        unselectedFontSize: 9,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(color: AppData.matruColor),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              //color: Colors.grey,
              size: 30,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          /* BottomNavigationBarItem(
                icon: Icon(
                  Icons.child_friendly_outlined,
                  //color: Colors.grey,
                  size: 30,
                ),
                title: Text(
                  'Maa Gruha',
                  style: TextStyle(color: Colors.grey),
                ),
              ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Icons.support,
              //color: Colors.grey,
              size: 30,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              //color: Colors.grey,
              size: 30,
            ),
            title: Text(
              'Support',
              style: TextStyle(color: Colors.grey),
            ),
            //backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              //color: Colors.grey,
              size: 30,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(color: Colors.grey),
            ),
            //backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _dashboardnew(context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: double.maxFinite,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10),
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                         /* Expanded(
                            child:*/ Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTileblue(
                                    icon: Icons.movie_filter_sharp,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "My Medical Record",
                                    fun: () {
                                      /* Navigator.pushNamed(context, "/geneicstores");*/
                                      // AppData.showSnack(
                                      //     context, "Coming soon", Colors.green);
                                    },
                                    color: AppData.kPrimaryLightColor,
                                    bordercolor: AppData.kPrimaryLightColor,
                                    // ,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                    /* child: Expanded(*/
                                    child: Text(
                                      "My Medical Record",textAlign:TextAlign.center ,
                                      //overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                /*  Text(
                                    "My Medical Record",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),*/
                                ]),
                         
                          SizedBox(
                            width: 5,
                          ),
                          /*Expanded(
                            child:*/ Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTilered(
                                    //icon: "assets/meditate.png",
                                    icon: Icons.animation,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "Test Report",
                                    fun: () {
                                     /* Navigator.pushNamed(
                                          context, "/geneicstores");*/
                                      // AppData.showSnack(
                                      //   context, "Coming soon", Colors.green);
                                    },
                                    color: AppData.klightRedColor,
                                    bordercolor: AppData.klightRedColor,
                                    size: (size.width - 130) / 3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                     /* child: Expanded(*/
                                      child: Text(
                                        "Test Report",textAlign:TextAlign.center ,
                                        //overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                /*  ),*/
                                  /*Align(
                                      alignment: Alignment.center,
                                      child: Expanded(
                                        child: Text(
                                          "Test            Report",
                                          style: TextStyle(color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),*/
                                ]),


                          SizedBox(
                            width: 5,
                          ),
                         /* Expanded(*/
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTileblue(
                                    //icon: "assets/meditate.png",
                                    icon: Icons.animation,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "Generic Medical Stores",
                                    fun: () {
                                     /* Navigator.pushNamed(
                                          context, "/geneicstores");*/
                                      // AppData.showSnack(
                                      //   context, "Coming soon", Colors.green);
                                    },
                                    color: AppData.klightRedColor,
                                    bordercolor: AppData.klightRedColor,
                                    size: (size.width - 130) / 3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                      child: Text(
                                        "Health chat",textAlign:TextAlign.center ,
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
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         /* Expanded(*/
                             Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTile1(
                                    //icon: "assets/meditate.png",
                                    icon: Icons.local_offer,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "HELP",
                                    fun: () {
                                      // AppData.showSnack(
                                      //   context, "Coming soon", Colors.green);
                                      Navigator.pushNamed(
                                          context, "/emergencyHelp");
                                    },
                                    color: AppData.kPrimaryRedColor,
                                    bordercolor: AppData.kPrimaryRedColor,
                                    size: (size.width - 130) / 3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                    /* child: Expanded(*/
                                    child: Text(
                                      "Emergency Help",textAlign:TextAlign.center ,
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

                          SizedBox(
                            width: 5,
                          ),
                          /*Expanded(
                            child:*/ Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTileblue(
                                    // icon: "assets/logo1.png",
                                    icon: Icons.alarm,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "Medicine Reminder",
                                    fun: () {
                                      Navigator.pushNamed(
                                          context, "/medicinereminder");
                                      // AppData.showSnack(
                                      //     context, "Coming soon", Colors.green);
                                    },
                                    color: AppData.kPrimaryLightColor,
                                    bordercolor: AppData.kPrimaryLightColor,
                                    size: (size.width - 130) / 3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                    /* child: Expanded(*/
                                    child: Text(
                                      "Medicine Reminder",textAlign:TextAlign.center ,
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
                          /*),*/
                          SizedBox(
                            width: 5,
                          ),/*  Expanded(*/

                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTilered(
                                    //icon: "assets/meditate.png",
                                    icon: Icons.drive_folder_upload,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "Upload Medical Data",
                                    fun: () {
                                      // AppData.showSnack(
                                      //   context, "Coming soon", Colors.green);
                                    },
                                    color: AppData.klightRedColor,
                                    bordercolor: AppData.klightRedColor,
                                     size: (size.width - 130) / 3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                    /* child: Expanded(*/
                                    child: Text(
                                      "Upload Medical Data",textAlign:TextAlign.center ,
                                      //overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  /*Align(
                                      alignment: Alignment.center,
                                      child: Expanded(
                                        child: Text(
                                          "Upload Medical Data",
                                          style: TextStyle(color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),*/
                                ]),

                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /*Expanded(
                            child:*/ Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTileblue(
                                    //icon: "assets/logo1.png",
                                    icon: Icons.wc_rounded,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "Organ  Donation",
                                    fun: () {
                                      Navigator.pushNamed(
                                          context, "/organdonation");
                                      // AppData.showSnack(
                                      //     context, "Coming soon", Colors.green);
                                    },
                                    color: AppData.kPrimaryLightColor,
                                    bordercolor: AppData.kPrimaryLightColor,
                                    size: (size.width - 130) / 3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                    /* child: Expanded(*/
                                    child: Text(
                                      "Organ Donation",textAlign:TextAlign.center ,
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
                          /*Expanded(*/
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTilered(
                                    //icon: "assets/meditate.png",
                                    icon: Icons.animation,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "Generic Medical Stores",
                                    fun: () {
                                      Navigator.pushNamed(
                                          context, "/geneicstores");
                                      // AppData.showSnack(
                                      //   context, "Coming soon", Colors.green);
                                    },
                                    color: AppData.klightRedColor,
                                    bordercolor: AppData.klightRedColor,
                                    size: (size.width - 130) / 3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                    /* child: Expanded(*/
                                    child: Text(
                                      "Generic Medical Stores",textAlign:TextAlign.center ,
                                      //overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                 /* Align(
                                      alignment: Alignment.center,
                                      child: Expanded(
                                        child: Text(
                                          "Generic Medical Stores",
                                          style: TextStyle(color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),*/
                                ]),

                          SizedBox(
                            width: 5,
                          ),
                         /* Expanded(
                            child: */Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTileblue(
                                    icon: Icons.home_outlined,
                                    //icon: FontAwesomeIcons.accusoft,
                                    title: "Govt Schemes",
                                    fun: () {
                                      Navigator.pushNamed(
                                          context, "/govtschemes");
                                      // AppData.showSnack(
                                      //     context, "Coming soon", Colors.green);
                                    },
                                    color: AppData.kPrimaryLightColor,
                                    bordercolor: AppData.kPrimaryLightColor,
                                    size: (size.width - 130) / 3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height:35,
                                    /* child: Expanded(*/
                                    child: Text(
                                      "Govternment Schemes",textAlign:TextAlign.center ,
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
                      /*SizedBox(height: size.height * 0.02),
                                Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                              ],
                            ),*/
                      SizedBox(height: size.height * 0.02),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               // crossAxisAlignment: CrossAxisAlignment.center,

                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _buildTilered(
                                          //icon: "assets/meditate.png",
                                          icon: Icons.search,
                                          //icon: FontAwesomeIcons.accusoft,
                                          title: "Find Healthcare Services",
                                          fun: () {
                                            Navigator.pushNamed(
                                                context, "/findHealthcareService");
                                          },
                                          color: AppData.klightRedColor,
                                          bordercolor: AppData.klightRedColor,
                                          size: (size.width - 130) / 3,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 100,
                                          height:35,

                                          child: Text(
                                            "Find Healthcare Services",textAlign:TextAlign.center ,
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
                                          icon: Icons.local_offer,
                                          //icon: FontAwesomeIcons.accusoft,
                                          title: "Discount & Offers",
                                          fun: () {
                                            Navigator.pushNamed(
                                                context, "/setdiscount");
                                            // AppData.showSnack(
                                            //     context, "Coming soon", Colors.green);
                                          },
                                          color: AppData.kPrimaryLightColor,
                                          bordercolor: AppData.kPrimaryLightColor,
                                          size: (size.width - 130) / 3,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: 100,
                                          height:35,

                                            child: Text(
                                              "Discount & Offers",textAlign:TextAlign.center ,
                                              //overflow: TextOverflow.ellipsis,
                                            ),
                                          ),

                                      /*  Align(
                                          alignment: Alignment.center,
                                          child:SizedBox(
                                            width:100, child: FittedBox(child:Text(
                                            "Discount & Offers",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                          )
                                        ),
                                        ),*/
                                      ]),

                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
           
            CarouselSlider(
              options: CarouselOptions(
                  height: 130,
                  autoPlay: true,
                  pageSnapping: true,
                  viewportFraction: 0.9,
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
              items: imageSliders
                  .map((item) => InkWell(
                        /* onTap: (){
                          int index=imageSliders.indexOf(item);
                          if(index==1)
                            //AppData.showInSnackDone(context, "Clicked");
                            AppData.launchURL("https://www.youtube.com/watch?v=XBvfeNAh9IY");
                        },*/
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
                                  /* Image.network(
                                                 item.bannerImage,
                                                 fit: BoxFit.fill,
                                                  width: 1000,
                                                height: double.maxFinite,
                                                 ),*/
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
                                  /*Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child:(imageSliders.indexOf(item)==1)? Icon(Icons.play_circle_fill,color: Colors.white,size: 45,):Container(),
                                  )*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            )
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
        width: (MediaQuery.of(context).size.width - 130) / 3,
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
              width: 1.5,
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
                    child: Icon(icon, color: AppData.kPrimaryColor,size: 40.0)),

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
        width: (MediaQuery.of(context).size.width - 130) / 3,
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
        width: /*(MediaQuery.of(context).size.width - 130) / 3*/size,
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
              width: 1.5,
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
                    child: Icon(icon, color: AppData.kPrimaryRedColor,size: 40.0)),

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
