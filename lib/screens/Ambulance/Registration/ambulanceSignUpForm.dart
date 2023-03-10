import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
class AmbulanceSignUpForm extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel organizationModel = null;
  static KeyvalueModel pharmacyModel = null;
  static KeyvalueModel ambulanceModel = null;
  static KeyvalueModel titlemodel = null;

  AmbulanceSignUpForm({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  AmbulanceSignUpFormState createState() => AmbulanceSignUpFormState();
}

class AmbulanceSignUpFormState extends State<AmbulanceSignUpForm> {
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
    AmbulanceSignUpForm.districtModel = null;
    AmbulanceSignUpForm.blockModel = null;
    AmbulanceSignUpForm.genderModel = null;
    AmbulanceSignUpForm.ambulanceModel = null;
    AmbulanceSignUpForm.titlemodel = null;
    AmbulanceSignUpForm.genderModel = null;

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
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        title: Text(
          MyLocalizations.of(context).text("SIGNUP"),
          style: TextStyle(color: Colors.white),
        ),

        //automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            /*  Padding(
      padding: const EdgeInsets.only( left:5.0,right: 5.0,top: 5.0),
      child:*/ /*Container(
              color: AppData.kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.only( left:15.0,right: 15.0),

                child: Row(*/ /*
        mainAxisAlignment: MainAxisAlignment.start,*/ /*
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
                    */ /*Align(
            alignment: Alignment.center,
            child: Text('SIGN UP',textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.white,),
          ),
          ),*/ /*
                  ],
                ),
              ),
              height: 55,
              width: MediaQuery.of(context).size.width,
              */ /*  height:*/ /*
            ),*/

            /* ),*/
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
                                        MyLocalizations.of(context).text(
                                            "FILL_IN_PERSONAL_INFORMATION"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  DropDown.networkDropdownGetpartUser1(
                                      MyLocalizations.of(context)
                                          .text("ORGANIZATION_NAME"),
                                      ApiFactory.AMBULANCE_ORGANISATION_API,
                                      "ambulance",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory
                                          .AMBULANCE_ORGANISATION_API);
                                      AmbulanceSignUpForm.ambulanceModel = data;
                                    });
                                  }),
                                  DropDown.networkDropdownGetpartUser1(
                                      MyLocalizations.of(context).text("TITLE"),
                                      ApiFactory.TITLE_API,
                                      "title",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.TITLE_API);
                                      AmbulanceSignUpForm.titlemodel = data;
                                    });
                                  }),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  formFieldName(
                                      9,
                                      MyLocalizations.of(context)
                                          .text("PROFESSIONAL_NAME"),
                                      fnode1,
                                      fnode2),
                                  SizedBox(height: 8.0),
                                  formFieldExperience(
                                      10,
                                      MyLocalizations.of(context)
                                          .text("EXPERIENCE"),
                                      fnode2,
                                      fnode3),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                   formField(
                                      11,
                                      MyLocalizations.of(context)
                                          .text("ADDRESS"),
                                      fnode3,
                                      null),

                                  DropDown.networkDropdownGetpartUser1(
                                      MyLocalizations.of(context)
                                          .text("GENDER"),
                                      ApiFactory.GENDER_API,
                                      "gender",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.GENDER_API);
                                      AmbulanceSignUpForm.genderModel = data;
                                    });
                                  }),
                                  SizedBox(height: 15),
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
    return MyWidgets.nextButton(
      text: MyLocalizations.of(context).text("NEXT"),
      context: context,
      fun: () {
        // Navigator.pushNamed(context, "/patientRegistration2");
        if (AmbulanceSignUpForm.ambulanceModel == null ||
            AmbulanceSignUpForm.ambulanceModel == "") {
          AppData.showInSnackBar(context, "Please select organization name");
        } else if (AmbulanceSignUpForm.titlemodel == null ||
            AmbulanceSignUpForm.titlemodel == "") {
          AppData.showInSnackBar(context, "Please select title");
        } else if (textEditingController[9].text == "" ||
            textEditingController[9].text == null) {
          AppData.showInSnackBar(context, "Please enter professional's name");
          FocusScope.of(context).requestFocus(fnode6);
        }  else if (textEditingController[9].text.length<3) {
          AppData.showInSnackBar(context, "Please enter valid professional's name");
          FocusScope.of(context).requestFocus(fnode6);
        } else if (textEditingController[10].text == "" ||
            textEditingController[10].text == null) {
          AppData.showInSnackBar(context, "Please enter experience");
          FocusScope.of(context).requestFocus(fnode6);
        } else if (textEditingController[11].text == "" ||
            textEditingController[11].text == null) {
          AppData.showInSnackBar(context, "Please enter address");
          FocusScope.of(context).requestFocus(fnode6);
        }  else if (textEditingController[11].text.length<3) {
          AppData.showInSnackBar(context, "Please enter valid address");
          FocusScope.of(context).requestFocus(fnode6);
      } else if (AmbulanceSignUpForm.genderModel == null ||
            AmbulanceSignUpForm.genderModel == "") {
          AppData.showInSnackBar(context, "Please select gender");
        } else {
          widget.model.ambulanceorganisation =
              AmbulanceSignUpForm.ambulanceModel.key;
          widget.model.ambulancetitle = AmbulanceSignUpForm.titlemodel.key;
          widget.model.ambulanceprofessional = textEditingController[9].text;
          widget.model.ambulanceexperience = textEditingController[10].text;
          widget.model.ambulanceaddress = textEditingController[11].text;
          widget.model.ambulancegender = AmbulanceSignUpForm.genderModel.key;

          Navigator.pushNamed(context, "/ambulancesignupform2");
        }
      },
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
    } else if (AmbulanceSignUpForm.genderModel == null ||
        AmbulanceSignUpForm.genderModel == "") {
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
    } else if (AmbulanceSignUpForm.districtModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT DISTRICT");
    } else if (AmbulanceSignUpForm.blockModel == null) {
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

  // Widget formField(int index, String hint,) {
  //   return TextFieldContainer(
  //     child: Container(
  //       height: 50,
  //       padding:
  //       EdgeInsets.symmetric(horizontal: 5),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius:
  //         BorderRadius.circular(5),
  //         border: Border.all(
  //             color: Colors.black, width: 0.3),
  //       ),
  //       child: TextFormField(
  //         controller: textEditingController[index],
  //         textInputAction: TextInputAction.done,
  //         keyboardType:TextInputType.text,
  //         /* decoration: BoxDecoration(11
  //           color: AppData.kPrimaryLightColor,
  //           //color: Color(0x45283e81),
  //           borderRadius: BorderRadius.circular(29),
  //         ),*/
  //         style: TextStyle(fontSize: 13),
  //         decoration: InputDecoration(
  //             hintText: hint,
  //             hintStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
  //             border: InputBorder.none,
  //             contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
  //         onChanged: (newValue) {},
  //       ),
  //     ),
  //   );
  // }
  Widget formFieldExperience(
      int index, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  enabled: widget.isConfirmPage ? false : true,
                  controller: textEditingController[index],
                  focusNode: currentfn,
                  cursorColor: AppData.kPrimaryColor,
                  textInputAction: TextInputAction.next,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    counterText: "",
                    hintText: hint,
                    hintStyle:
                        TextStyle(color: AppData.hintColor, fontSize: 15),
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

  Widget formField(
      int index, String hint, FocusNode currentfn, FocusNode nextFn) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              //counterText: "",
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
            ),
            textInputAction: TextInputAction.next,
            focusNode: currentfn,
           // maxLength: 3,
            keyboardType: TextInputType.text,
            controller: textEditingController[index],
            textAlignVertical: TextAlignVertical.center,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z. , / 0-9 ]")
              ),
            ],

            onFieldSubmitted: (value) {
              setState(() {});
              AppData.fieldFocusChange(context, currentfn, nextFn);
            },
          ),
        ),
      ),
    );
  }

  Widget formFieldName(
      int index, String hint, FocusNode currentfn, FocusNode nextFn) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              //counterText: "",
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
            ),
            textInputAction: TextInputAction.next,
            focusNode: currentfn,
            // maxLength: 3,
            keyboardType: TextInputType.text,
            controller: textEditingController[index],
            textAlignVertical: TextAlignVertical.center,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z. ]")
              ),
            ],

            onFieldSubmitted: (value) {
              setState(() {});
              AppData.fieldFocusChange(context, currentfn, nextFn);
            },
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
