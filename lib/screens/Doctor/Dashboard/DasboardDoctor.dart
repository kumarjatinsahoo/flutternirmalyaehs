import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/Appointment1.dart';

class DasboardDoctor extends StatefulWidget {
  MainModel model;


  DasboardDoctor({Key key, this.model}) : super(key: key);

  @override
  _DasboardDoctorState createState() => _DasboardDoctorState();
}

class _DasboardDoctorState extends State<DasboardDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Dashboard"),backgroundColor:Color(0xFF0F6CE1)),
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
                      Navigator.push(context,
                          new MaterialPageRoute(
                              builder: (context) => new Appointment1()));
                      Navigator.pushNamed(context, "/apntMange");
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
                    /*Navigator.push(context,
                        new MaterialPageRoute(
                            builder: (context) => new ShowEmr()));*/
                    Navigator.pushNamed(context, "/showEmr");
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
                    onTap: () async {},
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
                    Text("Ipsita Sahoo",style: TextStyle(color: Colors.black,fontSize:15)),
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
