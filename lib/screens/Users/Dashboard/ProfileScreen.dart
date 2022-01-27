import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddUserFamilyDetailsModel.dart';
import 'package:user/models/FamilyDoctorModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/LoginResponse1.dart' as login;
import 'package:user/models/PatientListModel.dart';
import 'package:user/models/ProfileModel.dart';
import 'package:user/models/ProfileModel.dart';
import 'package:user/models/UpdateEmergencyModel.dart';
import 'package:user/models/UpdateProfileModel.dart';
import 'package:user/models/UserFamilyDetailModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/SharedPref.dart';
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
  UserFamilyDetailsModel userfamilydetails;
  bool emeradd = true;
  bool famdoctoradd = true;
  bool familydetailsadd = true;
  bool isdata = false;
  bool _inProcess = false;

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

  SharedPref sharedPref=SharedPref();

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
    setState(() {
      callApi();
    });
   // callApi();
  }
  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.PATIENT_PROFILE + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          // setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                patientProfileModel = ProfileModel.fromJson(map);
                loginResponse1.body.userPic = patientProfileModel.body.profileImage;
              });
              if (patientProfileModel?.body?.bloodGroup != null) {
                ProfileScreen.bloodgroupmodel = KeyvalueModel(
                    key: patientProfileModel.body.bloodGroupId,
                    name: patientProfileModel.body.bloodGroup);
              } else {
                ProfileScreen.bloodgroupmodel = null;
              }
              if (patientProfileModel?.body?.gender != null) {
                ProfileScreen.gendermodel = KeyvalueModel(
                    key: patientProfileModel.body.genderId,
                    name: patientProfileModel.body.gender);
              } else {
                ProfileScreen.gendermodel = null;
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
              if (patientProfileModel.body.emergenceList[0].type != null) {
                ProfileScreen.relationmodel = KeyvalueModel(
                  key: patientProfileModel.body.emergenceList[0].typeid,
                  name: patientProfileModel.body.emergenceList[0].type,
                );
              }
              if (patientProfileModel.body.familyDoctorList[0].type != null) {
                ProfileScreen.relationmodel = KeyvalueModel(
                  key: patientProfileModel.body.familyDoctorList[0].typeid,
                  name: patientProfileModel.body.familyDoctorList[0].type,
                );
              }
              if (patientProfileModel.body.familyDetailsList[0].relation !=
                  null) {
                ProfileScreen.relationmodel = KeyvalueModel(
                  key: patientProfileModel.body.familyDetailsList[0].relid,
                  name: patientProfileModel.body.familyDetailsList[0].relation,
                );
              }

/*
              if (patientProfileModel?.body?.emergenceList[i].type != null) {
                ProfileScreen.materialmodel = KeyvalueModel(
                    key: patientProfileModel.body.emergenceList[i].typeid,
                    name: patientProfileModel.body.emergenceList[i].type);
              }
*/
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
             // isDataNotAvail = true;
              isdata=true;
              //AppData.showInSnackBar(context, "Something Went Wrong");
            }
          });
        // });
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
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: Text(
                  MyLocalizations.of(context).text("MY_PROFILE"),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 80.0),
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
      body: patientProfileModel == null
          ?  isdata != true
          ? Center(
        child: Column(
          children: [
            SizedBox(
              height:
              MediaQuery.of(context).size.height * 0.35,
            ),
            CircularProgressIndicator(),
          ],
        ),
      )
          :Container(
        child: Center(

          child: Column(
            children: [
              SizedBox(
                height:
                MediaQuery.of(context).size.height * 0.35,
              ),
              //CircularProgressIndicator()
              Text(
                MyLocalizations.of(context).text("NO_DATA_FOUND"),
                style: TextStyle(
                    color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      )
          : Padding(
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
                                  setState(() {
                                    if (patientProfileModel != null) {
                                      _displayTextInputDialog(context);
                                    } else {
                                      AppData.showInSnackBar(context,
                                          "Please wait until we are fetching your data");
                                    }
                                  });


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
                        InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => dialogUserView(context),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 20,),
                              Text(
                                patientProfileModel?.body?.fullName ?? "N/A",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
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
                                    .text("FAMILY_DETAILS")
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
                          //height: 300,
                        child:LimitedBox( // use this 
                            maxHeight: 300,
                        child: TabBarView(
                          children: [
                            (patientProfileModel != null)?rowValue():Container(),
                            (patientProfileModel != null)? backUp():Container(),
                            (patientProfileModel != null)?rowValue2():Container(),
                            (patientProfileModel != null)? rowValue3():Container(),
                            /* rowValue1(),
                            rowValue1(),
                            rowValue1(),
                            rowValue1(),
                            rowValue1(),*/
                          ],
                        )
                      ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }




  ///////Profile Swap ////Sanjaya//////

  Widget dialogUserView(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(onPressed: (){
          Navigator.pop(context);
        },child: Text("Cancel"),)
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 20),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 450,
            child: Column(
              children: [
                Text(
                  "Login Users",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //_buildAboutText(),
                        //_buildLogoAttribution(),

                        ListView.separated(
                          separatorBuilder: (c,i){
                            return Divider();
                          },
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return ListTile(
                              leading: Icon(CupertinoIcons.person_alt_circle,size: 44,),
                              title: Text(widget.model.masterResponse.body[i].userName),
                              subtitle: Text(widget.model.masterResponse.body[i].user),
                              onTap: (){
                                roleUpdateApi(widget.model.masterResponse.body[i]);
                              },
                              trailing: Icon(Icons.arrow_right),
                            );
                          },
                          itemCount: widget.model.masterResponse.body.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      /*actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("Cancel"),
        ),
        new FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: const Text('SEARCH'),
        ),
      ],*/
    );
  }

  roleUpdateApi(data){
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(api: ApiFactory.GET_ROLE+data.user, fun: (Map<String,dynamic> map){
      Navigator.pop(context);
      if(map["code"]=="success"){
        LoginResponse1 loginResponse = LoginResponse1();
        login.Body body=login.Body();
        body.user=data.user;
        body.userName=data.userName;
        body.userAddress=data.userAddress;
        body.userPassword=data.userPassword;
        body.userMobile=data.userMobile;
        body.userStatus=data.userStatus;
        body.token=data.token;
        body.roles=[];
        body.roles.add(map["body"]["roleid"]);
        loginResponse.body=body;
        widget.model.token = data.token;
        widget.model.user = data.user;
        log("Response after assign>>>>"+jsonEncode(loginResponse.toJson()));
        sharedPref.save(Const.LOGIN_DATA, loginResponse);
        widget.model.setLoginData1(loginResponse);
/*
        FirebaseMessaging.instance.subscribeToTopic(data.user);
        FirebaseMessaging.instance.subscribeToTopic(data.userMobile);*/

        if (map["body"]["roleid"] == "1".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboard', (Route<dynamic> route) => false);
        } else if (map["body"]["roleid"] ==
            "2".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashDoctor', (Route<dynamic> route) => false);
        } else if (map["body"]["roleid"] ==
            "5".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboardreceptionlist',
                  (Route<dynamic> route) => false);
        } else if (map["body"]["roleid"] ==
            "7".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboardpharmacy',
                  (Route<dynamic> route) => false);
        } else if (map["body"]["roleid"] ==
            "8".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/labDash', (Route<dynamic> route) => false);
        } else if (map["body"]["roleid"] ==
            "12".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/ambulancedash', (Route<dynamic> route) => false);
        } else if (map["body"]["roleid"] ==
            "13".toLowerCase()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/bloodBankDashboard',
                  (Route<dynamic> route) => false);
        } else {
          AppData.showInSnackBar(context, "No Role Assign");
        }
      }
    });
  }




  /////////////////////




   Widget rowValue() {
    return
      (patientProfileModel != null)?SingleChildScrollView(
        child: Card(
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
                                " " + (patientProfileModel?.body?.pAddress ?? "N/A"),
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
                            MyLocalizations.of(context).text("EMAILID"),
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
                            MyLocalizations.of(context).text("PIN_CODE"),
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
                            MyLocalizations.of(context).text("MARITAL_STATUS"),
                            /*'Confirmed'*/
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
                          child: Text( MyLocalizations.of(context).text("QUALIFICATION"),
                            /*'Confirmed'*/
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
                          child: Text(MyLocalizations.of(context).text("SPECILAZATION"),
                            /*'Confirmed'*/
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
                          child: Text(MyLocalizations.of(context).text("PAN_CARD_NO"),
                            /*'Confirmed'*/
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
                          child: Text(MyLocalizations.of(context).text("PASSPORT_NO"),
                            /*'Confirmed'*/
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
                          child: Text(MyLocalizations.of(context).text("AADHAAR_NO1"),
                            /*'Confirmed'*/
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
                          child: Text(MyLocalizations.of(context).text("VOTER_CARD_NO"),
                            /*'Confirmed'*/
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
                          child: Text(MyLocalizations.of(context).text("LICENCE_NO"),
                            /*'Confirmed'*/
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
                          child: Text(MyLocalizations.of(context).text("LICENSE_AUTHORITY"),
                            /*'Confirmed'*/
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
    ),
      ):Container();
  }

  Widget backUp() {
    if(patientProfileModel.body.emergenceList.length >= 5)
    {
      setState(() {
        emeradd=false;
      });
    }
    else{
      emeradd=true;
    }
    return
      (patientProfileModel != null)?SingleChildScrollView(
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
                    setState(() {
                      displayDialog(context);
                    });
                  },
                  child: Visibility(
                    visible: emeradd,
                    child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          (patientProfileModel != null)
              ?
          ListView.builder(
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
                              Row(
                                children: [
                                  Text(" "),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        EmergencydisplayDialog(
                                            context, patientProfileModel, index);
                                      });

                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        emergencydetailsdisplayDialog(context, patientProfileModel, index);

                                      });

                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  ),
                                ],
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
                   itemCount: patientProfileModel.body.emergenceList.take(5).length,
                  //itemCount: 5,
                )
              : Container()
        ],
      ),
    ):Container();
  }

  Widget rowValue2() {
    if(patientProfileModel.body.familyDoctorList.length >= 5)
    {
      setState(() {
        famdoctoradd=false;
      });
    }
    else{
      emeradd=true;
    }
    return (patientProfileModel != null)?SingleChildScrollView(
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
                    setState(() {
                      displayDialog2(context);
                    });
                  },
                  child: Visibility(
                    visible: famdoctoradd,
                    child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          (patientProfileModel != null)
              ?
          ListView.builder(
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
                              //Text("Mu Hero",),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, top: 0, right: 0.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(" "),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              doctordisplayDialog(context,
                                                  patientProfileModel, index);
                                            });

                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              deletedoctordetailsdisplayDialog(context, patientProfileModel, index);

                                            });

                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:20),
                                    Padding(
                                      padding: const EdgeInsets.only(left:10,right:10),
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
                  itemCount: patientProfileModel.body.familyDoctorList.take(5).length,
                  //itemCount: 5,
                )
              : Container()
        ],
      ),
    ):Container();
  }

  Widget rowValue3() {
    if(patientProfileModel.body.familyDetailsList.length >= 5)
    {
      setState(() {
        familydetailsadd=false;
      });
    }
    else{
      emeradd=true;
    }
    return (patientProfileModel != null)?SingleChildScrollView(
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
                    setState(() {
                      displayDialog3(context);

                    });
                  },
                  child: Visibility(
                    visible: familydetailsadd,
                    child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          (patientProfileModel != null)
              ?           ListView.builder(
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
                                    left: 0.0, top: 0, right: 0.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(" "),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              familydetailsdisplayDialog(context, patientProfileModel, index);

                                            });
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              deletefamilydetailsdisplayDialog(context, patientProfileModel, index);

                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:20),
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
                                            child: Text("UHID",
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
                                                  .userid ??
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
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                      child: Divider(
                                        color: AppData.lightgreyBorder,
                                        height: 6,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:10,right:10),
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
                  itemCount: patientProfileModel.body.familyDetailsList.take(5).length,
                )
              : Container()
        ],
      ),
    ):Container();
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
    textEditingController[1].text = patientProfileModel.body.address ?? ""/*""+patientProfileModel.body.pAddress ?? ""*/;
    textEditingController[2].text = patientProfileModel.body.occupation ?? "";
    textEditingController[3].text = patientProfileModel.body.qualification ?? "";
    textEditingController[4].text = patientProfileModel.body.specialization ?? "";
    textEditingController[5].text = patientProfileModel.body.pancardno ?? "";
    textEditingController[6].text = patientProfileModel.body.passportno ?? "";
    textEditingController[7].text = patientProfileModel.body.adharno ?? "";
    textEditingController[8].text = patientProfileModel.body.votercardno ?? "";
    textEditingController[9].text = patientProfileModel.body.licenceno ?? "";
    textEditingController[10].text = patientProfileModel.body.licenceauthority ?? "";
    textEditingController[11].text = patientProfileModel.body.email ?? "";
    textEditingController[12].text = patientProfileModel.body.pincode ?? "";
    textEditingController[13].text = patientProfileModel.body.mobile ?? "";
    textEditingController[14].text = patientProfileModel.body.fName ?? "";
    textEditingController[15].text = patientProfileModel.body.lName ?? "";
    textEditingController[16].text = patientProfileModel.body.gender ?? "";

/*
    updateProfileModel.mobile = patientProfileModel.body.mobile;
    updateProfileModel.fName = patientProfileModel.body.fName;
    updateProfileModel.lName = patientProfileModel.body.lName;
    updateProfileModel.gender = patientProfileModel.body.genderId;
*/

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

    if (patientProfileModel?.body?.gender == null ||
        patientProfileModel.body.gender == "") {
      ProfileScreen.gendermodel = null;
    } else {
      ProfileScreen.gendermodel = KeyvalueModel(
          key: patientProfileModel.body.genderId,
          name: patientProfileModel.body.gender);
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
                                    MyLocalizations.of(context).text("MARITAL_STATUS"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    MyLocalizations.of(context).text("MARITAL_STATUS"),
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
                                formField(3, MyLocalizations.of(context).text("QUALIFICATION"), fnode3, fnode4),
                                SizedBox(height: 20),
                                formField(4, MyLocalizations.of(context).text("SPECILAZATION"), fnode5, fnode6),
                                SizedBox(height: 20),
                                formFieldPassPortno(
                                    5,MyLocalizations.of(context).text("PAN_CARD_NO"), fnode6, fnode7),
                                SizedBox(height: 20),
                                formFieldPassPortno(
                                    6, MyLocalizations.of(context).text("PASSPORT_NO"), fnode7, fnode8),
                                SizedBox(height: 20),
                                formFieldAadhaaerno(
                                    7, MyLocalizations.of(context).text("AADHAAR_NO"),  fnode8, fnode9),
                                SizedBox(height: 20),
                                formFieldPassPortno(
                                    8, MyLocalizations.of(context).text("VOTER_CARD_NO"), fnode9, fnode10),
                                SizedBox(height: 20),
                                formFieldPassPortno(
                                    9,  MyLocalizations.of(context).text("LICENCE_NO"), fnode10, fnode11),
                                SizedBox(height: 20),
                                formField(
                                    10, MyLocalizations.of(context).text("LICENSE_AUTHORITY"), fnode11, fnode12),
                                SizedBox(height: 20),
                                formFieldemail(11, MyLocalizations.of(context).text("EMAILID"), fnode12, fnode13),
                                SizedBox(height: 20),
                                formFieldPinno(
                                    12,MyLocalizations.of(context).text("PIN_CODE"), fnode13, fnode14),
                                SizedBox(height: 20),
                                formFieldemail(13, MyLocalizations.of(context).text("MOBILE_NO"), fnode14, fnode15),
                                SizedBox(height: 20),
                                formFieldemail(14, MyLocalizations.of(context).text("FNAME"), fnode15, fnode16),
                                SizedBox(height: 20),
                                formFieldemail(15, MyLocalizations.of(context).text("LNAME"), fnode16, fnode17),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context).text("GENDER"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    MyLocalizations.of(context).text("GENDER"), ApiFactory.GENDER_API, "gen",
                                    (KeyvalueModel model) {
                                  setState(() {
                                    print(ApiFactory.GENDER_API);
                                    ProfileScreen.gendermodel = model;
                                    patientProfileModel.body.genderId =
                                        model.key;
                                    patientProfileModel.body.gender =
                                        model.name;
                                    //updateProfileModel.speciality = model.key;
                                  });
                                }),
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
                                          MyLocalizations.of(context)
                                              .text("COUNTRY"),
                                          ApiFactory.COUNTRY_API,
                                          "pcountry", (KeyvalueModel model) {
                                        setState(() {
                                          print(ApiFactory.COUNTRY_API);
                                          ProfileScreen.countrymodel = model;
                                          patientProfileModel.body.countryid = model.key;
                                          patientProfileModel.body.country = model.name;
                                          ProfileScreen.statemodel = null;
                                          ProfileScreen.districtmodel = null;
                                          ProfileScreen.citymodel = null;
                                          // updateProfileModel.bloodGroup = model.key;
                                        });
                                      }),
                                    ]),
                                SizedBox(height: 20),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                          MyLocalizations.of(context)
                                              .text("STATE"),
                                          ApiFactory.STATE_API +
                                              (ProfileScreen
                                                      ?.countrymodel?.key ?? ""),
                                          "pstate", (KeyvalueModel model) {
                                        setState(() {
                                          print(ApiFactory.STATE_API);
                                          ProfileScreen.statemodel = model;
                                          patientProfileModel.body.stateid = model.key;
                                          patientProfileModel.body.state = model.name;
                                          ProfileScreen.districtmodel = null;
                                          ProfileScreen.citymodel = null;
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
                                              .text("DIST"),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      DropDown.networkDropdownlabler1(
                                          MyLocalizations.of(context)
                                              .text("DIST"),
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
                                          ProfileScreen.citymodel = null;
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
                                          MyLocalizations.of(context)
                                              .text("CITY"),
                                          ApiFactory.CITY_API +
                                              (ProfileScreen
                                                      ?.districtmodel?.key ??
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
                    /* bool isAllBlank = true;
                    textEditingController.forEach((element) {
                      if (element.text != "") isAllBlank = false;
                    });*/
                    /* if (isAllBlank) {
                      //AppData.showInSnackBar(context, "Please select Smoking");
                      AppData.showInSnackBar(
                          context, "Please Fill Up Atleast One Field ");
                    }*/
                    if (textEditingController[0].text == null ||
                        textEditingController[0].text == "") {
                      AppData.showInSnackBar(context, "Please Enter  Dob");
                    // } else if (ProfileScreen.bloodgroupmodel == null ||
                    //     ProfileScreen.bloodgroupmodel == "") {
                    //   AppData.showInSnackBar(
                    //       context, "Please select Bloodgroup");
                    } else if (textEditingController[1].text == "" ||
                        textEditingController[1].text == null) {
                      AppData.showInSnackBar(context, "Please enter Address");
                    // } else if (ProfileScreen.materialmodel == null ||
                    //     ProfileScreen.materialmodel == "") {
                    //   AppData.showInSnackBar(
                    //       context, "Please select Marital Status");
                    // } else if (textEditingController[2].text == "" ||
                    //     textEditingController[2].text.length == null) {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter Occupation");
                      // FocusScope.of(context).requestFocus(fnode2);
                    // } else if (textEditingController[3].text == "" ||
                    //     textEditingController[3].text.length == null) {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter Qualification");
                      // FocusScope.of(context).requestFocus(fnode3);
                    // } else if (textEditingController[4].text == "" &&
                    //     textEditingController[4].text.length == null) {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter  Specialization");
                      // FocusScope.of(context).requestFocus(fnode4);
                    // } else if (textEditingController[5].text == "" ||
                    //     textEditingController[5].text == null) {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter Pan Card No");
                      // FocusScope.of(context).requestFocus(fnode5);
                    // } else if (textEditingController[6].text == "" ||
                    //     textEditingController[6].text.length == null) {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter a Passport No");
                    //   FocusScope.of(context).requestFocus(fnode5);
                    // } else if (textEditingController[7].text == "" ||
                    //     textEditingController[7].text == null) {
                    //   AppData.showInSnackBar(context, "Please enter Aadhar No");
                    //   FocusScope.of(context).requestFocus(fnode6);
                    // } else if (textEditingController[8].text == "" ||
                    //     textEditingController[8].text == null) {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter Votor Card No");
                    // } else if (textEditingController[9].text == "" ||
                    //     textEditingController[9].text == null) {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter Licence No.");
                    // } else if (textEditingController[10].text == "" ||
                    //     textEditingController[10].text == null) {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter Licence Authority");
                    // } else if (textEditingController[11].text == "" ||
                    //     textEditingController[11].text == null) {
                    //   AppData.showInSnackBar(context, "Please enter Email");
                    // } else if (textEditingController[12].text == "" ||
                    //     textEditingController[12].text == null) {
                    //   AppData.showInSnackBar(context, "Please enter PinCode");
                    } else if (textEditingController[13].text == "" ||
                        textEditingController[13].text == null) {
                      AppData.showInSnackBar(context, "Please enter Mobile no");
                    } else if (textEditingController[14].text == "" ||
                        textEditingController[14].text == null) {
                      AppData.showInSnackBar(context, "Please enter Fname");
                    } else if (textEditingController[15].text == "" ||
                        textEditingController[15].text == null) {
                      AppData.showInSnackBar(context, "Please enter Lname");
                    } else if (textEditingController[16].text == "" ||
                        textEditingController[16].text == null) {
                      AppData.showInSnackBar(context, "Please enter gender");
                    } else if (ProfileScreen.countrymodel == null ||
                        ProfileScreen.countrymodel == "") {
                      AppData.showInSnackBar(context, "Please select Country");
                    } else if (ProfileScreen.statemodel == null ||
                        ProfileScreen.statemodel == "") {
                      AppData.showInSnackBar(context, "Please select State");
                    } else if (ProfileScreen.districtmodel == null ||
                        ProfileScreen.districtmodel == "") {
                      AppData.showInSnackBar(context, "Please select District");
                    } else if (ProfileScreen.citymodel == null ||
                        ProfileScreen.citymodel == "") {
                      AppData.showInSnackBar(context, "Please select City");
                    } else {
                      updateProfileModel.eCardNo =
                          patientProfileModel.body.eCardNo;
                      updateProfileModel.dob = textEditingController[0].text;
                      updateProfileModel.bloodGroup =
                          ProfileScreen?.bloodgroupmodel?.key ?? null;
                      updateProfileModel.maritialstatus =
                          ProfileScreen?.materialmodel?.key ?? null;
                      if (textEditingController[1].text != "") {
                        updateProfileModel.address =
                            textEditingController[1].text;
                      }
                      updateProfileModel.occupation =
                          textEditingController[2].text;
                      updateProfileModel.qualification =
                          textEditingController[3].text;
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
                      updateProfileModel.mobile = textEditingController[13].text;
                      updateProfileModel.fName = textEditingController[14].text;
                      updateProfileModel.lName = textEditingController[15].text;
                      updateProfileModel.gender = ProfileScreen.gendermodel.key;
                      updateProfileModel.countryid = ProfileScreen.countrymodel.key;
                      updateProfileModel.stateid = ProfileScreen.statemodel.key;
                      updateProfileModel.distid = ProfileScreen.districtmodel.key;
                      updateProfileModel.cityid = ProfileScreen.citymodel.key;
                      /*updateProfileModel.mobile = patientProfileModel.body.mobile;
                      updateProfileModel.fName = patientProfileModel.body.fName;
                      updateProfileModel.lName = patientProfileModel.body.lName;
                      updateProfileModel.gender = patientProfileModel.body.genderId;*/

                      log("Post json>>>>" + jsonEncode(updateProfileModel.toJson()));
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
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z . @]")),
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
 /* void _settingModalBottomSheet(context) {
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
                   // getImage(ImageSource.camera),

              getCameraImage(),
                        }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
          Navigator.pop(context),
         // getImage(ImageSource.gallery),

         getGalleryImage(),
                  },
                ),
              ],
            ),
          );
        });
  }*/

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
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                      //getCameraImage(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: (){
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                    //_openImage();
                    // _loadPicker(ImageSource.camera);
                    //_buildOpenImage(),
                    /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cropimage()),
                  ),*/
                    //_sample == null ? _buildOpeningImage() : _buildCroppingImage(),
                    //_buildCroppingImage(),
                    // getGalleryImage(),
                    //_openImage(),
                    //_cropImage(),
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
    ProfileScreen.relationmodel = null;

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
                        formField1(13, "Name"),
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
                    if (textEditingController[13].text == null ||
                        textEditingController[13].text == "") {
                      AppData.showInSnackBar(context, "Please enter Name");
                    } else if (textEditingController[13].text != "" &&
                        textEditingController[13].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter a valid First Name");
                    } else if (ProfileScreen.relationmodel == "" ||
                        ProfileScreen.relationmodel == null) {
                      AppData.showInSnackBar(
                          context, "Please Select Relation ");
                    } else if (textEditingController[14].text == "" ||
                        textEditingController[14].text == null) {
                      AppData.showInSnackBar(
                          context, "Please enter  Mobile No.");
                    } else if (textEditingController[14] != "" &&
                        textEditingController[14].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid  Mobile No.");
                    } else {
                      UpdateEmergencyModel updateEmergencyModel =
                          UpdateEmergencyModel();
                      updateEmergencyModel.name =
                          textEditingController[13].text;
                      updateEmergencyModel.mobile =
                          textEditingController[14].text;
                      updateEmergencyModel.userid = widget.model.user;
                      updateEmergencyModel.relation =
                          ProfileScreen.relationmodel.key;
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

  void EmergencydisplayDialog(
      BuildContext context, patientProfileModel, int index) {
    //_date.text = "";
    textEditingController[13].text =
        patientProfileModel?.body?.emergenceList[index].name ?? "";
    textEditingController[14].text =
        patientProfileModel?.body?.emergenceList[index].mobile ?? "";
    if (patientProfileModel?.body?.emergenceList[index].type == null ||
        patientProfileModel.body.emergenceList[index].type == "") {
      ProfileScreen.relationmodel = null;
    } else {
      ProfileScreen.relationmodel = KeyvalueModel(
          key: patientProfileModel.body.emergenceList[index].typeid,
          name: patientProfileModel.body.emergenceList[index].type);
    }
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
                                child: Text(MyLocalizations.of(context).text("UPDATE_EMERGENCY_CONTACT"),
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
                        formField1(13, MyLocalizations.of(context).text("NAME")),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                            MyLocalizations.of(context).text("RELATION"),
                            ApiFactory.RELATION_API,
                            "rln",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.RELATION_API);
                            ProfileScreen.relationmodel = data;
                            ProfileScreen.relationmodel = data.key;
                          });
                        }),
                        SizedBox(height: 8),
                        mobileformField1(14, MyLocalizations.of(context).text("MOBILE_NO")),
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
                    if (textEditingController[13].text == null ||
                        textEditingController[13].text == "") {
                      AppData.showInSnackBar(context, "Please enter Name");
                    } else if (textEditingController[13].text != "" &&
                        textEditingController[13].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter a valid  Name");
                    } else if (ProfileScreen.relationmodel == "" ||
                        ProfileScreen.relationmodel == null) {
                      AppData.showInSnackBar(
                          context, "Please Select Relation ");
                    } else if (textEditingController[14].text == "" ||
                        textEditingController[14].text == null) {
                      AppData.showInSnackBar(
                          context, "Please enter Emergency Mobile No.");
                    } else if (textEditingController[14] != "" &&
                        textEditingController[14].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Emergency Mobile No.");
                    } else {
                      UpdateEmergencyModel updateEmergencyModel =
                          UpdateEmergencyModel();
                      updateEmergencyModel.name =
                          textEditingController[13].text;
                      updateEmergencyModel.mobile =
                          textEditingController[14].text;
                      updateEmergencyModel.id =
                          patientProfileModel?.body?.emergenceList[index].id;
                      updateEmergencyModel.userid = widget.model.user;
                      updateEmergencyModel.relation =
                          ProfileScreen.relationmodel.key;
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
                              //  Navigator.pop(context);
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
    textEditingController[15].text = "";
    textEditingController[16].text = "";
    ProfileScreen.specialitymodel = null;

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
                                child: Text(MyLocalizations.of(context).text("ADD_FAMILY_DOCTORS_NAME"),
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
                        formField1(15, MyLocalizations.of(context).text("NAME")),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                            MyLocalizations.of(context).text("SPECIALITY"),
                            ApiFactory.SPECIALITY_API,
                            "speciality",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel model) {
                          setState(() {
                            ProfileScreen.specialitymodel = model;
                            patientProfileModel.body.specialityId = model.key;
                            patientProfileModel.body.speciality = model.name;
                          });
                        }),
                        SizedBox(height: 8),
                        mobileformField1(16,   MyLocalizations.of(context).text("MOBILE_NO")),
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
                    if (textEditingController[15].text == null ||
                        textEditingController[15].text == "") {
                      AppData.showInSnackBar(context, "Please enter Name");
                    } else if (textEditingController[15].text != "" &&
                        textEditingController[15].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter a valid  Name");
                    } else if (ProfileScreen.specialitymodel == "" ||
                        ProfileScreen.specialitymodel == null) {
                      AppData.showInSnackBar(
                          context, "Please Select Speciallity ");
                    } else if (textEditingController[16].text == "" ||
                        textEditingController[16].text == null) {
                      AppData.showInSnackBar(
                          context, "Please enter  Mobile No.");
                    } else if (textEditingController[16] != "" &&
                        textEditingController[16].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Mobile No.");
                    } else {
                      FamilyDoctorModel familydoctormodel = FamilyDoctorModel();
                      familydoctormodel.name = textEditingController[15].text;
                      familydoctormodel.mobile = textEditingController[16].text;
                      familydoctormodel.userid = widget.model.user;
                      familydoctormodel.type =
                          ProfileScreen.specialitymodel.key;
                      log("Value json>>" +
                          familydoctormodel.toJson().toString());
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.UPDATE_DOCTOR_CONTACT,
                          json: familydoctormodel.toJson(),
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

  void displayDialog3(BuildContext context) {
    //_date.text = "";

    textEditingController[19].text = "";

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
                      //  mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(MyLocalizations.of(context).text("ADD_FAMILY_DETAILS") ,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                controller: textEditingController[19],
                                maxLength: 16,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'UHID NO ',
                                  counterText: "",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
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
                  MyLocalizations.of(context).text("SEARCH"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  setState(() {
                    if (textEditingController[19].text == null ||
                        textEditingController[19].text == "") {
                      AppData.showInSnackBar(context, "Please enter UHID no");
                    } else {
                      MyWidgets.showLoading(context);
                      widget.model.GETMETHODCALL_TOKEN(
                          api: ApiFactory.UHID_LIST +
                              textEditingController[19].text,
                          token: widget.model.token,
                          fun: (Map<String, dynamic> map) {
                            Navigator.pop(context);
                            setState(() {
                              String msg = map[Const.MESSAGE];
                              if (map["code"] == Const.SUCCESS) {
                                setState(() {
                                  // isdata = false;
                                  userfamilydetails =
                                      UserFamilyDetailsModel.fromJson(map);
                                  Navigator.pop(context);
                                  display(context, userfamilydetails);
                                });
                                // appointModel = lab.LabBookModel.fromJson(map);
                              } else {
                                // isdata = false;
                                // isDataNotAvail = true;
                                AppData.showInSnackBar(context, msg);
                              }
                            });
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
            WhitelistingTextInputFormatter(RegExp("[a-z A-Z.]")),
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

  Widget uhidformField1(
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
          maxLength: 16,
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
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 -]")),
              ],
              //maxLength: 10,
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

  void doctordisplayDialog(
      BuildContext context, ProfileModel patientProfileModel, int index) {
    textEditingController[15].text =
        patientProfileModel?.body?.familyDoctorList[index].name ?? "";
    textEditingController[16].text =
        patientProfileModel?.body?.familyDoctorList[index].mobile ?? "";
    if (patientProfileModel?.body?.familyDoctorList[0].type == null ||
        patientProfileModel.body.familyDoctorList[0].type == "") {
      ProfileScreen.specialitymodel = null;
    } else {
      ProfileScreen.specialitymodel = KeyvalueModel(
          key: patientProfileModel.body.familyDoctorList[index].typeid,
          name: patientProfileModel.body.familyDoctorList[index].type);
    }
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
                                child: Text(MyLocalizations.of(context).text("UPDATE_FAMILY_DOCTORS_NAME"),
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
                        formField1(15, MyLocalizations.of(context).text("NAME")),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                        MyLocalizations.of(context).text("SPECIALITY"),
                            ApiFactory.SPECIALITY_API,
                            "spl",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel model) {
                          setState(() {
                            ProfileScreen.specialitymodel = model;
                            patientProfileModel.body.specialityId = model.key;
                            patientProfileModel.body.speciality = model.name;
                          });
                        }),
                        SizedBox(height: 8),
                        mobileformField1(16, MyLocalizations.of(context).text("MOBILE_NO")),
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
                    if (textEditingController[15].text == null ||
                        textEditingController[15].text == "") {
                      AppData.showInSnackBar(context, "Please enter Name");
                    } else if (textEditingController[15].text != "" &&
                        textEditingController[15].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter a valid  Name");
                    } else if (ProfileScreen.specialitymodel == "" ||
                        ProfileScreen.specialitymodel == null) {
                      AppData.showInSnackBar(
                          context, "Please Select Speciallity ");
                    } else if (textEditingController[16].text == "" ||
                        textEditingController[16].text == null) {
                      AppData.showInSnackBar(
                          context, "Please enter  Mobile No.");
                    } else if (textEditingController[16] != "" &&
                        textEditingController[16].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid  Mobile No.");
                    } else {
                      FamilyDoctorModel familydoctormodel = FamilyDoctorModel();
                      familydoctormodel.name = textEditingController[15].text;
                      familydoctormodel.mobile = textEditingController[16].text;
                      familydoctormodel.userid = widget.model.user;
                      familydoctormodel.type =
                          ProfileScreen.specialitymodel.key;
                      familydoctormodel.id =
                          patientProfileModel?.body?.familyDoctorList[index].id;

                      log("Value json>>" +
                          familydoctormodel.toJson().toString());
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.UPDATE_DOCTOR_CONTACT,
                          json: familydoctormodel.toJson(),
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

  void familydetailsdisplayDialog(BuildContext context, ProfileModel patientProfileModel, int index) {
    if (patientProfileModel?.body?.familyDetailsList[index].relation == null ||
        patientProfileModel.body.familyDetailsList[index].relation == "") {
      ProfileScreen.relationmodel = null;
    } else {
      ProfileScreen.relationmodel = KeyvalueModel(
          key: patientProfileModel.body.familyDetailsList[index].relid,
          name: patientProfileModel.body.familyDetailsList[index].relation);
    }

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
                                child: Text(MyLocalizations.of(context).text("UPDATE_FAMILY_DETAILS"),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              border: Border.all(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:12.00,left: 8,right: 8,bottom: 10),
                              child: Text(
                                patientProfileModel.body.familyDetailsList[index].userid,style: TextStyle(color:Colors.white),
                              ),
                            ), //////
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              border: Border.all(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:12.00,left: 8,right: 8,bottom: 10),
                              child: Text(
                                patientProfileModel.body.familyDetailsList[index].memeberName,style: TextStyle(color:Colors.white),
                              ),
                            ), //////
                          ),
                        ),

                        //SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              border: Border.all(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:12.00,left: 8,right: 8,bottom: 10),
                              child: Text(
                                patientProfileModel
                                    .body.familyDetailsList[index].age,style: TextStyle(color:Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        DropDown.networkDropdownGetpartUser1(
                            "Relation",
                            ApiFactory.RELATION_API,
                            "rlnn",
                            Icons.people_alt_rounded,
                            23.0, (KeyvalueModel model) {
                          setState(() {
                            ProfileScreen.relationmodel = model;
                            patientProfileModel.body.eRelationId = model.key;
                            patientProfileModel.body.eRelation = model.name;
                          });
                        }),
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
                  // setState(() {
                  if (ProfileScreen.relationmodel == "" ||
                      ProfileScreen.relationmodel == null) {
                    AppData.showInSnackBar(context, "Please Select Relation ");
                  } else {
                    AddUserFamilyDetailsModel Addfamilydetailsmodel =
                        AddUserFamilyDetailsModel();
                    Addfamilydetailsmodel.userid = widget.model.user;
                    Addfamilydetailsmodel.memberid = patientProfileModel
                        .body.familyDetailsList[index].userid;
                    Addfamilydetailsmodel.famid =
                        patientProfileModel.body.familyDetailsList[index].famid;
                    Addfamilydetailsmodel.relation =
                        ProfileScreen.relationmodel.key;
                    log("Value json>>" +
                        Addfamilydetailsmodel.toJson().toString());
                    MyWidgets.showLoading(context);
                    widget.model.POSTMETHOD_TOKEN(
                        api: ApiFactory.UPDATE_FAMILY_CONTACT,
                        json: Addfamilydetailsmodel.toJson(),
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          Navigator.pop(context);

                          if (map[Const.STATUS1] == Const.SUCCESS) {
                            Navigator.pop(context);
                            // popup(context, map[Const.MESSAGE]);
                            callApi();
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);
                            Navigator.pop(context);
                          } else {
                            // AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
                  }
                  // });
                },
              ),
            ],
          );
        },
        context: context);
  }

  void display(BuildContext context, UserFamilyDetailsModel userfamilydetails) {
    // userfamilydetails.body.code="";
    //userfamilydetails.body.name="";
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
                                  "Add Family Detail's Name",
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                userfamilydetails.body.name,
                              ),
                            ),
                          ),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                userfamilydetails.body.code,
                              ),
                            ),
                          ),
                        ),
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
                    if (ProfileScreen.relationmodel == "" ||
                        ProfileScreen.relationmodel == null) {
                      AppData.showInSnackBar(
                          context, "Please Select Relation ");
                    } else {
                      AddUserFamilyDetailsModel Addfamilydetailsmodel =
                          AddUserFamilyDetailsModel();
                      Addfamilydetailsmodel.userid = widget.model.user;
                      Addfamilydetailsmodel.memberid =
                          userfamilydetails.body.key;
                      Addfamilydetailsmodel.famid = null;
                      Addfamilydetailsmodel.relation =
                          ProfileScreen.relationmodel.key;
                      log("Value json>>" +
                          Addfamilydetailsmodel.toJson().toString());
                      MyWidgets.showLoading(context);
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.UPDATE_FAMILY_CONTACT,
                          json: Addfamilydetailsmodel.toJson(),
                          token: widget.model.token,
                          fun: (Map<String, dynamic> map) {
                            Navigator.pop(context);
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

  void deletefamilydetailsdisplayDialog(BuildContext context, ProfileModel patientProfileModel, int index) {

    // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("No",style: TextStyle(color: AppData.kPrimaryRedColor)),
        onPressed:  () {
          Navigator.pop(context);
        },
      );
      Widget continueButton = TextButton(
        child: Text("Yes"),
        onPressed:  () {
          Navigator.pop(context);
          String listid = patientProfileModel.body.familyDetailsList[index].famid;
          String familydetails="3";

          FamilyDeleteApi(listid,familydetails);

        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Delete"),
        content: Text("Do You Want to Delete ?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

  void FamilyDeleteApi(String listid, String familydetails) {
            MyWidgets.showLoading(context);
            widget.model.DELETEMETHODCALL_TOKEN(
                api: ApiFactory.Delete_profile_CONTACT + listid+"&type="+familydetails,
                token: widget.model.token,
                fun: (Map<String, dynamic> map) {
                  Navigator.pop(context);
                  setState(() {
                    String msg = map[Const.MESSAGE];
                    if (map["status"] == Const.SUCCESS) {
                      callApi();
                      AppData.showInSnackDone(context, map[Const.MESSAGE]);
                    } else {
                      AppData.showInSnackBar(context, msg);
                    }
                  });

                });
  }

  void deletedoctordetailsdisplayDialog(BuildContext context, ProfileModel patientProfileModel, int index) {
    Widget cancelButton = TextButton(
      child: Text("No",style: TextStyle(color: AppData.kPrimaryRedColor)),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.pop(context);
        String listid = patientProfileModel.body.familyDoctorList[index].id;
        String famdoctor="2";

        FamilydoctorDeleteApi(listid,famdoctor);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Do You Want to Delete ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void FamilydoctorDeleteApi(String listid, String famdoctor) {
    MyWidgets.showLoading(context);
    widget.model.DELETEMETHODCALL_TOKEN(
        api: ApiFactory.Delete_profile_CONTACT + listid+"&type="+famdoctor,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map["status"] == Const.SUCCESS) {
             callApi();
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, msg);
            }
          });

        });
  }

  void emergencydetailsdisplayDialog(BuildContext context, ProfileModel patientProfileModel, int index) {
    Widget cancelButton = TextButton(
      child: Text("No",style: TextStyle(color: AppData.kPrimaryRedColor)),

      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.pop(context);
        String listid = patientProfileModel.body.emergenceList[index].id;
        String emergency="1";

        emergencydoctorDeleteApi(listid,emergency);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Do You Want to Delete ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void emergencydoctorDeleteApi(String listid, String emergency) {

    MyWidgets.showLoading(context);
    widget.model.DELETEMETHODCALL_TOKEN(
        api: ApiFactory.Delete_profile_CONTACT + listid+"&type="+emergency,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map["status"] == Const.SUCCESS) {
              callApi();
              AppData.showInSnackDone(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, msg);
            }
          });

        });
  }

  getImage(ImageSource source) async {
    this.setState((){
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if(image != null){
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            // textAlign: TextAlign.center,
            toolbarColor: AppData.kPrimaryColor,
            toolbarTitle: "Image Cropper",
            toolbarWidgetColor: Colors.white,
            //centerTitle: true,
            //toolbar.setTitleTextColor(Color.RED);
            ///statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          )
      );
      if (cropped != null) {
        var enc = await cropped.readAsBytes();
        String _path = image.path;
        setState(() => pathUsr = cropped);

        String _fileName = _path != null ? _path.split('/').last : '...';
        var pos = _fileName.lastIndexOf('.');
        String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
        print(extName);
        print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
        setState(() {
          pathUsr = cropped;
          _inProcess = false;

          // callApii();
          // widget.model.patientimg =base64Encode(enc);
          //widget.model.patientimgtype =extName;
          //updateProfileModel.profileImage = base64Encode(enc) as List<Null>;
          //updateProfileModel.profileImageType = extName;
          updateProfile(base64Encode(enc), extName);
        });
      }
      /*this.setState((){
        pathUsr = cropped;
        //updateProfile(base64Encode(cropped), extName);
        _inProcess = false;
      });*/
    } else {
      this.setState((){
        _inProcess = false;
      });
    }
  }


}
