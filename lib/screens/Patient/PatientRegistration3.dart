import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/PatientRegModel.dart';
import 'package:user/providers/Aadhar.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:user/widgets/text_field_container.dart';

class PatientRegistration3 extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel countryModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel cityModel = null;

  const PatientRegistration3({Key key, this.model}) : super(key: key);

  @override
  _PatientRegistration3State createState() => _PatientRegistration3State();
}

class _PatientRegistration3State extends State<PatientRegistration3> {
  var selectedMinValue;
  File pathUsr = null;
  PatientRegModel patientRegModel;

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  String email;

  @override
  void initState() {
    // TODO: implement initState
    callApi();

  }
  callApi(){
    widget.model.GETMETHODCALL(
        api: ApiFactory.PATIENT_REG_ADDRESS+widget.model.loginResponse1.body.user,
        //token: widget.model.loginResponse.body.token,
        fun: (Map<String, dynamic> map){
          if (map[Const.CODE] == Const.SUCCESS) {
            patientRegModel=PatientRegModel.fromJson(map);
            log("?????"+patientRegModel.body[0].countryId+"name:"+ patientRegModel.body[0].countryName);
            PatientRegistration3.countryModel=new KeyvalueModel(
                key: patientRegModel.body[0].countryId,name: patientRegModel.body[0].countryName);
            PatientRegistration3.stateModel=new KeyvalueModel(
              key: patientRegModel.body[0].stateId,name: patientRegModel.body[0].stateName);
            PatientRegistration3.districtModel=new KeyvalueModel(
              key: patientRegModel.body[0].districtId,name: patientRegModel.body[0].districtName);
            PatientRegistration3.cityModel=new KeyvalueModel(
              key: patientRegModel.body[0].cityId,name: patientRegModel.body[0].cityName);
            setState(() {

            });
          }else {
            setState(() {
              //isDataNoFound = true;
              // AppData.showInSnackBar(context, msg);
            });
          }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        /*leading: BackButton(
              color: Colors.white,
            ),*/
        title: Text(
          MyLocalizations.of(context).text("PATIENT_REGISTRATION"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    MyLocalizations.of(context).text("PROFILE"),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: NumberformField(0,MyLocalizations.of(context).text("HEIGHT")),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: NumberformField(1, MyLocalizations.of(context).text("WEIGHT")),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: formField(2, MyLocalizations.of(context).text("EMAILID1")),
                  ),
                  SizedBox(
                    height:5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: adharaformField(3, MyLocalizations.of(context).text("AADHAAR_NO")),
                  ),

                  /* Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 7.0),
                    child: SizedBox(
                      height: 45,
                      child: DropDown.networkDropdownGetpart(
                          "State", ApiFactory.STATE_API, "state",
                              (KeyvalueModel data) {
                            setState(() {
                              PatientRegistration3.stateModel = data;
                              */ /*PartnerSignUpForm.cityModel = null;*/ /*
                            });
                          }),
                    ),
                  ),*/
                  SizedBox(
                    height:7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: SizedBox(
                      height: 55,
                      child: DropDown.networkDropdownGetpart4(
                          MyLocalizations.of(context).text("COUNTRY"),
                          ApiFactory.COUNTRY_API, "countryReg",
                          (KeyvalueModel data) {
                        setState(() {
                          print(ApiFactory.COUNTRY_API);
                          PatientRegistration3.countryModel = data;
                          PatientRegistration3.stateModel = null;
                          PatientRegistration3.districtModel = null;
                          PatientRegistration3.cityModel = null;
                        });
                      }),
                    ),
                  ),
                  SizedBox(
                    height:7,
                  ),
                  (PatientRegistration3.countryModel != null)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 7.0),
                          child: SizedBox(
                            height: 55,
                            child: DropDown.networkDropdownGetpart4(
                                MyLocalizations.of(context).text("STATE"),
                                ApiFactory.STATE_API +
                                    PatientRegistration3.countryModel.key,
                                "stateReg", (KeyvalueModel data) {
                              setState(() {
                                PatientRegistration3.stateModel = data;
                                PatientRegistration3.districtModel = null;
                                PatientRegistration3.cityModel = null;
                              });
                            }),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 2,
                  ),
                  (PatientRegistration3.stateModel != null)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 7.0),
                          child: SizedBox(
                            height: 55,
                            child: DropDown.networkDropdownGetpart4(
                                MyLocalizations.of(context).text("DIST"),
                                ApiFactory.DISTRICT_API +
                                    PatientRegistration3.stateModel.key,
                                "districtReg", (KeyvalueModel data) {
                              setState(() {
                                PatientRegistration3.districtModel = data;
                                PatientRegistration3.cityModel = null;
                              });
                            }),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height:2,
                  ),
                  (PatientRegistration3.districtModel != null)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 7.0),
                          child: SizedBox(
                            height: 55,
                            child: DropDown.networkDropdownGetpart4(
                                MyLocalizations.of(context).text("CITY"),
                                ApiFactory.CITY_API +
                                    PatientRegistration3.districtModel.key,
                                "cityReg", (KeyvalueModel data) {
                              setState(() {
                                PatientRegistration3.cityModel = data;
                              });
                            }),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: _submitButton(),
                  ),
                  SizedBox(
                    height: size.height * 0.20,
                  ),
                ]),
          )
        ],
      ),
    );
  }

  Widget formField(
    int index,
    String hint,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Container(
          //color: Colors.white,
          height: 47,
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), //shadow direction: bottom right
              )
            ],
          ),
          child: TextFormField(
            //enabled: widget.isConfirmPage ? false : true,
            controller: textEditingController[index],
            //focusNode: fnode7,
            cursorColor: AppData.kPrimaryColor,
            textInputAction: TextInputAction.next,
            /* maxLength: 10,*/
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              /* suffixIcon: Icon(Icons.phone),*/
              border: InputBorder.none,

              //hintText:"Patient Name",
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black26, fontSize: 17),
            ),
            //validator: (val) => AppData.isValidEmail(textEditingController[2].text)? null : "Check your email",
            // validator: (input) => AppData.isValidEmail(2) ? null : "Check your email",
            onSaved: (String value) {
              // email = value;
              //userPersonalForm.phoneNumber = value;
            },
          ),
        ) /*),*/
        );
  }

  /*Widget EmailFieldNew(String hint, bool enb, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
      child: TextFormField(
        autofocus: false,
        controller: controller[index],
        focusNode: currentfn,
        textInputAction: inputAct,
        //inputFormatters: [AppData.filtterInputType(format: "0-9")],
        */ /* inputFormatters: [
          UpperCaseTextFormatter(),
          //WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],*/ /*
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
  Widget NumberformField(
    int index,
    String hint,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Container(
          //color: Colors.white,
          height: 47,
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), //shadow direction: bottom right
              )
            ],
          ),
          child: TextFormField(
            //enabled: widget.isConfirmPage ? false : true,
            controller: textEditingController[index],
            //focusNode: fnode7,
            cursorColor: AppData.kPrimaryColor,
            textInputAction: TextInputAction.next,
            maxLength: 5,
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[0-9. ]")),
            ],
            decoration: InputDecoration(
              /* suffixIcon: Icon(Icons.phone),*/
              border: InputBorder.none,
              counterText: "",
              //hintText:"Patient Name",
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black26, fontSize: 17),
            ),
            onSaved: (value) {
              //userPersonalForm.phoneNumber = value;
            },
          ),
        ) /*),*/
        );
  }

  Widget adharaformField(
    int index,
    String hint,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Container(
          //color: Colors.white,
          height: 47,
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), //shadow direction: bottom right
              )
            ],
          ),
          child: TextFormField(
            //enabled: widget.isConfirmPage ? false : true,
            controller: textEditingController[index],
            //focusNode: fnode7,
            cursorColor: AppData.kPrimaryColor,
            textInputAction: TextInputAction.next,
            maxLength: 12,
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[0-9. ]")),
            ],
            decoration: InputDecoration(
              /* suffixIcon: Icon(Icons.phone),*/
              border: InputBorder.none,
              counterText: "",
              //hintText:"Patient Name",
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black26, fontSize: 17),
            ),
            onSaved: (value) {
              //userPersonalForm.phoneNumber = value;
            },
          ),
        ) /*),*/
        );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text:  MyLocalizations.of(context).text("NEXT").toUpperCase(),
      context: context,
      fun: () {
        // if (textEditingController[0].text == "" ||
        //     textEditingController[0].text == null) {
        //   AppData.showInSnackBar(context, "Please enter height(cm)");
        //
        // }else if (double.tryParse(textEditingController[0].text)>250) {
        //   AppData.showInSnackBar(
        //       context, "Invalid height");
        if (textEditingController[0].text.trim()=="") {
          //AppData.showInSnackBar(context, "Please select Smoking");
          AppData.showInSnackBar(
              context, "Please enter height");

        }else if (double.tryParse(textEditingController[0].text)>250) {
          //AppData.showInSnackBar(context, "Please select Smoking");
          AppData.showInSnackBar(
              context, "Invalid height");
        }else if (textEditingController[1].text.trim()=="") {
          //AppData.showInSnackBar(context, "Please select Smoking");
          AppData.showInSnackBar(
              context, "Please enter weight");
        }else if (double.tryParse(textEditingController[1].text)>636) {
          //AppData.showInSnackBar(context, "Please select Smoking");
          AppData.showInSnackBar(
              context, "Invalid weight");

        } else if (textEditingController[2].text != ""  &&
            !AppData.isValidEmail(textEditingController[2].text)) {
          AppData.showInSnackBar(context, "Please enter a valid e-mail");
        // } else if (textEditingController[3].text != '' &&
        //     textEditingController[3].text.length != 12) {
        //   AppData.showInSnackBar(context, "Please enter a valid aadhaar no.");

        } else if (textEditingController[3].text != ""  && (!Aadhar.validateVerhoeff(
            textEditingController[3].text.replaceAll("-", "").toString())|| textEditingController[3].text.length!=12)) {
          AppData.showInSnackBar(context, "Please enter valid aadhar no");


        } else if (PatientRegistration3.countryModel == null ||
            PatientRegistration3.countryModel == "") {
          AppData.showInSnackBar(context, "Please select country");
        } else if (PatientRegistration3.stateModel == null ||
            PatientRegistration3.stateModel == "") {
          AppData.showInSnackBar(context, "Please select state");
        } else if (PatientRegistration3.districtModel == null ||
            PatientRegistration3.districtModel == "") {
          AppData.showInSnackBar(context, "Please select district");
        } else if (PatientRegistration3.cityModel == null ||
            PatientRegistration3.cityModel == "") {
          AppData.showInSnackBar(context, "Please select city");
          /* } else if (textEditingController[2].text != '' &&
            !AppData.isValidEmail(textEditingController[2].text)) {
          AppData.showInSnackBar(context, "Please enter a valid E-mail");*/
          // return false;

        } else {
          widget.model.patientheight = textEditingController[0].text;
          widget.model.patientweight = textEditingController[1].text;
          widget.model.patientemail = textEditingController[2].text;
          widget.model.patientaadhar = textEditingController[3].text;
          widget.model.patienCountrykey = PatientRegistration3.countryModel.key;
          widget.model.patienCountrycode = PatientRegistration3.countryModel.code;
          widget.model.patienStatekey = PatientRegistration3.stateModel.key;
          widget.model.patienStatecode = PatientRegistration3.stateModel.code;
          widget.model.districtid = PatientRegistration3.districtModel.key;
          widget.model.patienCitykey = PatientRegistration3.cityModel.key;
          widget.model.patienCitycode = PatientRegistration3.cityModel.code;
          Navigator.pushNamed(context, "/patientRegistration4");
        }
      },
    );
  }

  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
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
    }
  }
}
