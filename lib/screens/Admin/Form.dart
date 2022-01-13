import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/DoctorRegistrationModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/NewsupdateModel.dart';
import 'package:user/models/UserRegistrationModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Admin/Admin.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';

class Mediaupdate extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel titleModel = null;
  static KeyvalueModel organizationModel = null;
  static KeyvalueModel specialityModel = null;
  static KeyvalueModel countryModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel cityModel = null;

  Mediaupdate({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  MediaupdateState createState() =>
      MediaupdateState();
}

enum TypeDob { Age, DOB }

class MediaupdateState extends State<Mediaupdate> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  String extension;
  File selectFile;

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];

  String token;
  TypeDob selectDobEn = TypeDob.Age;

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
  var dio = Dio();

  List<KeyvalueModel> specialitylist = [
    KeyvalueModel(name: "Syndicate Partner", key: "57"),
  ];

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
  final df1 = new DateFormat('yyyy');
  bool ispartnercode = false;
  bool _checkbox = false;
  String profilePath = null, idproof = null;
  NewsupdateModel newsModel = NewsupdateModel();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        /*initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now(),*/
        initialDate: DateTime.now().subtract(Duration(days: 6570)),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now()
            .subtract(Duration(days: 6570))); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[5] = false;
        textEditingController[5].value =
            TextEditingValue(text: df.format(picked));
      });
  }

  DateTime _selectYear = DateTime.now();
  bool fromLogin = false;

  StreamSubscription _connectionChangeStream;
  bool isOnline = false;
  List<KeyvalueModel> genderList = [
    KeyvalueModel(name: "Male", key: "1"),
    KeyvalueModel(name: "Female", key: "2"),
    KeyvalueModel(name: "Transgender", key: "3"),
  ];

  List<KeyvalueModel> titleList = [
    KeyvalueModel(name: "Mr.", key: "1"),
    KeyvalueModel(name: "Mrs.", key: "2"),
  ];

  File pathUsr;

  TextEditingController dob = TextEditingController();

  ///UserRegistrationModel userModel;
  UserRegistrationModel userModel = UserRegistrationModel();

  @override
  void initState() {
    super.initState();
    Mediaupdate.genderModel = null;
    Mediaupdate.titleModel = null;
    Mediaupdate.countryModel = null;
    Mediaupdate.stateModel = null;
    Mediaupdate.districtModel = null;
    Mediaupdate.cityModel = null;
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        AppData.showInSnackBar(context, "Privacy Setting");

        /* Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SettingPage()));*/
        break;
      case 1:
        AppData.showInSnackBar(context, "Privacy Clicked");

        break;
      case 2:
        AppData.showInSnackBar(context, "User Logged out");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text("News & Media"),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
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
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formKey,
                          // ignore: deprecated_member_use
                          autovalidate: _autovalidate,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black, width: 0.3),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Title",
                                      prefixIcon: Icon(Icons.person_rounded),
                                      hintStyle: TextStyle(
                                          color: AppData.hintColor,
                                          fontSize: 16),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    controller: textEditingController[1],
                                    //focusNode: fnode5,
                                    textAlignVertical: TextAlignVertical.center,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(
                                          RegExp("[a-z A-Z.]")),
                                    ],

                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black, width: 0.3),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                      "SubTitle",
                                      prefixIcon:
                                      Icon(Icons.person),
                                      hintStyle: TextStyle(
                                          color: AppData.hintColor,
                                          fontSize: 16),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    controller: textEditingController[2],
                                    focusNode: fnode4,
                                    textAlignVertical:
                                    TextAlignVertical.center,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(
                                          RegExp("[a-z A-Z. , /0-9]")),
                                    ],

                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black, width: 0.3),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: "",
                                      hintText:
                                      "Video Link",
                                      prefixIcon:
                                      Icon(Icons.videocam),
                                      hintStyle: TextStyle(
                                          color: AppData.hintColor,
                                          fontSize: 16),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    controller: textEditingController[3],
                                    focusNode: fnode3,
                                    textAlignVertical:
                                    TextAlignVertical.center,
                                    //maxLength: 2,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(
                                          RegExp("[a-z A-Z. , :,/0-9]")),
                                    ],


                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Padding(
                                padding:
                                const EdgeInsets.only(left: 0, right: 0),
                                child: SizedBox(
                                  height: 58,
                                  child: DropDown
                                      .networkDropdownGetpartUserundreline1(
                                    // "Country",
                                      MyLocalizations.of(context)
                                          .text("COUNTRY"),
                                      ApiFactory.COUNTRY_API,
                                      "countryU",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.COUNTRY_API);
                                      Mediaupdate.countryModel = data;
                                      Mediaupdate.stateModel = null;
                                      Mediaupdate.districtModel = null;
                                      Mediaupdate.cityModel = null;
                                    });
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              (Mediaupdate.countryModel != null)
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, bottom: 0),
                                child: SizedBox(
                                  height: 58,
                                  child: DropDown.countryList(
                                    //"State",
                                      MyLocalizations.of(context)
                                          .text("STATE"),
                                      ApiFactory.STATE_API +
                                          Mediaupdate
                                              .countryModel.key,
                                      "stateR",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      Mediaupdate.stateModel = data;
                                      Mediaupdate.districtModel = null;
                                      Mediaupdate.cityModel = null;
                                      /*userModel.state=data.key;
                                      userModel.stateCode=data.code;*/
                                    });
                                  }),
                                ),
                              )
                                  : Container(),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              (Mediaupdate.stateModel != null)
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0),
                                child: SizedBox(
                                  height: 58,
                                  child: DropDown.countryList(
                                    //"District",
                                      MyLocalizations.of(context)
                                          .text("DIST"),
                                      ApiFactory.DISTRICT_API +
                                          Mediaupdate
                                              .stateModel.key,
                                      "districtR",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.COUNTRY_API);
                                      Mediaupdate.districtModel = data;
                                      Mediaupdate.cityModel = null;
                                    });
                                  }),
                                ),
                              )
                                  : Container(),
                              SizedBox(
                                height: 5,
                              ),
                              (Mediaupdate.districtModel != null)
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, bottom: 0),
                                child: SizedBox(
                                  height: 58,
                                  child: DropDown.countryList(
                                    //"City",
                                      MyLocalizations.of(context)
                                          .text("CITY"),
                                      ApiFactory.CITY_API +
                                          Mediaupdate
                                              .districtModel.key,
                                      "cityR",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      Mediaupdate.cityModel =
                                          data;
                                      /*userModel.state=data.key;
                                      userModel.stateCode=data.code;*/
                                    });
                                  }),
                                ),
                              )
                                  : Container(),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                children: [
                                 Expanded(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Upload Banner",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),),
                                  //SizedBox(width: 30),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Material(
                                         elevation: 3,
                                         color: AppData.kPrimaryColor,
                                         borderRadius: BorderRadius.circular(5.0),
                                         child: MaterialButton(
                                           onPressed: () {
                                             _settingModalBottomSheet(context);
                                           },
                                           minWidth: 120,
                                           height: 40.0,
                                           child: Text(
                                             "Upload",
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 17.0),
                                           ),
                                         ),
                                       ),
                                    ),
                                  ),
                                ],
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          "Report Path :" + idproof,
                                          style:
                                          TextStyle(color: Colors.green),
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
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: nextButton(),
                              ),
                              SizedBox(
                                height: 25,
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
      ),
    );
  }

  Widget dobBirth() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              enabled: !widget.isConfirmPage ? false : true,
              controller: dob,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Date Of Birth",
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

  Widget gender() {
    return DropDown.searchDropdowntyp("Gender", "genderPartner", genderList,
            (KeyvalueModel model) {
          Mediaupdate.genderModel = model;
        });
  }

  Widget newContainer(child) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }

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

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validate();
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
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
            MyLocalizations.of(context).text("SUBMIT"),
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
                controller: textEditingController[5],
                focusNode: fnode6,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                //inputFormatters:[1,2,3,4,5,6,7,8,9],
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                // Only numbers can be entered
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  //suffixIcon: Icon(Icons.phone),
                  border: InputBorder.none,
                  counterText: "",
                  hintText: MyLocalizations.of(context).text("PHONE_NUMBER"),
                  hintStyle: TextStyle(color: AppData.hintColor, fontSize: 16),
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
                  //AppData.fieldFocusChange(context, fnode3, fnode4);
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

  validate() async {
  if (textEditingController[1].text == null ||
        textEditingController[1].text == "") {
      AppData.showInSnackBar(context, "Please enter Title");
    }  else if (textEditingController[1].text.length<3) {
      AppData.showInSnackBar(context, "Please enter valid address");
    } else if (textEditingController[2].text ==null||
        textEditingController[2].text == "" ) {
      AppData.showInSnackBar(context, "Please enter SubTitle");
      FocusScope.of(context).requestFocus(fnode3);
    } else if (textEditingController[3].text == "" ||
        textEditingController[3].text == null) {
      AppData.showInSnackBar(context, "Please enter VidioLink");
    } else if (Mediaupdate.countryModel == null ||
        Mediaupdate.countryModel == "") {
      AppData.showInSnackBar(context, "Please select country");
    } else if (Mediaupdate.stateModel == null ||
        Mediaupdate.stateModel == "") {
      AppData.showInSnackBar(context, "Please select state");
    } else if (Mediaupdate.districtModel == null ||
        Mediaupdate.districtModel == "") {
      AppData.showInSnackBar(context, "Please select district");
    } else if (Mediaupdate.cityModel == null ||
        Mediaupdate.cityModel == "") {
      AppData.showInSnackBar(context, "Please select city");
    }else if (idproof == null) {
      AppData.showInSnackBar(context, "Please upload Image");
    }
    else {
    postMultiPart();
     /* newsModel.title = textEditingController[1].text;
      newsModel.subTitle = textEditingController[2].text;
      newsModel.vdoURL = textEditingController[3].text;
      newsModel.country = Mediaupdate.countryModel.key;
      newsModel.state = Mediaupdate.stateModel.key;
      newsModel.district = Mediaupdate.districtModel.key;
      newsModel.city = Mediaupdate.cityModel.key;
      newsModel.admId = "23";
      log("DOCTOR MODEL SEND>>>>" + jsonEncode(newsModel.toJson()));
      MyWidgets.showLoading(context);
      *//*widget.model.POSTMETHOD(
          api: ApiFactory.NEWS_UPDATE_POST,
          json: newsModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    };

  }

  popup(BuildContext context) {
    return Alert(
        context: context,
        title: "Successfully Uploaded",
        type: AlertType.success,
        onWillPopActive: true,
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
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AdminUser(model: widget.model)));
                //Navigator.pop(context, true);
              });

              //Navigator.pop(context, true);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
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
              /*  new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload(),
                    }),*/
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

          selectFile = image;
          idproof = image.path;
          // widget.model.patientimg =base64Encode(enc);
          // widget.model.patientimgtype =extName;
          _imageCertificate = image;
          idproof = _fileName;
          // Print("pathhh"+idproof);
          //userModel.profileImage = base64Encode(enc);
          //newsModel.documentUpload=base64Encode(enc);
         // newsModel.documentExt=extName;
         // extension=extName;

        });
      }
    } catch (e) {
      print("Error>>in" + e.toString());
    }
  }

  Future getPdfAndUpload() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        idproof = file.path;
        //userModel. = base64Encode(enc);
        //file1 = file; //file1 is a global variable which i created
       // newsModel.documentUpload=base64Encode(enc);
        //newsModel.documentExt=extName;
      });
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
      selectFile = image;
      idproof = image.path;
      extension=extName;
      _imageCertificate = image;
      idproof = _fileName;
      // userModel.profileImage = base64Encode(enc);
     // newsModel.documentUpload=base64Encode(enc);
      //newsModel.documentExt=extName;
    });
  }
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
                        ListTile(
                          title: Text("Health Screening"),
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            size: 40,
                          ),
                          onTap: () {
                            widget.model.apntUserType =
                                Const.HEALTH_SCREENING_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
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
                            widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
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
                            widget.model.apntUserType = Const.DOC_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
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

  Widget formField1(
      int index,
      String hint,
      ) {
    return Container(
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
          prefixIcon: Icon(Icons.person_rounded),
          hintStyle: TextStyle(color: AppData.hintColor, fontSize: 17),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        controller: textEditingController[index],
        focusNode: fnode1,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        onFieldSubmitted: (value) {
          setState(() {});
          AppData.fieldFocusChange(context, fnode1, null);
        },
      ),
    );
  }

  void postMultiPart() async {
    MyWidgets.showLoading(context);
    try {
      Response response;
      response = await dio.post(
        ApiFactory.NEWS_UPDATE_POST,
        data: await FormData2(),
        onSendProgress: (received, total) {
          if (total != -1) {
            setState(() {
              print((received / total * 100).toStringAsFixed(0) + '%');
            });
          }
        },
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        log("value" + jsonEncode(response.data));
        if (response.data["code"] == "success") {
          //Navigator.pushNamed(context, "/uploaddocument");
          popup(context,);
        } else {
          AppData.showInSnackBar(context, "Something went wrong");
        }
      } else {
        Navigator.pop(context);
        AppData.showInSnackBar(context, "Something went wrong");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        log(e.response.data);
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        log(e.response.data);
      }
      if (e.type == DioErrorType.DEFAULT) {
        log(e.response.data);
      }
      if (e.type == DioErrorType.RESPONSE) {
        log(e.response.data);
      }
    }
    //print(response);
  }

  Future<FormData> FormData2() async {
    log("File extension is:::::>>>>>" +
        textEditingController[1].text +
        "," +
        textEditingController[2].text +
        "," +textEditingController[3].text+","+
        extension +
        ","+selectFile.path );
    var formData = FormData();
    formData.fields
      ..add(MapEntry('title',
          textEditingController[1].text ))
      ..add(MapEntry(
        'subTitle',
        textEditingController[2].text,
      ))..add(MapEntry(
        'vdoURL',
        textEditingController[3].text,
      ))
      ..add(MapEntry(
        'admId',
        "23",
      ))
      ..add(MapEntry(
        'country',
        Mediaupdate.countryModel.key,
      ))
      ..add(MapEntry(
        'state',
        Mediaupdate.cityModel.key,
      ))
      ..add(MapEntry(
        'district',
        Mediaupdate.districtModel.key,
      ))..add(MapEntry(
      'city',
      Mediaupdate.cityModel.key,
    ))..add(MapEntry(
        'extension',
        extension,
      ));
    formData.files.add(MapEntry(
      'multipleFile',
      MultipartFile.fromFileSync(
        selectFile.path,
        filename: selectFile.path,
        //contentType: new MediaType('','')
      ),
    ));
    return formData;
  }


}
