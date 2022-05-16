import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/UserRegistrationModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';
import '../../localization/localizations.dart';
import '../../models/KeyvalueModel.dart';
import '../../providers/app_data.dart';

class UserSignUpForm extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel titleModel = null;
  static KeyvalueModel countryModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel cityModel = null;


  UserSignUpForm({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  UserSignUpFormState createState() => UserSignUpFormState();
}

enum TypeDob { Age, DOB }

class UserSignUpFormState extends State<UserSignUpForm> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];

  String token,
      idproof = null;
  TypeDob selectDobEn = TypeDob.Age;
  String _selectedGender = 'male';

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
  bool _inProcess = false;
  LoginResponse1 loginResponse1;
  bool isDataNotAvail = false;
  String useridd;
  String password;
  String msg;

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

  File pathUsr ;
  TextEditingController dob = TextEditingController();

  ///UserRegistrationModel userModel;
  UserRegistrationModel userModel = UserRegistrationModel();

  @override
  void initState() {
    super.initState();
    UserSignUpForm.genderModel = null;
    UserSignUpForm.titleModel = null;
    UserSignUpForm.countryModel = null;
    UserSignUpForm.stateModel = null;
    UserSignUpForm.districtModel = null;
    UserSignUpForm.cityModel = null;
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


  // updateProfile(String image, String ext) {
  //   MyWidgets.showLoading(context);
  //   var value = {
  //     "profileImageType": ext,
  //     "pImage": [image],
  //     "eCardNo": loginResponse1.body.user
  //   };
  //
  //   log("Post data>>\n\n" + jsonEncode(value));
  //   widget.model.POSTMETHOD_TOKEN(
  //       api: ApiFactory.USER_PROFILE_IMAGE,
  //       token: widget.model.token,
  //       json: value,
  //       fun: (Map<String, dynamic> map) {
  //         Navigator.pop(context);
  //         setState(() {
  //           log("Value>>>" + jsonEncode(map));
  //           String msg = map[Const.MESSAGE];
  //           if (map[Const.CODE] == Const.SUCCESS) {
  //           } else {
  //             isDataNotAvail = true;
  //             AppData.showInSnackBar(context, msg);
  //           }
  //         });
  //       });
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).text("SIGNUP")),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        /*actions: [
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: TextTheme().apply(bodyColor: Colors.black),
                dividerColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.white)),
            child: PopupMenuButton<int>(
              color: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text("Setting", style: TextStyle(color: Colors.black),)),

              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
          ),
        ],*/
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
                          height: 30,
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
                                    backgroundImage:
                                    FileImage(pathUsr),
                                  ),
                                )
                                    : Material(
                                  elevation: 5.0,
                                  shape: CircleBorder(),
                                  child: CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: NetworkImage(
                                        AppData.defaultImgUrl),
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
                        Form(
                          key: _formKey,
                          // ignore: deprecated_member_use
                          autovalidate: _autovalidate,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0),
                                child: SizedBox(
                                  height: 58,
                                  child:
                                  DropDown.
                                  networkDropdownGetpartUserundreline1(
                                    // "TITLE"
                                      MyLocalizations.of(context)
                                          .text("TITLE") +"*",
                                      ApiFactory.TITLE_API,
                                      "title",
                                      Icons.person_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.TITLE_API);
                                      UserSignUpForm.titleModel = data;
                                      userModel.title = data.key;
                                    });
                                  }),
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
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 0),
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
                                      hintText: MyLocalizations.of(context)
                                          .text("FIRST_NAME") + "*",
                                      prefixIcon:
                                      Icon(Icons.person_rounded),
                                      hintStyle: TextStyle(
                                          color: AppData.hintColor,
                                          fontSize: 16),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    controller: textEditingController[0],
                                    focusNode: fnode1,
                                    textAlignVertical:
                                    TextAlignVertical.center,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(
                                          RegExp("[a-z A-Z]")),
                                    ],
                                    onFieldSubmitted: (value) {
                                      AppData.fieldFocusChange(context, fnode1, fnode2);
                                    },
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
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 0.3)),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                      MyLocalizations.of(context)
                                          .text("LAST_NAME") +
                                          "*",
                                      prefixIcon:
                                      Icon(Icons.person_rounded),
                                      hintStyle: TextStyle(
                                          color: AppData.hintColor,
                                          fontSize: 16),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    textAlignVertical:
                                    TextAlignVertical.center,
                                    controller: textEditingController[1],
                                    focusNode: fnode2,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(
                                          RegExp("[a-zA-Z]")),
                                    ],
                                    onFieldSubmitted: (value) {
                                      AppData.fieldFocusChange(context, fnode2, fnode3);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0),
                                child: SizedBox(
                                  height: 58,


                                  child:DropDown.networkDropdownGetpartUserundreline1(
                                    //"Gender"
                                      MyLocalizations.of(context)
                                          .text("GENDER") +"*",
                                      ApiFactory.GENDER_API,
                                      "gender",
                                      Icons.wc_outlined,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.GENDER_API);
                                      UserSignUpForm.genderModel = data;
                                      userModel.gender = data.key;
                                      // UserSignUpForm.cityModel = null;
                                    });
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, left: 0),
                                child: mobileNoOTPSearch(),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0),
                                child: SizedBox(
                                  height: 58,
                                  child:DropDown.
                                  networkDropdownGetpartUserundreline1(
                                    // "Country",
                                      MyLocalizations.of(context)
                                          .text("COUNTRY")+"*" ,
                                      ApiFactory.COUNTRY_API,
                                      "country",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.COUNTRY_API);
                                      UserSignUpForm.countryModel = data;
                                      UserSignUpForm.stateModel = null;
                                      UserSignUpForm.districtModel = null;
                                      UserSignUpForm.cityModel = null;
                                    });
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              (UserSignUpForm.countryModel != null)
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, bottom: 0),
                                child: SizedBox(
                                  height: 58,
                                  child: DropDown.countryList(
                                    //"State",
                                      MyLocalizations.of(context)
                                          .text("STATE") +"*",
                                      ApiFactory.STATE_API +
                                          UserSignUpForm
                                              .countryModel.key,
                                      "stateU",
                                      Icons.location_on_rounded,
                                      23.0,
                                          (KeyvalueModel data) {
                                        setState(() {
                                          UserSignUpForm.stateModel = data;
                                          UserSignUpForm.districtModel = null;
                                          UserSignUpForm.cityModel = null;
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
                              (UserSignUpForm.stateModel != null)
                                  ?Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0),
                                child: SizedBox(
                                  height: 58,
                                  child: DropDown.
                                  countryList(
                                    //"District",
                                      MyLocalizations.of(context)
                                          .text("DIST")+"*" ,
                                      ApiFactory.DISTRICT_API +
                                          UserSignUpForm.stateModel.key,
                                      "districtU",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.COUNTRY_API);
                                      UserSignUpForm.districtModel = data;
                                      UserSignUpForm.cityModel = null ;
                                    });
                                  }),
                                ),
                              ) : Container(),
                              SizedBox(
                                height: 5,
                              ),
                              (UserSignUpForm.districtModel != null)
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, bottom: 0),
                                child: SizedBox(
                                  height: 58,
                                  child: DropDown
                                      .countryList(
                                    //"City",
                                      MyLocalizations.of(context)
                                          .text("CITY") +"*",
                                      ApiFactory.CITY_API +
                                          UserSignUpForm
                                              .districtModel.key,
                                      "cityU",
                                      Icons.location_on_rounded,
                                      23.0,
                                          (KeyvalueModel data) {
                                        setState(() {
                                          UserSignUpForm.cityModel = data;
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

                              // formFieldzip(2, MyLocalizations.of(context).text("ENTER_ZIP_CODE"),fnode3,fnode4),
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.all(10),
                              //       child: Text(MyLocalizations.of(context).text("UPLOAD_DOCUMENT"),
                              //         style: TextStyle(color:AppData.kPrimaryColor,fontSize: 20,
                              //         ),),
                              //     ),
                              //     SizedBox(width:5),
                              //     Material(
                              //       elevation: 3,
                              //       color:AppData.kPrimaryColor,
                              //       borderRadius: BorderRadius.circular(5.0),
                              //       child: MaterialButton(
                              //         onPressed: () {
                              //           _settingModalBottomSheet1(context);
                              //
                              //         },
                              //         minWidth: 145,
                              //         height: 40.0,
                              //         child: Text(MyLocalizations.of(context).text("UPLOAD"),
                              //           style: TextStyle(
                              //               color: Colors.white, fontSize: 17.0),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 10),
                              // (idproof != null)
                              //     ? Padding(
                              //   padding: const EdgeInsets.only(
                              //       left: 10, right: 10),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Expanded(
                              //         child: Container(
                              //           child: Text(
                              //             "Report Path :" + idproof,
                              //             style: TextStyle(color: Colors.green),
                              //           ),
                              //         ),
                              //       ),
                              //       InkWell(
                              //         child: SizedBox(
                              //             width: 50.0,
                              //             child: Icon(Icons.clear)),
                              //         onTap: () {
                              //           setState(() {
                              //             userModel.documentExt = null;
                              //             idproof = null;
                              //             // registrationModel.profilePhotoBase64 =
                              //             null;
                              //             //registrationModel.profilePhotoExt =
                              //             null;
                              //           });
                              //         },
                              //       )
                              //     ],
                              //   ),
                              // ):Container(),



                              /* Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(MyLocalizations.of(context).text("AGE")),
                                  leading: Radio(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize
                                            .shrinkWrap,
                                    value: TypeDob.Age,
                                    groupValue: selectDobEn,
                                    onChanged: (TypeDob value) {
                                      setState(() {
                                        selectDobEn = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(MyLocalizations.of(context).text("DOB")),
                                  leading: Radio(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize
                                            .shrinkWrap,
                                    value: TypeDob.DOB,
                                    groupValue: selectDobEn,
                                    onChanged: (TypeDob value) {
                                      setState(() {
                                        selectDobEn = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          (selectDobEn == TypeDob.Age)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 10),
                                        child: Container(
                                          height: 47,
                                          padding:
                                              EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(
                                                    5),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.3),
                                          ),
                                          child: TextFormField(
                                            controller: textEditingController[3],
                                            focusNode: fnode4,
                                            decoration:
                                                InputDecoration(
                                              prefixIcon: Icon(Icons
                                                  .accessibility_outlined),
                                              border:
                                                  InputBorder.none,
                                              counterText:"",
                                              hintText:
                                                  MyLocalizations.of(
                                                          context)
                                                      .text("AGE"),
                                              hintStyle: TextStyle(
                                                  color: AppData
                                                      .hintColor,
                                                  fontSize: 17),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical
                                                    .center,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.number,
                                            maxLength: 3,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
                                            onFieldSubmitted: (value) {
                                            //  AppData.fieldFocusChange(context, fnode4, null);
                                            },
                                            onChanged:(s){
                                              if(s!=null && s!="") {
                                                textEditingController[4].text =
                                                    (DateTime.now().year - int.parse(
                                                        textEditingController[3]
                                                            .text)).toString();
                                              }else{
                                                textEditingController[4].text="";
                                              }
                                            }
                                            //maxLength: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: InkWell(
                                        onTap: () {
                                          //_selectDate1(context);

                                          */
                              /*showDialog(
                                            context: context,
                                            builder: (BuildContext
                                                context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Select Year"),
                                                content: Container(
                                                  // Need to use container to add size constraint.
                                                  width: 300,
                                                  height: 300,
                                                  child: YearPicker(
                                                    firstDate: DateTime(
                                                        DateTime.now()
                                                                .year -
                                                            100,
                                                        1),
                                                    lastDate: DateTime
                                                        .now(),
                                                    initialDate:
                                                        DateTime
                                                            .now(),
                                                    selectedDate:
                                                        _selectYear,
                                                    onChanged:
                                                        (DateTime
                                                            dateTime) {
                                                      // close the dialog when year is selected.
                                                      Navigator.pop(
                                                          context);
                                                      textEditingController[
                                                                  4]
                                                              .value =
                                                          TextEditingValue(
                                                              text: df1
                                                                  .format(dateTime));

                                                      // Do something with the dateTime selected.
                                                      // Remember that you need to use dateTime.year to get the year
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );*/
                              /*
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 10),
                                          child: Container(
                                            height: 47,
                                            padding:
                                                EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius
                                                      .circular(5),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 0.3),
                                            ),
                                            child: TextFormField(
                                              enabled: false,
                                              controller:
                                                  textEditingController[
                                                      4],
                                              decoration:
                                                  InputDecoration(
                                                prefixIcon: Icon(Icons
                                                    .calendar_today),
                                                border:
                                                    InputBorder.none,
                                                hintText:MyLocalizations.of(context).text("YEARS") ,
                                                hintStyle: TextStyle(
                                                    color: AppData
                                                        .hintColor,
                                                    fontSize: 17),
                                              ),
                                              textAlignVertical:
                                                  TextAlignVertical
                                                      .center,
                                              textInputAction:
                                                  TextInputAction
                                                      .next,
                                              keyboardType:
                                                  TextInputType
                                                      .number,
                                              //maxLength: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                )
                              : InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8),
                                    child: Container(
                                      height: 50,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 0.3),
                                      ),
                                      child: TextFormField(
                                        controller:
                                            textEditingController[5],
                                        enabled: false,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.calendar_today),
                                          border: InputBorder.none,
                                          hintText:MyLocalizations.of(context).text("DOB1") ,                                              hintStyle: TextStyle(
                                              color:
                                                  AppData.hintColor,
                                              fontSize: 17),
                                        ),
                                        textInputAction:
                                            TextInputAction.next,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType:
                                            TextInputType.number,
                                        //maxLength: 2,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),*/
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
                                        child:RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:MyLocalizations.of(context).text("AGREE_EHEALTHSYSTEM"),
                                                  /* "Welcome back",*/
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.w800,
                                                    fontFamily: "Monte",
                                                    // fontSize: 25.0,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                // SizedBox(width: 10),
                                                TextSpan(
                                                    text:MyLocalizations.of(context).text("T&C"),
                                                    /* "Welcome back",*/
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "Monte",
                                                      // fontSize: 25.0,
                                                      color: AppData
                                                          .kPrimaryColor,
                                                    ),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.pushNamed(context, "/termsandConditionPage");
                                                        // AppData.showInSnackBar(context, "Please select Gender");
                                                      }),

                                              ],
                                            ))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
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

  Widget formFieldzip(int index, String hint,FocusNode currentfn, FocusNode nextFn,) {
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
          UserSignUpForm.genderModel = model;
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
                controller: textEditingController[2],
                focusNode: fnode3,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                //inputFormatters:[1,2,3,4,5,6,7,8,9],
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  //suffixIcon: Icon(Icons.phone),
                  border: InputBorder.none,
                  counterText: "",
                  hintText:
                  MyLocalizations.of(context).text("PHONE_NUMBER") + "*",
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
                  AppData.fieldFocusChange(context, fnode3, fnode4);
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

  /* Widget continueButton() {
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
  }*/

  validate() async {
    _formKey.currentState.validate();
    if (UserSignUpForm.titleModel == null || UserSignUpForm.titleModel == "") {
      AppData.showInSnackBar(context, "Please select title");
    } else if (textEditingController[0].text == "" ||
        textEditingController[0].text == null) {
      AppData.showInSnackBar(context, "Please enter first name");
      FocusScope.of(context).requestFocus(fnode1);
    }else if (textEditingController[0].text != "" &&
        textEditingController[0].text.length <= 2) {
      AppData.showInSnackBar(context, "Please enter a valid first name");
    }else if (textEditingController[1].text == "" ||
        textEditingController[1].text == null) {
      AppData.showInSnackBar(context, "Please enter last name");
      FocusScope.of(context).requestFocus(fnode2);
    }else if (textEditingController[1].text != "" &&
        textEditingController[1].text.length <= 2) {
      AppData.showInSnackBar(context, "Please enter a valid  last name");
    } else if (UserSignUpForm.genderModel == null ||
        UserSignUpForm.genderModel == "") {
      AppData.showInSnackBar(context, "Please select gender");
    }else if (textEditingController[2].text=="" ||
        textEditingController[2].text == null) {
      AppData.showInSnackBar(context, "Please enter phone number");
      FocusScope.of(context).requestFocus(fnode3);
    }else if (textEditingController[2].text.length != 10 ||
        textEditingController[2].text == null) {
      AppData.showInSnackBar(context, "Please enter valid phone number");
      FocusScope.of(context).requestFocus(fnode3);
    }else if (UserSignUpForm.countryModel == null ||
        UserSignUpForm.countryModel == "") {
      AppData.showInSnackBar(context, "Please select country");
    } else if (UserSignUpForm.stateModel == null ||
        UserSignUpForm.stateModel == "") {
      AppData.showInSnackBar(context, "Please select state");
    } else if (UserSignUpForm.districtModel == null ||
        UserSignUpForm.districtModel == "") {
      AppData.showInSnackBar(context, "Please select district");
    } else if (UserSignUpForm.cityModel == null ||
        UserSignUpForm.cityModel == "") {
      AppData.showInSnackBar(context, "Please select city");
    }
    /*else if (selectDobEn==TypeDob.Age && (textEditingController[3].text =="" || textEditingController[3].text == null) ) {
      AppData.showInSnackBar(context, "Please enter your Age");
      FocusScope.of(context).requestFocus(fnode4);
    } else if (selectDobEn==TypeDob.Age  && (int.tryParse(textEditingController[3].text)<18) ) {
      AppData.showInSnackBar(context, "Age should be 18 above");
      // FocusScope.of(context).requestFocus(fnode4);
    }
    else if (selectDobEn==TypeDob.DOB &&(textEditingController[5].text == "" || textEditingController[5].text == null) ) {
      AppData.showInSnackBar(context, "Please enter your DOB");
    }*/
    else if (_checkbox == false) {
      AppData.showInSnackBar(context, "Please check terms and conditions");
    }
    else {

     /* widget.model.title = UserSignUpForm.titleModel.key;
      widget.model.firstname = textEditingController[0].text;
      widget.model.lastname = textEditingController[1].text;
      widget.model.userrphoneno = textEditingController[2].text;
      widget.model.usercountry = UserSignUpForm.countryModel.key;
      widget.model.countrycode = UserSignUpForm.countryModel.code;
      widget.model.statecode = UserSignUpForm.stateModel.code;
      widget.model.userstate = UserSignUpForm.stateModel.key;
      widget.model.userdistrict = UserSignUpForm.districtModel.key;
      widget.model.city = UserSignUpForm.cityModel.key;
      widget.model.usergender = UserSignUpForm.genderModel.key;
      Navigator.pushNamed(context, "/intrestsignup");

    }*/
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      userModel.fName = textEditingController[0].text;
      userModel.lName = textEditingController[1].text;
      userModel.mobile = textEditingController[2].text;
      //  userModel.age = (textEditingController[3].text=="")?null:textEditingController[3].text;
      //  userModel.ageYears = textEditingController[4].text;
      //userModel.dob =(textEditingController[5].text=="")?null:textEditingController[5].text;
      userModel.country = UserSignUpForm.countryModel.key;
      userModel.countryCode = UserSignUpForm.countryModel.code;
      userModel.stateCode = UserSignUpForm.stateModel.code;
      userModel.state = UserSignUpForm.stateModel.key;
      userModel.districtid = UserSignUpForm.districtModel.key;
      userModel.cityid = UserSignUpForm.cityModel.key;
      userModel.title=UserSignUpForm.titleModel.key;
      userModel.gender=UserSignUpForm.genderModel.key;

      print("API NAME>>>>" + ApiFactory.USER_REGISTRATION);
      print("TO POST>>>>" + jsonEncode(userModel.toJson()));

      MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(
          api: ApiFactory.USER_REGISTRATION,
          json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            String msg = map["message"].toString();
            if (map[Const.STATUS] == Const.SUCCESS) {
              setState(() {
                useridd = map["body"]["key"];
                password = map["body"]["name"];
                log("Version>>>" + useridd + "<>>" + password);
                popup(msg, context,password,useridd);
              });
              //popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, msg);
              // Navigator.pushNamed(context, "/");
             // AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
    }
  }

  // popup(BuildContext context, String message) {
  //   return Alert(
  //       context: context,
  //       title: message,
  //       desc:
  //       MyLocalizations.of(context).text("REG_SUCCESS_POPUP"),
  //       type: AlertType.success,
  //       onWillPopActive: true,
  //       closeIcon: Icon(
  //         Icons.info,
  //         color: Colors.transparent,
  //       ),
  //       //image: Image.asset("assets/success.png"),
  //       closeFunction: () {},
  //       buttons: [
  //         DialogButton(
  //           child: Text(
  //             "OK",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //           onPressed: () {
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //             // Navigator.pop(context);
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
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
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
                  onTap: () => {
                    Navigator.pop(context),
                    getGalleryImage()},
                ),
                // new ListTile(
                //     leading: new Icon(Icons.file_copy),
                //     title: new Text('Document'),
                //     onTap: () => {
                //       Navigator.pop(context),
                //       getPdfAndUpload(),
                //     }),
              ],
            ),
          );
        });
  }

  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);
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
        // widget.model.patientimg =base64Encode(enc);
        // widget.model.patientimgtype =extName;
        userModel.profileImage = base64Encode(enc);
        userModel.profileImageType = extName;
      });
    }
  }
  /*Future getCerificateImage() async {
    var image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image.readAsBytes();
    String _path = image.path;

    String fileName = path != null ? _path.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? fileName.substring(pos + 1) : fileName;
    print(extName);

    setState(() {
      _imageCertificate = image;
      idproof = _fileName;
      pregnancyreportModel.ultrasoundrprt = base64Encode(enc);
    });
  }*/
  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    if (image != null) {
      var enc = await image.readAsBytes();
      String _path = image.path;
      setState(() =>pathUsr = File(image.path));/*File(_path));*/

      String _fileName = _path != null ? _path.split('/').last : '...';
      var pos = _fileName.lastIndexOf('.');
      String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
      print(extName);
      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
      setState(() {
        ///pathUsr = image/*File(_path)*/;
        // widget.model.patientimg =base64Encode(enc);
        // widget.model.patientimgtype =extName;
        userModel.profileImage = base64Encode(enc);
        userModel.profileImageType = extName;
      });
    }
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

          userModel.profileImage = base64Encode(enc);
          userModel.profileImageType = extName;
          // callApii();
          // widget.model.patientimg =base64Encode(enc);
          //widget.model.patientimgtype =extName;
          //updateProfileModel.profileImage = base64Encode(enc) as List<Null>;
          //updateProfileModel.profileImageType = extName;
          //updateProfile(base64Encode(enc), extName);
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

  // void _settingModalBottomSheet1(context) {
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
  //                     getCameraImage1(),
  //                   }),
  //               new ListTile(
  //                 leading: new Icon(Icons.folder),
  //                 title: new Text('Gallery'),
  //                 onTap: () => {
  //                   Navigator.pop(context),
  //                   getGalleryImage1()},
  //               ),
  //               new ListTile(
  //                   leading: new Icon(Icons.file_copy),
  //                   title: new Text('Document'),
  //                   onTap: () => {
  //                     Navigator.pop(context),
  //                     getPdfAndUpload1(),
  //                   }),
  //             ],
  //           ),
  //         );
  //       });
  // }
  //
  // Future getCameraImage1() async {
  //   var image = await ImagePicker.pickImage(
  //       source: ImageSource.camera, imageQuality: 25);
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
  //
  //     print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
  //     setState(() {
  //       pathUsr = File(_path);
  //       // widget.model.patientimg =base64Encode(enc);
  //       // widget.model.patientimgtype =extName;
  //       userModel. documentUpload= base64Encode(enc);
  //       userModel.documentExt = extName;
  //     });
  //   }
  // }
  // /*Future getCerificateImage() async {
  //   var image = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 10,
  //   );
  //   var enc = await image.readAsBytes();
  //   String _path = image.path;
  //
  //   String fileName = path != null ? _path.split('/').last : '...';
  //   var pos = _fileName.lastIndexOf('.');
  //   String extName = (pos != -1) ? fileName.substring(pos + 1) : fileName;
  //   print(extName);
  //
  //   setState(() {
  //     _imageCertificate = image;
  //     idproof = _fileName;
  //     pregnancyreportModel.ultrasoundrprt = base64Encode(enc);
  //   });
  // }*/
  // Future getGalleryImage1() async {
  //   var image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 25);
  //   // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  //   if (image != null) {
  //     var enc = await image.readAsBytes();
  //     String _path = image.path;
  //     setState(() =>pathUsr = File(image.path));/*File(_path));*/
  //
  //     String _fileName = _path != null ? _path.split('/').last : '...';
  //     var pos = _fileName.lastIndexOf('.');
  //     String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
  //     print(extName);
  //     print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
  //     setState(() {
  //       ///pathUsr = image/*File(_path)*/;
  //       // widget.model.patientimg =base64Encode(enc);
  //       // widget.model.patientimgtype =extName;
  //       userModel.documentUpload = base64Encode(enc);
  //       userModel.documentExt = extName;
  //     });
  //   }
  // }
  //
  // Future getPdfAndUpload1() async {
  //   File file = await FilePicker.getFile(
  //     type: FileType.custom,
  //     allowedExtensions: [
  //       'pdf',
  //       'docx'
  //     ], //here you can add any of extention what you need to pick
  //   );
  //   var enc = await file.readAsBytes();
  //   String _path = file.path;
  //
  //   String _fileName = _path != null ? _path.split('/').last : '...';
  //   var pos = _fileName.lastIndexOf('.');
  //   String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
  //   print(extName);
  //
  //   if (file != null) {
  //     setState(() {
  //       idproof = file.path;
  //       userModel.documentUpload=base64Encode(enc);
  //       userModel.documentExt=extName;
  //       //userModel. = base64Encode(enc);
  //       //file1 = file; //file1 is a global variable which i created
  //     });
  //   }
  // }


}
