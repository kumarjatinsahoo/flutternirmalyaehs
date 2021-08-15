import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';

import 'package:user/models/DocterMedicationModel.dart';

import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/SignUpForm.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_address.dart';
import 'package:user/widgets/text_field_container.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ignore: must_be_immutable
class MedicationAddScreen extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;

  static KeyvalueModel genderModel = null;
  static KeyvalueModel titleModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel cityModel = null;
  static KeyvalueModel medicinModel = null;

  MedicationAddScreen({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  MedicationAddScreenState createState() => MedicationAddScreenState();
}

enum TypeDob { Age, DOB }

class MedicationAddScreenState extends State<MedicationAddScreen> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  DateTime selectedDate = DateTime.now();
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
  ];

  String token;
  TypeDob selectDobEn = TypeDob.Age;

  List<bool> error = [false, false, false, false, false, false];
  bool _isSignUpLoading = false;

  TextEditingController statedate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  TextEditingController typecont = TextEditingController();
  TextEditingController expdt = TextEditingController();

  // List<bool> error = [false, false, false, false, false, false];
  FocusNode firstname_ = new FocusNode();
  FocusNode middelname_ = new FocusNode();
  FocusNode lastname_ = new FocusNode();
  FocusNode age_ = new FocusNode();
  FocusNode postal_ = new FocusNode();
  FocusNode address_ = new FocusNode();
  FocusNode email_ = new FocusNode();
  FocusNode attendantname_ = new FocusNode();

  TextEditingController _email = TextEditingController();
  FocusNode emailFocus_ = FocusNode();

  List<bool> dropdownError = [false, false, false];
  var color = Colors.black;
  var strokeWidth = 3.0;
  File _imageCertificate;
  bool selectGallery = false;
  var image;
  var pngBytes;
  String selectedDatestr;
  KeyvalueModel selectedKey = null;
  final df = new DateFormat('dd/MM/yyyy');
  final df1 = new DateFormat('yyyy');
  bool ispartnercode = false;

  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox = false;
  String _checkboxstr = "0";
  String _checkboxstr1 = "0";
  String _checkboxstr2 = "0";

  Future<Null> _selectDate(BuildContext context, String comeFrom) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate:
            DateTime.now().add(Duration(days: 6570))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      selectedDatestr = df.format(selectedDate).toString();
      statedate.value = TextEditingValue(text: df.format(selectedDate));
      //MyWidgets.showLoading(context);
    });
  }

  Future<Null> _selectDate1(BuildContext context, String comeFrom) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate:
            DateTime.now().add(Duration(days: 6570))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      selectedDatestr = df.format(selectedDate).toString();
      enddate.value = TextEditingValue(text: df.format(selectedDate));
      //MyWidgets.showLoading(context);
    });
  }

  /* Future<Null> _selectDate(BuildContext context) async {
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
        error[5] = false;
        textEditingController[5].value =
            TextEditingValue(text: df.format(picked));
      });
  }*/

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

  File pathUsr = null;
  TextEditingController dob = TextEditingController();

  ///UserRegistrationModel userModel;
  DoctorMedicationModel doctorMedicationModel = DoctorMedicationModel();

  @override
  void initState() {
    super.initState();
    MedicationAddScreen.genderModel = null;
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Medication"),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
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
                            SizedBox(height: 10),
                            Text(
                              widget.model.appointmentlist.patname??""
                             /* "Medicine"*/,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: SizedBox(
                                height: 58,
                                child: DropDown.networkDropdownGetpartUser(
                                    "Medicine",
                                    ApiFactory.MEDICINE_API,
                                    "medicine",
                                    Icons.fiber_manual_record,
                                    23.0, (KeyvalueModel data) {
                                  setState(() {
                                    print(ApiFactory.MEDICINE_API);
                                    MedicationAddScreen.medicinModel = data;
                                    textEditingController[0].text =
                                        MedicationAddScreen.medicinModel.code;

                                    /* userModel.country=data.key;
                                                    userModel.countryCode=data.code;*/
                                  });
                                }),
                              ),
                            ),
                            fromField1(0, "Type", TextInputAction.next,
                                TextInputType.text, firstname_, lastname_, "Type"),
                            SizedBox(
                              height: 10,
                            ),
                            statedatefrom(),
                            SizedBox(
                              height: 10,
                            ),
                            enddateform(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Morning: ',
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.blue,
                                    value: this._checkbox,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this._checkbox = value;
                                        if (_checkbox = true) {
                                          _checkboxstr = "1";
                                          // AppData.showInSnackBar(context,_checkboxstr );
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            //Divider(height: 2,color: Colors.black),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Afternoon ',
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.blue,
                                    value: this._checkbox1,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this._checkbox1 = value;
                                        if (_checkbox1 = true) {
                                          _checkboxstr1 = "1";
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),

                            //Divider(height: 2,color: Colors.black),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Evening ',
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.blue,
                                    value: this._checkbox2,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this._checkbox2 = value;
                                        if (_checkbox2 = true) {
                                          _checkboxstr2 = "1";
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            fromAddress(
                                1,
                                "Remark",
                                TextInputAction.next,
                                TextInputType.text,
                                lastname_,
                                null,
                                "reasonforchoiceofDr"),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:  _submitButton(),
                        ),
                        SizedBox(
                          height: 25,
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
    ));
  }

  Widget statedatefrom() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context, "Statdate"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: statedate,
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
                    "Start Date",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
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

  Widget enddateform() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate1(context, "enddate"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: enddate,
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
                    "End Date",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
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

  Widget dobBirth() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        /*  onTap: () => _selectDate(context),*/
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
      MedicationAddScreen.genderModel = model;
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

  Widget fromField1(int index, String hint, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type) {
    return TextFieldContainer(
      child: AbsorbPointer(
        child: TextFormField(
          controller: textEditingController[index],
          focusNode: currentfn,
          textInputAction: inputAct,
          inputFormatters: [
            //UpperCaseTextFormatter(),
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
          keyboardType: keyType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),

            // suffixIcon: Icon(Icons.person_rounded),
            //contentPadding: EdgeInsets.symmetric(vertical: 10)
          ),
          textAlignVertical: TextAlignVertical.center,
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
            "Add",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget fromAddress(int index, String hint, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type) {
    return TextFieldAddress(
      child: TextFormField(
        controller: textEditingController[index],
        focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          // suffixIcon: Icon(Icons.person_rounded),
          //contentPadding: EdgeInsets.symmetric(vertical: 10)
        ),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (newValue) {},
        onFieldSubmitted: (value) {
          print("ValueValue" + error[index].toString());
          setState(() {
            error[index] = false;
          });
          AppData.fieldFocusChange(context, currentfn, nextFn);
        },
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
                //focusNode: fnode7,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                  border: InputBorder.none,
                  counterText: "",
                  hintText:
                      MyLocalizations.of(context).text("PHONE_NUMBER") + "*",
                  hintStyle: TextStyle(color: AppData.hintColor, fontSize: 17),
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
                  //AppData.fieldFocusChange(context, fnode7, fnode8);
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
  Widget  _submitButton() {
    return MyWidgets.nextButton(
      text: "Add".toUpperCase(),
      context: context,
      fun: () {
        //print("form submit");
        if (MedicationAddScreen.medicinModel == null ||
            MedicationAddScreen.medicinModel == "") {
          AppData.showInSnackBar(context, "Please select Medicin");
          /*} else if (textEditingController[0].text == "" ||
        textEditingController[0].text == null) {
      AppData.showInSnackBar(context, "Please enter type");*/
        } else if (statedate.text == "" || statedate.text == null) {
          AppData.showInSnackBar(context, "Please select start date ");
        } else if (enddate.text == "" || enddate.text == null) {
          AppData.showInSnackBar(context, "Please select end date ");
        } else if (textEditingController[1].text == "" ||
            textEditingController[1].text == null) {
          AppData.showInSnackBar(context, "Please enter remark");
        } else {
          // PatientSignupModel patientSignupModel = PatientSignupModel();
          doctorMedicationModel.userid = widget.model.appointmentlist.userid;
          doctorMedicationModel.appno = widget.model.appointmentlist.doctorName;
          doctorMedicationModel.medname = MedicationAddScreen.medicinModel.key;
          doctorMedicationModel.fromdate = statedate.text;
          doctorMedicationModel.todate = enddate.text;
          doctorMedicationModel.remarks = textEditingController[1].text;
          doctorMedicationModel.doctor = widget.model.user;
          doctorMedicationModel.morning = _checkboxstr;
          doctorMedicationModel.afternoon = _checkboxstr1;
          doctorMedicationModel.evening = _checkboxstr2;

          //log(jsonEncode(doctorMedicationModel.toJson()));
          MyWidgets.showLoading(context);
          widget.model.POSTMETHOD_TOKEN(
              api: ApiFactory.POST_MEDICATION,
              json: doctorMedicationModel.toJson(),
              token: widget.model.token,
              fun: (Map<String, dynamic> map) {
                Navigator.pop(context);
                if (map[Const.STATUS] == Const.SUCCESS) {
                  popup(context, map[Const.MESSAGE],map[Const.BODY]);
                } else {
                  AppData.showInSnackBar(context, map[Const.MESSAGE]);
                }
              });
        }

      },
    );
  }
  validate() async {
    _formKey.currentState.validate();

  }

  popup(BuildContext context, String message,String body) {
    return Alert(
        context: context,
        title: message,
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
              Navigator.pop(context);
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
                    getGalleryImage(),
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
        /*userModel.profileImage=base64Encode(enc);
        userModel.profileImageType=extName;
*/
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
        /*userModel.profileImage=base64Encode(enc);
        userModel.profileImageType=extName;
*/
      });
    }
  }
}
