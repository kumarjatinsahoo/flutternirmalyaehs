import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

class LabOrders extends StatefulWidget {
  final MainModel model;

  const LabOrders({Key key, this.model}) : super(key: key);

  @override
  _LabOrdersState createState() => _LabOrdersState();
}

class _LabOrdersState extends State<LabOrders> {
  int _selectedDestination = -1;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'LabOrders',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
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
                           color: Colors.blue[50]),
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

        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(shape: BoxShape.rectangle,
                      //color: const Color(0xFF66BB6A),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 1.0,
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(color: Colors.black54),
                          ),
                          Text(
                            '40',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.grey,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pickup',
                            style: TextStyle(color: Colors.black54),
                          ),
                          Text(
                            '20',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.grey,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Drop',
                            style: TextStyle(color: Colors.black54),
                          ),
                          Text(
                            '20',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Card(
                      elevation: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 3,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pickup id: DRLL12345'.toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppData.kPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Siva Sankar Prasad',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.black54,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    ' Distance 100m',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .circle_notifications,
                                                    color: Colors.black54,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    ' 10.00 am to 6.00 pm  ',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Text(
                                                    '(3 min delay)',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.red[900],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Colors.blue),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Colors.green),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/sampletracking");
                              },
                              child: Card(
                                  child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue[200]),
                                          color: Colors.blue[50]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Online Sample Request',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '5 tests included',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '100',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Center(
                                                    child: Icon(
                                                  Icons.info,
                                                  color: Colors.black54,
                                                )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 3,
                                    color: Colors.red[900],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pickup id: DRLL12345'.toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppData.kPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Siva Sankar Prasad',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.black54,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    ' Distance 100m',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .circle_notifications,
                                                    color: Colors.black54,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    ' 10.00 am to 6.00 pm  ',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Text(
                                                    '(3 min delay)',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.red[900],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Colors.blue),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Colors.green),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/processedorders");
                              },
                              child: Card(
                                  child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue[200]),
                                          color: Colors.blue[50]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Processed Orders',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '5 tests included',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black54),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '100',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Center(
                                                    child: Icon(
                                                  Icons.info,
                                                  color: Colors.black54,
                                                )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          color: Colors.grey,
          activeColor: AppData.kPrimaryColor,
          style: TabStyle.fixed,
          items: [
            TabItem(
                icon: Icons.collections_bookmark_rounded, title: 'Dashboard'),
            TabItem(icon: Icons.map, title: 'Orders'),
            TabItem(icon: Icons.home_outlined, title: 'Home'),
            TabItem(icon: Icons.notifications, title: 'Notification'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: 2,
          //optional, default as 0
          onTap: (int i) => print('click index=$i'),
        ));
  }
}
