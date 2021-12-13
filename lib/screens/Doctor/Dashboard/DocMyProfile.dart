import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/ProfileModel1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/providers/text_field_container.dart';

import 'package:user/scoped-models/MainModel.dart';
import 'package:user/models/PatientListModel.dart';

class DocMyProfile extends StatefulWidget {
  MainModel model;

  DocMyProfile({Key key, this.model}) : super(key: key);

  @override
  _DocMyProfileState createState() => _DocMyProfileState();
}

class _DocMyProfileState extends State<DocMyProfile> {
  String loAd = "Loading..";
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  //Body model;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  ProfileModel1 profileModel1;
  List<bool> error = [false, false, false, false, false, false];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
    //model = widget.model.model;
  }

  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.USER_PROFILE + loginResponse.body.user,
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              profileModel1 = ProfileModel1.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  getGender(String gender) {
    switch (gender) {
      case "0":
        return "Male";
        break;
      case "1":
        return "Female";
        break;
      case "2":
        return "Transgender";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          /* leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
              Center(
                child: Text(
                  MyLocalizations.of(context).text("MY_PROFILE"),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //Spacer(),
                 Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: InkWell(
                    onTap: () {
                      if (profileModel1 != null) {
                        _displayTextInputDialog(context);
                      } else {
                        AppData.showInSnackBar(context,
                            "Please wait until we are fetching your data");
                      }
                    },
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
              /*Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/idCard");
                  },
                  child: Text(
                    "ID CARD",
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),*/
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
              )
            ],
          ),
          backgroundColor: AppData.kPrimaryColor,
          //centerTitle: true,
          // iconTheme: IconThemeData(color: AppData.kPrimaryColor,),
        ),
        /*appBar: AppBar(
          title: Text("User Profile"),
          titleSpacing: 2,
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),*/
        body: (profileModel1 != null)
            ? Container(
                height: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: AppData.matruColor.withOpacity(0.7),
                            ),
                          ),
                          _buildHeader(context)
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                         MyLocalizations.of(context).text("USER_INFORMATION").toUpperCase(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.calendar_today),
                                        title: Text(MyLocalizations.of(context).text("DOB1").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1.body.birthdate ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.wc),
                                        title: Text(MyLocalizations.of(context).text("GENDER").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1.body.gender ?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.book),
                                        title: Text(MyLocalizations.of(context).text("EDUCATION").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.education ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.work_outlined),
                                        title: Text(MyLocalizations.of(context).text("SPECIALITY").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.speciality ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.home_work_sharp),
                                        title: Text(MyLocalizations.of(context).text("ORGANIZATION").toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1.body.organization ??
                                            "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.contact_phone),
                                        title: Text(MyLocalizations.of(context).text("IMA_NO").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1.body.imano ?? "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("PAN_CARD_NO").toUpperCase(),
                                        ),
                                        subtitle:
                                            Text(profileModel1.body.pancardno),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("PASSPORT_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.passportno ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("VOTER_CARD_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.votercardno ??
                                                "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("LICENCE_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1.body.licenceno ??
                                                "N/A"),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        height: 13,
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(
                  loAd,
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
              ));
  }
  Future<void> _displayTextInputDialog(BuildContext context) async {
    /*ProfileScreen.relationmodel.key=patientProfileModel.body.eRelation.toString()??"N/A";
    ProfileScreen.specialitymodel.key=patientProfileModel.body.speciality.toString()??"N/A";
    ProfileScreen.bloodgroupmodel.key=patientProfileModel.body.bloodGroup.toString()??"N/A";*/

    //_fDoctor.text =(patientProfileModel != null)||(patientProfileModel.body.fDoctor==null)?"N/A":patientProfileModel.body.fDoctor.toString();
    //_eName.text =(patientProfileModel != null)||(patientProfileModel.body.eName!=null)? patientProfileModel.body.eName.toString():"N/A";
    //_docMobile.text =(patientProfileModel != null)||(patientProfileModel.body.docMobile == null)?patientProfileModel.body.docMobile:"N/A";
    //_eMobile.text = (patientProfileModel != null)||(patientProfileModel.body.eMobile==null)?"N/A":patientProfileModel.body.eMobile.toString();

    //patientProfileModel.body.eMobile.toString() == null?"N/A":_eMobile.text =patientProfileModel.body.eMobile.toString();
    //textEditingController[1].text = (patientProfileModel != null)||(patientProfileModel.body.eName == null)?patientProfileModel.body.eName.toString(): "N/A";
    //patientProfileModel.body.fDoctor.toString() == null?"N/A":_fDoctor.text =patientProfileModel.body.fDoctor.toString();
    //patientProfileModel.body.eName.toString() == null?"N/A":_eName.text =patientProfileModel.body.eName.toString();
    // patientProfileModel.body.docMobile.toString() == null?"N/A":_docMobile.text == patientProfileModel.body.docMobile;
    //textEditingController[5].text = (patientProfileModel != null)||(patientProfileModel.body.address == null)?patientProfileModel.body.address.toString(): "N/A";
  /*  textEditingController[5].text = patientProfileModel.body.address ?? "";
    textEditingController[1].text = patientProfileModel.body.eName ?? "";
    textEditingController[2].text = patientProfileModel.body.eMobile ?? "";
    textEditingController[3].text = patientProfileModel.body.fDoctor ?? "";
    textEditingController[4].text = patientProfileModel.body.docMobile ?? "";
    textEditingController[0].text = (patientProfileModel != null)
        ? myFormatDate(patientProfileModel.body.dob.toString())
        : "";
    updateProfileModel.eCardNo = patientProfileModel.body.id.toString();

    updateProfileModel.id = patientProfileModel.body.id.toString();
    if (patientProfileModel?.body?.bloodGroup == null ||
        patientProfileModel?.body?.bloodGroup == "") {
      ProfileScreen.bloodgroupmodel = null;
    }
    if (patientProfileModel?.body?.eRelation == null ||
        patientProfileModel?.body?.eRelation == "") {
      ProfileScreen.relationmodel = null;
    }
    if (patientProfileModel?.body?.speciality == null ||
        patientProfileModel?.body?.speciality == "") {
      ProfileScreen.specialitymodel = null;
    }
    if (patientProfileModel?.body?.eMobile == null ||
        patientProfileModel?.body?.eMobile == "") {
      textEditingController[2].text = "";
    }
    if (patientProfileModel?.body?.docMobile == null ||
        patientProfileModel?.body?.docMobile == "") {
      textEditingController[4].text = "";
    }
*/
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            MyLocalizations.of(context).text("UPDATE_PROFILE"),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          dob(MyLocalizations.of(context).text("DOB")),
                          SizedBox(
                            height: 20,
                          ),
                          /*Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context)
                                        .text("BLOODGROUP"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "Blood Group",
                                    ApiFactory.BLOODGROUP_API,
                                    "bloodgroup", (KeyvalueModel model) {
                                  setState(() {
                                    ProfileScreen.bloodgroupmodel = model;
                                    patientProfileModel.body.bloodGroupId =
                                        model.key;
                                    patientProfileModel.body.bloodGroup =
                                        model.name;
                                    // updateProfileModel.bloodGroup = model.key;
                                  });
                                }),
                              ]),*/


                          SizedBox(
                            height: 20,
                          ),
                          /*   Divider(height: 2, color: Colors.black),*/
                          formFieldMobileno(
                              2,
                              MyLocalizations.of(context)
                                  .text("EMERGENCY_CONTACT_NO"),
                              fnode2,
                              fnode3),
                          SizedBox(
                            height: 20,
                          ),
                          formField(
                              3,
                              MyLocalizations.of(context)
                                  .text("FAMILY_DOCTORS"),
                              fnode3,
                              fnode4),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context)
                                        .text("SPECIALITY"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                /*DropDown.networkDropdownlabler1(
                                    "Speciality",
                                    ApiFactory.SPECIALITY_API,
                                    "speciality", (KeyvalueModel model) {
                                  setState(() {
                                    ProfileScreen.specialitymodel = model;

                                    //updateProfileModel.speciality = model.key;
                                  });
                                }),*/
                              ]),
                          SizedBox(
                            height: 20,
                          ),
                          /*Divider(
                            height: 2,
                            color: Colors.black,
                          ),*/
                          formFieldMobileno(
                              4,
                              MyLocalizations.of(context).text("DOC_MOBILE"),
                              fnode4,
                              fnode5),
                          SizedBox(
                            height: 20,
                          ),
                         /* formFieldAddress(
                              5,
                              MyLocalizations.of(context).text("USER_ADDRESS"),
                              fnode5,
                              null),*/
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  setState(() {
                    //callApi();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(MyLocalizations.of(context).text("UPDATE")),
                //textColor: Colors.grey,
                /*child: Text(
                  MyLocalizations.of(context).text("SAVE"),
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),*/
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {
                    /*  if (_eMobile.text != "" && _eMobile.text.length != 10) {
           ScaffoldMessenger.of(context)
               .showSnackBar(SnackBar(content: Text("My amazing message! O.o")));
*/
                    if (textEditingController[0].text == "N/A" ||
                        textEditingController[0].text == null ||
                        textEditingController[0].text == "") {
                      //AppData.showInSnackBar(context, "Please enter Emergency Contact No.");
                      AppData.showInSnackBar(context, "Please enter DOB");

                    } else if (textEditingController[1].text == "N/A" ||
                        textEditingController[1].text == null ||
                        textEditingController[1].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Emergency Contact Name");
                      FocusScope.of(context).requestFocus(fnode1);
                    } else if (textEditingController[1].text != "" &&
                        textEditingController[1].text.length <= 2) {
                      AppData.showInSnackBar(context,
                          "Please enter valid Emergency Contact Name ");
                      FocusScope.of(context).requestFocus(fnode1);

                    } else if (textEditingController[2].text == "N/A" ||
                        textEditingController[2].text == null ||
                        textEditingController[2].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter  Emergency Contact No.");
                      FocusScope.of(context).requestFocus(fnode2);
                    } else if (textEditingController[2].text != "" &&
                        textEditingController[2].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Emergency Contact No.");
                      FocusScope.of(context).requestFocus(fnode2);
                    } else if (textEditingController[3].text == "" ||
                        textEditingController[3].text == null ||
                        textEditingController[3].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Family Doctor Name");
                      FocusScope.of(context).requestFocus(fnode3);
                    } else if (textEditingController[3].text != "" &&
                        textEditingController[3].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Family Doctor Name ");
                      FocusScope.of(context).requestFocus(fnode3);
                    /*} else if (ProfileScreen.specialitymodel == null ||
                        ProfileScreen.specialitymodel == "") {
                      AppData.showInSnackBar(
                          context, "Please select Speciality");*/
                    } else if (textEditingController[4].text == "N/A" ||
                        textEditingController[4].text == null ||
                        textEditingController[4].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter Doctor Mobile No.");
                      FocusScope.of(context).requestFocus(fnode4);
                    } else if (textEditingController[4].text != "" &&
                        textEditingController[4].text.length != 10) {
                      AppData.showInSnackBar(
                          context, "Please enter valid  Doctor Mobile No.");
                      FocusScope.of(context).requestFocus(fnode4);
                      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter Emergency Contact No."), backgroundColor: Colors.red,duration: Duration(seconds: 6),));
                    } else if (textEditingController[5].text == "N/A" ||
                        textEditingController[5].text == null ||
                        textEditingController[5].text == "") {
                      AppData.showInSnackBar(context, "Please enter Address");
                      FocusScope.of(context).requestFocus(fnode5);
                    } else if (textEditingController[5].text != "" &&
                        textEditingController[5].text.length <= 2) {
                      AppData.showInSnackBar(
                          context, "Please enter valid Address");
                      FocusScope.of(context).requestFocus(fnode5);
                    } else {
                    /*  updateProfileModel.dob = textEditingController[0].text;
                      updateProfileModel.bloodGroup =
                          ProfileScreen.bloodgroupmodel.key;
                      updateProfileModel.address =
                          textEditingController[5].text;
                      //Emergency
                      updateProfileModel.eName = *//*_eName.text*//*
                      textEditingController[1].text;
                      updateProfileModel.eMobile = *//*_eMobile.text*//*
                      textEditingController[2].text;
                      updateProfileModel.eRelation =
                          ProfileScreen.relationmodel.key;
                      //doctor
                      updateProfileModel.fDoctor = *//* _fDoctor.text*//*
                      textEditingController[3].text;
                      updateProfileModel.speciality =
                          ProfileScreen.specialitymodel.key;
                      updateProfileModel.docMobile = *//*_docMobile.text*//*
                      textEditingController[4].text;
*/
                    /*  log("Post json>>>>" +
                          jsonEncode(updateProfileModel.toJson()));
*/
                     /* widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.USER_UPDATEPROFILE,
                          json: updateProfileModel.toJson(),
                          token: widget.model.token,
                          fun: (Map<String, dynamic> map) {
                            Navigator.pop(context);
                            if (map[Const.STATUS] == Const.SUCCESS) {
                              // popup(context, map[Const.MESSAGE]);
                              //print("Post json>>>>"+jsonEncode(updateProfileModel.toJson()));
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);

                              callApi();
                            } else {
                              AppData.showInSnackBar(
                                  context, map[Const.MESSAGE]);
                              callApi();
                            }
                          });*/
                    }
                  });
                },
              ),
            ],
          );
        });
  }
  Widget dob(String hint) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        /*onTap: () => _selectDate(
          context,
        ),*/
        child: AbsorbPointer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 5, bottom: 8),
                child: Text(
                  hint,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: "",
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                // width: size.width * 0.8,
                /*decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey, width: 0.3)),*/
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextFormField(
                    //focusNode: fnode4,
                    //enabled: !widget.isConfirmPage ? false : true,
                    controller: textEditingController[0],
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    onSaved: (value) {
                      // registrationModel.dathOfBirth = value;
                    },
                    /*validator: (value) {
                      if (value.isEmpty) {
                        error[3] = true;
                        return null;
                      }
                      error[3] = false;
                      return null;
                    },*/
                    onFieldSubmitted: (value) {
                      //error[3] = false;
                      // print("error>>>" + error[2].toString());

                      setState(() {});
                      // AppData.fieldFocusChange(context, fnode4, fnode5);
                    },
                    decoration: InputDecoration(
                      hintText: //"Last Period Date",
                      "Appointment Date",
                      border: InputBorder.none,
                      //contentPadding: EdgeInsets.symmetric(vertical: 10),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget formField(
      int index, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[index],
              textInputAction: TextInputAction.done,
              focusNode: currentfn,
              keyboardType: TextInputType.text,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z .]")),
              ],
              // Validator.getKeyboardTyp(validateModel.fieldType.toLowerCase()),
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                //hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
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
        ),
      ],
    );
  }
  Widget formFieldMobileno(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: currentfn,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9]"),
                ),
              ],
              maxLength: 10,
              // Validator.getKeyboardTyp(validateModel.fieldType.toLowerCase()),
              style: TextStyle(fontSize: 15),

              decoration: InputDecoration(
                //hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
              onChanged: (newValue) {},
              onFieldSubmitted: (value) {
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }
  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 200.0,
      child: Stack(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: .0),
            width: double.maxFinite,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
                bottomLeft: const Radius.circular(15.0),
                bottomRight: const Radius.circular(15.0),
              ),
              /*image: DecorationImage(
                  image: AssetImage(
                    "assets/card.png",
                  ),
                  fit: BoxFit.fitWidth,
                ),*/
              /*gradient: LinearGradient(
                  colors: [AppData.matruColor, Colors.black54],
                ),*/
              color: AppData.matruColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*SizedBox(
                  height: 45.0,
                ),*/
                Text(
                  profileModel1.body.name ?? "N/A",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "AADHAAR NO" + ": " + profileModel1.body.aadhaar ?? "N/A",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(AppData.defaultImgUrl),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
