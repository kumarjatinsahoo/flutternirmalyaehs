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
import 'package:user/models/UpdateEmergencyModel.dart';
import 'package:user/models/UpdateProfileModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/providers/text_field_container.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/TextFormatter.dart';

class ProfileScreen extends StatefulWidget {
  final MainModel model;
  final bool isConfirmPage;
  static KeyvalueModel bloodgroupmodel = null;
  static KeyvalueModel gendermodel = null;
  static KeyvalueModel relationmodel = null;
  static KeyvalueModel specialitymodel = null;
  static KeyvalueModel materialmodel = null;
  static KeyvalueModel countrymodel = null;
  static KeyvalueModel statemodel = null;
  static KeyvalueModel districtmodel = null;
  static KeyvalueModel citymodel = null;

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
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
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
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();
  FocusNode fnode10 = new FocusNode();
  FocusNode fnode11 = new FocusNode();
  FocusNode fnode12 = new FocusNode();
  FocusNode fnode13 = new FocusNode();
  FocusNode fnode14 = new FocusNode();
  FocusNode fnode15 = new FocusNode();
  FocusNode fnode16 = new FocusNode();
  FocusNode fnode17 = new FocusNode();
  FocusNode fnode18 = new FocusNode();
  FocusNode fnode19 = new FocusNode();
  FocusNode fnode20 = new FocusNode();
  FocusNode fnode21 = new FocusNode();

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
              loginResponse1.body.userPic =
                  patientProfileModel.body.profileImage;
              if (patientProfileModel?.body?.bloodGroup != null) {
                ProfileScreen.bloodgroupmodel = KeyvalueModel(
                    key: patientProfileModel.body.bloodGroupId,
                    name: patientProfileModel.body.bloodGroup);
              } else {
                ProfileScreen.bloodgroupmodel = null;
              }
              if (patientProfileModel?.body?.country != null) {
                ProfileScreen.countrymodel = KeyvalueModel(
                    key: patientProfileModel.body.countryid,
                    name: patientProfileModel.body.country);
              } else {
                ProfileScreen.countrymodel = null;
              }
              if (patientProfileModel?.body?.state != null) {
                ProfileScreen.statemodel = KeyvalueModel(
                    key: patientProfileModel.body.stateid,
                    name: patientProfileModel.body.state);
              } else {
                ProfileScreen.statemodel = null;
              }
              if (patientProfileModel?.body?.dist != null) {
                ProfileScreen.districtmodel = KeyvalueModel(
                    key: patientProfileModel.body.distid,
                    name: patientProfileModel.body.dist);
              } else {
                ProfileScreen.districtmodel = null;
              }
              if (patientProfileModel?.body?.city != null) {
                ProfileScreen.citymodel = KeyvalueModel(
                    key: patientProfileModel.body.cityid,
                    name: patientProfileModel.body.city);
              } else {
                ProfileScreen.citymodel = null;
              }
              if (patientProfileModel?.body?.maritialstatus != null) {
                ProfileScreen.materialmodel = KeyvalueModel(
                    key: patientProfileModel.body.mstausid,
                    name: patientProfileModel.body.maritialstatus);
              }
              /*else {
                ProfileScreen.materialmodel = null;
              }*/
             /* else {
                ProfileScreen.specialitymodel = null;
                ProfileScreen.countrymodel = null;
                ProfileScreen.statemodel = null;
                ProfileScreen.districtmodel = null;
                ProfileScreen.citymodel = null;
              }*/
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, "Something Went Wrong");
            }
          });
        });
  }

  updateProfile(String image, String ext) {
    MyWidgets.showLoading(context);
    var value = {
      "profileImageType": ext,
      "pImage": [image],
      "eCardNo": loginResponse1.body.user
    };

    log("Post data>>\n\n" + jsonEncode(value));
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Center(
              child: Text(
                MyLocalizations.of(context).text("MY_PROFILE"),
                style: TextStyle(color: Colors.white),
              ),
            ),
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
                  MyLocalizations.of(context).text("ID_CARD"),
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: double.maxFinite,
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
                          (patientProfileModel?.body?.eCardNo != null)
                              ? AppData.subStringBy(
                                          patientProfileModel?.body?.eCardNo) +
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
              DefaultTabController(
                  length: 4,
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
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                                MyLocalizations.of(context)
                                    .text("DETAILS")
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                                MyLocalizations.of(context)
                                    .text("EMERGENCY_CONTACT")
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    fontSize: 13)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                                MyLocalizations.of(context)
                                    .text("FAMILY_DOCTORS")
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    fontSize: 13)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                                MyLocalizations.of(context)
                                    .text("FAMILY DETAILS")
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    fontSize: 13)),
                          ),
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
                          //height: MediaQuery.of(context).size.height * 100,
                          height: 300,
                          child: TabBarView(
                            children: [
                              rowValue(),
                              backUp(),
                              rowValue2(),
                              rowValue3(),
                              /* rowValue1(),
                              rowValue1(),
                              rowValue1(),
                              rowValue1(),
                              rowValue1(),*/
                            ],
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget rowValue() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Container(
          child: SingleChildScrollView(
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
                          MyLocalizations.of(context).text("DOB1"),
                          style: TextStyle(
                            fontSize: 15,
                            // color: Colors.black54,
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
                          MyLocalizations.of(context).text("BLOODGROUP"),
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
                            MyLocalizations.of(context).text("GENDER"),
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
                          MyLocalizations.of(context).text("CONTACT_DETAILS"),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          MyLocalizations.of(context).text("ADDRESS"),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.address ?? "N/A") +
                              " " +
                              (patientProfileModel?.body?.pAddress ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.email,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          MyLocalizations.of(context).text("EMAIL"),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.email ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          MyLocalizations.of(context).text("PINCODE"),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.pincode ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.wc,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          MyLocalizations.of(context).text("MARITAL STATUS"),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.maritialstatus ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.work_sharp,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          MyLocalizations.of(context).text("OCCUPATION"),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.occupation ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.book,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          "Qualification",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.qualification ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.work_sharp,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          "Specilazation",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.specialization ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          "PAN Card No",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.pancardno ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          "Passport No",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.passportno ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          "Aadhaar No",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.adharno ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card_sharp,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          "Voter Card No",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.votercardno ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          "License No ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.licenceno ?? "N/A"),
                          style: TextStyle(fontSize: 14
                              //fontWeight: FontWeight.w500,
                              // color: AppData.kPrimaryColor,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          /*'Confirmed'*/
                          "License Authority ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (patientProfileModel?.body?.licenceauthority ??
                              "N/A"),
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
      ),
    );
  }

  Widget backUp() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(""),
                Spacer(),
                InkWell(
                  onTap: () {
                    displayDialog(context);
                  },
                  child: Icon(
                    Icons.add_circle_outline_sharp,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          (patientProfileModel != null)
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  EmergencydisplayDialog(context,patientProfileModel,0);
                                },
                                child: Row(
                                  children: [
                                    Text(" "),
                                    Spacer(),
                                    Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 20, right: 10.0),
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
                                        MyLocalizations.of(context)
                                            .text("NAME"),
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
                                        patientProfileModel?.body
                                                ?.emergenceList[index].name ??
                                            "N/A",
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  color: AppData.lightgreyBorder,
                                  height: 6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
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
                                        MyLocalizations.of(context)
                                            .text("RELATION"),
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
                                        patientProfileModel?.body
                                                ?.emergenceList[index].type ??
                                            "N/A",
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  color: AppData.lightgreyBorder,
                                  height: 6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
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
                                        MyLocalizations.of(context)
                                            .text("MOBILE_NO"),
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
                                        patientProfileModel?.body
                                                ?.emergenceList[index].mobile ??
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: patientProfileModel.body.emergenceList.length,
                )
              : Container()
        ],
      ),
    );
  }

  Widget rowValue2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(""),
                Spacer(),
                InkWell(
                  onTap: () {
                    displayDialog2(context);
                  },
                  child: Icon(
                    Icons.add_circle_outline_sharp,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          (patientProfileModel != null)
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 20, right: 10.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //  _displayTextInputDialog(context);
                                      },
                                      child: Row(
                                        children: [
                                          Text(" "),
                                          Spacer(),
                                          Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            MyLocalizations.of(context)
                                                .text("NAME"),
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
                                            patientProfileModel
                                                    ?.body
                                                    ?.familyDoctorList[index]
                                                    .name ??
                                                "N/A",
                                            style: TextStyle(fontSize: 14
                                                // fontWeight: FontWeight.w500,
                                                // color: Colors.black54,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              /*SizedBox(
                        height: 10,
                      ),*/
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  color: AppData.lightgreyBorder,
                                  height: 6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
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
                                        MyLocalizations.of(context)
                                            .text("SPECIALITY"),
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
                                        patientProfileModel
                                                ?.body
                                                ?.familyDoctorList[index]
                                                .type ??
                                            "N/A",
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  color: AppData.lightgreyBorder,
                                  height: 6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
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
                                        MyLocalizations.of(context)
                                            .text("MOBILE_NO"),
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
                                        patientProfileModel
                                                ?.body
                                                ?.familyDoctorList[index]
                                                .mobile ??
                                            "N/A",
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
                  },
                  itemCount: patientProfileModel.body.familyDoctorList.length,
                )
              : Container()
        ],
      ),
    );
  }

  Widget rowValue3() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(""),
                Spacer(),
                InkWell(
                  onTap: () {
                    displayDialog3(context);
                  },
                  child: Icon(
                    Icons.add_circle_outline_sharp,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          (patientProfileModel != null)
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 20, right: 10.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //  _displayTextInputDialog(context);
                                      },
                                      child: Row(
                                        children: [
                                          Text(" "),
                                          Spacer(),
                                          Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            MyLocalizations.of(context)
                                                .text("NAME"),
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
                                            patientProfileModel
                                                    ?.body
                                                    ?.familyDetailsList[index]
                                                    .memeberName ??
                                                "N/A",
                                            style: TextStyle(fontSize: 14
                                                // fontWeight: FontWeight.w500,
                                                // color: Colors.black54,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              /*SizedBox(
                  height: 10,
                ),*/
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  color: AppData.lightgreyBorder,
                                  height: 6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
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
                                        MyLocalizations.of(context)
                                            .text("RELATION"),
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
                                        patientProfileModel
                                                ?.body
                                                ?.familyDetailsList[index]
                                                .relation ??
                                            "N/A",
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  color: AppData.lightgreyBorder,
                                  height: 6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
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
                                        MyLocalizations.of(context).text("AGE"),
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
                                        patientProfileModel
                                                ?.body
                                                ?.familyDetailsList[index]
                                                .age ??
                                            "N/A",
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
                  },
                  itemCount: patientProfileModel.body.familyDetailsList.length,
                )
              : Container()
        ],
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
    textEditingController[1].text = patientProfileModel.body.address ?? "";
    textEditingController[2].text = patientProfileModel.body.occupation ?? "";
    textEditingController[3].text =
        patientProfileModel.body.qualification ?? "";
    textEditingController[4].text =
        patientProfileModel.body.specialization ?? "";
    textEditingController[5].text = patientProfileModel.body.pancardno ?? "";
    textEditingController[6].text = patientProfileModel.body.passportno ?? "";
    textEditingController[7].text = patientProfileModel.body.adharno ?? "";
    textEditingController[8].text = patientProfileModel.body.votercardno ?? "";
    textEditingController[9].text = patientProfileModel.body.licenceno ?? "";
    textEditingController[10].text =
        patientProfileModel.body.licenceauthority ?? "";
    textEditingController[11].text = patientProfileModel.body.email ?? "";
    textEditingController[12].text = patientProfileModel.body.pincode ?? "";
    textEditingController[0].text = (patientProfileModel != null)
        ? myFormatDate(patientProfileModel.body.dob.toString())
        : "";
    updateProfileModel.eCardNo = patientProfileModel.body.eCardNo.toString();

    updateProfileModel.eCardNo = patientProfileModel.body.eCardNo.toString();
    if (patientProfileModel?.body?.bloodGroup == null ||
        patientProfileModel?.body?.bloodGroup == "") {
      ProfileScreen.bloodgroupmodel = null;
    }
    if (patientProfileModel?.body?.maritialstatus == null ||
        patientProfileModel?.body?.maritialstatus == "") {
      ProfileScreen.materialmodel = null;
    }
    if (patientProfileModel?.body?.country == null ||
        patientProfileModel?.body?.country == "") {
      ProfileScreen.countrymodel = null;
    }
    if (patientProfileModel?.body?.state == null ||
        patientProfileModel?.body?.state == "") {
      ProfileScreen.statemodel = null;
    }
    if (patientProfileModel?.body?.dist == null ||
        patientProfileModel?.body?.dist == "") {
      ProfileScreen.districtmodel = null;
    }
    if (patientProfileModel?.body?.city == null ||
        patientProfileModel?.body?.city == "") {
      ProfileScreen.citymodel = null;
    }

    /* if (patientProfileModel?.body?.speciality == null ||
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
*/
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
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
                          SizedBox(height: 10),
                          Text(
                            MyLocalizations.of(context).text("UPDATE_PROFILE"),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          dob(MyLocalizations.of(context).text("DOB")),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context)
                                        .text("BLOODGROUP"),
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
                          SizedBox(
                            height: 20,
                          ),
                          formFieldAddress(
                              1,
                              MyLocalizations.of(context).text("USER_ADDRESS"),
                              fnode1,
                              null),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    "Marital Status",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "Marital Status",
                                    ApiFactory.MARITAL_API,
                                    "marital", (KeyvalueModel model) {
                                  setState(() {
                                    print(ApiFactory.MARITAL_API);
                                    ProfileScreen.materialmodel = model;
                                    patientProfileModel.body.mstausid =
                                        model.key;
                                    patientProfileModel.body.maritialstatus =
                                        model.name;
                                    //updateProfileModel.speciality = model.key;
                                  });
                                }),
                                SizedBox(height: 20),
                                formField(
                                    2,
                                    MyLocalizations.of(context)
                                        .text("OCCUPATION"),
                                    fnode2,
                                    fnode3),
                                SizedBox(height: 20),
                                formField(3, "Qualification", fnode3, fnode4),
                                SizedBox(height: 20),
                                formField(4, "Specialization", fnode5, fnode6),
                                SizedBox(height: 20),
                                formFieldPassPortno(
                                    5, "PanCard No", fnode6, fnode7),
                                SizedBox(height: 20),
                                formFieldPassPortno(
                                    6, "Passport No", fnode7, fnode8),
                                SizedBox(height: 20),
                                formFieldAadhaaerno(
                                    7, "Aadhar No", fnode8, fnode9),
                                SizedBox(height: 20),
                                formFieldPassPortno(
                                    8, "Voter Card No", fnode9, fnode10),
                                SizedBox(height: 20),
                                formFieldPassPortno(
                                    9, "Licence No", fnode10, fnode11),
                                SizedBox(height: 20),
                                formField(
                                    10, "Licence Authority", fnode11, fnode12),
                                SizedBox(height: 20),
                                formFieldemail(11, "Email", fnode12, fnode13),
                                SizedBox(height: 20),
                                formFieldPinno(12, "Pincode", fnode13, fnode14),
                                SizedBox(height: 20),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 5, bottom: 0),
                                        child: Text(
                                          MyLocalizations.of(context)
                                              .text("COUNTRY"),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      DropDown.networkDropdownlabler1(
                                          "Country",
                                          ApiFactory.COUNTRY_API,
                                          "pcountry", (KeyvalueModel model) {
                                        setState(() {
                                          print(ApiFactory.COUNTRY_API);
                                          ProfileScreen.countrymodel = model;
                                          patientProfileModel.body.countryid =
                                              model.key;
                                          patientProfileModel.body.country =
                                              model.name;
                                          // updateProfileModel.bloodGroup = model.key;
                                        });
                                      }),
                                    ]),
                                SizedBox(height: 20),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 5, bottom: 0),
                                        child: Text(
                                          MyLocalizations.of(context)
                                              .text("STATE"),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      DropDown.networkDropdownlabler1(
                                          "State",
                                          ApiFactory.STATE_API +
                                              (ProfileScreen
                                                      ?.countrymodel?.key ??
                                                  ""),
                                          "pstate", (KeyvalueModel model) {
                                        setState(() {
                                          print(ApiFactory.STATE_API);
                                          ProfileScreen.statemodel = model;
                                          patientProfileModel.body.stateid =
                                              model.key;
                                          patientProfileModel.body.state =
                                              model.name;
                                          // updateProfileModel.bloodGroup = model.key;
                                        });
                                      }),
                                    ]),
                                SizedBox(height: 20),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 5, bottom: 0),
                                        child: Text(
                                          "District",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      DropDown.networkDropdownlabler1(
                                          "District",
                                          ApiFactory.DISTRICT_API +
                                              (ProfileScreen?.statemodel?.key ??
                                                  ""),
                                          "pdistrict", (KeyvalueModel model) {
                                        setState(() {
                                          print(ApiFactory.DISTRICT_API);
                                          ProfileScreen.districtmodel = model;
                                          patientProfileModel.body.distid =
                                              model.key;
                                          patientProfileModel.body.dist =
                                              model.name;
                                          // updateProfileModel.bloodGroup = model.key;
                                        });
                                      }),
                                    ]),
                                SizedBox(height: 20),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 5, bottom: 0),
                                        child: Text(
                                          MyLocalizations.of(context)
                                              .text("CITY"),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      DropDown.networkDropdownlabler1(
                                          "City",
                                          ApiFactory.CITY_API +
                                              (ProfileScreen?.districtmodel?.key ??
                                                  ""),
                                          "pcity", (KeyvalueModel model) {
                                        setState(() {
                                          print(ApiFactory.CITY_API);
                                          ProfileScreen.citymodel = model;
                                          patientProfileModel.body.cityid =
                                              model.key;
                                          patientProfileModel.body.city =
                                              model.name;
                                          // updateProfileModel.bloodGroup = model.key;
                                        });
                                      }),
                                    ]),
                              ]),
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
                child: Text(MyLocalizations.of(context).text("CANCEL"),
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  setState(() {
                    callApi();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(MyLocalizations.of(context).text("UPDATE")),
                onPressed: () {
                  setState(() {
                    bool isAllBlank = true;
                    textEditingController.forEach((element) {
                      if (element.text != "") isAllBlank = false;
                    });
                    if (isAllBlank) {
                      //AppData.showInSnackBar(context, "Please select Smoking");
                      AppData.showInSnackBar(
                          context, "Please Fill Up Atleast One Field ");
                    } else {
                      updateProfileModel.eCardNo =
                          patientProfileModel.body.eCardNo;
                      updateProfileModel.dob = textEditingController[0].text;
                      updateProfileModel.bloodGroup = ProfileScreen?.bloodgroupmodel?.key??null;
                      updateProfileModel.maritialstatus = ProfileScreen?.materialmodel?.key??null;
                      if(textEditingController[1].text!="") {
                        updateProfileModel.address =
                            textEditingController[1].text;
                      }
                      updateProfileModel.occupation = textEditingController[2].text;
                      updateProfileModel.qualification = textEditingController[3].text;
                      updateProfileModel.specialization =
                          textEditingController[4].text;
                      updateProfileModel.pancardno =
                          textEditingController[5].text;
                      updateProfileModel.passportno =
                          textEditingController[6].text;
                      updateProfileModel.adharno =
                          textEditingController[7].text;
                      updateProfileModel.votercardno =
                          textEditingController[8].text;
                      updateProfileModel.licenceno =
                          textEditingController[9].text;
                      updateProfileModel.licenceauthority =
                          textEditingController[10].text;
                      updateProfileModel.email = textEditingController[11].text;
                      updateProfileModel.pincode = textEditingController[12].text;
                      updateProfileModel.countryid = ProfileScreen.countrymodel.key;
                      updateProfileModel.stateid = ProfileScreen.statemodel.key;
                      updateProfileModel.distid = ProfileScreen.districtmodel.key;
                      updateProfileModel.cityid = ProfileScreen.citymodel.key;
                      updateProfileModel.mobile = patientProfileModel.body.mobile;
                      updateProfileModel.fName = patientProfileModel.body.fName;
                      updateProfileModel.lName = patientProfileModel.body.lName;
                      updateProfileModel.gender = patientProfileModel.body.genderId;

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
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z .]")),
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
  Widget formFieldemail(
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
              /*inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z .]")),
              ],*/
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

  void displayDialog(BuildContext context) {
    textEditingController[13].text = "";
    textEditingController[14].text = "";
    ProfileScreen.relationmodel=null;

    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Add Emergency Contact",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formField1(13, " Name"),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                            "Relation",
                            ApiFactory.RELATION_API,
                            "relation",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.RELATION_API);
                            ProfileScreen.relationmodel = data;
                            ProfileScreen.relationmodel = data.key;
                          });
                        }),
                        SizedBox(height: 8),
                        mobileformField1(14, "Mobile No"),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
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
                  MyLocalizations.of(context).text("SUBMIT"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  setState(() {
          if (textEditingController[13].text == null || textEditingController[13].text == "") {
          AppData.showInSnackBar(context, "Please enter Name");
          } else if (textEditingController[13].text != "" && textEditingController[13].text.length <= 2) {
          AppData.showInSnackBar(
          context, "Please enter a valid First Name");
          } else if (ProfileScreen.relationmodel == "" ||
          ProfileScreen.relationmodel == null) {
          AppData.showInSnackBar(
          context, "Please Select Relation ");
          }else if (textEditingController[14].text == "" || textEditingController[14].text == null) {
            AppData.showInSnackBar(
                context, "Please enter Emergency Contact No.");
          } else if (textEditingController[14] != "" &&
              textEditingController[14].text.length != 10) {
            AppData.showInSnackBar(
                context, "Please enter valid Emergency Contact No.");
          }
          else {
            UpdateEmergencyModel  updateEmergencyModel = UpdateEmergencyModel();
            updateEmergencyModel.name = textEditingController[13].text;
            updateEmergencyModel.mobile = textEditingController[14].text;
            updateEmergencyModel.userid = widget.model.user;
            updateEmergencyModel.relation = ProfileScreen.relationmodel.key;
            log("Value json>>" +
                updateEmergencyModel.toJson().toString());
            widget.model.POSTMETHOD_TOKEN(
                api: ApiFactory.UPDATE_EMERGENCY_CONTACT,
                json: updateEmergencyModel.toJson(),
                token: widget.model.token,

                fun: (Map<String, dynamic> map) {
                  // Navigator.pop(context);

                  if (map[Const.STATUS1] == Const.SUCCESS) {
                    Navigator.pop(context);
                    // popup(context, map[Const.MESSAGE]);
                    callApi();
                    AppData.showInSnackDone(
                        context, map[Const.MESSAGE]);
                  } else {
                    // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  }
                });
          }
                  });

                },
              ),
            ],
          );
        },
        context: context);
  }
  void EmergencydisplayDialog(BuildContext context,patientProfileModel, int index) {
    //_date.text = "";
    textEditingController[13].text=patientProfileModel?.body?.emergenceList[index].name??"";
    textEditingController[14].text=patientProfileModel?.body?.emergenceList[index].mobile??"";
    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Update Emergency Contact",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formField1(13, " Name"),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                            "Relation",
                            ApiFactory.RELATION_API,
                            "relation",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.RELATION_API);
                            ProfileScreen.relationmodel = data;
                            ProfileScreen.relationmodel = data.key;
                          });
                        }),
                        SizedBox(height: 8),
                        mobileformField1(14, "Mobile No"),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
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
                  MyLocalizations.of(context).text("UPDATE"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  setState(() {
                    if (textEditingController[13].text == null || textEditingController[13].text == "") {
                      AppData.showInSnackBar(context, "Please enter Name");
                    } else if (textEditingController[13].text != "" && textEditingController[13].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter a valid First Name");
                    } else if (ProfileScreen.relationmodel == "" ||
                        ProfileScreen.relationmodel == null) {
                      AppData.showInSnackBar(
                          context, "Please Select Relation ");
                    }else if (textEditingController[14].text == "" || textEditingController[14].text == null) {
                      AppData.showInSnackBar(
                          context, "Please enter Emergency Contact No.");
                    } else if (textEditingController[14] != "" &&
                        textEditingController[14].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Emergency Contact No.");
                    }
                    else {
                      UpdateEmergencyModel  updateEmergencyModel = UpdateEmergencyModel();
                      updateEmergencyModel.name = textEditingController[13].text;
                      updateEmergencyModel.mobile = textEditingController[14].text;
                      updateEmergencyModel.id = patientProfileModel?.body?.emergenceList[index].id;
                      updateEmergencyModel.userid = widget.model.user;
                      updateEmergencyModel.relation = ProfileScreen.relationmodel.key;
                      log("Value json>>" +
                          updateEmergencyModel.toJson().toString());
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.UPDATE_EMERGENCY_CONTACT,
                          json: updateEmergencyModel.toJson(),
                          token: widget.model.token,

                          fun: (Map<String, dynamic> map) {
                            // Navigator.pop(context);

                            if (map[Const.STATUS1] == Const.SUCCESS) {
                              Navigator.pop(context);
                              // popup(context, map[Const.MESSAGE]);
                              callApi();
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);
                            } else {
                              // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                            }
                          });
                    }
                  });

                },
              ),
            ],
          );
        },
        context: context);
  }

  void displayDialog2(BuildContext context) {
    //_date.text = "";

    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Add Family Doctor's Name",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formField1(1, " Name"),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                            "Relation",
                            ApiFactory.RELATION_API,
                            "relation",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel model) {
                          setState(() {
                            ProfileScreen.relationmodel = model;
                            patientProfileModel.body.eRelationId = model.key;
                            patientProfileModel.body.eRelation = model.name;
                          });
                        }),
                        SizedBox(height: 8),
                        formField1(2, "Mobile No"),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
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
                  MyLocalizations.of(context).text("SUBMIT"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  /*if (Immunization.immunizationmodel == null || Immunization.immunizationmodel == "") {
                      AppData.showInSnackBar(context, "Please Select Immunization Type ");
                    } else if (_date.text == "" || _date.text == null) {
                      AppData.showInSnackBar(context, "Please Enter Immunization Date");
                    } else if (textEditingController[1].text == "" ||textEditingController[1].text == null) {
                      AppData.showInSnackBar(context, "Please Enter Prescribed By");
                    } else if (textEditingController[2].text == ""||textEditingController[2].text == null) {
                      AppData.showInSnackBar(context, "Please Enter Immunization Details ");
                    } else {
                      MyWidgets.showLoading(context);
                      ImmunizationPostModel immunizationmodel =
                      ImmunizationPostModel();
                      immunizationmodel.patientId = loginResponse1.body.user;
                      immunizationmodel.immunizationId =
                          Immunization.immunizationmodel.key;
                      immunizationmodel.immunizationDate = _date.text;
                      immunizationmodel.doctorName =
                          textEditingController[1].text;
                      immunizationmodel.immunizationDetails =
                          textEditingController[2].text;
                      immunizationmodel.status = "yes";
                      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                          immunizationmodel.toJson().toString());
                      widget.model.POSTMETHOD2(
                        api: ApiFactory.ADD_IMMUNIZATION,
                        json: immunizationmodel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          if (map["code"] == Const.SUCCESS) {
                            Navigator.pop(context);
                            callApi();
                            AppData.showInSnackDone(
                                context,map["message"]);
                          } else {

                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        },
                      );
                    }*/
                },
              ),
            ],
          );
        },
        context: context);
  }

  void displayDialog3(BuildContext context) {
    //_date.text = "";

    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Add Family Details",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formField1(1, " Name"),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                            "Relation",
                            ApiFactory.RELATION_API,
                            "relation",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel model) {
                          setState(() {
                            ProfileScreen.relationmodel = model;
                            patientProfileModel.body.eRelationId = model.key;
                            patientProfileModel.body.eRelation = model.name;
                          });
                        }),
                        SizedBox(height: 8),
                        formField1(2, "Mobile No"),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
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
                  MyLocalizations.of(context).text("SUBMIT"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  /*if (Immunization.immunizationmodel == null || Immunization.immunizationmodel == "") {
                      AppData.showInSnackBar(context, "Please Select Immunization Type ");
                    } else if (_date.text == "" || _date.text == null) {
                      AppData.showInSnackBar(context, "Please Enter Immunization Date");
                    } else if (textEditingController[1].text == "" ||textEditingController[1].text == null) {
                      AppData.showInSnackBar(context, "Please Enter Prescribed By");
                    } else if (textEditingController[2].text == ""||textEditingController[2].text == null) {
                      AppData.showInSnackBar(context, "Please Enter Immunization Details ");
                    } else {
                      MyWidgets.showLoading(context);
                      ImmunizationPostModel immunizationmodel =
                      ImmunizationPostModel();
                      immunizationmodel.patientId = loginResponse1.body.user;
                      immunizationmodel.immunizationId =
                          Immunization.immunizationmodel.key;
                      immunizationmodel.immunizationDate = _date.text;
                      immunizationmodel.doctorName =
                          textEditingController[1].text;
                      immunizationmodel.immunizationDetails =
                          textEditingController[2].text;
                      immunizationmodel.status = "yes";
                      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                          immunizationmodel.toJson().toString());
                      widget.model.POSTMETHOD2(
                        api: ApiFactory.ADD_IMMUNIZATION,
                        json: immunizationmodel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          if (map["code"] == Const.SUCCESS) {
                            Navigator.pop(context);
                            callApi();
                            AppData.showInSnackDone(
                                context,map["message"]);
                          } else {

                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        },
                      );
                    }*/
                },
              ),
            ],
          );
        },
        context: context);
  }

  void displayDialog4(BuildContext context) {
    //_date.text = "";

    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Add Education Name",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formField1(1, " Name"),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                            "Relation",
                            ApiFactory.RELATION_API,
                            "relation",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel model) {
                          setState(() {
                            ProfileScreen.relationmodel = model;
                            patientProfileModel.body.eRelationId = model.key;
                            patientProfileModel.body.eRelation = model.name;
                          });
                        }),
                        SizedBox(height: 8),
                        formField1(2, "Mobile No"),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                //textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
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
                  MyLocalizations.of(context).text("SUBMIT"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  /*if (Immunization.immunizationmodel == null || Immunization.immunizationmodel == "") {
                      AppData.showInSnackBar(context, "Please Select Immunization Type ");
                    } else if (_date.text == "" || _date.text == null) {
                      AppData.showInSnackBar(context, "Please Enter Immunization Date");
                    } else if (textEditingController[1].text == "" ||textEditingController[1].text == null) {
                      AppData.showInSnackBar(context, "Please Enter Prescribed By");
                    } else if (textEditingController[2].text == ""||textEditingController[2].text == null) {
                      AppData.showInSnackBar(context, "Please Enter Immunization Details ");
                    } else {
                      MyWidgets.showLoading(context);
                      ImmunizationPostModel immunizationmodel =
                      ImmunizationPostModel();
                      immunizationmodel.patientId = loginResponse1.body.user;
                      immunizationmodel.immunizationId =
                          Immunization.immunizationmodel.key;
                      immunizationmodel.immunizationDate = _date.text;
                      immunizationmodel.doctorName =
                          textEditingController[1].text;
                      immunizationmodel.immunizationDetails =
                          textEditingController[2].text;
                      immunizationmodel.status = "yes";
                      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                          immunizationmodel.toJson().toString());
                      widget.model.POSTMETHOD2(
                        api: ApiFactory.ADD_IMMUNIZATION,
                        json: immunizationmodel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);
                          if (map["code"] == Const.SUCCESS) {
                            Navigator.pop(context);
                            callApi();
                            AppData.showInSnackDone(
                                context,map["message"]);
                          } else {

                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        },
                      );
                    }*/
                },
              ),
            ],
          );
        },
        context: context);
  }

  Widget formField1(
    int index,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          // controller: _reason,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }
  Widget mobileformField1(
    int index,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(

          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
counterText: "",
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor),
          ),
          keyboardType: TextInputType.number,

          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[0-9]")),
          ],
          maxLength: 10,
          textInputAction: TextInputAction.next,
          // controller: _reason,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }

  Widget formFieldAadhaaerno(
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
              maxLength: 12,
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

  Widget formFieldPinno(
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
              maxLength: 6,
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

  Widget formFieldPassPortno(
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
              keyboardType: TextInputType.text,
              focusNode: currentfn,

              inputFormatters: [
                UpperCaseTextFormatter(),
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
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
}
