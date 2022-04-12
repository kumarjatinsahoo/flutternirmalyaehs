
import 'package:flutter/gestures.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

import 'DoctorAppointment_Requested.dart';
import 'DoctorAppointment_Confirmed.dart';
import 'DoctorAppointment_Cancel.dart';
import 'DoctorAppointment_Treated.dart';

class DoctorAppointment extends StatefulWidget {
  final MainModel model;

  DoctorAppointment({Key key, this.model}) : super(key: key);

  @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _DoctorAppointmentState extends State<DoctorAppointment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text(MyLocalizations.of(context).text("DOCTOR_APPOINTMENT")),
          backgroundColor: AppData.kPrimaryColor,
          actions: <Widget>[
           /* IconButton(
              icon: const Icon(Icons.add_box_rounded),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.pushNamed(
                    context, "/doctorconsultationPage");
              },
            ),*/
          ],
          /*appBar: AppBar(
          title: Text("My Appointment"),
          titleSpacing: 0.0,
          backgroundColor: AppData.kPrimaryColor,
          centerTitle: true,*/
          //iconTheme: IconThemeData(color: AppData.kPrimaryColor,),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.orangeAccent,
            isScrollable: true,
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Tab(
                text: MyLocalizations.of(context).text("REQUESTED") ,

              ),
              Tab(
                text: MyLocalizations.of(context).text("CONFIRMED") ,
              ),
              Tab(
                text: MyLocalizations.of(context).text("CANCELLED"),
              ),
              Tab(
                text: MyLocalizations.of(context).text("TREATED") ,
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            DoctorAppointmentRequested(model:widget.model,),
            DoctorAppointmentConfirmed(model:widget.model,),
            DoctorAppointmentCancle(model:widget.model,),
            DoctorAppointmentTreated(model:widget.model,),
            /*SalaryProcessPage(model:widget.model,),
            SalaryStatementPage1(model: widget.model,),
            SalaryReportPage(model: widget.model,)*/
          ],
        ),
      ),
    );
    /*SafeArea(
      child: Scaffold(
       */ /* floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add, color: Colors.white, size: 29,),
          backgroundColor: AppData.kPrimaryColor,
          elevation: 5,
          splashColor: Colors.grey,
        ),*/
    /*
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'My Appointment',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppData.kPrimaryColor,
          centerTitle: true,

          // iconTheme: IconThemeData(color: AppData.kPrimaryColor,),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  */
    /*Padding(
                    padding: const EdgeInsets.only(top:0.0,bottom: 0.0,left: 0.0, right: 0.0),
                    child: Container(
                      // height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [
                              Colors.blue[400] ,
                              Colors.blue[200]
                            ]),
                             borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20,top: 10,bottom: 10),
                        child: */ /**/
    /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [*/ /**/
    /*
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // height: 95,
                                  // width: 95,
                                  // decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(55),
                                  //     border: Border.all(color: Colors.white, width: 0.5),
                                  //     color: Colors.blue[50]
                                  //     ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(55),
                                      child: Image.asset(
                                        'assets/images/user.png',
                                        // height: 95,
                                        height: size.height * 0.12,
                                        width: size.width * 0.22,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(height: size.height * 0.04,),
                                Text(
                                      'BMS Lab',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                SizedBox(height: size.height * 0.04,),
                              ],
                            ),

                        */ /**/ /*  ],
                        ),*/ /**/ /*
                      ),
                    ),
                  ),*/ /*
                  SizedBox(height: size.height * 0.02,),
                  DefaultTabController(
                     //isScrollable: true,
                      length: 4,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          TabBar(tabs: [Text('Confirmed',style: TextStyle(color: Colors.black)),
                            Text('Requested',style: TextStyle(color: Colors.black)),
                            Text('Cancelled',style: TextStyle(color: Colors.black)),
                            Text('Treated',style: TextStyle(color: Colors.black)),
                          ]),
                          //TabBar(tabs: [Tab(text: 'DETAILS',), Tab(text: 'CONTACTS'),Tab(text: 'FAMILY DOCTORS')]),
                          Container(
                              height: 550,
                              child: TabBarView(
                                children: [
                                  MyAppointmentConfirmed(),
                                  MyAppointmentRequested(),
                                  MyAppointmentCancle(),
                                  MyAppointmentTreated(),
                                ],
                              ))],
                      ))
                */ /*  SizedBox(height: size.height * 0.02,),*/ /*
                  */ /*TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.orangeAccent,
                    isScrollable: false,
                    dragStartBehavior:DragStartBehavior.down,
                    tabs: [
                      Tab(text: "PROCESS",),
                      Tab(text: "STATEMENT",),
                      Tab(text: "REPORTS",),
                    ],
                  ),*/ /*
                  */ /*TabBarView(
                    children: [
                      rowValue(),
                      rowValue(),
                      rowValue(),
                    ],
                  ),*/ /*
                ],
              ),
            ),
          ),
        ),
      ),
    );*/
  }

  Widget rowValue() {
    return Container(
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.blueGrey[50], Colors.blue[50]]),
        borderRadius: BorderRadius.circular(1),
        // border: Border.all(color: Colors.blue[100]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20,right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Personal Details',style: TextStyle(fontWeight: FontWeight.bold),),
                */ /* Image.asset('assets/images/edit.png',
                  color: Colors.grey[700],
                )*/ /*

              ],
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Date Of Birth:',
                  style: TextStyle(
                    // color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '30-Jul-2019',
                  style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      // color: Colors.black54,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Bloood Group:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'unknown',
                  style: TextStyle(
                      //fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Text(
                  'eHealthCard No:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '009167445576779889',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    // color: AppData.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Gender:',
                  style: TextStyle(
                    // color: AppData.kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Male',
                  style: TextStyle(
                      //fontWeight: FontWeight.w500,
                      // color: AppData.kPrimaryColor,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Contact Details:',
                  style: TextStyle(
                    // color: AppData.kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '+2345678900',
                  style: TextStyle(
                      //fontWeight: FontWeight.w500,
                      // color: AppData.kPrimaryColor,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget rowValue1() {
    return Container(
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.blueGrey[50], Colors.blue[50]]),
        borderRadius: BorderRadius.circular(1),
        // border: Border.all(color: Colors.blue[100]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20,right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Personal Details',style: TextStyle(fontWeight: FontWeight.bold),),
                */ /* Image.asset('assets/images/edit.png',
                  color: Colors.grey[700],
                )*/ /*

              ],
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Name:',
                  style: TextStyle(
                    // color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Mr.abc',
                  style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      // color: Colors.black54,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Relaton:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Friend',
                  style: TextStyle(
                      //fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Mobile No.:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '2345688999',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    // color: AppData.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowValue2() {
    return Container(
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.blueGrey[50], Colors.blue[50]]),
        borderRadius: BorderRadius.circular(1),
        // border: Border.all(color: Colors.blue[100]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20,right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Personal Details',style: TextStyle(fontWeight: FontWeight.bold),),
                */ /* Image.asset('assets/images/edit.png',
                  color: Colors.grey[700],
                )*/ /*

              ],
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Name:',
                  style: TextStyle(
                    // color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Dr.abc',
                  style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      // color: Colors.black54,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Specialty:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Dental Pedodontia',
                  style: TextStyle(
                      //fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Text(
                  'Mobile No.:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '2345688999',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    // color: AppData.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
