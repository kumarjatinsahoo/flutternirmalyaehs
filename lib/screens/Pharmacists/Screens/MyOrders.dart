import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  final MainModel model;

  const MyOrders({Key key, this.model}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int _selectedDestination = -1;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Orders List',
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
        
         body: ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Container(
                    height: height * 0.27,
                    // color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
            colors: [Colors.blueGrey[50], Colors.blue[50]])
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5, bottom: 5),
                            child: InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, "/confirmorder");
                              },
                                                          child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                                                      child: Image.asset(
                                      'assets/discount2.jpg',
                                      width: width * 0.4,
                                      // height: height,
                                       height: height * 0.17,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  Expanded(
                                         child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '2021-07-06',
                                              textAlign: TextAlign.right,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.alarm,
                                              size: 15,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '19:41:10',
                                              textAlign: TextAlign.right,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Text(
                                          'Order ID: ',
                                          style: TextStyle(
                                              color: Colors.blue, fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                              'OD67867871941',
                                              overflow: TextOverflow.clip,
                                              maxLines: 2,
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.red[900]),
                                  child: RaisedButton(
                                    onPressed: null,
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 ),
                                    ),
                                    disabledColor: Colors.red[900],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black12),
                                      color: Colors.blue),
                                  child: RaisedButton(
                                    onPressed: null,
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                                    ),
                                    disabledColor: Colors.blue[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
