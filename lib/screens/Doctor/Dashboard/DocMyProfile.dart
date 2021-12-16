import 'dart:convert';
import 'dart:developer';
// import 'dart:html';
import 'dart:typed_data';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/ProfileModel1.dart';
import 'package:user/models/UpdateDocProfileModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/providers/text_field_container.dart';
import 'package:flutter/rendering.dart';


import 'package:user/scoped-models/MainModel.dart';
import 'package:user/models/PatientListModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/TextFormatter.dart';
import 'package:user/widgets/signature.dart';

class DocMyProfile extends StatefulWidget {
  MainModel model;
  static KeyvalueModel gendermodel = null;

  DocMyProfile({Key key, this.model}) : super(key: key);

  @override
  _DocMyProfileState createState() => _DocMyProfileState();
}

class _DocMyProfileState extends State<DocMyProfile> {

  String loAd = "Loading..";
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  //Body model;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  ProfileModel1 profileModel1;
  List<bool> error = [false, false, false, false, false, false];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  final df = new DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();
  UpdateDocProfileModel updateProfileModel = UpdateDocProfileModel();

  bool selectGallery = false;

  var image;
  var pngBytes;
  //File _imageSign;

  final _sign = GlobalKey<Signature1State>();

  String signImg, signExt, signBase64;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
    //model = widget.model.model;
  }

  static final List colors = [
  Colors.black,
  Colors.purple,
  Colors.green,
  ];
  static final List lineWidths = [3.0, 5.0, 8.0];
  // File imageFile;
  int selectedLine = 0;
  Color selectedColor = colors[0];

  int curFrame = 0;
  bool isClear = false;
  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.USER_PROFILE + loginResponse.body.user,
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              profileModel1 = ProfileModel1.fromJson(map);

              if (profileModel1?.body?.gender != null) {
                DocMyProfile.gendermodel = KeyvalueModel(
                     key: profileModel1.body.gender,
                    name: profileModel1.body.gendername);
              } else {
                DocMyProfile.gendermodel = null;
              }
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  getGender(String gender) {
    switch (gender) {
      case "1":
        return "Male";
        break;
      case "2":
        return "Female";
        break;
      case "3":
        return "Other";
        break;
    }
  }
  List<KeyvalueModel> genderList = [
    KeyvalueModel(key: "1", name: "Male"),
    KeyvalueModel(key: "2", name: "Female"),
    KeyvalueModel(key: "3", name: "Other"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
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
                  MyLocalizations.of(context).text("MY_PROFILE"),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //Spacer(),
                 Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: InkWell(
                    onTap: () {
                     // _displayTextInputDialog(context);
                      if (profileModel1 != null) {
                        _displayTextInputDialog(context);
                      } else {
                        AppData.showInSnackBar(context,"Please wait until we are fetching your data");
                      }
                    },
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
              /*Align(
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
              ),*/
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
        /*appBar: AppBar(
          title: Text("User Profile"),
          titleSpacing: 2,
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),*/
        body: (profileModel1 != null)
            ? Container(
                height: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: AppData.matruColor.withOpacity(0.7),
                            ),
                          ),
                          _buildHeader(context)
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                         MyLocalizations.of(context).text("USER_INFORMATION").toUpperCase(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.calendar_today),
                                        title: Text(MyLocalizations.of(context).text("DOB1").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1.body.birthdate ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.wc),
                                        title: Text(MyLocalizations.of(context).text("GENDER").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1.body.gendername ?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.call),
                                        title: Text("Mobile No.".toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1.body.mobile ??
                                            "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.call),
                                        title: Text("Email.".toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1.body.email?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.bloodtype_outlined),
                                        title: Text("bloodgroup".toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.bldGrname?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text("Address".toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.address?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text("country".toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.countryName?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text("state".toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.stateName?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text("district".toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.districtName?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text("city".toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.cityName?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.book),
                                        title: Text(MyLocalizations.of(context).text("EDUCATION").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.education ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.work_outlined),
                                        title: Text(MyLocalizations.of(context).text("SPECIALITY").toUpperCase(),),
                                        subtitle: Text(
                                            profileModel1.body.speciality ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.home_work_sharp),
                                        title: Text(MyLocalizations.of(context).text("ORGANIZATION").toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1.body.organization ??
                                            "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.work_outlined),
                                        title: Text("Experience".toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1.body.experience ??
                                            "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.contact_phone),
                                        title: Text(MyLocalizations.of(context).text("IMA_NO").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1.body.imano ?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("PAN_CARD_NO").toUpperCase(),
                                        ),
                                        subtitle:
                                            Text(profileModel1.body.pancardno),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("PASSPORT_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.passportno ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("VOTER_CARD_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.votercardno ??
                                                "N/A"),
                                      ),

                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("LICENCE_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.licenceno ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text("License authority".toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.licenseauthority ??
                                                "N/A"),
                                      ),

                                      InkWell(
                                        onTap: () {
                                        //  _displayTextInputDialog(context);
                                          openSignaturePage();


                                        },
                                      child:ListTile(
                                        leading:Icon(Icons.satellite_outlined),
                                        title:Text("Digital Signature".toUpperCase(),
                                        ),
                                        /*subtitle: Text(
                                            profileModel1.body.address+profileModel1.body.address1?? "N/A"),*/
                                          trailing:Icon(Icons.edit),
                                      ),

                                      ),
                                    ],
                                  ),

                                  Container(
                                    width: 100,
                                    height: 70,
                                    child: profileModel1.body.digsign!= null
                                        ? Image.network(
                                      profileModel1.body.digsign,
                                      height: 80.0,
                                    )
                                        : null,
                                  ),

                                ],

                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        height: 13,
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(
                  loAd,
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
              ));
  }
  Future<void> _displayTextInputDialog(BuildContext context) async {

    textEditingController[0].text = toDate(profileModel1.body.birthdate)??"";
    textEditingController[1].text =  profileModel1.body.education ??"";
    textEditingController[2].text =  profileModel1.body.imano ?? "";
    textEditingController[3].text = profileModel1.body.aadhaar ?? "";
    textEditingController[4].text = profileModel1.body.passportno ??"";
    textEditingController[5].text = profileModel1.body.votercardno ?? "";
    textEditingController[6].text = profileModel1.body.licenceno ??"";
    textEditingController[7].text = profileModel1.body.pancardno ?? "";



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
                            height: 10,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                   "Gender",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                gender(),

                              ]),

                          SizedBox(
                            height: 10,
                          ),
                          formFieldEducation(
                              1,
                              "Education Name",
                              fnode1,
                              fnode2),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldMobileno(
                              2,
                             "IMA No",
                              fnode2,
                              fnode3),

                          SizedBox(
                            height: 10,
                          ),
                          formFieldAadhaaerno(
                              3,
                              "Aadhaar No",
                              fnode3,
                              fnode4),
                          SizedBox(
                            height: 10,
                          ),

                          formFieldPassPortno(
                              4,"Passport No",
                              fnode4,
                              fnode5),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldPassPortno(
                              5,
                              "Voter Card No",
                              fnode5,
                              fnode6),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldPassPortno(
                              6,
                              "Licenece No",
                              fnode6,
                              fnode7),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldPassPortno(
                              7,"Pan No",
                              fnode7,
                              null),
                          SizedBox(
                            height: 10,
                          ),
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
                    //callApi();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(MyLocalizations.of(context).text("UPDATE")),

                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {

                 /*   if (textEditingController[0].text == "N/A" ||
                        textEditingController[0].text == null ||
                        textEditingController[0].text == "") {

                      AppData.showInSnackBar(context, "Please enter DOB");*/
                 bool isAllBlank = true;
                 textEditingController.forEach((element) {
          if (element.text != "") isAllBlank = false;
          });if (isAllBlank) {
          //AppData.showInSnackBar(context, "Please select Smoking");
          AppData.showInSnackBar(
          context, "Please Fill Up Atleast One Field ");


          /*} else if (textEditingController[1].text == "N/A" ||
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
                      FocusScope.of(context).requestFocus(fnode5);*/
                    } else {
                      updateProfileModel.dctrid = loginResponse.body.user;
                      updateProfileModel.dob = textEditingController[0].text;
                      updateProfileModel.gender = DocMyProfile.gendermodel.key;
                      updateProfileModel.educationid = textEditingController[1].text;
                      updateProfileModel.imaNo = textEditingController[2].text;
                      //Emergency
                      updateProfileModel.adhaarNo = textEditingController[3].text;
                      updateProfileModel.passportNo = textEditingController[4].text;
                      updateProfileModel.votterId = textEditingController[5].text;

                      updateProfileModel.liceneceNo = textEditingController[6].text;
                      updateProfileModel.panNo = textEditingController[7].text;
                      log("Post json2>>>>" + jsonEncode(updateProfileModel.toJson()));
                      log("Post api>>>>" +ApiFactory.UPDATE_DOCTER_PROFILE);
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.UPDATE_DOCTER_PROFILE,
                          json: updateProfileModel.toJson(),
                          token: widget.model.token,
                          fun: (Map<String, dynamic> map) {
                            Navigator.pop(context);
                            if (map[Const.STATUS] == Const.SUCCESS) {
                              // popup(context, map[Const.MESSAGE]);
                              print("Post json>>>>"+jsonEncode(updateProfileModel.toJson()));
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);

                              callAPI();
                            } else {
                              AppData.showInSnackBar(context, map[Const.MESSAGE]);
                              callAPI();
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





  openSignaturePage() async {
    Size size = MediaQuery.of(context).size;

    var color = Colors.black;
    var strokeWidth = 3.0;
    print("signature");
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 290,
                child: SizedBox.expand(
                    child: Signature1(
                      color: color,
                      key: _sign,
                      strokeWidth: strokeWidth,
                    )),
                margin: EdgeInsets.only(bottom: 40, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned(
              top: size.height / 1.65,
              left: 12,
              right: 12,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text("Clear"),
                          onPressed: () {
                            _sign.currentState.clear();
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          child: Text("Save"),
                          onPressed: () {
                            var img = _sign.currentState.getData();
                            print(img);
                            setRenderedImage(context);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );

  }

  setRenderedImage(BuildContext context) async {
    ui.Image renderedImage = await _sign.currentState.getData();

    setState(() {
      image = renderedImage;
      print(image);
    });

    showImage(context);
  }

  Future<Null> showImage(BuildContext context) async {
    pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    ByteData data = pngBytes;
    var list = data.buffer.asUint8List();
   /* String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);*/
    String extName  = "png";
    signBase64 = base64.encode(list);
    updateProfile(base64Encode(list), extName);
    /*registrationModel.signUploadBase64 = signBase64;
    registrationModel.signUploadExt = "png";
*/
    //log(">>>>" + base);
    setState(() {

      selectGallery = false;
    });
  }


  updateProfile(String image, String ext) {
    MyWidgets.showLoading(context);
    var value = {
      "digSignType": ext,
      "digSign": [image],
      "dctrid": loginResponse.body.user
    };

    log("Post data>>\n\n" + jsonEncode(value));
    widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.OTHER_PROFILE_SIGN,
        token: widget.model.token,
        json: value,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              AppData.showInSnackDone(context, msg);
              callAPI();
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
              callAPI();
            }
          });
        });
  }
 /* Future getSignatureImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var enc = await image.readAsBytes();

    print(
        "size>>>" + AppData.formatBytes(enc.length, 0).split('')[1].toString());
    var ext = AppData.formatBytes(enc.length, 0).split(' ')[1];
    int size = int.parse(AppData.formatBytes(enc.length, 0).split(' ')[0]);
    int requiredSize = int.parse(AppData.formatBytes(15000, 0).split(' ')[0]);

    if (ext == "KB" && size <= requiredSize) {
      var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      print(decodedImage.width);
      print(decodedImage.height);
      setState(() {
        _imageSignature = image;
        selectGallery = true;
        pngBytes = null;
        print('Image Path $_imageSignature');
      });
    } else {
      AppData.showToastMessage(
          MyLocalizations.of(context).text("SELECT_IMAGE_WITH_MAXIMUM_SIZE"),
          *//* "Please select image with maximum size 15 KB "*//* Colors.red);
      return;
    }
  }*/




  static String toDate(String date) {
    if (date != null && date != "") {
      DateTime formatter = new DateFormat("dd-MM-yyyy").parse(date);
      DateFormat toNeed = DateFormat("dd/MM/yyyy");
      final String formatted = toNeed.format(formatter);
      return formatted;
    } else {
      return "";
    }
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

        textEditingController[0].value = TextEditingValue(text: df.format(picked));
        //updateProfileModel.dob = df.format(picked);
      });
  }
  Widget gender() {
    return DropDown.staticDropdown4(
        "Gender", "gender1", genderList,
            (KeyvalueModel model) {
          DocMyProfile.gendermodel = model;
          profileModel1.body.gender = model.key;
          profileModel1.body.gendername = model.name;
        });
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
                    /*validator: (value) {
                      if (value.isEmpty) {
                        error[3] = true;
                        return null;
                      }
                      error[3] = false;
                      return null;
                    },*/
                    onFieldSubmitted: (value) {
                      //error[3] = false;
                      // print("error>>>" + error[2].toString());

                      setState(() {});
                      // AppData.fieldFocusChange(context, fnode4, fnode5);
                    },
                    decoration: InputDecoration(
                      hintText: //"Last Period Date",
                      "DOB",
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
  /*Widget IdNoFieldNew(String hint, bool enb, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
      child: TextFormField(
        autofocus: false,
        controller: textEditingController[controller],
        focusNode: currentfn,
        textInputAction: inputAct,
        //inputFormatters: [AppData.filtterInputType(format: "0-9")],
        inputFormatters: [
          UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
        ],
        decoration: InputDecoration(
          //prefixIcon: Icon(Icons.insert_drive_file_outlined),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          labelText: hint,
          alignLabelWithHint: false,
          //border: ,
          contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
        ),
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }*/
  Widget formFieldEducation(
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
                WhitelistingTextInputFormatter(
                  RegExp("[a-zA-Z0-9.]"),
                ),
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
  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 200.0,
      child: Stack(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: .0),
            width: double.maxFinite,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
                bottomLeft: const Radius.circular(15.0),
                bottomRight: const Radius.circular(15.0),
              ),
              /*image: DecorationImage(
                  image: AssetImage(
                    "assets/card.png",
                  ),
                  fit: BoxFit.fitWidth,
                ),*/
              /*gradient: LinearGradient(
                  colors: [AppData.matruColor, Colors.black54],
                ),*/
              color: AppData.matruColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*SizedBox(
                  height: 45.0,
                ),*/
                Text(
                  profileModel1.body.name ?? "N/A",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "AADHAAR NO" + ": " + profileModel1.body.aadhaar ?? "N/A",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(AppData.defaultImgUrl),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
