

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:intl/intl.dart';
import 'package:pageview_indicator_plugins/pageview_indicator_plugins.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/Const.dart';
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
  double _height = 75;
  int _selectedDestination = -1;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
  PageController _controller = PageController(
    initialPage: 0,
  );

List<String> imageSliders = [
    "assets/AjitPawarji.PNG",
     "assets/JaiRamThakurji.jpg",
     "assets/NitishKumarji.jpg",
     "assets/PramodAgrawalji .jpg",
     "assets/PramodSawantji.jpg",
     "assets/UddhavThackeryji.jfif",
     "assets/YogiAdityanathji.jpg",
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
                    //Navigator.pushNamed(context, "/dashboard");
                   // Navigator.pushNamed(context, "/dashboard1");
                  }
                  // onTap: (){},

                  ),
              ListTile(
                leading:Image.asset("assets/images/myprofile.png",height: 30,),
                title: Text('My Profile'),
                selected: _selectedDestination == 1,
                onTap: () {
                  selectDestination(1);
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              ListTile(
                 leading:Image.asset("assets/images/home.png",height: 30,),
                // leading: Icon(Icons.person),
                title: Text('Home'),
                selected: _selectedDestination == 2,
                // onTap: () {
                //   selectDestination(1);
                //   Navigator.pushNamed(context, "/profile");
                // },
              ),
              ListTile(
                 leading:Image.asset("assets/images/account.png",height: 30,),
                // leading: Icon(Icons.person),
                title: Text('Manage Account'),
                selected: _selectedDestination == 3,
                onTap: () {
                  selectDestination(1);
                 // Navigator.pushNamed(context, "/patientDashboard");
                },
              ),
              ListTile(
                leading:Image.asset("assets/images/aboutus.png",height: 30,),
                // leading: Icon(Icons.person),
                title: Text('About Us'),
                selected: _selectedDestination == 4,
                // onTap: () {
                //   selectDestination(1);
                //   Navigator.pushNamed(context, "/profile");
                // },
              ),
              ListTile(
                  leading: Image.asset("assets/images/share.png",height: 30,),
                  title: Text('Share'),
                  selected: _selectedDestination == 5,
                  /* onTap: () {
                   selectDestination(5);
                   Navigator.pushNamed(context, "/dashboard1");
                  }*/
              ),

              ListTile(
                  leading: Image.asset("assets/images/contact us.png",height: 30,),
                  title: Text('Contact Us'),
                  selected: _selectedDestination == 6,
                  onTap: () {
                    selectDestination(6);
                    Navigator.pushNamed(context, "/share");
                  }
              ),

              ListTile(
                leading: Image.asset("assets/images/support.png",height: 30,),
                title: Text('Support'),
                selected: _selectedDestination == 7,
                onTap: () {
                  selectDestination(5);
                  Navigator.pushNamed(context, "/signUpForm");
                }
                ),
              ListTile(
                leading: Image.asset("assets/images/reminder.png",height: 30,),
                title: Text('Reminder'),
                selected: _selectedDestination == 8,
                // onTap: () {
                //   selectDestination(5);
                //   Navigator.pushNamed(context, "/share");
                // }
              ),



              ListTile(
                leading: Icon(Icons.person),
                title: Text('Notifications'),
                selected: _selectedDestination == 2,
                onTap: () {
                  selectDestination(2);
                   Navigator.pushNamed(context, "/patientRegistration");
                },
              ),
              ListTile(
                leading: Icon(Icons.help_center),
                title: Text('Help'),
                selected: _selectedDestination == 4,
                onTap: () {
                  selectDestination(4);
                  Navigator.pushNamed(context, "/help");
                },
                // onTap: () {
                // },
              ),

              ListTile(
                  leading: Icon(Icons.collections),
                  title: Text('My Orders'),
                  selected: _selectedDestination == 6,
                  onTap: () {
                    selectDestination(6);
                    Navigator.pushNamed(context, "/myorder");
                  }),
              ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Monthly Overview'),
                  selected: _selectedDestination == 7,
                  onTap: () {
                    selectDestination(7);
                    Navigator.pushNamed(context, "/monthlyview");
                  }),
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
                leading: Icon(Icons.home),
                title: Text('Tab Instruction'),
                selected: _selectedDestination == 9,
                onTap: () {
                  selectDestination(8);
                  Navigator.pushNamed(context, "/tabinstruction");
                },
              ),
              ListTile(
                leading: Image.asset("assets/images/logout.png",height: 30,),
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
     /* bottomNavigationBar: BottomNavigationBar(
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
          *//* BottomNavigationBarItem(
                icon: Icon(
                  Icons.child_friendly_outlined,
                  //color: Colors.grey,
                  size: 30,
                ),
                title: Text(
                  'Maa Gruha',
                  style: TextStyle(color: Colors.grey),
                ),
              ),*//*
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
      ),*/
    );
  }


  Widget _dashboardnew(context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: double.maxFinite,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _controller,

                children: [
                  MyPage1Widget(),
                  MyPage2Widget(),

                ],
              ),
            ),

            PageIndicator(
              length: 2,
              pageController: _controller,
              currentColor:Colors.grey,
              normalColor:Colors.black12,
              /*colorDot: Colors.grey,
              sizeDot: 8.0,
              colorActiveDot: Colors.black,*/
            ),
            /*CarouselSlider(
              options: CarouselOptions(
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
                  .map((item) =>
                  InkWell(
                    onTap: (){
                      int index=imageSliders.indexOf(item);
                      if(index==1)
                        //AppData.showInSnackDone(context, "Clicked");
                        AppData.launchURL("https://www.youtube.com/watch?v=XBvfeNAh9IY");
                    },
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)),
                          child: Stack(
                            children: [
                              Image.asset(
                                item,
                                fit: BoxFit.fill,
                                width: 1000,
                                height: double.maxFinite,
                                //height: 100,
                              ),
                              *//* Image.network(
                                                     item.bannerImage,
                                                     fit: BoxFit.fill,
                                                      width: 1000,
                                                    height: double.maxFinite,
                                                     ),*//*
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(
                                            200, 0, 0, 0),
                                        Color.fromARGB(
                                            0, 0, 0, 0)
                                      ],
                                      begin: Alignment
                                          .bottomCenter,
                                      end:
                                      Alignment.topCenter,
                                    ),
                                  ),
                                  padding:
                                  EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        (imageSliders.indexOf(
                                            item) +
                                            1)
                                            .toString() +
                                            "/" +
                                            imageSliders
                                                .length
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight:
                                          FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child:(imageSliders.indexOf(item)==1)? Icon(Icons.play_circle_fill,color: Colors.white,size: 45,):Container(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
                  .toList(),
            ),*/
            CarouselSlider(
              options: CarouselOptions(
                  height: 225,
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
              items: imageSliders
                  .map((item) =>
                  InkWell(
                    onTap: (){
                      int index=imageSliders.indexOf(item);
                      if(index==3)
                        //AppData.showInSnackDone(context, "Clicked");
                       // AppData.launchURL("https://www.youtube.com/watch?v=XBvfeNAh9IY");
                       AppData.launchURL("https://www.youtube.com/watch?v=axzWoVaF4N4");
                      if(index==6)
                        //AppData.showInSnackDone(context, "Clicked");
                        // AppData.launchURL("https://www.youtube.com/watch?v=XBvfeNAh9IY");
                        AppData.launchURL("https://www.youtube.com/watch?v=ckYGlJwCmlg&fs=1");
                      if(index==0)
                        //AppData.showInSnackDone(context, "Clicked");
                        // AppData.launchURL("https://www.youtube.com/watch?v=XBvfeNAh9IY");
                        //AppData.launchURL("https://youtu.be/-sTLaWKiklM");
                        AppData.launchURL("https://www.youtube.com/embed/-sTLaWKiklM&vs");
                    },
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)),
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
                                        Color.fromARGB(
                                            200, 0, 0, 0),
                                        Color.fromARGB(
                                            0, 0, 0, 0)
                                      ],
                                      begin: Alignment
                                          .bottomCenter,
                                      end:
                                      Alignment.topCenter,
                                    ),
                                  ),
                                  padding:
                                  EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        (imageSliders.indexOf(
                                            item) +
                                            1)
                                            .toString() +
                                            "/" +
                                            imageSliders
                                                .length
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight:
                                          FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child:(imageSliders.indexOf(item)==3)? Icon(Icons.play_circle_fill,color: Colors.white,size: 45,):Container(),

                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child:(imageSliders.indexOf(item)==6)? Icon(Icons.play_circle_fill,color: Colors.white,size: 45,):Container(),

                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child:(imageSliders.indexOf(item)==0)? Icon(Icons.play_circle_fill,color: Colors.white,size: 45,):Container(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
                  .toList(),
            ),

            /*CarouselSlider(
              options: CarouselOptions(
                  height: 170,
                  autoPlay: true,
                  pageSnapping: true,
                  viewportFraction: 0.9,
                  scrollDirection: Axis.horizontal,
                  disableCenter: true,
                  autoPlayInterval: Duration(seconds: 8),
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
                        *//* onTap: (){
                          int index=imageSliders.indexOf(item);
                          if(index==1)
                            //AppData.showInSnackDone(context, "Clicked");
                            AppData.launchURL("https://www.youtube.com/watch?v=XBvfeNAh9IY");
                        },*//*
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
                                   *//*Image.network(
                                                 item.bannerImage,
                                                 fit: BoxFit.fill,
                                                  width: 1000,
                                                height: double.maxFinite,
                                                 ),*//*
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
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child:(imageSliders.indexOf(item)==1)? Icon(Icons.play_circle_fill,color: Colors.white,size: 45,):Container(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            )*/
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


class MyPage1Widget extends StatelessWidget {
  double _height = 85;
  double _width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _width =  (MediaQuery.of(context).size.width - 80) / 3;
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, bottom: 10),
            child: SingleChildScrollView(
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
                              icon: "assets/folder.png",
                              fun: () {
                                Navigator.pushNamed(context, "/medicalrecordpage");
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
                              height:35,
                              /* child: Expanded(*/
                              child: Text(
                                "My Medical Record",textAlign:TextAlign.center ,
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
                              icon: "assets/search_icon.png",
                              fun: () {
                                Navigator.pushNamed(
                                    context, "/findHealthcareService");
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
                              height:35,
                              /* child: Expanded(*/
                              child: Text(
                                "Find Healthcare Services",textAlign:TextAlign.center ,
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
                            _buildTileblue(
                              icon: "assets/health_checkup.png",
                              fun: () {
                                //chooseAppointment(context);
                                /*Navigator.pushNamed(
                                    context, "/medipedia");*/
                                // AppData.showSnack(
                                //     context, "Coming soon", Colors.green);
                              },
                              color: AppData.BG2BLUE,
                              bordercolor: AppData.BG2BLUE,
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
                                "Appointment",textAlign:TextAlign.center ,
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
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                              //size: (size.width - 130) / 3,
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
                               icon: "assets/clock.png",
                              //icon: Icons.alarm,
                              //icon: FontAwesomeIcons.accusoft,
                              title: "Medicine Reminder",
                              fun: () {
                                Navigator.pushNamed(
                                    context, "/medicinereminder");
                                // AppData.showSnack(
                                //     context, "Coming soon", Colors.green);
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
                              icon: "assets/offers.png",
                              fun: () {
                                Navigator.pushNamed(
                                    context, "/discountoffer");
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
                              height:35,
                              child: Text(
                                "Discount & Offers",textAlign:TextAlign.center ,
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
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /*Expanded(
                            child:*/ Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTileblue(
                              icon: "assets/organ_donner.png",
                              //icon: Icons.wc_rounded,
                              //icon: FontAwesomeIcons.accusoft,
                              title: "Organ  Donation",
                              fun: () {
                                Navigator.pushNamed(
                                    context, "/organdonation");
                                // AppData.showSnack(
                                //     context, "Coming soon", Colors.green);
                              },
                              color: AppData.BG2BLUE,
                              bordercolor: AppData.BG2BLUE,
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
                              icon: "assets/generic_medicine.png",
                              //icon: Icons.animation,
                              //icon: FontAwesomeIcons.accusoft,
                              title: "Generic Medical Stores",
                              fun: () {
                                Navigator.pushNamed(
                                    context, "/geneicstores");
                                // AppData.showSnack(
                                //   context, "Coming soon", Colors.green);
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
                              icon: "assets/govtscheme.png",
                              //icon: Icons.home_outlined,
                              //icon: FontAwesomeIcons.accusoft,
                              title: "Govt Schemes",
                              fun: () {
                                Navigator.pushNamed(
                                    context, "/govtschemes");
                                // AppData.showSnack(
                                //     context, "Coming soon", Colors.green);
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
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /*Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTilered(
                              icon: "assets/upload.png",
                              //icon: Icons.wc_rounded,
                              //icon: FontAwesomeIcons.accusoft,
                             // title: "Upload Medical Data",
                              fun: () {
                               Navigator.pushNamed(
                                    context, "/worldwidehospital");
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
                              height:35,
                              *//* child: Expanded(*//*
                              child: Text(
                                "Upload Medical Data",textAlign:TextAlign.center ,
                                //overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            *//* Align(
                                      alignment: Alignment.center,
                                      child: Expanded(
                                        child: Text(
                                          "Organ     Donation",
                                          style: TextStyle(color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),*//*
                          ]),*/

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTilered(
                              icon: "assets/insurance.png",
                              //icon: Icons.drive_folder_upload,
                              //icon: FontAwesomeIcons.accusoft,
                              title: "Upload Medical Data",
                              fun: () {
                                Navigator.pushNamed(
                                    context, "/insuranceList");

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
                              height:35,
                              /* child: Expanded(*/
                              child: Text(
                                "Insurance",textAlign:TextAlign.center ,
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
                            _buildTileblue(
                              icon: "assets/health_care.png",
                              //icon: Icons.animation,
                              //icon: FontAwesomeIcons.accusoft,
                             title: "Generic Medical Stores",
                              fun: () {
                              /*  Navigator.pushNamed(
                                    context, "/geneicstores");*/
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
                              height:35,
                              /* child: Expanded(*/
                              child: Text(
                                "Preventive Health Care",textAlign:TextAlign.center ,
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
                            _buildTilered(
                              icon: "assets/medipedia.png",
                              fun: () {
                                Navigator.pushNamed(
                                    context, "/medipedia");
                                // AppData.showSnack(
                                //     context, "Coming soon", Colors.green);
                              },
                              color: AppData.BG1RED,
                              bordercolor: AppData.BG1RED,
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
                                "Medipedia",textAlign:TextAlign.center ,
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
                ],
              ),
            ),
            ),
          ),
      ],
    );
  }
  Widget _buildTileblue(
      {String icon, /*IconData icon,*/
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
                   /* "assets/logo1.png"*/icon,
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
      { String icon,
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
        width:_width,
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
                    /*"assets/logo1.png"*/icon,
                    fit: BoxFit.fitWidth,
                       width: 50,
                       height: 70.0,
                  ),),
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
    _width =  (MediaQuery.of(context).size.width - 80) / 3;
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, bottom: 10),
           /* child: SingleChildScrollView(*/
              child: Column(

                children: [
                  SizedBox(
                    height: 10,
                  ),

                  Row(
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
                                Navigator.pushNamed(
                                    context, "/healthCheckup");
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
                              height:35,

                              child: Text(
                                "Health Checkup",textAlign:TextAlign.center ,
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
                            _buildTilered(
                              icon: "assets/infomatics.png",
                              //icon: Icons.local_offer,
                              //icon: FontAwesomeIcons.accusoft,
                              title: "Discount & Offers",
                              fun: () {
                               /* Navigator.pushNamed(
                                    context, "/setdiscount");*/
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
                              height:35,

                              child: Text(
                                "eHealth Infomatics",textAlign:TextAlign.center ,
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
                      SizedBox(
                        width: 15,
                      ),

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
      {String icon,/* IconData icon,*/
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
                    /*"assets/logo1.png"*/icon,
                    fit: BoxFit.fitWidth,
                       width: 50,
                       height: 70.0,

                  ),
                   /* child: Icon(icon, color: AppData.kPrimaryColor,size: 40.0)*/),

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
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                          /*  widget.model.apntUserType = Const.HEALTH_SCREENING_APNT;*/
                            //Navigator.pop(context);
                            //Navigator.pushNamed(context, "/docApnt");
                            Navigator.pushNamed(context, "/docApnt");
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
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Doctor Visit"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                            //widget.model.apntUserType = Const.DOC_APNT;
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

  Widget _buildTile1(
      { IconData icon,
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
        width:_width,
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
                   /* "assets/logo1.png"*/icon,
                    fit: BoxFit.fitWidth,
                       width: 50,
                       height: 70.0,
                  ),),
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