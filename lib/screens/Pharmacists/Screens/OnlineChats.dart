import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

class OnlineChats extends StatefulWidget {
  final MainModel model;

  const OnlineChats({Key key, this.model}) : super(key: key);

  @override
  _OnlineChatsState createState() => _OnlineChatsState();
}

class _OnlineChatsState extends State<OnlineChats> {
  int _radioSelected = 1;
  String _radioVal;
  List<KeyvalueModel> doctorList = [
    KeyvalueModel(name: "doctor 1", key: "1"),
    KeyvalueModel(name: "doctor 2", key: "2"),
    KeyvalueModel(name: "doctor 3", key: "3"),
  ];
  List<KeyvalueModel> patientList = [
    KeyvalueModel(name: "patient 1", key: "1"),
    KeyvalueModel(name: "patient 2", key: "2"),
    KeyvalueModel(name: "patient 3", key: "3"),
  ];

  Widget searchButton() {
    return GestureDetector(
      onTap: () {
        // validate();
      },
      child: Container(
        // margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 45.0, right: 45.0, top: 15.0, bottom: 15.0),
          child: Text(
            "Search",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Online Chat',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        decoration: BoxDecoration(
                          //  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue[100]),
                   color: Colors.blue[50],
                        ),
                       
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 15.0, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: _radioSelected,
                                    activeColor: Colors.blue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioSelected = value;
                                        _radioVal = 'patient';
                                      });
                                    },
                                  ),
                                  Text('Patient'),
                                  SizedBox(
                                    width: size.width * 0.24,
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _radioSelected,
                                    activeColor: Colors.pink,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioSelected = value;
                                        _radioVal = 'doctor';
                                      });
                                    },
                                  ),
                                  Text('Doctor'),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  // width: 170,
                                  width: size.width *0.44,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black, width: 0.8)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 3.0),
                                    child: DropDown.staticDropdown2(
                                        'Select', "patient", patientList,
                                        (KeyvalueModel data) {
                                      setState(() {
                                        // SignUpForm.genderModel = data;
                                      });
                                    }),
                                  ),
                                ),
                                Container(
                                   width: size.width *0.44,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black, width: 0.8)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 3.0),
                                    child: DropDown.staticDropdown2(
                                        'Select', "doctor", doctorList,
                                        (KeyvalueModel data) {
                                      setState(() {
                                        // SignUpForm.genderModel = data;
                                      });
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            searchButton(),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
