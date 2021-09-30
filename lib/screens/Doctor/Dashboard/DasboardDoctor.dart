import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/scoped-models/MainModel.dart';

class DasboardDoctor extends StatefulWidget {
  MainModel model;


  DasboardDoctor({Key key, this.model}) : super(key: key);

  @override
  _DasboardDoctorState createState() => _DasboardDoctorState();
}
SharedPref sharedPref = SharedPref();


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
                      _Tilered(
                        // icon: Icons.calendar_today,
                        icon: CupertinoIcons.calendar_today,
                        title: "Health Screening",
                        fun: () {
                          //Navigator.pushNamed(context, "/medicalrecordpage");
                        },
                      ),
                      Divider(),
                      _Tilered(
                        // icon: Icons.calendar_today,
                        icon: CupertinoIcons.calendar_today,
                        title: "Health Check-up",
                        fun: () {
                         //Navigator.pushNamed(context, "/medicalrecordpage");
                        },
                      ),
                      Divider(),
                      _Tilered(
                        // icon: Icons.calendar_today,
                        icon: CupertinoIcons.calendar_today,
                        title: "Doctor Appointment",
                        fun: () {
                          Navigator.pushNamed(context, "/doctorAppointment");
                          // Navigator.pushNamed(context, "/doctorconsultationPage");
                          // Navigator.pop(context);
                        },
                      ),


                      /* ListTile(
                          title: Text("Health Screening"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                            //widget.model.apntUserType =Const.HEALTH_SCREENING_APNT;

                            Navigator.pushNamed(context, "/docApnt");
                            Navigator.pop(context);
                            // AppData.showInSnackBar(context,"hi");
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

                            Navigator.pushNamed(context, "/docApnt");
                            Navigator.pop(context);
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Doctor Appointment"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {

                            //widget.model.apntUserType = Const.DOC_APNT;
                            Navigator.pushNamed(context, "/doctorconsultationPage");
                            Navigator.pop(context);
                          },
                        ),*/
                      Divider(),
                      MaterialButton(
                        child: Text(
                          "CANCEL",
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
Widget _Tilered({IconData icon,
  String title,
  Function fun}) {
  return InkWell(
    onTap: fun,
    child: Container(
      padding: const EdgeInsets.all(10.0),
      /* height: MediaQuery.of(context).size.height * 0.23,*/
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Colors.grey, size: 35,),
          SizedBox(
            width: 20,
          ),
          Text(title,
              style: TextStyle(/*fontWeight: FontWeight.w300,*/
                  fontSize: 17,
                  color: Colors.black), textAlign: TextAlign.center),
          //Icon(Icons.search, color: Colors.white),
        ],
      ),

    ),
  );
}

class _DasboardDoctorState extends State<DasboardDoctor> {
  LoginResponse1 loginResponse;
  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    // checkApiCallOrNot();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(centerTitle: true, title: Text("Dashboard"),backgroundColor:Color(0xFF0F6CE1)),
      body: Center(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: InkWell(
                  child: Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.all(15.00),
                        child:
                        Container(
                            width:50,
                            height: 50,
                            child: Image.asset('assets/images/myprofile.png',fit: BoxFit.cover)
                        ),
                      ),
                      Text(
                        "My Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: (){

                    Navigator.pushNamed(context, "/docMyProf");
                  },
                ),
              ),
              SizedBox(
                //  width: 10.00,
              ),
              Expanded(
                child: InkWell(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.00),
                          child:
                          Container(
                              width:50,
                              height: 50,
                              child: Image.asset('assets/images/appointment.png',fit: BoxFit.cover)
                          ),
                        ),
                        Text(
                          "Appointment",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                     /* Navigator.push(context,
                          new MaterialPageRoute(
                              builder: (context) => new Appointment1()));*/
                      //Navigator.pushNamed(context, "/apntMange");
                      Navigator.pushNamed(context, "/doctorAppointment");
                      //chooseAppointment(context);
                    }
                ),
              ),
              SizedBox(
                //   width: 10.00,
              ),
              Expanded(
                child: InkWell(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.00),
                        child:
                        Container(
                            width:50,
                            height: 50,
                            child: Image.asset('assets/images/walk.png',fit: BoxFit.cover)
                        ),
                      ),
                      Text(
                        "Walk in Patient",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: (){
                    /*Navigator.push(context,
                        new MaterialPageRoute(
                            builder: (context) => new WalkPatient()));*/
                    Navigator.pushNamed(context, "/docWalkInReg");
                  },
                ),
              ),

            ],
          ),
          SizedBox(
            height: 11.00,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: InkWell(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.00),
                          child:
                          Container(
                              width:50,
                              height: 50,
                              child: Image.asset('assets/images/emergency.png',fit: BoxFit.cover,)
                          ),
                        ),
                        Text(
                          "Emergency  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "  Access  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    onTap: () {
                      /*Navigator.push(context,
                          new MaterialPageRoute(
                              builder: (context) => new EmergencyAccess()));*/
                      Navigator.pushNamed(context, "/emegencyAc");
                    }
                ),


              ),
              SizedBox(
                //  width: 10.00,
              ),

              Expanded(
                child: InkWell(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.00),
                        child:
                        Container(
                            width:50,
                            height: 50,
                            child: Image.asset('assets/images/shareapnt.png',fit: BoxFit.cover)
                        ),
                      ),
                      Text(
                        "  Share  ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " Appointment",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // onTap: (){
                  //   Navigator.push(context,
                  //       new MaterialPageRoute(
                  //           builder: (context) => new VitalDoctor()));
                  // },
                ),
              ),

              SizedBox(
                //  width: 10.00,
              ),
              Expanded(
                child: GestureDetector(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.00),
                        child:
                        Container(
                            width:50,
                            height: 50,
                            child: Image.asset('assets/images/mypatient.png',fit: BoxFit.cover)
                        ),
                      ),
                      Text(
                        "My Patients",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: (){
                   // Navigator.pushNamed(context, "/showEmr");
                  },
                ),
              ),


            ],
          ),
          SizedBox(
            height: 11.00,
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 10),
                  InkWell(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.00),
                          child:
                          Container(
                              width:50,
                              height: 50,
                              child: Image.asset('assets/images/monthlyoverview.png',fit: BoxFit.cover)
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 13,),
                            Text(
                              " Monthly Overview ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: ()  {},
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.00),
                          child:
                          Container(
                              width:50,
                              height: 50,
                              child: Image.asset('assets/images/video.png',fit: BoxFit.cover)
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text(
                              "Video Consultation  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () async {
    Navigator.pushNamed(context, "/Healthchart");

                    },
                  ),
                ]
            ),
          ),
        ]),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Hi " + loginResponse.body.userName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child:
                  Icon(Icons.person,size: 35,),
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFD2E4FC),
                // color: Colors.blueGrey,
              ),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width:30,
                        height: 30,
                        child: Image.asset('assets/images/myprofile.png',fit: BoxFit.cover)
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              title: Text("My Profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width:30,
                        height: 30,
                        child: Image.asset('assets/images/dash.png',fit: BoxFit.cover)
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              title: Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width:30,
                        height: 30,
                        child: Image.asset('assets/images/aboutus.png',fit: BoxFit.cover)
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              title: Text("About Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width:30,
                        height: 30,
                        child: Image.asset('assets/images/share.png',fit: BoxFit.cover)
                    ),                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              title: Text("Share"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width:30,
                        height: 30,
                        child: Image.asset('assets/images/contact.png',fit: BoxFit.cover)
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width:30,
                        height: 30,
                        child: Image.asset('assets/images/logout.png',fit: BoxFit.cover)
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              title: Text("Logout"),
              onTap: () {
               // selectDestination(9);
                sharedPref.save(Const.IS_LOGIN, false.toString());
                sharedPref.save(Const.IS_REGISTRATION, false.toString());
                sharedPref.remove(Const.IS_REGISTRATION);
                sharedPref.remove(Const.IS_LOGIN);
                sharedPref.remove(Const.LOGIN_DATA);
                sharedPref.remove(Const.IS_REG_SERVER);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              //  _exitApp();
              },
            ),
          ],
        ),
      ),
    );

  }

}
