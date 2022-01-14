import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
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

class IntrestSignUpForm extends StatefulWidget {
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

  IntrestSignUpForm({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  IntrestSignUpFormState createState() => IntrestSignUpFormState();
}

enum TypeDob { Age, DOB }

class IntrestSignUpFormState extends State<IntrestSignUpForm> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  bool isChecked = false;
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
    IntrestSignUpForm.genderModel = null;
    IntrestSignUpForm.titleModel = null;
    IntrestSignUpForm.countryModel = null;
    IntrestSignUpForm.stateModel = null;
    IntrestSignUpForm.districtModel = null;
    IntrestSignUpForm.cityModel = null;
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
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "To Keep Connected With Us Please \n Sign Up With Your Personal Info",
                  style: TextStyle(
                      color: AppData.kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
//                  news.Body body = newsupdatemodel.body[i];
                  //  print("video###############"+body.vdoURL);
                  // String docTyp=getFormatType(body.extension);
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Text("Environment" + " : ",
                            style: TextStyle(
                                color: AppData.kPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
//                  news.Body body = newsupdatemodel.body[i];
                            //  print("video###############"+body.vdoURL);
                            // String docTyp=getFormatType(body.extension);
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: CheckboxListTile(
                                      activeColor: Colors.blue[300],
                                      dense: true,
                                      title: new Text(
                                        MyLocalizations.of(context)
                                            .text("ALL_ORGAN")
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      value: isChecked,
                                      onChanged: (val) {
                                        setState(() {
                                          isChecked = val;
                                          //selectedOrganList.clear();
                                          /* organModel.body.forEach((element) {
                                                    element.isChecked = val;
                                                    if (val) {
                                                      selectedorgan.add(element);
                                                      selectedOrganList.add(element.key.toString());
                                                    } else {
                                                      selectedorgan.remove(element);
                                                      selectedOrganList
                                                          .remove(element.key.toString());
                                                    }
                                                  });*/
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                          itemCount: 5,
                        )
                      ]),
                    ),
                  );
                },
                itemCount: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                 // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        child: skip(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: nextButton(),
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

  Widget skip() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validate();
      },
      child: Container(
        width: 150,
        //  width: MediaQuery.of(context).size.width,
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
          child: Text("Skip",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
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
        width: 150,
        //  width: MediaQuery.of(context).size.width,
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
                ],
                // Only numbers can be entered
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

    /*_formKey.currentState.validate();
    if (IntrestSignUpForm.titleModel == null ||
        IntrestSignUpForm.titleModel == "") {
      AppData.showInSnackBar(context, "Please select title");
    } else if (textEditingController[0].text == "" ||
        textEditingController[0].text == null) {
      AppData.showInSnackBar(context, "Please enter first name");
      FocusScope.of(context).requestFocus(fnode1);
    } else if (textEditingController[0].text != "" &&
        textEditingController[0].text.length <= 2) {
      AppData.showInSnackBar(context, "Please enter a valid first name");
    } else if (textEditingController[1].text == "" ||
        textEditingController[1].text == null) {
      AppData.showInSnackBar(context, "Please enter last name");
      FocusScope.of(context).requestFocus(fnode2);
    } else if (textEditingController[1].text != "" &&
        textEditingController[1].text.length <= 2) {
      AppData.showInSnackBar(context, "Please enter a valid  last name");
    } else if (IntrestSignUpForm.genderModel == null ||
        IntrestSignUpForm.genderModel == "") {
      AppData.showInSnackBar(context, "Please select gender");
    } else if (textEditingController[2].text == "" ||
        textEditingController[2].text == null) {
      AppData.showInSnackBar(context, "Please enter phone number");
      FocusScope.of(context).requestFocus(fnode3);
    } else if (textEditingController[2].text.length != 10 ||
        textEditingController[2].text == null) {
      AppData.showInSnackBar(context, "Please enter valid phone number");
      FocusScope.of(context).requestFocus(fnode3);
    } else if (IntrestSignUpForm.countryModel == null ||
        IntrestSignUpForm.countryModel == "") {
      AppData.showInSnackBar(context, "Please select country");
    } else if (IntrestSignUpForm.stateModel == null ||
        IntrestSignUpForm.stateModel == "") {
      AppData.showInSnackBar(context, "Please select state");
    } else if (IntrestSignUpForm.districtModel == null ||
        IntrestSignUpForm.districtModel == "") {
      AppData.showInSnackBar(context, "Please select district");
    } else if (IntrestSignUpForm.cityModel == null ||
        IntrestSignUpForm.cityModel == "") {
      AppData.showInSnackBar(context, "Please select city");
    }
    *//*else if (selectDobEn==TypeDob.Age && (textEditingController[3].text =="" || textEditingController[3].text == null) ) {
      AppData.showInSnackBar(context, "Please enter your Age");
      FocusScope.of(context).requestFocus(fnode4);
    } else if (selectDobEn==TypeDob.Age  && (int.tryParse(textEditingController[3].text)<18) ) {
      AppData.showInSnackBar(context, "Age should be 18 above");
      // FocusScope.of(context).requestFocus(fnode4);
    }
    else if (selectDobEn==TypeDob.DOB &&(textEditingController[5].text == "" || textEditingController[5].text == null) ) {
      AppData.showInSnackBar(context, "Please enter your DOB");
    }*//*
    else if (_checkbox == false) {
      AppData.showInSnackBar(context, "Please check terms and conditions");
    } else {*/
      /* // PatientSignupModel patientSignupModel = PatientSignupModel();
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
*/

    userModel.title=  widget.model.title ;
    userModel.fName=  widget.model.firstname ;
    userModel.lName= widget.model.lastname;
    userModel.mobile= widget.model.userrphoneno;
    userModel.country= widget.model.usercountry ;
    userModel.countryCode= widget.model.countrycode ;
    userModel.stateCode=widget.model.statecode;
    userModel.state= widget.model.userstate ;
    userModel.districtid= widget.model.userdistrict;
    userModel.cityid= widget.model.city ;
    userModel.gender= widget.model.usergender ;
    userModel.profileImage = widget.model.userproimage;
    userModel.profileImageType =widget.model.userextesion;
       print("API NAME>>>>" + ApiFactory.USER_REGISTRATION);
      print("TO POST>>>>" + jsonEncode(userModel.toJson()));

       MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(
          api: ApiFactory.USER_REGISTRATION,
          json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
    }
  }

  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
        desc: MyLocalizations.of(context).text("REG_SUCCESS_POPUP"),
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
                          //getCameraImage(),
                         // getImage(ImageSource.camera),
                        }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),
                    //getGalleryImage(),
                    //getImage(ImageSource.gallery),
                  },
                ),
              ],
            ),
          );
        });
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
                           // widget.model.apntUserType =Const.HEALTH_SCREENING_APNT;
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
                          //  widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
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
                           // widget.model.apntUserType = Const.DOC_APNT;
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
