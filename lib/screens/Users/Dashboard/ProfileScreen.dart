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
import 'package:user/providers/text_field_container.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/MyWidget.dart';

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
  FocusNode fnode6 = new FocusNode();

  TextEditingController _fname = TextEditingController();
  TextEditingController _address = TextEditingController();
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
    /*?? "N/A"*/;
    //_controller = TabController(length: 3);

    // updateProfileModel.eCardNo =patientProfileModel.body.eCardNo;
    /*patientProfileModel.body=null?textEditingController[2].text =
        myFormatDate(patientProfileModel.body.dob.toString()):N/A*/
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
              if (patientProfileModel?.body?.bloodGroup != null) {
                ProfileScreen.bloodgroupmodel = KeyvalueModel(
                    key: patientProfileModel.body.bloodGroupId,
                    name: patientProfileModel.body.bloodGroup);
              } else {
                ProfileScreen.bloodgroupmodel = null;
              }
              if (patientProfileModel?.body?.eRelation != null) {
                ProfileScreen.relationmodel = KeyvalueModel(
                    key: patientProfileModel.body.eRelationId,
                    name: patientProfileModel.body.eRelation);
              } else {
                ProfileScreen.relationmodel = null;
              }
              if (patientProfileModel?.body?.speciality != null) {
                ProfileScreen.specialitymodel = KeyvalueModel(
                    key: patientProfileModel.body.specialityId,
                    name: patientProfileModel.body.speciality);
              } else {
                ProfileScreen.specialitymodel = null;
              }
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  updateProfile(String image, String ext) {
    MyWidgets.showLoading(context);
    var value = {"profileImageType": ext, "pImage": [image], "eCardNo": loginResponse1.body.user};

    log("Post data>>\n\n"+jsonEncode(value));
    widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.USER_PROFILE_IMAGE,
        token: widget.model.token,
        json: value,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {

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
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 29,),
        backgroundColor: AppData.kPrimaryColor,
        elevation: 5,
        splashColor: Colors.grey,
      ),*/
      appBar: AppBar(
        /* leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Center(
              child: Text(
                'My Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
            //Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 70.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/qrcode");
                  },
                  child: Icon(Icons.qr_code_outlined),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
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
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
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
                                    if (patientProfileModel != null) {
                                      _displayTextInputDialog(context);
                                    } else {
                                      AppData.showInSnackBar(context,
                                          "Please wait until we are fetching your data");
                                    }
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
                                child: Column(
                                  children: [
                                    /*Image.network(
                                      patientProfileModel
                                              ?.body?.profileImageType ??
                                          AppData.defaultImgUrl,
                                      // height: 95,
                                      height: size.height * 0.15,
                                      width: size.width * 0.25,
                                    ),*/
                                    /* Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          //_settingModalBottomSheet(context);
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: AppData.kPrimaryColor,
                                        ),
                                      ),
                                    ),*/
                                  ],
                                )),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 83,
                              width: 83,
                              child: Stack(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  (pathUsr != null)
                                      ? Material(
                                          elevation: 5.0,
                                          shape: CircleBorder(),
                                          child: CircleAvatar(
                                            radius: 40.0,
                                            backgroundImage: FileImage(pathUsr),
                                          ),
                                        )
                                      : Material(
                                          elevation: 5.0,
                                          shape: CircleBorder(),
                                          child: CircleAvatar(
                                            radius: 40.0,
                                            backgroundImage: NetworkImage(
                                                (patientProfileModel?.body
                                                            ?.profileImage !=
                                                        null)
                                                    ? patientProfileModel
                                                        ?.body?.profileImage
                                                    : AppData.defaultImgUrl),
                                          ),
                                        ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        _settingModalBottomSheet(context);
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: AppData.kPrimaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            patientProfileModel?.body?.fullName ?? "N/A",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (patientProfileModel?.body?.id != null)
                                ? AppData.subStringBy(
                                            patientProfileModel?.body?.id) +
                                        "\n(UHID)" ??
                                    "N/A"
                                : "",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
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
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('Details'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 13)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                  'Emergency Contacts'
                                      .toUpperCase()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      fontSize: 13)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('Family Doctors'.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      fontSize: 13)),
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
                              children: [rowValue(), rowValue1(), rowValue2()],
                            ))
                      ],
                    ))
              ],
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
                        style: TextStyle(
                          fontSize: 15
                          // color: Colors.black54,
                          ,
                          fontWeight: FontWeight.w800,
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
              /*SizedBox(
                height: 6,
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: AppData.lightgreyBorder,
                  height: 6,
                ),
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
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: AppData.lightgreyBorder,
                  height: 6,
                ),
              ),
              /* Padding(
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
                          ,fontWeight: FontWeight.w800,
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
              SizedBox(height: 10),*/
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
                          style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800,
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
              //SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: AppData.lightgreyBorder,
                  height: 6,
                ),
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
                        'Contact Details',
                        style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800,
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
              //SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: AppData.lightgreyBorder,
                  height: 6,
                ),
              ),
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
                        style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800,
                          // color: AppData.kPrimaryColor,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        patientProfileModel?.body?.address ?? "N/A",
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
                        style: TextStyle(
                          fontSize: 15,
                          // color: Colors.black54,
                          fontWeight: FontWeight.w600,
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
              /*SizedBox(
                height: 10,
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: AppData.lightgreyBorder,
                  height: 6,
                ),
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
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
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
              /* SizedBox(
                height: 10,
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: AppData.lightgreyBorder,
                  height: 6,
                ),
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
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
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
                        style: TextStyle(
                          fontSize: 15
                          // color: Colors.black54,
                          ,
                          fontWeight: FontWeight.w600,
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
              /*SizedBox(
                height: 10,
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: AppData.lightgreyBorder,
                  height: 6,
                ),
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
                        'Speciality ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
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
              /*SizedBox(
                height: 10,
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: AppData.lightgreyBorder,
                  height: 6,
                ),
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
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
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

  myFormatDate(String date) {
    if (date != null && date.contains("-")) {
      List<String> myList = date.split("-");
      return myList[0] + "/" + myList[1] + "/" + myList[2];
    } else {
      return "N/A";
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    /*ProfileScreen.relationmodel.key=patientProfileModel.body.eRelation.toString()??"N/A";
    ProfileScreen.specialitymodel.key=patientProfileModel.body.speciality.toString()??"N/A";
    ProfileScreen.bloodgroupmodel.key=patientProfileModel.body.bloodGroup.toString()??"N/A";*/

    //_fDoctor.text =(patientProfileModel != null)||(patientProfileModel.body.fDoctor==null)?"N/A":patientProfileModel.body.fDoctor.toString();
    //_eName.text =(patientProfileModel != null)||(patientProfileModel.body.eName!=null)? patientProfileModel.body.eName.toString():"N/A";
    //_docMobile.text =(patientProfileModel != null)||(patientProfileModel.body.docMobile == null)?patientProfileModel.body.docMobile:"N/A";
    //_eMobile.text = (patientProfileModel != null)||(patientProfileModel.body.eMobile==null)?"N/A":patientProfileModel.body.eMobile.toString();

    //patientProfileModel.body.eMobile.toString() == null?"N/A":_eMobile.text =patientProfileModel.body.eMobile.toString();
    //textEditingController[1].text = (patientProfileModel != null)||(patientProfileModel.body.eName == null)?patientProfileModel.body.eName.toString(): "N/A";
    //patientProfileModel.body.fDoctor.toString() == null?"N/A":_fDoctor.text =patientProfileModel.body.fDoctor.toString();
    //patientProfileModel.body.eName.toString() == null?"N/A":_eName.text =patientProfileModel.body.eName.toString();
    // patientProfileModel.body.docMobile.toString() == null?"N/A":_docMobile.text == patientProfileModel.body.docMobile;
    //textEditingController[5].text = (patientProfileModel != null)||(patientProfileModel.body.address == null)?patientProfileModel.body.address.toString(): "N/A";
    textEditingController[5].text = patientProfileModel.body.address ?? "";
    textEditingController[1].text = patientProfileModel.body.eName ?? "";
    textEditingController[2].text = patientProfileModel.body.eMobile ?? "";
    textEditingController[3].text = patientProfileModel.body.fDoctor ?? "";
    textEditingController[4].text = patientProfileModel.body.docMobile ?? "";
    textEditingController[0].text = (patientProfileModel != null)
        ? myFormatDate(patientProfileModel.body.dob.toString())
        : "";
    updateProfileModel.eCardNo = patientProfileModel.body.id.toString();

    updateProfileModel.id = patientProfileModel.body.id.toString();
    if (patientProfileModel?.body?.bloodGroup == null ||
        patientProfileModel?.body?.bloodGroup == "") {
      ProfileScreen.bloodgroupmodel = null;
    }
    if (patientProfileModel?.body?.eRelation == null ||
        patientProfileModel?.body?.eRelation == "") {
      ProfileScreen.relationmodel = null;
    }
    if (patientProfileModel?.body?.speciality == null ||
        patientProfileModel?.body?.speciality == "") {
      ProfileScreen.specialitymodel = null;
    }
    if (patientProfileModel?.body?.eMobile == null ||
        patientProfileModel?.body?.eMobile == "") {
      textEditingController[2].text = "";
    }
    if (patientProfileModel?.body?.docMobile == null ||
        patientProfileModel?.body?.docMobile == "") {
      textEditingController[4].text = "";
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            insetPadding: EdgeInsets.zero,

            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
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
                          dob("DOB"),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    "Blood Group",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "Blood Group",
                                    ApiFactory.BLOODGROUP_API,
                                    "bloodgroup", (KeyvalueModel model) {
                                  setState(() {
                                    ProfileScreen.bloodgroupmodel = model;
                                    patientProfileModel.body.bloodGroupId =
                                        model.key;
                                    patientProfileModel.body.bloodGroup =
                                        model.name;
                                    // updateProfileModel.bloodGroup = model.key;
                                  });
                                }),
                              ]),
                          formField(
                              1, "Emergency Contact Name", fnode1, fnode2),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    "Relation",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "Relation",
                                    ApiFactory.RELATION_API,
                                    "relation", (KeyvalueModel model) {
                                  setState(() {
                                    ProfileScreen.relationmodel = model;
                                    patientProfileModel.body.eRelationId =
                                        model.key;
                                    patientProfileModel.body.eRelation =
                                        model.name;
                                    // updateProfileModel.eRelation = model.key;
                                  });
                                }),
                              ]),
                          /*   Divider(height: 2, color: Colors.black),*/
                          formFieldMobileno(
                              2, "Emergency Contact No.", fnode2, fnode3),
                          formField(3, "Family Doctor's Name", fnode3, fnode4),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    "Speciality",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "Speciality",
                                    ApiFactory.SPECIALITY_API,
                                    "speciality", (KeyvalueModel model) {
                                  setState(() {
                                    ProfileScreen.specialitymodel = model;

                                    //updateProfileModel.speciality = model.key;
                                  });
                                }),
                              ]),
                          /*Divider(
                            height: 2,
                            color: Colors.black,
                          ),*/
                          formFieldMobileno(
                              4, "Doctors Mobile No", fnode4, fnode5),
                          formFieldAddress(5, "User Address", fnode5, null),
                        ],
                      ),
                    ),
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
                    callApi();
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
                    /*  if (_eMobile.text != "" && _eMobile.text.length != 10) {
           ScaffoldMessenger.of(context)
               .showSnackBar(SnackBar(content: Text("My amazing message! O.o")));
*/
                    if (textEditingController[0].text == "N/A" ||
                        textEditingController[0].text == null ||
                        textEditingController[0].text == "") {
                      //AppData.showInSnackBar(context, "Please enter Emergency Contact No.");
                      AppData.showInSnackBar(context, "Please enter DOB");
                    } else if (ProfileScreen.bloodgroupmodel == null ||
                        ProfileScreen.bloodgroupmodel == "") {
                      AppData.showInSnackBar(
                          context, "Please select Blood Group");
                      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter Emergency Contact No."), backgroundColor: Colors.red,duration: Duration(seconds: 6),));
                    } else if (textEditingController[1].text == "N/A" ||
                        textEditingController[1].text == null ||
                        textEditingController[1].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Emergency Contact Name");
                      FocusScope.of(context).requestFocus(fnode1);
                    } else if (textEditingController[1].text != "" &&
                        textEditingController[1].text.length <= 2) {
                      AppData.showInSnackBar(context,
                          "Please enter valid Emergency Contact Name ");
                      FocusScope.of(context).requestFocus(fnode1);
                    } else if (ProfileScreen.relationmodel == null ||
                        ProfileScreen.relationmodel == "") {
                      AppData.showInSnackBar(context, "Please select Relation");
                    } else if (textEditingController[2].text == "N/A" ||
                        textEditingController[2].text == null ||
                        textEditingController[2].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter  Emergency Contact No.");
                      FocusScope.of(context).requestFocus(fnode2);
                    } else if (textEditingController[2].text != "" &&
                        textEditingController[2].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Emergency Contact No.");
                      FocusScope.of(context).requestFocus(fnode2);
                    } else if (textEditingController[3].text == "" ||
                        textEditingController[3].text == null ||
                        textEditingController[3].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Family Doctor Name");
                      FocusScope.of(context).requestFocus(fnode3);
                    } else if (textEditingController[3].text != "" &&
                        textEditingController[3].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Family Doctor Name ");
                      FocusScope.of(context).requestFocus(fnode3);
                    } else if (ProfileScreen.specialitymodel == null ||
                        ProfileScreen.specialitymodel == "") {
                      AppData.showInSnackBar(
                          context, "Please select Speciality");
                    } else if (textEditingController[4].text == "N/A" ||
                        textEditingController[4].text == null ||
                        textEditingController[4].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Doctor Mobile No.");
                      FocusScope.of(context).requestFocus(fnode4);
                    } else if (textEditingController[4].text != "" &&
                        textEditingController[4].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid  Doctor Mobile No.");
                      FocusScope.of(context).requestFocus(fnode4);
                      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter Emergency Contact No."), backgroundColor: Colors.red,duration: Duration(seconds: 6),));
                    } else if (textEditingController[5].text == "N/A" ||
                        textEditingController[5].text == null ||
                        textEditingController[5].text == "") {
                      AppData.showInSnackBar(context, "Please enter Address");
                      FocusScope.of(context).requestFocus(fnode5);
                    } else if (textEditingController[5].text != "" &&
                        textEditingController[5].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Address");
                      FocusScope.of(context).requestFocus(fnode5);
                    } else {
                      updateProfileModel.dob = textEditingController[0].text;
                      updateProfileModel.bloodGroup =
                          ProfileScreen.bloodgroupmodel.key;
                      updateProfileModel.address =
                          textEditingController[5].text;
                      //Emergency
                      updateProfileModel.eName = /*_eName.text*/
                          textEditingController[1].text;
                      updateProfileModel.eMobile = /*_eMobile.text*/
                          textEditingController[2].text;
                      updateProfileModel.eRelation =
                          ProfileScreen.relationmodel.key;
                      //doctor
                      updateProfileModel.fDoctor = /* _fDoctor.text*/
                          textEditingController[3].text;
                      updateProfileModel.speciality =
                          ProfileScreen.specialitymodel.key;
                      updateProfileModel.docMobile = /*_docMobile.text*/
                          textEditingController[4].text;

                      log("Post json>>>>" +
                          jsonEncode(updateProfileModel.toJson()));

                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.USER_UPDATEPROFILE,
                          json: updateProfileModel.toJson(),
                          token: widget.model.token,
                          fun: (Map<String, dynamic> map) {
                            Navigator.pop(context);
                            if (map[Const.STATUS] == Const.SUCCESS) {
                              // popup(context, map[Const.MESSAGE]);
                              //print("Post json>>>>"+jsonEncode(updateProfileModel.toJson()));
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);

                              callApi();
                            } else {
                              AppData.showInSnackBar(
                                  context, map[Const.MESSAGE]);
                              callApi();
                            }
                          });
                    }
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

  Widget formFieldMobileno(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: currentfn,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9]"),
                ),
              ],
              maxLength: 10,
              // Validator.getKeyboardTyp(validateModel.fieldType.toLowerCase()),
              style: TextStyle(fontSize: 15),

              decoration: InputDecoration(
                  //hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
              onChanged: (newValue) {},
              onFieldSubmitted: (value) {
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget formFieldAddress(
    int controller,
    String hint,
    FocusNode currentfn,
    FocusNode nextFn,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              focusNode: currentfn,
              /*inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9]"),
                ),
              ],*/

              ///maxLength: 10,
              // Validator.getKeyboardTyp(validateModel.fieldType.toLowerCase()),
              style: TextStyle(fontSize: 15),

              decoration: InputDecoration(
                  //hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
              onChanged: (newValue) {},
              onFieldSubmitted: (value) {
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget formField(
      int index, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[index],
              textInputAction: TextInputAction.done,
              focusNode: currentfn,
              keyboardType: TextInputType.text,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
              ],
              // Validator.getKeyboardTyp(validateModel.fieldType.toLowerCase()),
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  //hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
              onChanged: (newValue) {},
              onFieldSubmitted: (value) {
                print("ValueValue" + error[index].toString());

                setState(() {
                  error[index] = false;
                });
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget dob(String hint) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => _selectDate(
          context,
        ),
        child: AbsorbPointer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 5, bottom: 8),
                child: Text(
                  hint,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: "",
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                // width: size.width * 0.8,
                /*decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey, width: 0.3)),*/
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextFormField(
                    //focusNode: fnode4,
                    //enabled: !widget.isConfirmPage ? false : true,
                    controller: textEditingController[0],
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    onSaved: (value) {
                      // registrationModel.dathOfBirth = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        error[3] = true;
                        return null;
                      }
                      error[3] = false;
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      error[3] = false;
                      // print("error>>>" + error[2].toString());

                      setState(() {});
                      // AppData.fieldFocusChange(context, fnode4, fnode5);
                    },
                    decoration: InputDecoration(
                      hintText: //"Last Period Date",
                          "Appointment Date",
                      border: InputBorder.none,
                      //contentPadding: EdgeInsets.symmetric(vertical: 10),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dob1() {
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

              onFieldSubmitted: (value) {
                error[2] = false;
                // print("error>>>" + error[2].toString());

                setState(() {});
                AppData.fieldFocusChange(context, fnode3, fnode4);
              },
              decoration: InputDecoration(
                hintText: MyLocalizations.of(context).text("DOB1"),
                /*labelText: "Family Doctor's Name",
                labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    // fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline
                ),*/
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey,
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

        textEditingController[0].value =
            TextEditingValue(text: df.format(picked));
        //updateProfileModel.dob = df.format(picked);
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
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                          Navigator.pop(context),
                          getCameraImage(),
                        }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),
                    getGalleryImage(),
                  },
                ),
              ],
            ),
          );
        });
  }

  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 45);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    if (image != null) {
      var enc = await image.readAsBytes();
      String _path = image.path;
      setState(() => pathUsr = File(_path));

      String _fileName = _path != null ? _path.split('/').last : '...';
      var pos = _fileName.lastIndexOf('.');
      String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
      print(extName);

      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
      setState(() {
        pathUsr = File(_path);
        // callApii();
        // widget.model.patientimg =base64Encode(enc);
        //widget.model.patientimgtype =extName;
        //updateProfileModel.profileImage = base64Encode(enc) as List<Null>;
        //updateProfileModel.profileImageType = extName;
        updateProfile(base64Encode(enc), extName);
      });
    }
  }

  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 45);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    if (image != null) {
      var enc = await image.readAsBytes();
      String _path = image.path;
      setState(() => pathUsr = File(image.path)); /*File(_path));*/

      String _fileName = _path != null ? _path.split('/').last : '...';
      var pos = _fileName.lastIndexOf('.');
      String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
      print(extName);
      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
      setState(() {
        pathUsr = File(_path);
        //widget.model.patientimg =base64Encode(enc);
        //widget.model.patientimgtype =extName;
        //updateProfileModel.profileImage = base64Encode(enc) as List<Null>;
        //updateProfileModel.profileImageType = extName;
        updateProfile(base64Encode(enc), extName);
      });
    }
  }

  void callApii() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.ALLERGY_LIST + loginResponse1.body.user,
        userId: loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
}
