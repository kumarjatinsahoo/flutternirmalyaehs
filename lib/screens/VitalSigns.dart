
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/UserVitalsignsModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
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
  VitalsignsModel vitalsignsModel;
  List<String> strOrders = ['My Orders', 'Confirm Orders', 'Processed Orders','Delivered Orders','Delivered Orders1'];
  List<String> strOthers1 = ['Invoices','Monthly Review','Offfers and Discount', 'Online Chat', 'Daily Sales'];
  String valueText = null;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
  TextEditingController _height = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _bmi = TextEditingController();
  TextEditingController _tempreture = TextEditingController();
  TextEditingController _systolicbloodpressure = TextEditingController();
  TextEditingController _diastolicbloodpressure = TextEditingController();
  TextEditingController _pulse = TextEditingController();
  TextEditingController _respiration = TextEditingController();
  TextEditingController _oxygensaturation = TextEditingController();
 // VITAL_SIGN_DETAIS
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

      callAPI();
    });
  }
  callAPI() {
    /*if (comeFrom == Const.HEALTH_SCREENING_APNT) {*/
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.VITAL_SIGN_DETAIS + widget.model.user ,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              vitalsignsModel = VitalsignsModel.fromJson(map);
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              // isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
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
            actions: <Widget>[
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(20.00),
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                onTap:() async{
                  _displayTextInputDialog(context);



                },
              ),
]
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15,left: 5,right: 5,),
            child: Column(
              children: [
                Container(
                  height: 90,
                  child: vitalsignsModel==null??ListView(
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
                                  /*'161',*/vitalsignsModel.body[0].height,
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
                          /*    itemCount: strOrders.length,
                          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            // mainAxisExtent: 110,
                            // mainAxisSpacing: 5,
                              crossAxisCount: (orientation == Orientation.portrait) ? 2:5 ),
                          itemBuilder: (BuildContext context, int index) {*/
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
                                      Navigator.pushNamed(context, "/deliveredorder");
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
                                                    color:choices[index].color,
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
  Future<void> _displayTextInputDialog(BuildContext context) async {
    _height.text = "161";
    _weight.text = "63";
    _bmi.text = "23";
    _tempreture.text = "38.000c1000.000f";
    _systolicbloodpressure.text = "213";
    _diastolicbloodpressure.text = "4";
    _pulse.text ="120";
    _respiration.text = "24";
    _oxygensaturation.text = "50";

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.symmetric(horizontal: 3),
            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                //    mainAxisSize: MainAxisSize.min,
                    children: [

                      SizedBox(height: 10),
                      Text(
                        "Update Vital Sign",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {

                           // valueText = value;
                             _height.text=value;
                          });
                        },
                        controller: _height,
                        decoration: InputDecoration(hintText: "Height"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            //valueText = value;
                          _weight.text = value;
                          });
                        },
                        controller: _weight,
                        decoration: InputDecoration(hintText: "Weight"),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),

                      TextField(
                        // onChanged: (value) {
                        //   setState(() {
                        //    //valueText = value;
                        //    _bmi.text = value;
                        //   });
                        // },
                        controller: _bmi,
                        decoration:
                        InputDecoration(hintText: "BMI(KG/m)"),
                      ),
                      Divider(height: 2, color: Colors.black),

                      TextField(
                        onChanged: (value) {
                          setState(() {
                           //valueText = value;
                           _tempreture.text = value;
                          });
                        },
                        controller: _tempreture,
                        decoration:
                        InputDecoration(hintText: "Temprature"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                          // valueText = value;
                           _systolicbloodpressure.text = value;
                          });
                        },
                        controller: _systolicbloodpressure,
                        decoration:
                        InputDecoration(hintText: "Systolic Blood Pressure"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                           //valueText = value;
                           _diastolicbloodpressure.text = value;

                          });
                        },
                        controller: _diastolicbloodpressure,
                        decoration: InputDecoration(hintText: "Diastolic Blood Pressure"),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),

                      TextField(
                        onChanged: (value) {
                          setState(() {
                          // valueText = value;
                           _pulse.text = value;
                          });
                        },
                        controller: _pulse,
                        decoration:
                        InputDecoration(hintText: " Pulse"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                           // valueText = value;
                           _respiration.text = value;
                          });
                        },
                        controller: _respiration,
                        decoration:
                        InputDecoration(hintText: " Respiration"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                           valueText = value;
                           _oxygensaturation.text = value;
                          });
                        },
                        controller: _oxygensaturation,
                        decoration:
                        InputDecoration(hintText: " Oxygen Saturation"),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {

                  });
                },
              ),
            ],
          );
        });
  }

}
class Choice {
  const Choice({this.title, this.icon,this.title1,this.color});
  final String title;
  final String icon;
  final Color color;
  final String title1;
}
const List<Choice> choices = const <Choice>[
  //const Choice(title: 'Home', icon: Icons.home,title1: '12345'),
  const Choice(title: '38.000C 1000.000F', icon: "assets/temperatuer.png",color:Color(0xFFCF3564),title1: 'Temperature'),
  const Choice(title: '213/4 mmHg', icon: "assets/bloodp.png",color:Color(0xFF2372B6), title1: 'Systolic Diastolic Blood Pressure'),
  const Choice(title: '120/min',icon: "assets/pulse.png",color:Color(0xFF2372B6),title1: 'Pulse'),
  const Choice(title: '24 bpm',icon: "assets/respiration.png",color:Color(0xFFCF3564),title1: 'Respiration'),
  const Choice(title: '50 % ',icon: "assets/oxygen.png",color:Color(0xFFCF3564),title1: 'Oxygen Saturation'),
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
                                      Navigator.pushNamed(context, "/deliveredorder");
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