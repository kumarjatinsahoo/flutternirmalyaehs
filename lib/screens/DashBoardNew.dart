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
 
 int _selectedIndex = 0;
  String motherName, lastPerioddt, deliverydt, id;
  String dateLeft = "0";

   int _selectedDestination = -1;
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

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
                    padding: EdgeInsets.only(
                      left: 20.0,
                      top: 20.0,
                      bottom: 20.0
                    ),
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
                  SizedBox(width: 20,),
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
                ListTile(
                  leading: Icon(Icons.notifications),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    selectDestination(3);
                    Navigator.pushNamed(context, "/onlinechats");
                  },

                  title: Text('Online Chat'),
                  // onTap: () {
                  // },
                ),
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
                  onTap: (){
                    selectDestination(6);
                     Navigator.pushNamed(context, "/myorder");
                  } 
                ),
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
                    selectDestination(8);
                    Navigator.pushNamed(context, "/processedorders");
                  } 
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Set Discount and Offer'),
                  selected: _selectedDestination == 9,
                  onTap: () {
                    selectDestination(9);
                    Navigator.pushNamed(context, "/setdiscount");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  selected: _selectedDestination == 10,
                  onTap: () {
                    selectDestination(10);
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
     
Widget _dashboardnew(context){
  Size size = MediaQuery.of(context).size;
 return SafeArea(
      child: Container(
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
           /*Padding(
             padding: const EdgeInsets.only(top:20.0, left: 10, right: 10, bottom: 10.0),
             child: FlutterToggleTab(  
  // width in percent, to set full width just set to 100  
  width: size.width * 0.23,  
  borderRadius: 30,  
  height: size.height * 0.06,  
  initialIndex:0, 
  selectedBackgroundColors: [AppData.matruColor],  
  selectedTextStyle: TextStyle(  
    color: Colors.white,
    // fontSize: 18,
    fontWeight: FontWeight.w600),
  unSelectedTextStyle: TextStyle(  
    color: Colors.black38,
    fontSize: 14,
    fontWeight: FontWeight.w600),
  labels: ["Day", "Week", "Month"],  
  selectedLabelIndex: (index) {  
	print("Selected Index $index");
  },  
),
 ),*/
           
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildTile(
                                      icon: Icons.book_online,
                                      //icon: FontAwesomeIcons.accusoft,
                                      title: "My Medical Record",
                                      fun: () {
                                         /* Navigator.pushNamed(context, "/geneicstores");*/
                                        // AppData.showSnack(
                                        //     context, "Coming soon", Colors.green);
                                      },
                                      color: Colors.pink[300],
                                      bordercolor: Colors.pink[100],
                                      size: (size.width - 42) / 2
                                      ),
                                      SizedBox(width: 5,),
                                 
                                  _buildTile(
                                      //icon: "assets/meditate.png",
                                      icon: Icons.mark_as_unread,
                                      //icon: FontAwesomeIcons.accusoft,
                                      title: "Find Healthcare Services",
                                      fun: () {
                                        Navigator.pushNamed(context, "/findHealthcareService");
                                      },
                                      color: Colors.indigoAccent[100],
                                      bordercolor: Colors.indigo[200],
                                      size: (size.width - 42) / 2),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTile(
                                  icon: Icons.directions_walk,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Discount & Offers",
                                  fun: () {
                                      Navigator.pushNamed(context, "/setdiscount");
                                    // AppData.showSnack(
                                    //     context, "Coming soon", Colors.green);
                                  },
                                  color: Colors.amber[700],
                                  bordercolor: Colors.amber[300],
                                  size: (size.width - 42) / 2),
                                  SizedBox(width: 5,),
                             
                              _buildTile(
                                  //icon: "assets/meditate.png",
                                  icon: Icons.description,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Emergency Help",
                                  fun: () {
                                    // AppData.showSnack(
                                    //   context, "Coming soon", Colors.green);
                                  },
                                  color: Colors.blue[300],
                                  bordercolor: Colors.blue[200],
                                  size: (size.width - 42) / 2),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                              Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTile(
                                  icon: Icons.description,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Medicine Reminder",
                                  fun: () {
                                      Navigator.pushNamed(context, "/medicinereminder");
                                    // AppData.showSnack(
                                    //     context, "Coming soon", Colors.green);
                                  },
                                  color: Colors.pink[300],
                                  bordercolor: Colors.pink[100],
                                  size: (size.width - 42) / 2),
                                  SizedBox(width: 5,),
                             
                              _buildTile(
                                  //icon: "assets/meditate.png",
                                  icon: Icons.calendar_today,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Upload Medical Data",
                                  fun: () {
                                    // AppData.showSnack(
                                    //   context, "Coming soon", Colors.green);
                                  },
                                  color: Colors.indigoAccent[100],
                                  bordercolor: Colors.indigo[200],
                                  size: (size.width - 42) / 2),
                            ],
                          ),
                           SizedBox(height: size.height * 0.02),
                              Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTile(
                                  icon: Icons.description,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Organ Donation",
                                  fun: () {
                                      Navigator.pushNamed(context, "/organdonation");
                                    // AppData.showSnack(
                                    //     context, "Coming soon", Colors.green);
                                  },
                                  color: Colors.pink[300],
                                  bordercolor: Colors.pink[100],
                                  size: (size.width - 42) / 2),
                                  SizedBox(width: 5,),
                             
                              _buildTile(
                                  //icon: "assets/meditate.png",
                                  icon: Icons.calendar_today,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Generic Medical Stores",
                                  fun: () {
                                     Navigator.pushNamed(context, "/geneicstores");
                                    // AppData.showSnack(
                                    //   context, "Coming soon", Colors.green);
                                  },
                                  color: Colors.indigoAccent[100],
                                  bordercolor: Colors.indigo[200],
                                  size: (size.width - 42) / 2),
                            ],
                          ),
                           SizedBox(height: size.height * 0.02),
                              Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTile(
                                  icon: Icons.description,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Govt Schemes",
                                  fun: () {
                                      Navigator.pushNamed(context, "/govtschemes");
                                    // AppData.showSnack(
                                    //     context, "Coming soon", Colors.green);
                                  },
                                  color: Colors.pink[300],
                                  bordercolor: Colors.pink[100],
                                  size: (size.width - 42) / 2),
                                  SizedBox(width: 5,),
                             
                              _buildTile(
                                  //icon: "assets/meditate.png",
                                  icon: Icons.calendar_today,
                                  //icon: FontAwesomeIcons.accusoft,
                                  title: "Monthly Overview",
                                  fun: () {
                                     Navigator.pushNamed(context, "/monthlyview");
                                    // AppData.showSnack(
                                    //   context, "Coming soon", Colors.green);
                                  },
                                  color: Colors.indigoAccent[100],
                                  bordercolor: Colors.indigo[200],
                                  size: (size.width - 42) / 2),
                            ],
                          ),
                  ],
                ),
              ),

           
            ],
          ),
        ),
      ),
    );
}

          
            void _onItemTapped(int index) {
             setState(() {
               if(index == 1){
                 Navigator.pushNamed(context, "/profile");
               }
               else if(index ==2){
                 Navigator.pushNamed(context, "/support");
               }
      _selectedIndex = index;
    });
  }
       Widget _buildTile({IconData icon, String title, double size, Color bordercolor, Color color, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        height: MediaQuery.of(context).size.height * 0.23,
        width: size,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),  
          color: color,        
          boxShadow: [
            BoxShadow(
              color: bordercolor,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Stack(
                  children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '12',
                  style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Monte",
                            fontSize: 22.0,
                  ),
                 
                ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20,top: 10),
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
                    ),
              ],
            ),
        Positioned(
          top: -3,
          right: -3,
          child: Container(
            height: 60,
            width: 60,
             decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),  
          color: Colors.white24, 
             ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(icon, color: Colors.white,)
            ) )),
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
