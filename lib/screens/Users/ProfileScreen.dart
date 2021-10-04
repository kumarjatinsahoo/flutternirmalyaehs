import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/PatientListModel.dart';
import 'package:user/models/ProfileModel.dart';
import 'package:user/models/ProfileModel.dart';
import 'package:user/models/UpdateProfileModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final MainModel model;
  final bool isConfirmPage;
  static KeyvalueModel bloodgroupmodel = null;
  static KeyvalueModel gendermodel = null;
  static KeyvalueModel relationmodel = null;
  static KeyvalueModel specialitymodel = null;

  ProfileScreen({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _ProfileScreenState extends State<ProfileScreen> {
  LoginResponse1 loginResponse1;
  File pathUsr = null;
  String today;
  String comeFrom;
  bool isDataNotAvail = false;
  ProfileModel patientProfileModel;
  String base64Img;
  String valueText = null;
  File _camImage;
  String imgValue;
  String selectDob;
  final df = new DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  List<bool> error = [false, false, false, false, false, false];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();

  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _bloodGroup = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _eName = TextEditingController();
  TextEditingController _eRelation = TextEditingController();
  TextEditingController _eMobile = TextEditingController();
  TextEditingController _fDoctor = TextEditingController();
  TextEditingController _speciality = TextEditingController();
  TextEditingController _docMobile = TextEditingController();
  TextEditingController _profileImage = TextEditingController();

  //TextEditingController _profileImage = TextEditingController();
  // TextEditingController _profileImage = TextEditingController();
  //TabController _controller;

  UpdateProfileModel updateProfileModel = UpdateProfileModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // comeFrom = widget.model.apntUserType;
    loginResponse1 = widget.model.loginResponse1;
    //_controller = TabController(length: 3);
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.PATIENT_PROFILE + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              patientProfileModel = ProfileModel.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        /* floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add, color: Colors.white, size: 29,),
          backgroundColor: AppData.kPrimaryColor,
          elevation: 5,
          splashColor: Colors.grey,
        ),*/
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            children: [
              Text(
                'My Profile',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/idCard");
                },
                child: Text(
                  "ID CARD",
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: AppData.kPrimaryColor,
          //centerTitle: true,
          // iconTheme: IconThemeData(color: AppData.kPrimaryColor,),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          /*gradient: LinearGradient(
                            colors: [Colors.blue[400], Colors.blue[200]]),*/
                          /*borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[200]),*/
                          ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 0, bottom: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      _displayTextInputDialog(context);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    patientProfileModel
                                            ?.body?.profileImageName ??
                                        AppData.defaultImgUrl,
                                    // height: 95,
                                    height: size.height * 0.15,
                                    width: size.width * 0.25,
                                  )),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Text(
                              patientProfileModel?.body?.fullName ?? "N/A",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Text(
                              patientProfileModel?.body?.age ?? "N/A",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  new Divider(
                    color: AppData.lightgreyBorder,
                  ),
                  /* Container(
                    //This is responsible for the background of the tabbar, does the magic
                      decoration: BoxDecoration(
                        //This is for background color
                          color: Colors.white.withOpacity(0.0),
                          //This is for bottom border that is needed
                          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.8))),
                      child: TabBar(
                          //controller: _controller,
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:12),
                              child: Text('Details',
                                  style: TextStyle(color: Colors.black,fontSize:13)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('Emergency Contacts',
                                  style: TextStyle(color: Colors.black,fontSize:13)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:12),
                              child: Text('Family Docters',
                                  style: TextStyle(color: Colors.black,fontSize:13)),
                            )

                          ]
                      )
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height/2.3,
                      child: new TabBarView(
                        //controller: _controller,
                        children: <Widget>[

                           rowValue(),
                            rowValue1(),
                            rowValue2()

                        ],
                      ),
                  ),*/
                  /*DefaultTabController(
                    length: 3,
                    child: Column(
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(maxHeight: 150.0),
                          child: Material(
                            color: Colors.indigo,
                            child: TabBar(
                              tabs: [
                                Tab(icon: Icon(Icons.directions_car)),
                                Tab(icon: Icon(Icons.directions_transit)),
                                Tab(icon: Icon(Icons.directions_bike)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              rowValue(),
                              rowValue1(),
                              rowValue2()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      //backgroundColor: Colors.white,
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            automaticIndicatorColorAdjustment: true,
                            indicatorColor: AppData.kPrimaryRedColor,
                            unselectedLabelColor: Colors.black,
                            labelColor: Color(0xffF15C22),
                            /*indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),
                              insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                            ),*/
                            indicatorSize: TabBarIndicatorSize.tab,

                            /*labelColor: Color(0xFF343434),
                            labelStyle: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600).copyWith(
                                fontSize: 20.0,
                                color: Color(0xFFc9c9c9),
                                fontWeight: FontWeight.w700),
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),
                              insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                            ),
                            unselectedLabelColor: Color(0xFFc9c9c9),
                            unselectedLabelStyle: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600).copyWith(
                                fontSize: 20.0,
                                color: Color(0xFFc9c9c9),
                                fontWeight: FontWeight.w700),*/
                            //unselectedLabelColor: AppData.kPrimaryRedColor,
                            tabs: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text('Details',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text('Emergency Contacts',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text('Family Doctors',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13)),
                              )
                            ],
                          ),
                          /* new Divider(
                            color: AppData.lightgreyBorder,
                          ),*/
                          /*SizedBox(
                            height: size.height * 0.02,
                          ),*/
                          //TabBar(tabs: [Tab(text: 'DETAILS',), Tab(text: 'CONTACTS'),Tab(text: 'FAMILY DOCTORS')]),
                          Container(
                              height: 280.0,
                              child: TabBarView(
                                children: [
                                  rowValue(),
                                  rowValue1(),
                                  rowValue2()
                                ],
                              ))
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rowValue() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          /*decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
           color: Colors.grey[300],

                          //borderRadius: BorderRadius.circular(5),
              // border: Border.all(color: Colors.blue[100]),
            ),
              borderRadius: BorderRadius.circular(5),

    ),*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Date Of Birth',
                        style: TextStyle(fontSize: 15
                            // color: Colors.black54,
                            // fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    /* SizedBox(
                    width: spaceTab,
                  ),*/
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.dob ?? "N/A",
                        style: TextStyle(fontSize: 14
                            // fontWeight: FontWeight.w500,
                            // color: Colors.black54,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.bloodtype_outlined,
                      size: 20,
                    ),

                    //Icon(Icons.bloodtype,size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Blood Group',
                        style: TextStyle(fontSize: 15
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.bloodGroup ?? "N/A",
                        style: TextStyle(fontSize: 14
                            //fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.credit_card_outlined,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'UHID ',
                        style: TextStyle(fontSize: 15
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.id ?? "N/A",
                        style: TextStyle(fontSize: 14
                            //fontWeight: FontWeight.w500,
                            // color: AppData.kPrimaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 100,
                        child: Text(
                          'Gender',
                          style: TextStyle(fontSize: 15
                              // color: AppData.kPrimaryColor,
                              /*fontWeight: FontWeight.w600*/
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 100,
                        child: Text(
                          patientProfileModel?.body?.gender ?? "N/A",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Contact Details',
                        style: TextStyle(fontSize: 15
                            // color: AppData.kPrimaryColor,
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.mobile ?? "N/A",
                        style: TextStyle(fontSize: 14
                            //fontWeight: FontWeight.w500,
                            // color: AppData.kPrimaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Address',
                        style: TextStyle(fontSize: 15
                            // color: AppData.kPrimaryColor,
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        /* patientProfileModel?.body?.mobile ??*/
                        "N/A",
                        style: TextStyle(fontSize: 14
                            //fontWeight: FontWeight.w500,
                            // color: AppData.kPrimaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowValue1() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          /* decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(
    color: Colors.grey[300],

    //borderRadius: BorderRadius.circular(5),
    // border: Border.all(color: Colors.blue[100]),
    ),
    borderRadius: BorderRadius.circular(5),

    ),*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 15
                            // color: Colors.black54,
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.eName ?? "N/A",
                        style: TextStyle(fontSize: 14
                            // fontWeight: FontWeight.w500,
                            // color: Colors.black54,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.people_alt_rounded,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Relation',
                        style: TextStyle(fontSize: 15
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.eRelation ?? "N/A",
                        style: TextStyle(fontSize: 14
                            //fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Mobile No.',
                        style: TextStyle(fontSize: 15
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.eMobile ?? "N/A",
                        style: TextStyle(fontSize: 14
                            //fontWeight: FontWeight.w500,
                            // color: AppData.kPrimaryColor,
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

  Widget rowValue2() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          /*decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(
    color: Colors.grey[300],

    //borderRadius: BorderRadius.circular(5),
    // border: Border.all(color: Colors.blue[100]),
    ),
    borderRadius: BorderRadius.circular(5),

    ),*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20,right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Personal Details',style: TextStyle(fontWeight: FontWeight.bold),),
                */
              /* Image.asset('assets/images/edit.png',
                  color: Colors.grey[700],
                )*/
              /*

              ],
            ),
          ),*/
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 15
                            // color: Colors.black54,
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.fDoctor ?? "N/A",
                        style: TextStyle(fontSize: 14
                            // fontWeight: FontWeight.w500,
                            // color: Colors.black54,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Specialty ',
                        style: TextStyle(fontSize: 15
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.speciality ?? "N/A",
                        style: TextStyle(fontSize: 14
                            //fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Mobile No.',
                        style: TextStyle(fontSize: 15
                            //fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.docMobile ?? "N/A",
                        style: TextStyle(fontSize: 14
                            // fontWeight: FontWeight.w500,
                            // color: AppData.kPrimaryColor,
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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    _fname.text = "";
    _lname.text = "";
    textEditingController[2].text = "";
    // _bloodGroup.text = patientProfileModel.body.bloodGroup;
    //_gender.text = patientProfileModel.body.gender;
    _eMobile.text = "";
    _eName.text = "";
    _fDoctor.text = "";
    _docMobile.text = "";

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.symmetric(horizontal: 3),
            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                // Future getCerificateImage() async {
                //   var image =
                //   await ImagePicker.pickImage(source: ImageSource.gallery);
                //   var enc = await image.readAsBytes();
                //   String _path = image.path;
                //
                //   String _fileName =
                //   _path != null ? _path.split('/').last : '...';
                //   var pos = _fileName.lastIndexOf('.');
                //   String extName =
                //   (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
                //   setState(() => _camImage = image);
                //   base64Img = base64Encode(enc);
                // }
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Container(
                      //   width: double.infinity,
                      //   height: 110.0,
                      //   child: Center(
                      //     child: Container(
                      //       height: 110.0,
                      //       width: 110.0,
                      //       child: Stack(
                      //         children: [
                      //           // ClipRRect(
                      //           //     borderRadius: BorderRadius.circular(110.0),
                      //           //     child: _camImage != null
                      //           //         ? Image.file(
                      //           //       _camImage,
                      //           //       height: 110,
                      //           //       width: 110,
                      //           //       fit: BoxFit.cover,
                      //           //     )
                      //           //         : Image.network(
                      //           //         imgValue ?? AppData.defaultImgUrl,
                      //           //         height: 140)),
                      //           // Positioned(
                      //           //   child: InkWell(
                      //           //     onTap: () {
                      //           //       //getCameraImage();
                      //           //       //showDialog();
                      //           //       //_settingModalBottomSheet(context);
                      //           //       getCerificateImage();
                      //           //     },
                      //           //     child: Icon(
                      //           //       Icons.camera_alt,
                      //           //       color: Colors.black,
                      //           //       size: 20,
                      //           //     ),
                      //           //   ),
                      //           //   bottom: 3,
                      //           //   right: 12,
                      //           // )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: 10),
                      Text(
                        "Update Profile",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                        controller: _fname,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        decoration: InputDecoration(hintText: "First Name"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            updateProfileModel.lName = value;
                          });
                        },
                        controller: _lname,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        decoration: InputDecoration(hintText: "Last Name"),
                      ),

                      dob(),
                      DropDown.networkDropdown(
                          "Blood Group",
                          ApiFactory.BLOODGROUP_API,
                          "bloodgroup", (KeyvalueModel model) {
                        setState(() {
                          // patientProfileModel.body.bloodGroup= model.key;
                          patientProfileModel.body.bloodGroup = model.name;
                          ProfileScreen.bloodgroupmodel = model;
                          updateProfileModel.bloodGroup = model.key;
                        });
                      }),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),

                      DropDown.networkDropdown(
                          "Gender", ApiFactory.GENDER_API, "gender",
                          (KeyvalueModel model) {
                        setState(() {
                          patientProfileModel.body.gender = model.name;
                          ProfileScreen.gendermodel = model;
                          updateProfileModel.gender = model.key;
                        });
                      }),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),

                      // TextField(
                      //   onChanged: (value) {
                      //     setState(() {
                      //       valueText = value;
                      //     });
                      //   },
                      //   controller: _mobile,
                      //   decoration: InputDecoration(hintText: "Mobile No"),
                      // ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            updateProfileModel.eName = value;
                          });
                        },
                        controller: _eName,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        decoration:
                            InputDecoration(hintText: "Emergency Contact Name"),
                      ),
                      DropDown.networkDropdown(
                          "Relation", ApiFactory.RELATION_API, "relation",
                          (KeyvalueModel model) {
                        setState(() {
                          patientProfileModel.body.eRelation = model.name;
                          ProfileScreen.relationmodel = model;
                          updateProfileModel.eRelation = model.key;
                        });
                      }),
                      Divider(height: 2, color: Colors.black),

                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            updateProfileModel.eMobile = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: _eMobile,

                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[0-9]"),),
                        ],

                        maxLength: 10,
                        decoration:
                          new InputDecoration(hintText: "Emergency Contact No.",
                          counterText: "",
                          ),

                      ),

                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            updateProfileModel.fName = value;
                          });
                        },
                        controller: _fDoctor,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                        ],
                        decoration:
                            InputDecoration(hintText: "Family Doctor's Name"),
                      ),
                      // TextField(
                      //   onChanged: (value) {
                      //     setState(() {
                      //       valueText = value;
                      //     });
                      //   },
                      //   controller: _speciality,
                      //   decoration: InputDecoration(hintText: "Speciality"),
                      // ),
                      DropDown.networkDropdown(
                          "Speciality", ApiFactory.SPECIALITY_API, "speciality",
                          (KeyvalueModel model) {
                        setState(() {
                          patientProfileModel.body.speciality = model.name;
                          ProfileScreen.specialitymodel = model;
                          updateProfileModel.speciality = model.key;
                        });
                      }),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),

                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                            updateProfileModel.docMobile = value;
                          });
                        },
                        controller: _docMobile,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[0-9 ]")),
                        ],
                        decoration:
                           new InputDecoration(hintText: " Doctors Mobile No",
                           counterText: "",
                           ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text('CANCEL',
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
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
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {
                    /*codeDialog = valueText;
                    Navigator.pop(context);*/
                    /*if (_fname.text == null || _fname.text == "") {
                      AppData.showInSnackBar(context, "Please enter firstname");
                    } else if (_gender.text == null || _gender.text == "") {
                      AppData.showInSnackBar(context, "Please enter Gender");
                    } else if (_docMobile.text == null ||
                        _docMobile.text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Contact Details");
                    } else if (_eName.text == null || _eName.text == "") {
                      AppData.showInSnackBar(context, "Please enter Name");
                    } else if (_eRelation.text == null ||
                        _eRelation.text == "") {
                      AppData.showInSnackBar(context, "Please enter Relation");
                    } else if (_eMobile.text == null || _eMobile.text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Mobile Number");
                    } else if (_fDoctor.text == null || _fDoctor.text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Doctors Name");
                    } else if (_speciality.text == null ||
                        _speciality.text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Speciality");
                    } else if (_lname.text == null || _lname.text == "") {
                      AppData.showInSnackBar(context, "Please enter last name");
                    } else {*/
                    updateProfileModel.fName = _fname.text;
                    updateProfileModel.lName = _lname.text;
                    updateProfileModel.eCardNo = patientProfileModel.body.id;
                    updateProfileModel.fDoctor = _fDoctor.text;
                    updateProfileModel.fDoctor = _fDoctor.text;

                    updateProfileModel.id = patientProfileModel.body.id;
                    widget.model.POSTMETHOD_TOKEN(
                        api: ApiFactory.USER_UPDATEPROFILE,
                        json: updateProfileModel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          if (map[Const.STATUS] == Const.SUCCESS) {
                            // popup(context, map[Const.MESSAGE]);
                            callApi();
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);
                          } else {
                            // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
                    // }
                  });
                },
              ),
            ],
          );
        });
  }

  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
        type: AlertType.success,
        //onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  Widget dob() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
              // color: AppData.kPrimaryLightColor,
              // borderRadius: BorderRadius.circular(29),
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
                // border: Border.all(color: Colors.black, width: 0.3)
              ),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: textEditingController[2],
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              onSaved: (value) {
                //userPersonalForm.dob = value;
                selectDob = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  error[2] = true;
                  return null;
                }
                error[2] = false;
                return null;
              },
              onFieldSubmitted: (value) {
                error[2] = false;
                // print("error>>>" + error[2].toString());

                setState(() {});
                AppData.fieldFocusChange(context, fnode3, fnode4);
              },
              decoration: InputDecoration(
                hintText: MyLocalizations.of(context).text("DATE_OF_BIRTH"),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AppData.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now().subtract(Duration(days: 6570)),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now()
            .subtract(Duration(days: 6570))); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        textEditingController[2].value =
            TextEditingValue(text: df.format(picked));
        updateProfileModel.dob = df.format(picked);
      });
  }

// void _settingModalBottomSheet(context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return Container(
//           child: new Wrap(
//             children: <Widget>[
//               new ListTile(
//                   leading: new Icon(Icons.camera),
//                   title: new Text('Camera'),
//                   onTap: () => {
//                     Navigator.pop(context),
//                     getCameraImage(),
//                   }),
//               new ListTile(
//                 leading: new Icon(Icons.folder),
//                 title: new Text('Gallery'),
//                 onTap: () => {
//                   Navigator.pop(context),
//                   getGalleryImage(),
//                 },
//               ),
//             ],
//           ),
//         );
//       });
// }
// Future getCameraImage() async {
//   var image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 25);
//   // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
//   if (image != null) {
//     var enc = await image.readAsBytes();
//     String _path = image.path;
//     setState(() => pathUsr = File(_path));
//
//     String _fileName = _path != null ? _path
//         .split('/')
//         .last : '...';
//     var pos = _fileName.lastIndexOf('.');
//     String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
//     print(extName);
//
//     print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
//     setState(() {
//       // widget.model.patientimg =base64Encode(enc);
//       // widget.model.patientimgtype =extName;
//       // userModel.profileImage=base64Encode(enc);
//       // userModel.profileImageType=extName;
//
//     });
//
//   }
// }
// Future getGalleryImage() async {
//   var image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 25);
//   //var image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 80);
//   // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
//   if (image != null) {
//     var enc = await image.readAsBytes();
//     String _path = image.path;
//     setState(() => pathUsr = File(_path));
//
//     String _fileName = _path != null ? _path.split('/').last : '...';
//     var pos = _fileName.lastIndexOf('.');
//     String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
//     print(extName);
//     print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
//     setState(() {
//       // widget.model.patientimg =base64Encode(enc);
//       // widget.model.patientimgtype =extName;
//       // patientProfileModel.profileImage=base64Encode(enc);
//       // patientProfileModel.profileImageType=extName;
//
//     });
//
//   }
// }
}
