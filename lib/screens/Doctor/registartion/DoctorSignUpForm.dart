import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/text_field_container.dart';

import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';

// ignore: must_be_immutable

enum Organization {
  Doctor,
  Pharmacist,
  Pathologist,
  Receptionist,
  Hospital,
  Pharmacy,
  PathologyLab,
}
enum Individual{
  User,
}
class DoctorSignUpForm extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;

  DoctorSignUpForm({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  DoctorSignUpFormState createState() => DoctorSignUpFormState();

}

class DoctorSignUpFormState extends State<DoctorSignUpForm> {

  Organization org = Organization.Doctor;
  Individual indi = Individual.User;

  File pathUsr = null;
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
  bool _isSignUpLoading = false;

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
  List<KeyvalueModel> genderList = [
    KeyvalueModel(name: "Male", key: "1"),
    KeyvalueModel(name: "Female", key: "2"),
    KeyvalueModel(name: "Transgender", key: "3"),
  ];
  List<KeyvalueModel> districtList = [
    KeyvalueModel(name: "india", key: "1"),

  ];

  @override
  void initState() {
    super.initState();
    DoctorSignUpForm.districtModel = null;
    DoctorSignUpForm.blockModel = null;
    DoctorSignUpForm.genderModel = null;
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
        title: Text("SIGN UP"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
            /* Container(
                color: AppData.kPrimaryColor,
                child: Padding(
                  padding: const EdgeInsets.only( left:15.0,right: 15.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,color: Colors.white)),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 40.0),
                        child: Text(MyLocalizations.of(context).text("SIGNUP"),
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.white,),),
                      ),
                    ],
                  ),
                ),
                height: 55,
                width: MediaQuery.of(context).size.width,
              ),*/
              Padding(
                padding: const EdgeInsets.only(left:10.0, right: 10.0,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                        //     child: Image.asset(
                        //       "assets/logo1.png",
                        //       fit: BoxFit.fitWidth,
                        //       //width: ,
                        //       height: 110.0,
                        //     ),
                        //   ),
                        // ),


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
                          autovalidate: _autovalidate,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(Icons.supervised_user_circle_rounded),
                                  Text(MyLocalizations.of(context).text("INDIVIDUAL"),style: TextStyle(fontSize: 20),),
                                ],
                              ),

                              Row(
                                children: [
                                  Radio(
                                    value: Individual.User,
                                    groupValue: indi,
                                    onChanged: (Individual indi) {
                                      setState(() {
                                        this.indi = indi;
                                      });
                                    },
                                  ),
                                  Text(MyLocalizations.of(context).text("USER")),
                                ],
                              ),

                              Row(
                                children: [
                                  Icon(Icons.supervised_user_circle),
                                  Text(MyLocalizations.of(context).text("PROFESSIONAL/ORGANIZATION"),style: TextStyle(fontSize: 20),),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: Organization.Doctor,
                                    groupValue: org,
                                    onChanged: (Organization org) {
                                      setState(() {
                                        this.org = org;
                                      });
                                    },
                                  ),
                                  Text(MyLocalizations.of(context).text("DOCTOR")),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: Organization.Pharmacist,
                                    groupValue: org,
                                    onChanged: (Organization org) {
                                      setState(() {
                                        this.org = org;
                                      });
                                    },
                                  ),
                                  Text(MyLocalizations.of(context).text("PHARMACIST")),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: Organization.Pathologist,
                                    groupValue: org,
                                    onChanged: (Organization org) {
                                      setState(() {
                                        this.org = org;
                                      });
                                    },
                                  ),
                                  Text(MyLocalizations.of(context).text("PATHOLOGIST")),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: Organization.Receptionist,
                                    groupValue: org,
                                    onChanged: (Organization org) {
                                      setState(() {
                                        this.org = org;
                                      });
                                    },
                                  ),
                                  Text(MyLocalizations.of(context).text("RECEPTIONIST")),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: Organization.Hospital,
                                    groupValue: org,
                                    onChanged: (Organization org) {
                                      setState(() {
                                        this.org = org;
                                      });
                                    },
                                  ),
                                  Text(MyLocalizations.of(context).text("HOSPITAL")),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: Organization.Pharmacy,
                                    groupValue: org,
                                    onChanged: (Organization org) {
                                      setState(() {
                                        this.org = org;
                                      });
                                    },
                                  ),
                                  Text(MyLocalizations.of(context).text("PHARMACY")),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: Organization.PathologyLab,
                                    groupValue: org,
                                    onChanged: (Organization org) {
                                      setState(() {
                                        this.org = org;
                                      });
                                    },
                                  ),
                                  Text(MyLocalizations.of(context).text("PATHOLOGYLAB")),
                                ],
                              ),
                              SizedBox(height: 5),
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: nextButton1(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // InkWell(
                              //     onTap: () {
                              //       setState(() {
                              //         ispartnercode = !ispartnercode;
                              //       });
                              //     },
                              //     child: Text(
                              //       MyLocalizations.of(context)
                              //               .text("HAVE_PARTNERCODE") +
                              //           "?",
                              //       style: TextStyle(color: Colors.blue),
                              //     )),
                              //
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Visibility(
                              //   visible: ispartnercode,
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.symmetric(horizontal: 25),
                              //     child: TextFormField(
                              //       decoration: InputDecoration(
                              //           hintText: MyLocalizations.of(context)
                              //               .text("PARTNERCODE"),
                              //           hintStyle: TextStyle(color: Colors.grey)),
                              //       textInputAction: TextInputAction.next,
                              //       keyboardType: TextInputType.text,
                              //       //           inputFormatters: [
                              //       //  WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                              //       //           ],
                              //     ),
                              //   ),
                              // ),

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 10),
                              //   child: Row(
                              //     //  mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Checkbox(
                              //         value: _checkbox,
                              //         onChanged: (value) {
                              //           setState(() {
                              //             _checkbox = !_checkbox;
                              //           });
                              //         },
                              //       ),
                              //       SizedBox(
                              //         height: 10,
                              //       ),
                              //       RichText(
                              //           textAlign: TextAlign.start,
                              //           text: TextSpan(
                              //             children: [
                              //               TextSpan(
                              //                 text: 'I agree to NCORDS ',
                              //                 /* "Welcome back",*/
                              //                 style: TextStyle(
                              //                   // fontWeight: FontWeight.w800,
                              //                   fontFamily: "Monte",
                              //                   // fontSize: 25.0,
                              //                   color: Colors.grey,
                              //                 ),
                              //               ),
                              //               TextSpan(
                              //                 text: 'Terms and Conditions',
                              //                 /* "Welcome back",*/
                              //                 style: TextStyle(
                              //                   // fontWeight: FontWeight.w500,
                              //                   fontFamily: "Monte",
                              //                   // fontSize: 25.0,
                              //                   color: Colors.indigo,
                              //                 ),
                              //               )
                              //             ],
                              //           )),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 10),
                              //   child: nextButton(),
                              // ),
                              // SizedBox(
                              //   height: 25,
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],),
              ),
            ],
          ),
        ),
      ),


    );
  }
  Widget gender() {
    return DropDown.searchDropdowntyp("Gender", "genderPartner", genderList,
            (KeyvalueModel model) {
          DoctorSignUpForm.genderModel = model;
        });
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

  Future getCerificateImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);

    setState(() {
      _imageCertificate = image;
      selectGallery = true;
      print('Image Path $_imageCertificate');
    });
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/doctorsignupform2");
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left:180, right: 0),
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
            MyLocalizations.of(context).text("NEXT"),
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
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => widget.isConfirmPage ? null : _selectDate(context),
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
                  width: 2.0,
                  color: Colors.grey,
                ),
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
    } else if (DoctorSignUpForm.genderModel == null || DoctorSignUpForm.genderModel == "") {
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
    } else if (DoctorSignUpForm.districtModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT DISTRICT");
    } else if (DoctorSignUpForm.blockModel == null) {
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
          border:
          Border.all(color: AppData.matruColor, width: 3)),
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

  Widget formField(int index, String hint,) {
    return TextFieldContainer(
      child: TextFormField(
        controller: textEditingController[index],
        textInputAction: TextInputAction.done,
        keyboardType:TextInputType.text,
        /* decoration: BoxDecoration(11
          color: AppData.kPrimaryLightColor,
          //color: Color(0x45283e81),
          borderRadius: BorderRadius.circular(29),
        ),*/
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
        onChanged: (newValue) {},
      ),
    );
  }

// Widget formFieldPass(int index, String hint, int obqueTxt) {
//   return TextFieldContainer(
//     child: TextFormField(
//       controller: controller[index],
//       textInputAction: TextInputAction.done,
//       obscureText: !isViewList[obqueTxt],
//       keyboardType: Validator.getKeyboardTyp(Const.PASS),
//       style: TextStyle(fontSize: 13),
//       textAlignVertical: TextAlignVertical.center,
//       decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
//           border: InputBorder.none,
//           suffixIcon: InkWell(
//             onTap: () {
//               setState(() {
//                 isViewList[obqueTxt] = !isViewList[obqueTxt];
//               });
//             },
//             child: Icon(
//               isViewList[obqueTxt]
//                   ? CupertinoIcons.eye_slash_fill
//                   : CupertinoIcons.eye_fill,
//               size: 19,
//               color: Colors.grey,
//             ),
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
//     ),
//   );
// }
//


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
    var image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 25);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    if (image != null) {
      var enc = await image.readAsBytes();
      String _path = image.path;
      setState(() => pathUsr = File(_path));

      String _fileName = _path != null ? _path
          .split('/')
          .last : '...';
      var pos = _fileName.lastIndexOf('.');
      String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
      print(extName);

      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
      setState(() {
        // widget.model.patientimg =base64Encode(enc);
        // widget.model.patientimgtype =extName;
        // labSignupModel.profileImage=base64Encode(enc);
        // labSignupModel.profileImageType=extName;

      });

    }
  }

  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 25);
    //var image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 80);
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
        // widget.model.patientimg =base64Encode(enc);
        // widget.model.patientimgtype =extName;
        // labSignupModel.profileImage=base64Encode(enc);
        // labSignupModel.profileImageType=extName;

      });

    }
  }

}
