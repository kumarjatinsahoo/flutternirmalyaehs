
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class VitalSigns extends StatefulWidget {
  final MainModel model;
  final Choice choice;
  const VitalSigns({Key key, this.model,this.choice}) : super(key: key);

  @override
  _VitalSignsState createState() => _VitalSignsState();
}

class _VitalSignsState extends State<VitalSigns> {
  int _selectedDestination = -1;
  List<String> strOrders = ['My Orders', 'Confirm Orders', 'Processed Orders','Delivered Orders','Delivered Orders1'];
  List<String> strOthers1 = ['Invoices','Monthly Review','Offfers and Discount', 'Online Chat', 'Daily Sales'];

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
            'Vital Signs',
            style: TextStyle(color: AppData.white),
          ),
          centerTitle: true,
          backgroundColor:AppData.kPrimaryColor,
          iconTheme: IconThemeData(color: AppData.white),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15,left: 5,right: 5,),
            child: Column(
              children: [
                Container(
                  height: 90,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black26),
                            /*color: Colors.blue[50]*/),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '161',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  ' Height(CM)',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black26),
                            //color: Colors.red[50]),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '63',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Weigth(kg)',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black26),
                            ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '24',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'BMI(kg/m)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Column(
//                  shrinkWrap: true,
                    children: [
                      Container(
                        color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                      /*    itemCount: strOrders.length,
                          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            // mainAxisExtent: 110,
                            // mainAxisSpacing: 5,
                              crossAxisCount: (orientation == Orientation.portrait) ? 2:5 ),
                          itemBuilder: (BuildContext context, int index) {*/
                          children: List.generate(choices.length, (index) {
                            return Card(
                              elevation: 2,

                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppData.grey100,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                                  child: InkWell(
                                    /*onTap: (){
                                      Navigator.pushNamed(context, "/deliveredorder");
                                    },*/
                                    child: Container(
                                      child: new GridTile(
                                        child:

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 10,
                                                  child: new Image.asset(
                                                    "assets/images/dashboard (1).png",
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                    // color: Colors.blue
                                                  ),
                                                ),
                                              ],

                                            ),
                                            SizedBox(height: size.height * 0.02,),
                                            Text(choices..toString(),
                                              style: TextStyle( color: Colors.black,fontSize: 15),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              maxLines: 2,
                                            ),
                                            SizedBox(height: size.height * 0.01,),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(0xFFD8ABAF),
                                                    width: 1.0, // Underline thickness
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: size.height * 0.02,),
                                            Text(gridState[index].toString(),
                                              style: TextStyle( color: Colors.grey,fontSize: 12),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                    ),
                    ),
                      ),
  ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home),
  const Choice(title: 'Contact', icon: Icons.contacts),
  const Choice(title: 'Map', icon: Icons.map),
  const Choice(title: 'Phone', icon: Icons.phone),
  const Choice(title: 'Camera', icon: Icons.camera_alt),
  const Choice(title: 'Setting', icon: Icons.settings),
  const Choice(title: 'Album', icon: Icons.photo_album),
  const Choice(title: 'WiFi', icon: Icons.wifi),
];
