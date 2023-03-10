import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user/models/LabSignupModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';
import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';

// ignore: must_be_immutable
class LabSignUpForm extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel titlemodel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel organizationModel = null;

  LabSignUpForm({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,

    this.model,
  }) : super(key: key);

  @override
  LabSignUpFormState createState() => LabSignUpFormState();
}

class LabSignUpFormState extends State<LabSignUpForm> {
  File _image;
  File pathUsr = null;
  LabSignupModel labSignupModel = LabSignupModel();
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
  bool _inProcess = false;

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
    LabSignUpForm.districtModel = null;
    LabSignUpForm.blockModel = null;
    LabSignUpForm.genderModel = null;

    LabSignUpForm.organizationModel =null;
    LabSignUpForm.titlemodel = null;
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
                          Column(
                            children: [
                              Text(MyLocalizations.of(context).text("FILL_IN_PERSONAL_INFORMATION"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ],
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
                                  MyLocalizations.of(context)
                                      .text("ORGANIZATION_NAME") ,
                                  ApiFactory.ORGANISATION_API, "organisation", Icons.location_on_rounded,
                                  23.0,
                                      (KeyvalueModel data) {
                                    setState(() {

                                      print(ApiFactory.ORGANIZATION_API);
                                      LabSignUpForm.organizationModel = data;

                                    });
                                  }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0),
                            child: SizedBox(
                              height: 58,
                              child:
                              DropDown.networkDropdownGetpartUser(
                                  MyLocalizations.of(context)
                                      .text("TITLE") ,
                                  ApiFactory.TITLE_API,
                                  "title",
                                  Icons.person,
                                  23.0, (KeyvalueModel data) {
                                setState(() {
                                  print(ApiFactory.TITLE_API);
                                  LabSignUpForm.titlemodel = data;
                                  //userModel.title=data.key;
                                  // UserSignUpForm.cityModel = null;
                                });
                              }),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          formField1(1, MyLocalizations.of(context).text("PROFESSIONAL_NAME")),
                          SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0),
                            child: SizedBox(
                              height: 58,
                              child:
                              DropDown.networkDropdownGetpartUser(
                                  MyLocalizations.of(context)
                                      .text("GENDER"),
                                  ApiFactory.GENDER_API,
                                  "gender",
                                  Icons.wc_outlined,
                                  23.0, (KeyvalueModel data) {
                                setState(() {
                                  /* print(ApiFactory.GENDER_API);
                                      DoctorSignUpForm3.genderModel = data;
                                      userModel.title = data.key;*/
                                  print(ApiFactory.GENDER_API);
                                  LabSignUpForm.genderModel = data;
                                  // UserSignUpForm.cityModel = null;
                                });
                              }),
                            ),
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

                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 100),
                              //   child: InkWell(
                              //     onTap: (){
                              //       _settingModalBottomSheet(context);
                              //     },
                              //       child: Icon(Icons.camera_alt,size: 50,)),
                              //
                            ],
                          ),
                          SizedBox(height: 15),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10),
                            child: nextButton1(),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
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

  Widget gender() {
    return DropDown.searchDropdowntyp("Gender", "genderPartner", genderList,
        (KeyvalueModel model) {
      LabSignUpForm.genderModel = model;
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

  // Widget nextButton1() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, "/labsignup2");
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       margin: EdgeInsets.only(left: 180, right: 0),
  //       decoration: BoxDecoration(
  //           color: AppData.kPrimaryColor,
  //           borderRadius: BorderRadius.circular(10.0),
  //           gradient: LinearGradient(
  //               begin: Alignment.bottomRight,
  //               end: Alignment.topLeft,
  //               colors: [Colors.blue, AppData.kPrimaryColor])),
  //       child: Padding(
  //         padding:
  //             EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
  //         child: Text(
  //           MyLocalizations.of(context).text("NEXT"),
  //           textAlign: TextAlign.center,
  //           style: TextStyle(color: Colors.white, fontSize: 16.0),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget nextButton1() {
    return MyWidgets.nextButton(
      text:MyLocalizations.of(context).text("NEXT"),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/patientRegistration2");
         if (LabSignUpForm.organizationModel == null ||
        LabSignUpForm.organizationModel == "") {
          AppData.showInSnackBar(context, "Please select organization name");
        }else if (LabSignUpForm.titlemodel == null ||
             LabSignUpForm.titlemodel == "") {
           AppData.showInSnackBar(context, "Please select title");
         } else if(textEditingController[1].text == "" ||
            textEditingController[1].text == null) {
          AppData.showInSnackBar(context, "Please enter professional's name");
          FocusScope.of(context).requestFocus(fnode1);
        } else if (textEditingController[1].text.length <= 3) {
          AppData.showInSnackBar(context, "Please enter valid professional's name ");
          FocusScope.of(context).requestFocus(fnode1);
        } else if (LabSignUpForm.genderModel == null ||
             LabSignUpForm.genderModel == "") {
           AppData.showInSnackBar(context, "Please select gender");
         }
         else {
          widget.model.organization = LabSignUpForm.organizationModel.key;
          widget.model.labprofessionalname = textEditingController[1].text;
          widget.model.title1 = LabSignUpForm.titlemodel.key;
          widget.model.labgender = LabSignUpForm.genderModel.key;
          Navigator.pushNamed(context, "/labsignup3");
        ///  Navigator.pushNamed(context, "/labsignup2");
        }
      },
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
    } else if (LabSignUpForm.genderModel == null ||
        LabSignUpForm.genderModel == "") {
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
    } else if (LabSignUpForm.districtModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT DISTRICT");
    } else if (LabSignUpForm.blockModel == null) {
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

  Widget formField(
    int index,
    String hint,
  ) {
    return TextFieldContainer(
      child: TextFormField(
        controller: textEditingController[index],
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
            keyboardType: TextInputType.text,
            controller: textEditingController[index],
            focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },
            inputFormatters: [
              WhitelistingTextInputFormatter(
                  RegExp("[a-zA-Z ]")),
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
                      //getImage(ImageSource.camera),
                        }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),
                    getGalleryImage(),
                    //getImage(ImageSource.gallery),
                  },
                ),
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
        // widget.model.patientimg =base64Encode(enc);
        // widget.model.patientimgtype =extName;
        // labSignupModel.profileImage=base64Encode(enc);
        // labSignupModel.profileImageType=extName;
      });
    }
  }

  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
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

  // getImage(ImageSource source) async {
  //   this.setState((){
  //     _inProcess = true;
  //   });
  //   File image = await ImagePicker.pickImage(source: source);
  //   if(image != null){
  //     File cropped = await ImageCropper.cropImage(
  //         sourcePath: image.path,
  //         aspectRatio: CropAspectRatio(
  //             ratioX: 1, ratioY: 1),
  //         compressQuality: 100,
  //         maxWidth: 700,
  //         maxHeight: 700,
  //         compressFormat: ImageCompressFormat.jpg,
  //         androidUiSettings: AndroidUiSettings(
  //           // textAlign: TextAlign.center,
  //           toolbarColor: AppData.kPrimaryColor,
  //           toolbarTitle: "Image Cropper",
  //           toolbarWidgetColor: Colors.white,
  //           //centerTitle: true,
  //           //toolbar.setTitleTextColor(Color.RED);
  //           ///statusBarColor: Colors.deepOrange.shade900,
  //           backgroundColor: Colors.white,
  //         )
  //     );
  //     if (cropped != null) {
  //       var enc = await cropped.readAsBytes();
  //       String _path = image.path;
  //       setState(() => pathUsr = cropped);
  //
  //       String _fileName = _path != null ? _path.split('/').last : '...';
  //       var pos = _fileName.lastIndexOf('.');
  //       String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
  //       print(extName);
  //       print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
  //       setState(() {
  //         pathUsr = cropped;
  //         _inProcess = false;
  //
  //         labSignupModel.profileImage = base64Encode(enc);
  //         labSignupModel.profileImageType = extName;
  //         // callApii();
  //         // widget.model.patientimg =base64Encode(enc);
  //         //widget.model.patientimgtype =extName;
  //         //updateProfileModel.profileImage = base64Encode(enc) as List<Null>;
  //         //updateProfileModel.profileImageType = extName;
  //         //updateProfile(base64Encode(enc), extName);
  //       });
  //     }
  //     /*this.setState((){
  //       pathUsr = cropped;
  //       //updateProfile(base64Encode(cropped), extName);
  //       _inProcess = false;
  //     });*/
  //   } else {
  //     this.setState((){
  //       _inProcess = false;
  //     });
  //   }
  // }
  //

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
