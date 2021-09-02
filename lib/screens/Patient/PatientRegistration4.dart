import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/models/PatientSignupModel.dart';

class PatientRegistration4 extends StatefulWidget {
  MainModel model;
  Key key;

  PatientRegistration4({this.model, this.key}) : super(key: key);

  @override
  _PatientRegistration4State createState() => _PatientRegistration4State();
}

class _PatientRegistration4State extends State<PatientRegistration4> {
  String imgValue;

  String profileImage = null;
  String valueText = null;
  String codeDialog = null;
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();
  File _camImage;
  String base64Img;

  double widthSize;

  //LoginResponse loginResponse;
  String user;
  String token;
  String patientName;
  String patientage;
  String patientimg;
  String patientweight;
  String patientheight;
  String patientaadhar;
  String patientemail;
  String patientphnNo;
  String patientgender;
  String patientgenderSTR;
  String patienCitycode;
  String patienCitykey;
  String patienStatecode;
  String patienStatekey;
  String patientimgtype;
  String addhar;
  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //loginResponse=widget.model.loginResponse;
    patientName = widget.model.patientName;
    patientphnNo = widget.model.patientphnNo;
    patientemail = widget.model.patientemail;
    patientaadhar = widget.model.patientaadhar;
    patientheight = widget.model.patientheight;
    patientweight = widget.model.patientweight;
    patientimg = widget.model.patientimg;
    patientage = widget.model.patientage;
    patientgender = widget.model.patientgender;
    patienCitycode = widget.model.patienCitycode;
    patienCitykey = widget.model.patienCitykey;
    patienStatecode = widget.model.patienStatecode;
    patienStatekey = widget.model.patienStatekey;
    patientimgtype = widget.model.patientimgtype;
    addhar = widget.model.patientaadhar;
    email = widget.model.patientemail;
    user = widget.model.user;
    token = widget.model.token;
    print(patienCitykey);
    print(patienStatecode);
    print(patienStatekey);
    print(patienCitycode);
    if (patientgender == "1") {
      patientgender = "Male";
    } else {
      patientgender = "Female";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widthSize = size.width / 4 - 5;
    return Scaffold(
      backgroundColor: AppData.kPrimaryColor,
      //extendBody: true,
      body: SafeArea(
        child: Container(
          height: size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        //_displayTextInputDialog(context);
                      },
                      child: Container(
                        height: 200.0,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppData.kPrimaryColor,
                        ),
                        child: SafeArea(
                          child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 40.0, top: 20.0),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              /*  Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 83,
                                width: 83,
                                child: Stack(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                     */
                              /*Material(
                                      elevation: 5.0,
                                      shape: CircleBorder(),
                                      child: CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: FileImage(pathUsr),
                                      ),
                                    )
                                        : */
                              /*Material(
                                      elevation: 5.0,
                                      shape: CircleBorder(),
                                      child: CircleAvatar(
                                        radius: 40.0,
                                        //backgroundImage:Image.memory(base64Decode(patientimg))
                                        //NetworkImage(AppData.defaultImgUrl),
                                      ),
                                    ),
                                    */
                              /*Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          getCameraImage();
                                        },
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: AppData.kPrimaryColor,
                                        ),
                                      ),
                                    )*/
                              /*
                                  ],
                                ),
                              ),
                            ),*/
                              Align(
                                alignment: Alignment.topCenter,
                                /*child: Container(
                              width: double.infinity,
                              height: 100.0,*/
                                child: Center(
                                  child: Container(
                                    height: 100.0,
                                    width: 100.0,
                                    /*child: Stack(*/
                                    /*children: [*/
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: patientimg != null
                                            ? Image.memory(
                                                base64Decode(patientimg),
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                AppData.defaultImgUrl)),

                                    /*],
                                  ),*/
                                  ),
                                ),
                                /*),*/
                              ),
                              Text(
                                /*"Swapnil Nevale"*/
                                patientName,
                                style: TextStyle(
                                    fontSize: 28.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*  _buildHeader(context),*/
                  ],
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(8),
                  child: Column(children: <Widget>[
                    Column(
                      children: <Widget>[
                        ...ListTile.divideTiles(
                          color: Colors.grey,
                          tiles: [
                            ListTile(
                              leading: Icon(Icons.call),
                              title: Text(/*"9011118424"*/ patientphnNo),
                              subtitle: Text("Mobile"),
                            ),
                            ListTile(
                              leading: Icon(Icons.assignment_ind),
                              title: Text(/*"32 Year"*/ patientage),
                              subtitle: Text("Age"),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              leading: Icon(Icons.group),
                              title: Text(/*"Male"*/ patientgender),
                              subtitle: Text("Gender"
                                  /*address*/),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              leading: Icon(CupertinoIcons.sportscourt),
                              title: Text(/*"184CM"*/ patientheight),
                              subtitle: Text("Height"),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              leading: Icon(CupertinoIcons.sportscourt),
                              title: Text(/*"134 Kg"*/ patientweight),
                              subtitle: Text("Weight"),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              leading: Icon(CupertinoIcons.sportscourt),
                              title: Text(email ?? "N/A"),
                              subtitle: Text("Email"),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              leading: Icon(CupertinoIcons.sportscourt),
                              title: Text(addhar ?? "N/A"),
                              subtitle: Text("Aadhaar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
                _submitButton(),

                //SizedBox(height: size.height * 0.,),
                /*Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      child: Icon(Icons.arrow_back_ios),
                      backgroundColor: Colors.orange,
                      heroTag: 1,
                      onPressed: () {
                        Navigator.pushNamed(context, "/patientRegistration3");
                        //do something on press
                      },
                    ),
                  ),
                ),*/
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget  _submitButton() {
    return MyWidgets.nextButton(
      text: "NEXT".toUpperCase(),
      context: context,
      fun: () {
        //print("form submit");
        MyWidgets.showLoading(context);
        PatientSignupModel patientSignupModel = PatientSignupModel();
        patientSignupModel.fName = patientName;
        patientSignupModel.mobile = patientphnNo;
        patientSignupModel.age = patientage;
        patientSignupModel.country = patienStatekey;
        patientSignupModel.state = patienCitykey;
        patientSignupModel.gender = patientgender;
        patientSignupModel.height = patientheight;
        patientSignupModel.weight = patientweight;
        patientSignupModel.email = patientemail;
        patientSignupModel.aadhar = patientaadhar;
        patientSignupModel.profileImageType = patientimgtype;
        patientSignupModel.stateCode = patienCitycode;
        patientSignupModel.countryCode = patienStatecode;
        patientSignupModel.profileImage = patientimg;
        patientSignupModel.enteredBy = user;

        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>"+ patientSignupModel.toJson().toString());
        widget.model.postSignUp(token, patientSignupModel.toJson(),
            (Map<String, dynamic> map) {
          String msg = map["message"].toString();
          String userid = map["body"].toString();
          if (map["code"] == "success") {
            popup(msg, context,userid,patientphnNo);
          } else {
            AppData.showInSnackBar(context, msg);
          }
        });

      },
    );
  }

  popup(String msg, BuildContext context,String userid,String mobile) {
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
            Text(
            "Mobile No.:"+mobile,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "UserId:."+userid,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),SizedBox(
              height: 5,
            ),
            Text(
              "Password is: User@123",
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

              widget.model.patientName = null;/* Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);*/

              Navigator.pop(context);
              widget.model.patientphnNo = null;
              widget.model.patientemail = null;
              widget.model.patientaadhar = null;
              widget.model.patientheight = null;
              widget.model.patientweight = null;
              widget.model.patientimg = null;
              widget.model.patientage = null;
              widget.model.patientgender = null;
              widget.model.patienCitycode = null;
              widget.model.patienCitykey = null;
              widget.model.patienStatecode = null;
              widget.model.patienStatekey = null;
              widget.model.patientimgtype = null;
              Navigator.of(context).pushNamedAndRemoveUntil("/patientDashboard", (Route<dynamic> route) => false);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('TextField in Dialog'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                Future getCerificateImage() async {
                  var image =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  var enc = await image.readAsBytes();
                  String _path = image.path;

                  String _fileName =
                      _path != null ? _path.split('/').last : '...';
                  var pos = _fileName.lastIndexOf('.');
                  String extName =
                      (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
                  setState(() => _camImage = image);
                  base64Img = base64Encode(enc);
                }

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 110.0,
                        child: Center(
                          child: Container(
                            height: 110.0,
                            width: 110.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(110.0),
                                    child: _camImage != null
                                        ? Image.file(
                                            _camImage,
                                            height: 110,
                                            width: 110,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            imgValue ?? AppData.defaultImgUrl,
                                            height: 140)),
                                Positioned(
                                  child: InkWell(
                                    onTap: () {
                                      //getCameraImage();
                                      //showDialog();
                                      //_settingModalBottomSheet(context);
                                      getCerificateImage();
                                    },
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  bottom: 3,
                                  right: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                        controller: _name,
                        decoration: InputDecoration(
                          hintText: "Name",
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                        controller: _email,
                        decoration: InputDecoration(hintText: "Phoneno"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                        controller: _address,
                        decoration: InputDecoration(hintText: "Address"),
                      )
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  setState(() {
                    /*codeDialog = valueText;
                    Navigator.pop(context);*/
                    if (_name.text == null || _name.text == "") {
                      AppData.showInSnackBar(context, "Please enter name");
                    } else if (_address.text == null || _address.text == "") {
                      AppData.showInSnackBar(context, "Please enter address");
                    } else if (_email.text == null || _email.text == "") {
                      AppData.showInSnackBar(context, "Please enter phoneno.");
                    }
                    /*else if (!_email.text.contains("@")) {
                      AppData.showInSnackBar(
                          context, "Please enter valid email id");
                    } */
                    else {}
                  });
                },
              ),
            ],
          );
        });
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      height: 180.0,
      child: Stack(children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: .0),
          width: double.maxFinite,
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 5.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 45.0,
                ),
                Text(
                  "sdfgh",
                  style: TextStyle(fontSize: 24.0, color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "sdfg",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 95.0,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  (imgValue != null)
                      ? Material(
                          elevation: 5.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: NetworkImage(
                                (/*"https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png"*/ imgValue)),
                          ),
                        )
                      : SizedBox(
                          height: 85,
                          child: Image.asset(
                            "assets/images/sanja.png",
                          ),
                        ),
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        //getCameraImage();
                        //showDialog();
                        //_settingModalBottomSheet(context);
                      },
                      /* child: Icon(
                        Icons.camera_alt,
                        color: Colors.blueGrey,
                        size: 25,
                      ),*/
                    ),
                    bottom: 10,
                    right: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
