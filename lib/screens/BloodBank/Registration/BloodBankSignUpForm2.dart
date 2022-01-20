import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/PharamacistSignupModel.dart';
import 'package:user/models/PharmacyRegistrationModel.dart';
import 'package:user/models/UserRegistrationModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';

import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';

enum gender {
  Male,
  Female,
}

// ignore: must_be_immutable
class BloodBankSignUpForm2 extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel bloodgroupModel = null;
  static KeyvalueModel countryModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel citymodel = null;

  BloodBankSignUpForm2({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  BloodBankSignUpForm2State createState() => BloodBankSignUpForm2State();
}

class BloodBankSignUpForm2State extends State<BloodBankSignUpForm2> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  PharmacyRegistrationModel pharmaSignupModel = PharmacyRegistrationModel();

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
  ];
  String token;
  String user;
  String bloodbankorganisation;
  String bloodbanktitle;
  String bloodbankprofessional;
  String bloodbankexperience;
  String bloodbankspecialty;
  String bloodbankdob;
  String bloodbankbloodgrp;
  String bloodbankgender;
  String bloodbankaddress;
  String bloodbankcountryid;
  String bloodbankstateid;
  String bloodbankdistid;
  String bloodbankcityid;
  String bloodbankpincode;
  String bloodbankmobile;
  String bloodbankemail;
  String labalteremail;
  String labhomeph;
  String labofficeph;
  List<bool> error = [false, false, false, false, false, false];
  bool _isSignUpLoading = false;
  UserRegistrationModel userModel = UserRegistrationModel();
  String profilePath = null,
      idproof = null,
      labReport = null,
      helathCheckup = null;

  String profileBase64 = null,
      bankPathBase64 = null,
      adharPathBase64 = null,
      ageProofPathBase64 = null,
      expPathBase64 = null;
  final ImagePicker _picker = ImagePicker();

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();

  TextEditingController _email = TextEditingController();
  FocusNode emailFocus_ = FocusNode();

  List<bool> dropdownError = [false, false, false];
  var color = Colors.black;
  var strokeWidth = 3.0;
  File _imageCertificate;
  bool selectGallery = false;
  var image;
  var pngBytes;
  String selectDob;
  KeyvalueModel selectedKey = null;
  final df = new DateFormat('dd/MM/yyyy');
  bool ispartnercode = false;
  bool _checkbox = false;
  String useridd;
  String password;
  String msg;



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
      });
  }

  bool fromLogin = false;

  StreamSubscription _connectionChangeStream;
  bool isOnline = false;
  List<KeyvalueModel> BloodGroup = [
    KeyvalueModel(name: "A+", key: "1"),
    KeyvalueModel(name: "B+", key: "2"),
    KeyvalueModel(name: "O+", key: "3"),
    KeyvalueModel(name: "AB+", key: "4"),
    KeyvalueModel(name: "A-", key: "5"),
    KeyvalueModel(name: "B-", key: "6"),
    KeyvalueModel(name: "O-", key: "7"),
    KeyvalueModel(name: "AB-", key: "8"),
  ];
  List<KeyvalueModel> Gender = [
    KeyvalueModel(name: "Male", key: "0"),
    KeyvalueModel(name: "Female", key: "1"),
    KeyvalueModel(name: "Transgender", key: "2"),
  ];

  @override
  void initState() {
    super.initState();
    BloodBankSignUpForm2.countryModel = null;
    BloodBankSignUpForm2.stateModel = null;
    BloodBankSignUpForm2.citymodel = null;
    BloodBankSignUpForm2.districtModel = null;
    BloodBankSignUpForm2.blockModel = null;
    BloodBankSignUpForm2.genderModel = null;
    bloodbankorganisation = widget.model.bloodbankorganisation;
    bloodbanktitle = widget.model.bloodbanktitle;
    bloodbankprofessional = widget.model.bloodbankprofessional;
    bloodbankgender = widget.model.bloodbankgender;
    bloodbankaddress = widget.model.bloodbankaddress;
    bloodbankexperience = widget.model.bloodbankexperience;
    /*setState(() {
      masterClass = widget.model.masterDataResponse;
    });
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    setState(() {
      isOnline = connectionStatus.hasConnection;
    });*/
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text(MyLocalizations.of(context).text("SIGNUP")),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 60.0, right: 60.0),
                                child: Image.asset(
                                  "assets/logo1.png",
                                  fit: BoxFit.fitWidth,
                                  //width: ,
                                  height: 110.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _formKey,
                              autovalidate: _autovalidate,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text(
                                        MyLocalizations.of(context).text("FILL_IN_PERSONAL_INFORMATION"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  DropDown.networkDropdownGetpartUser(
                                      MyLocalizations.of(context).text("COUNTRY"),
                                      ApiFactory.COUNTRY_API,
                                      "country",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.COUNTRY_API);
                                      BloodBankSignUpForm2.countryModel = data;
                                      BloodBankSignUpForm2.stateModel = null;
                                    });
                                  }),
                                  DropDown.networkDropdownGetpartUser(
                                      MyLocalizations.of(context).text("STATE"),
                                      ApiFactory.STATE_API +
                                          (BloodBankSignUpForm2
                                                  ?.countryModel?.key ??
                                              ""),
                                      "state",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.STATE_API);
                                      BloodBankSignUpForm2.stateModel = data;
                                      BloodBankSignUpForm2.districtModel = null;
                                    });
                                  }),

                                  DropDown.networkDropdownGetpartUser(
                                      MyLocalizations.of(context).text("DIST"),
                                      ApiFactory.DISTRICT_API +
                                          (BloodBankSignUpForm2
                                                  ?.stateModel?.key ??
                                              ""),
                                      "district",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.DISTRICT_API);
                                      BloodBankSignUpForm2.districtModel = data;
                                      BloodBankSignUpForm2.citymodel = null;
                                    });
                                  }),

                                  DropDown.networkDropdownGetpartUser(
                                      MyLocalizations.of(context).text("CITY"),
                                      ApiFactory.CITY_API +
                                          (BloodBankSignUpForm2
                                                  ?.districtModel?.key ??
                                              ""),
                                      "city",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.CITY_API);
                                      BloodBankSignUpForm2.citymodel = data;
                                      // LabSignUpForm3.districtModel = null;
                                    });
                                  }),

                                  SizedBox(
                                    height: 8,
                                  ),
                                  formFieldzip(5,MyLocalizations.of(context).text("ENTER_ZIP_CODE"),
                                      fnode1,fnode2),
                                  SizedBox(
                                    height: 8,
                                  ),

                                  formFieldMobile(10,MyLocalizations.of(context).text("MOBILE_NO") ,fnode2,fnode3),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  formFieldEmail(11,MyLocalizations.of(context).text("EMAILID"),fnode3,null),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              MyLocalizations.of(context).text("UPLOAD_DOCUMENT"),
                                              style: TextStyle(
                                                  color: AppData.kPrimaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Material(
                                          elevation: 3,
                                          color: AppData.kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: MaterialButton(
                                            onPressed: () {
                                              _settingModalBottomSheet(context);
                                            },
                                            minWidth: 120,
                                            height: 40.0,
                                            child: Text(
                                              MyLocalizations.of(context).text("UPLOAD"),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  (idproof != null)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    "Report Path :" + idproof,
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                child: SizedBox(
                                                    width: 50.0,
                                                    child: Icon(Icons.clear)),
                                                onTap: () {
                                                  setState(() {
                                                    idproof = null;
                                                    // registrationModel.profilePhotoBase64 =
                                                    null;
                                                    //registrationModel.profilePhotoExt =
                                                    null;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      //  mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: _checkbox,
                                          onChanged: (value) {
                                            setState(() {
                                              _checkbox = !_checkbox;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: MyLocalizations.of(context).text("AGREE_EHEALTHSYSTEM"),
                                                    style: TextStyle(
                                                      fontFamily: "Monte",
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: MyLocalizations.of(context).text("T&C"),
                                                    style: TextStyle(
                                                      fontFamily: "Monte",
                                                      color: Colors.indigo,
                                                    ),
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.pushNamed(context, "/termsandConditionPage");
                                                          // AppData.showInSnackBar(context, "Please select Gender");
                                                        }
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: nextButton1(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*_
            ],
          ),
        ),
      ),
    );
  }*/
  // Widget gender() {
  //   return DropDown.searchDropdowntyp("Gender", "genderPartner", genderList,
  //           (KeyvalueModel model) {
  //         LabSignUpForm2.genderModel = model;
  //       });
  // }

  Widget mobileNoOTPSearch() {
    return Row(
      children: <Widget>[
        Expanded(
          //flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 0.0),
            child: Container(
              // padding: EdgeInsets.only(left: 2),
              height: 50.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 0.3)),
              // decoration: BoxDecoration(
              //     color: AppData.kPrimaryLightColor,
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(color: Colors.black, width: 0.3)),
              child: mobileNumber(),
            ),
          ),
        ),
      ],
    );
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    var enc = await image.readAsBytes();

    print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
    if (50000 < enc.length) {
      /*AppData.showToastMessage(
          "Please select image with maximum size 50 KB ", Colors.red);*/
      return;
    }

    setState(() {
      _image = image;

      print('Image Path $_image');
    });
  }

  Widget errorMsg(text) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget inputFieldContainer(child) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // decoration: BoxDecoration(
        //     // color: AppData.kPrimaryLightColor,
        //     borderRadius: BorderRadius.circular(29),
        //     border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }

  Widget fromField(int index, String hint, bool enb, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type) {
    // print(index);
    // print(currentfn);
    return TextFieldContainer(
      //color: error[index] ? Colors.red : AppData.kPrimaryLightColor,
      child: TextFormField(
        enabled: !enb,
        controller: textEditingController[index],
        focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          // ignore: deprecated_member_use
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value.isEmpty) {
            error[index] = true;
            return null;
          } else {
            error[index] = false;
            return null;
          }
        },
        onFieldSubmitted: (value) {
          print("ValueValue" + error[index].toString());

          setState(() {
            error[index] = false;
          });
          AppData.fieldFocusChange(context, currentfn, nextFn);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

  Widget nextButton1() {
    return MyWidgets.nextButton(
      text:MyLocalizations.of(context).text("SUBMIT").toUpperCase(),
      context: context,
      fun: () {
        if (BloodBankSignUpForm2.countryModel == null ||
            BloodBankSignUpForm2.countryModel == "") {
          AppData.showInSnackBar(context, "Please select Country");
        } else if (BloodBankSignUpForm2.stateModel == null ||
            BloodBankSignUpForm2.stateModel == "") {
          AppData.showInSnackBar(context, "Please select State");
        } else if (BloodBankSignUpForm2.districtModel == null ||
            BloodBankSignUpForm2.districtModel == "") {
          AppData.showInSnackBar(context, "Please select District");
        } else if (BloodBankSignUpForm2.citymodel == null ||
            BloodBankSignUpForm2.citymodel == "") {
          AppData.showInSnackBar(context, "Please select City");
        } else if (textEditingController[5].text == "" ||
            textEditingController[5].text == null) {
          AppData.showInSnackBar(context, "Please enter Zip/Pin Code");
        }else if (textEditingController[5].text != "" &&
            textEditingController[5].text.length != 6) {
          AppData.showInSnackBar(context, "Please enter a valid Zip/Pin Code ");
        } else if (textEditingController[10].text == "" ||
            textEditingController[10].text == null) {
          AppData.showInSnackBar(context, "Please enter Mobile Number");
        } else if (textEditingController[10].text != "" &&
            textEditingController[10].text.length != 10) {
          AppData.showInSnackBar(context, "Please enter a valid Mobile Number");
        } else if (textEditingController[11].text == "" ||
            textEditingController[11].text == null) {
          AppData.showInSnackBar(context, "Please enter Email Id");
        } else if (textEditingController[11].text != "" &&
            !AppData.isValidEmail(textEditingController[11].text)) {
          AppData.showInSnackBar(context, "Please enter a valid e-Mail");
        }else if (pharmaSignupModel.documentExt == null) {
          AppData.showInSnackBar(context, "Please Upload Document");
        }
        else if (_checkbox == false) {
          AppData.showInSnackBar(context, "Please check terms and Condition");
        } else {
          MyWidgets.showLoading(context);
          pharmaSignupModel.organizationid = bloodbankorganisation;
          pharmaSignupModel.titleid = bloodbanktitle;
          pharmaSignupModel.docname = bloodbankprofessional;
          pharmaSignupModel.experience = bloodbankexperience;
          pharmaSignupModel.gender = bloodbankgender;
          pharmaSignupModel.address = bloodbankaddress;
          // pharmaSignupModel.address = textEditingController[8].t Idext;
          pharmaSignupModel.countryid = BloodBankSignUpForm2.countryModel.key;
          pharmaSignupModel.stateid = BloodBankSignUpForm2.stateModel.key;
          pharmaSignupModel.districtid = BloodBankSignUpForm2.districtModel.key;
          pharmaSignupModel.cityid = BloodBankSignUpForm2.citymodel.key;
          pharmaSignupModel.pincode = textEditingController[5].text;
          //  pharmaSignupModel.homephone = textEditingController[4].text;
          //pharmaSignupModel.officephone = textEditingController[6].text;
          pharmaSignupModel.mobno = textEditingController[10].text;
          pharmaSignupModel.email = textEditingController[11].text;
          //pharmaSignupModel.alteremail = textEditingController[12].text;
          pharmaSignupModel.role = "13";
          pharmaSignupModel.speciality = "4";

          log(">>>>>>>>>>>>>>>>>>>>>>>>>>>"+ jsonEncode(pharmaSignupModel.toJson()));
          widget.model.POSTMETHOD(
              api: ApiFactory.PHARMACY_REGISTRATION,
              json: pharmaSignupModel.toJson(),
              fun: (Map<String, dynamic> map) {
                String msg = map["message"].toString();
                Navigator.pop(context);
                if (map[Const.STATUS] == Const.SUCCESS) {
                  setState(() {
                    useridd = map["body"]["key"];
                    password = map["body"]["name"];
                    log("Version>>>" + useridd + "<>>" + password);
                    popup(msg, context,password,useridd);
                  });
                  //popup(context, map[Const.MESSAGE]);
                } else {
                  AppData.showInSnackBar(context, map[Const.MESSAGE]);
                }
              });
          // AppData.showInSnackBar(context, "add Successfully");

        }
      },
    );
  }

  // popup(BuildContext context, String message) {
  //   return Alert(
  //       context: context,
  //       //title: "Success",
  //       title: message,
  //       desc: MyLocalizations.of(context).text("REG_SUCCESS_POPUP"),
  //       type: AlertType.success,
  //       //type: AlertType.info,
  //       onWillPopActive: true,
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             Icons.check_circle_outline_outlined,
  //             size: 140,
  //             color: Colors.green,
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //         ],
  //       ),
  //       closeIcon: Icon(
  //         Icons.info,
  //         color: Colors.transparent,
  //       ),
  //       closeFunction: () {},
  //       buttons: [
  //         DialogButton(
  //           child: Text(
  //             "OK",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //           onPressed: () {
  //             //   widget.model.patientName = null;
  //             Navigator.pop(context);
  //             widget.model.patientphnNo = null;
  //             widget.model.patientemail = null;
  //             widget.model.patientaadhar = null;
  //             widget.model.patientheight = null;
  //             widget.model.patientweight = null;
  //             widget.model.patientimg = null;
  //             widget.model.patientage = null;
  //             widget.model.patientgender = null;
  //             widget.model.patienCitycode = null;
  //             widget.model.patienCitykey = null;
  //             widget.model.patienStatecode = null;
  //             widget.model.patienStatekey = null;
  //             widget.model.patientimgtype = null;
  //             Navigator.of(context).pushNamedAndRemoveUntil(
  //                 "/login", (Route<dynamic> route) => false);
  //           },
  //           color: Color.fromRGBO(0, 179, 134, 1.0),
  //           radius: BorderRadius.circular(0.0),
  //         ),
  //       ]).show();
  // }

  popup(String msg, BuildContext context,String password,String useridd) {
    return Alert(
        context: context,
        //title: "Success",
        title: "Success",
        //type: AlertType.info,
        onWillPopActive: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              size: 140,
              color: Colors.green,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              msg,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            /*Text(
              "Mobile No. :"+mobile,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),*/
            SizedBox(
              height: 5,
            ),
            Text(
              "UserId:"+useridd,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),SizedBox(
              height: 5,
            ),
            Text(
              "Password is:"+password,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              //   widget.model.patientName = null;
              Navigator.pop(context);
              widget.model.patientphnNo = null;
              widget.model.patientemail = null;
              widget.model.patientaadhar = null;
              widget.model.patientheight = null;
              widget.model.patientweight = null;
              widget.model.patientimg = null;
              widget.model.patientage = null;
              widget.model.patientgender = null;
              widget.model.patienCitycode = null;
              widget.model.patienCitykey = null;
              widget.model.patienStatecode = null;
              widget.model.patienStatekey = null;
              widget.model.patientimgtype = null;
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/login", (Route<dynamic> route) => false);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }


  // Widget nextButton1() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, "/pharmasignupform4");
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       margin: EdgeInsets.only(left:180, right: 0),
  //       decoration: BoxDecoration(
  //           color: AppData.kPrimaryColor,
  //           borderRadius: BorderRadius.circular(10.0),
  //           gradient: LinearGradient(
  //               begin: Alignment.bottomRight,
  //               end: Alignment.topLeft,
  //               colors: [Colors.blue, AppData.kPrimaryColor])),
  //       child: Padding(
  //         padding:
  //         EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
  //         child: Text(
  //           MyLocalizations.of(context).text("SUBMIT"),
  //           textAlign: TextAlign.center,
  //           style: TextStyle(color: Colors.white, fontSize: 16.0),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.blue, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            MyLocalizations.of(context).text("SIGN_BTN"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget mobileNumber() {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 0.0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: AppData.kPrimaryLightColor,
        //   borderRadius: BorderRadius.circular(29),
        //   /*border: Border.all(
        //        color: Colors.black,width: 0.3)*/
        // ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButton<String>(
                // hint: Text("Select Device"),
                underline: Container(
                  color: Colors.grey,
                ),
                value: AppData.currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    AppData.currentSelectedValue = newValue;
                  });
                  print(AppData.currentSelectedValue);
                },
                items: AppData.phoneFormat.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 35.0,
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            new Expanded(
              child: TextFormField(
                enabled: widget.isConfirmPage ? false : true,
                controller: textEditingController[4],
                focusNode: fnode7,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText:
                      MyLocalizations.of(context).text("PHONE_NUMBER") + "*",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    error[4] = true;
                    return null;
                  }
                  error[4] = false;
                  return null;
                },
                onFieldSubmitted: (value) {
                  // print(error[2]);
                  error[4] = false;
                  setState(() {});
                  AppData.fieldFocusChange(context, fnode7, fnode8);
                },
                onSaved: (value) {
                  //userPersonalForm.phoneNumber = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dob() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => widget.isConfirmPage ? null : _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            //height: 45,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            alignment: Alignment.center,
            // width: size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 0.3,
                color: Colors.grey[800],
                // border: Border.all(color: Colors.black, width: 0.3)
              ),
            ),
            child: TextFormField(
              focusNode: fnode3,
              enabled: !widget.isConfirmPage ? false : true,
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
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: MyLocalizations.of(context).text("DATE_OF_BIRTH"),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                prefixIcon: Icon(
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

  Widget continueButton() {
    return InkWell(
      child: Center(
        child: CircleAvatar(
          radius: 20.0,
          //backgroundColor: Colors.amber.shade600,
          backgroundColor: AppData.kPrimaryColor,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        setState(() {});
        validate();
      },
    );
  }

  validate() async {
    _formKey.currentState.validate();

    if (error[0] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_FIRST_NAME"));
      FocusScope.of(context).requestFocus(fnode1);
    } else if (error[1] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_lAST_NAME"));
      FocusScope.of(context).requestFocus(fnode2);
    } else if (BloodBankSignUpForm2.genderModel == null ||
        BloodBankSignUpForm2.genderModel == "") {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_SELECT_GENDER"));
      FocusScope.of(context).requestFocus(fnode4);
    } else if (textEditingController[5].text == '') {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_AADHAAR_NUMBER"));
      FocusScope.of(context).requestFocus(fnode4);
    } else if (error[3] == true) {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_FATHER_NAME"));
      FocusScope.of(context).requestFocus(fnode6);
    } else if (error[2] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_DOB"));
      FocusScope.of(context).requestFocus(fnode3);
    } else if (error[4] == true) {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_PHONE_NUMBER"));
      FocusScope.of(context).requestFocus(fnode7);
    } else if (BloodBankSignUpForm2.districtModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT DISTRICT");
    } else if (BloodBankSignUpForm2.blockModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT BLOCK/ULB");
    } else {
      _formKey.currentState.save();

      if (isOnline) {
        setState(() {
          _isSignUpLoading = true;
        });
        await Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _isSignUpLoading = false;
          });
        });
      } else {
        AppData.showInSnackBar(context, "INTERNET_CONNECTION");
      }
    }
  }

  Widget mobileNumber1(int index, String hint, mobileModel) {
    return Container(
      margin:
          const EdgeInsets.only(top: 11.0, left: 8.0, right: 8.0, bottom: 0.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppData.matruColor, width: 3)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: AppData.currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    AppData.currentSelectedValue = newValue;
                  });
                  print(AppData.currentSelectedValue);
                },
                items: AppData.phoneFormat.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 35.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          new Expanded(
            child: TextFormField(
              // enabled: widget.isConfirmPage ? false : true,
              controller: textEditingController[index],
              cursorColor: AppData.matruColor,
              textInputAction: TextInputAction.done,
              maxLength: 10,
              style: TextStyle(fontSize: 13),
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  Icons.phone,
                  size: 19,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget formFieldaddress(
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
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          /* inputFormatters: [
            WhitelistingTextInputFormatter(
                RegExp("[a-zA-Z ]")),
          ],*/
        ),
      ),
    );
  }

  Widget formField(
    int index,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
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
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 17),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }

  Widget formFieldzip(
      int index,
      String hint,FocusNode currentfn, FocusNode nextFn,
      ) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
      const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.black,width: 0.3)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  enabled: widget.isConfirmPage ? false : true,
                  controller: textEditingController[index],
                  focusNode: currentfn,
                  cursorColor: AppData.kPrimaryColor,
                  textInputAction: TextInputAction.next,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(
                        RegExp("[0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    counterText: "",
                    hintText:hint,
                    hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
                  ),

                  onFieldSubmitted: (value) {
                    // print(error[2]);
                    error[4] = false;
                    setState(() {});
                    AppData.fieldFocusChange(context, currentfn, nextFn);
                  },
                  onSaved: (value) {
                    //userPersonalForm.phoneNumber = value;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget formFieldEmail(
      int index,
      String hint,FocusNode currentfn, FocusNode nextFn,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            textInputAction: TextInputAction.next,
            focusNode: currentfn,
            keyboardType: TextInputType.text,
            controller: textEditingController[index],

            onFieldSubmitted: (value) {
              // print(error[2]);
              error[4] = false;
              setState(() {});
              AppData.fieldFocusChange(context, currentfn, nextFn);
            },
            /* textAlignVertical:
            TextAlignVertical.center,*/
            /*inputFormatters: [
              WhitelistingTextInputFormatter(
                  RegExp("[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]")),
            ],*/
          ),
        ),
      ),
    );
  }



  Widget formFieldMobile(
      int index,
      String hint,FocusNode currentfn, FocusNode nextFn
      ) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
      const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.black, width: 0.3)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  enabled: widget.isConfirmPage ? false : true,
                  controller: textEditingController[index],
                  focusNode: currentfn,
                  cursorColor: AppData.kPrimaryColor,
                  textInputAction: TextInputAction.next,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(
                        RegExp("[0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    counterText: "",
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: AppData.hintColor, fontSize: 15),
                  ),

                  onFieldSubmitted: (value) {
                    // print(error[2]);
                    error[4] = false;
                    setState(() {});
                    AppData.fieldFocusChange(context, currentfn, nextFn);
                  },
                  onSaved: (value) {
                    //userPersonalForm.phoneNumber = value;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

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
                  onTap: () => {Navigator.pop(context),
                    getCerificateImage()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                          Navigator.pop(context),
                      getPdfAndUpload(),
                        }),
              ],
            ),
          );
        });
  }

  Future getCameraImage() async {
    // File pathUsr=null;
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var image;
    try {
      var image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);

      // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      if (image != null) {
        var enc = await image.readAsBytes();
        String _path = image.path;
        String _fileName = _path != null ? _path.split('/').last : '...';
        var pos = _fileName.lastIndexOf('.');
        String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
        print(extName);
        //print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
        setState(() {
          // widget.model.patientimg =base64Encode(enc);
          // widget.model.patientimgtype =extName;
          _imageCertificate = image;
          idproof = _fileName;
          // Print("pathhh"+idproof);
         // userModel.profileImage = base64Encode(enc);
          pharmaSignupModel.documentUpload=base64Encode(enc);
          pharmaSignupModel.documentExt=extName;
        });
      }
    } catch (e) {
      print("Error>>in" + e.toString());
    }
  }

  Future getCerificateImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image.readAsBytes();
    String _path = image.path;

    String _fileName = _path != null ? _path.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      _imageCertificate = image;
      idproof = _fileName;
      //userModel.profileImage = base64Encode(enc);
      pharmaSignupModel.documentUpload=base64Encode(enc);
      pharmaSignupModel.documentExt=extName;
    });
  }

  Future getPdfAndUpload() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf','docx'], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if(file != null) {
      setState(() {
        idproof = file.path;
        pharmaSignupModel.documentUpload=base64Encode(enc);
        pharmaSignupModel.documentExt=extName;
        //userModel. = base64Encode(enc);
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }

}
