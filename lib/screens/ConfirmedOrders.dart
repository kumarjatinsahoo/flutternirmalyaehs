import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmOrders extends StatefulWidget {
  final MainModel model;

  const ConfirmOrders({Key key, this.model}) : super(key: key);

  @override
  _ConfirmOrdersState createState() => _ConfirmOrdersState();
}

class _ConfirmOrdersState extends State<ConfirmOrders> {
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
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirm Orders',
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
        
       body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10.0),
                    child: Card(
                      child: Container(
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(5),
       border: Border.all(color: Colors.black12),    
                 gradient: LinearGradient(
            colors: [Colors.blueGrey[50], Colors.blue[50]])
                ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('Order No: ', style: TextStyle(
                                         color: AppData.kPrimaryColor
                                       ),),
                                       Text(' 9102'),
                                     ],
                                   ),
                                   SizedBox(height: 10,),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Text('Patient Name: ', style: TextStyle(
                                         color: AppData.kPrimaryColor
                                       ),),
                                       Text(' Seeama'),
                                     ],
                                   ),
                                   SizedBox(height: 10,),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Text('Location : ', style: TextStyle(
                                         color: AppData.kPrimaryColor
                                       ),),
                                       Text(' Baner'),
                                     ],
                                   ),
                                 ],
                               ),
                             
                             Icon(Icons.more_vert)
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
