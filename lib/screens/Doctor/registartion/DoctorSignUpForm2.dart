import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user/models/UserRegistrationModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';
import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';

// ignore: must_be_immutable
class DoctorSignUpForm2 extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel titleModel = null;
  static KeyvalueModel organizationModel = null;


  DoctorSignUpForm2({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  DoctorSignUpForm2State createState() => DoctorSignUpForm2State();
}

class DoctorSignUpForm2State extends State<DoctorSignUpForm2> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  UserRegistrationModel userModel = UserRegistrationModel();

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
  Uint8List bytes;

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
    DoctorSignUpForm2.districtModel = null;
    DoctorSignUpForm2.blockModel = null;
    DoctorSignUpForm2.genderModel = null;
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
  Future openGallery() async {
    var _picker;

    _picker = ImagePicker();
    var pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {}
    setState(() {
      final File picture1 = File(pickedFile.path);
      bytes = picture1.readAsBytesSync();
    });
  }

  Future openCamera() async {

    var _picker;
    _picker = ImagePicker();
    var pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {}
    setState(() {
      final File picture1 = File(pickedFile.path);

      bytes = picture1.readAsBytesSync();
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                            child: Text('SIGN UP',
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.white,),),
                          ),

                        ],
                      ),
                    ),
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                  ),
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
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
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
                                      Text("Fill in personal Information (All fields are mandatory)",
                                        style: TextStyle(fontSize: 18, color: Colors.black),),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: SizedBox(
                                      height: 58,
                                      child:
                                      DropDown.networkDropdownGetpartUser(
                                          "Organization Name", ApiFactory.ORGANISATION_API, "organisation", Icons.location_on_rounded,
                                          23.0,
                                              (KeyvalueModel data) {
                                            setState(() {

                                              print(ApiFactory.ORGANISATION_API);
                                              DoctorSignUpForm2.organizationModel = data;

                                            });
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: SizedBox(
                                      height: 58,
                                      child:
                                      DropDown.networkDropdownGetpartUser(
                                          "title",
                                          ApiFactory.TITLE_API,
                                          "title",
                                          Icons.mail,
                                          23.0, (KeyvalueModel data) {
                                        setState(() {
                                          print(ApiFactory.TITLE_API);
                                          DoctorSignUpForm2.titleModel =
                                              data;
                                          userModel.title=data.key;
                                          // UserSignUpForm.cityModel = null;
                                        });
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  formField1(1, "Professional's Name"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // formField(10, "User Id"),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // formField(11, "Password"),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // formField(12, "Confirm Password"),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),

                                  // Column(
                                  //   //crossAxisAlignment: CrossAxisAlignment.start,
                                  //   // mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //
                                  //     GestureDetector(
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Card(
                                  //             child: Container(
                                  //                 width: 300,
                                  //                 height: 40,
                                  //                 color: Colors.white,
                                  //                 alignment: Alignment.center,
                                  //                 child: Row(
                                  //                     mainAxisSize: MainAxisSize.min,
                                  //                     children: [
                                  //                       //
                                  //                       //   Image.memory(bytes),
                                  //                       SizedBox(width:5),
                                  //                       Icon(
                                  //                         Icons.photo,
                                  //                         color: Colors.red,
                                  //                       ),
                                  //                       SizedBox(
                                  //                         width: 5,
                                  //                       ),
                                  //                       Text(' Upload Photo'),
                                  //                     ]
                                  //                 )
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         onTap: () {
                                  //           displayModalBottomSheet(context);
                                  //
                                  //           // openGallery();
                                  //         }
                                  //     ),
                                  //     _showImage(),
                                  //   ],
                                  // ),
                                  SizedBox(height: 35),

                                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: nextButton1(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),

                      ],),
                  ),
                ],
              ),
            ),
          ),


        )
    );
  }
  Widget gender() {
    return DropDown.searchDropdowntyp("Gender", "genderPartner", genderList,
            (KeyvalueModel model) {
          DoctorSignUpForm2.genderModel = model;
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
      text: "NEXT".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/patientRegistration2");
         if (DoctorSignUpForm2.organizationModel == null ||
            DoctorSignUpForm2.organizationModel == "") {
          AppData.showInSnackBar(context, "Please select organization name");
        }else if (DoctorSignUpForm2.titleModel == null ||
            DoctorSignUpForm2.titleModel == "") {
          AppData.showInSnackBar(context, "Please select title");
        }
        else if (textEditingController[1].text== "" || textEditingController[1].text== null) {
          AppData.showInSnackBar(context, "Please enter Professional's name");
        }
        else if (textEditingController[1].text.length <= 3) {
          AppData.showInSnackBar(context, "Please enter Professional Name ");
        }
        // else if (textEditingController[10].text== "" || textEditingController[10].text== null) {
        //   AppData.showInSnackBar(context, "Please enter Userid");
        // }
        // else if (textEditingController[10].text.length <= 3) {
        //   AppData.showInSnackBar(context, "Please enter valid Name ");
        // }
        // else if (textEditingController[11].text== "" || textEditingController[11].text== null) {
        //   AppData.showInSnackBar(context, "Please enter password");
        // }
        // else if (textEditingController[11].text.length <= 3) {
        //   AppData.showInSnackBar(context, "Please enter valid password ");
        // }
        // else if (textEditingController[12].text== "" || textEditingController[12].text== null) {
        //   AppData.showInSnackBar(context, "Please enter confirm password");
        // }
        // else if (textEditingController[12].text.length <= 3) {
        //   AppData.showInSnackBar(context, "Please enter valid password ");
        // }

        else {
          widget.model.organisationname = DoctorSignUpForm2.organizationModel.key;
          widget.model.title = DoctorSignUpForm2.titleModel.key;
          widget.model.professionalname = textEditingController[9].text;
          // widget.model.userid = textEditingController[10].text;
          // widget.model.password = textEditingController[11].text;
          // widget.model.cnfrmpwd = textEditingController[12].text;
          Navigator.pushNamed(context, "/doctorsignupform3");
        }
      },
    );

    // return GestureDetector(
    //   onTap: () {
    //
    //     Navigator.pushNamed(context, "/doctorsignupform3");
    //   },
    //   child: Container(
    //     width: MediaQuery.of(context).size.width,
    //     margin: EdgeInsets.only(left:180, right: 0),
    //     decoration: BoxDecoration(
    //         color: AppData.kPrimaryColor,
    //         borderRadius: BorderRadius.circular(10.0),
    //         gradient: LinearGradient(
    //             begin: Alignment.bottomRight,
    //             end: Alignment.topLeft,
    //             colors: [Colors.blue, AppData.kPrimaryColor])),
    //     child: Padding(
    //       padding:
    //       EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
    //       child: Text(
    //         MyLocalizations.of(context).text("NEXT"),
    //         textAlign: TextAlign.center,
    //         style: TextStyle(color: Colors.white, fontSize: 16.0),
    //       ),
    //     ),
    //   ),
    // );
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

  // Widget mobileNumber() {
  //   return Padding(
  //     //padding: const EdgeInsets.all(8.0),
  //     padding:
  //     const EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 0.0),
  //     child: Container(
  //       // decoration: BoxDecoration(
  //       //   color: AppData.kPrimaryLightColor,
  //       //   borderRadius: BorderRadius.circular(29),
  //       //   /*border: Border.all(
  //       //        color: Colors.black,width: 0.3)*/
  //       // ),
  //       child: Row(
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(left: 8),
  //             child: DropdownButton<String>(
  //               // hint: Text("Select Device"),
  //               underline: Container(
  //                 color: Colors.grey,
  //               ),
  //               value: AppData.currentSelectedValue,
  //               isDense: true,
  //               onChanged: (newValue) {
  //                 setState(() {
  //                   AppData.currentSelectedValue = newValue;
  //                 });
  //                 print(AppData.currentSelectedValue);
  //               },
  //               items: AppData.phoneFormat.map((String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Text(value),
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //           Container(
  //             height: 35.0,
  //             width: 1.0,
  //             color: Colors.grey.withOpacity(0.5),
  //             margin: const EdgeInsets.only(left: 00.0, right: 10.0),
  //           ),
  //           new Expanded(
  //             child: TextFormField(
  //               enabled: widget.isConfirmPage ? false : true,
  //               controller: textEditingController[4],
  //               focusNode: fnode7,
  //               cursorColor: AppData.kPrimaryColor,
  //               textInputAction: TextInputAction.next,
  //               maxLength: 10,
  //               keyboardType: TextInputType.number,
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 counterText: "",
  //                 hintText:
  //                 MyLocalizations.of(context).text("PHONE_NUMBER") + "*",
  //                 hintStyle: TextStyle(color: Colors.grey),
  //               ),
  //               validator: (value) {
  //                 if (value.isEmpty) {
  //                   error[4] = true;
  //                   return null;
  //                 }
  //                 error[4] = false;
  //                 return null;
  //               },
  //               onFieldSubmitted: (value) {
  //                 // print(error[2]);
  //                 error[4] = false;
  //                 setState(() {});
  //                 AppData.fieldFocusChange(context, fnode7, fnode8);
  //               },
  //               onSaved: (value) {
  //                 //userPersonalForm.phoneNumber = value;
  //               },
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget dob() {
  //   return Padding(
  //     //padding: const EdgeInsets.symmetric(horizontal: 8),
  //     padding: const EdgeInsets.symmetric(horizontal: 0),
  //     child: GestureDetector(
  //       onTap: () => widget.isConfirmPage ? null : _selectDate(context),
  //       child: AbsorbPointer(
  //         child: Container(
  //           // margin: EdgeInsets.symmetric(vertical: 10),
  //           height: 45,
  //           padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  //           // width: size.width * 0.8,
  //           decoration: BoxDecoration(
  //             // color: AppData.kPrimaryLightColor,
  //             // borderRadius: BorderRadius.circular(29),
  //             border: Border(
  //               bottom: BorderSide(
  //                 width: 2.0,
  //                 color: Colors.grey,
  //               ),
  //               // border: Border.all(color: Colors.black, width: 0.3)
  //             ),
  //           ),
  //           child: TextFormField(
  //             focusNode: fnode3,
  //             enabled: !widget.isConfirmPage ? false : true,
  //             controller: textEditingController[2],
  //             keyboardType: TextInputType.datetime,
  //             textAlign: TextAlign.left,
  //             onSaved: (value) {
  //               //userPersonalForm.dob = value;
  //               selectDob = value;
  //             },
  //             validator: (value) {
  //               if (value.isEmpty) {
  //                 error[2] = true;
  //                 return null;
  //               }
  //               error[2] = false;
  //               return null;
  //             },
  //             onFieldSubmitted: (value) {
  //               error[2] = false;
  //               // print("error>>>" + error[2].toString());
  //
  //               setState(() {});
  //               AppData.fieldFocusChange(context, fnode3, fnode4);
  //             },
  //             decoration: InputDecoration(
  //               hintText: MyLocalizations.of(context).text("DATE_OF_BIRTH"),
  //               border: InputBorder.none,
  //               //contentPadding: EdgeInsets.symmetric(vertical: 10),
  //               prefixIcon: Icon(
  //                 Icons.calendar_today,
  //                 size: 18,
  //                 color: AppData.kPrimaryColor,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
          context, MyLocalizations.of(context).text("PLEASE_ENTER_ORGANISATION_NAME"));
      FocusScope.of(context).requestFocus(fnode1);
    } else if (error[1] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_PROFESSIOAL _NAME"));
      FocusScope.of(context).requestFocus(fnode3);
    } else if (DoctorSignUpForm2.genderModel == null || DoctorSignUpForm2.genderModel == "") {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_SELECT_GENDER"));
      FocusScope.of(context).requestFocus(fnode2);
    } else if (textEditingController[5].text == '') {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_USER_ID"));
      FocusScope.of(context).requestFocus(fnode4);
    } else if (error[3] == true) {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_PASSWORD"));
      FocusScope.of(context).requestFocus(fnode5);
    } else if (error[2] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_CONFIRM_PASSWORD"));
      FocusScope.of(context).requestFocus(fnode6);
    }
     else {
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
  Widget formField1(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 5),
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
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(
                color: AppData.hintColor,
                fontSize: 17),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: textEditingController[index],
          textAlignVertical:
          TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(
                RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }
  void displayModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 00.0),
            child: Container(
              height: 150,
              // color: Colors.white,
              child: Center(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                                child: Container(
                                    width: 100,
                                    height: 100,
                                    alignment: Alignment.center,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //   Image.memory(bytes),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.camera,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Text(' Camera '),
                                          ),
                                        ])),
                                onTap: () {
                                  openCamera();
                                  Navigator.pop(context);

                                }),
                            SizedBox(width: 80),
                            GestureDetector(
                                child: Container(
                                    width: 100,
                                    height: 100,
                                    alignment: Alignment.center,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //   Image.memory(bytes),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.camera_alt,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Text('Gallery'),
                                          ),
                                        ])),
                                onTap: () {
                                  openGallery();
                                  Navigator.pop(context);
                                })
                          ],
                        ))),
              ),
            ),
          );
        });
  }


  Widget _showImage() {
    return Container(
      child: Center(
        child: Align(
          alignment: Alignment.center,
          child: bytes != null
              ? Container(
            padding: EdgeInsets.all(10.00),
            width: 100,
            height: 100,
            decoration: new BoxDecoration(
              border: Border.all(
                //color: Colors.red,
                  width: 0.1
              ),
              image: DecorationImage(
                  image: MemoryImage(bytes),
                  fit: BoxFit.fill
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0)
              ),

              // borderRadius: new BorderRadius.only(
              //   topLeft: const Radius.circular(100.0),
              //   topRight: const Radius.circular(100.0),
              //   bottomLeft: const Radius.circular(100.0),
              //   bottomRight: const Radius.circular(100.0),
              // ),
            ),
            // child: Image.memory(
            //   bytes,
            //   fit: BoxFit.fill,
            //   width: 400,
            //   height: 200,
            // ))
          )
              : Container(
              decoration: new BoxDecoration(
                border: Border.all(
                    color: Colors.red,
                    width: 0.1
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)
                ),
                // borderRadius: new BorderRadius.only(
                //   topLeft: const Radius.circular(100.0),
                //   topRight: const Radius.circular(100.0),
                //   bottomLeft: const Radius.circular(100.0),
                //   bottomRight: const Radius.circular(100.0),
                // ),
              )
          ),
        ),
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


}
