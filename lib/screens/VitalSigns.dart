
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
  int count = 0;
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
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 8.0,
                          children: List.generate(choices.length, (index) {
                            return
                             Card(
                              elevation: 2,

                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppData.grey100,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                                  child: InkWell(
                                    onTap: (){
                                     // Navigator.pushNamed(context, "/deliveredorder");
                                    },
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
                                                
                                                Container(
                                            /*count % 2 == 1 ??*/
                                                    color:AppData.kPrimaryRedColor,
                                                    padding: EdgeInsets.all(3),
                                                    child: Image.asset(choices[index].icon,height: 40,)
                                                ),
                                                Container(
                                                  /*count % 2 == 1 ??*/
                                                    color:AppData.klightblurColor,
                                                    padding: EdgeInsets.all(3),
                                                    child: Image.asset(choices[index].icon,height: 40,)
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: size.height * 0.02,),
                                            Text( choices[index].title.toString(),
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
                                            Text( choices[index].title1.toString(),
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
  const Choice({this.title, this.icon,this.title1});
  final String title;
  final String icon;
  final String title1;
}
const List<Choice> choices = const <Choice>[
  //const Choice(title: 'Home', icon: Icons.home,title1: '12345'),
  const Choice(title: '38.000C 1000.000F', icon: "assets/temperatuer.png",title1: 'Temperature'),
  const Choice(title: '213/4 mmHg', icon: "assets/bloodp.png", title1: 'Systolic Diastolic Blood Pressure'),
  const Choice(title: '120/min',icon: "assets/pulse.png",title1: 'Pulse'),
  const Choice(title: '24 bpm',icon: "assets/respiration.png",title1: 'Respiration'),
  const Choice(title: '50 % ',icon: "assets/oxygen.png",title1: 'Oxygen Saturation'),
];
class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return  Card(
                              elevation: 2,

                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppData.grey100,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                                  child: InkWell(
                                    onTap: (){
                                     // Navigator.pushNamed(context, "/deliveredorder");
                                    },
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
                                            Text( choice.title,
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
                                            Text( choice.title1,
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
    /*Card(
        color: Colors.orange,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Icon(choice.icon, size:50.0, color: textStyle.color)),
              Text(choice.title, style: textStyle),
            ]
        ),
        )
    );*/
  }
}