import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';

class Appointment1 extends StatefulWidget {

  MainModel model;


  Appointment1({Key key, this.model}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Appointmentt();
}

class _Appointmentt extends State<Appointment1> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    var date;
    //DateFormat formatter = DateFormat('yyyy-MM-dd');


    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
      appBar: AppBar(
        backgroundColor: Color(0xFF0F6CE1),
        centerTitle: true,
        title: Text('Appointment '),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int i) {
                // // Appointdtls patient = createAppointmentModel.appointdtls[i];
                //  var fromatted= formatter.format(DateTime.parse(patient.appointdt));
                //  date = DateTime.parse(fromatted);
                //  var formattedmonth = "${date.month}";
                //  var formattedday= "${date.day}";
                //  var formattedyear= "${date.year}";
                //  const monthNames = ["","Jan", "Feb", "Mar", "Apr", "May", "Jun",
                //    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                //  ];

                //print(monthNames[int.parse(formattedmonth)]);
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                        // offset:
                        //     Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Auguest", style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w600
                              ),
                                textAlign: TextAlign.center,
                              ),
                              Text("08", style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              )),
                              Text("2021", style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 11, fontWeight: FontWeight.w600
                              ),),
                            ],),
                        ),
                        SizedBox(width: size.width * 0.02,),
                        Container(
                            height: 80, child: VerticalDivider(color: Colors
                            .black26)),
                        SizedBox(width: size.width * 0.02,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Lisarani", style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),),

                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                children: [
                                  Text("Appolo", style: TextStyle(
                                      color: Colors.blue
                                  ),),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              Text('Dr ' + "Sanjib", style: TextStyle(
                                  color: Colors.blue
                              ),),
                              //  SizedBox(height: size.height * 0.01),
                              // Row(
                              //   children: [
                              //     Text(patient.appointstatus,style: TextStyle(
                              //       color:patient.appointstatus=="Pending"? Colors.amber:Colors.green,
                              //       fontWeight: FontWeight.bold

                              //     ),),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Text("Accept", style: TextStyle(
                              // color:patient.appointstatus=="Pending"? Colors.amber:Colors.green,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 13
                            ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    changeStatus(
                                        context,

                                        ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),

      ),
    );
  }

  Widget changeStatus(BuildContext context,  ) {
    //NomineeModel nomineeModel = NomineeModel();
    //Nomine
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 20),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text(
                  "CHANGE STATUS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Lisa Rani",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text("BOOKED"),
                  leading: Icon(Icons.book),
                  onTap: () {
                    //updateApi(userName.id.toString(), "0", i);
                  },
                ),
                Divider(
                  height: 2,
                ),
                ListTile(
                  title: Text("IN-PROGRESS"),
                  leading: Icon(Icons.trending_up),
                  onTap: () {
                    //updateApi(userName.id.toString(), "1", i);
                  },
                ),
                Divider(
                  height: 2,
                ),
                ListTile(
                  title: Text("COMPLETED"),
                  leading: Icon(Icons.done_outline_outlined),
                  onTap: () {
//                    updateApi(userName.id.toString(), "2", i);
                  },
                )
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("CANCEL"),
        ),
      ],
    );
  }
}