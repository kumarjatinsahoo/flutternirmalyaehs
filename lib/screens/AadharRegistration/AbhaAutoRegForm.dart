import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:developer';
// import 'package:flutter/src/painting/gradiant' as ui;

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/AbhaResponseModel.dart';
import 'package:user/models/UserRegistrationModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/providers/text_field_container.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import 'AbhaMobileVerification.dart';

class AbhaAutoRegForm extends StatefulWidget {
  final MainModel model;

  const AbhaAutoRegForm({Key key, this.model}) : super(key: key);

  @override
  _AbhaAutoRegFormState createState() => _AbhaAutoRegFormState();
}

class _AbhaAutoRegFormState extends State<AbhaAutoRegForm> {
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
    new TextEditingController()
  ];
  AbhaResponseModel abhaResponseModel;
  UserRegistrationModel userModel;
  String useridd;
  String password;

  //File pathUsr = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postAbhaServer();
  }

  postAbhaServer() {
    var postData = {
      "email": "",
      "firstName": "",
      "healthId": "",
      "lastName": "",
      "middleName": "",
      "password": "",
      "profilePhoto": "",
      "txnId": widget.model.txnId
    };

    // MyWidgets.showLoading(context);
    //dev.log("<<<<<<<TESTING>>>>>>>>"+ApiFactory.POST_ABHA_REGISTRATION);
    dev.log("<<<<<<<Suvam>>>>>>>>" + jsonEncode(postData));
    widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.POST_ABHA_REGISTRATION,
        //api: "https://healthidsbx.abdm.gov.in/api/v1/registration/aadhaar/createHealthIdWithPreVerified",
        json: postData,
        token: "Bearer " + widget.model.abhaTokenModel.accessToken,
        fun: (Map<String, dynamic> map) {
          // Navigator.pop(context);
          dev.log("message????????????????" + jsonEncode(map));
          // String msg = map["message"].toString();
          if (!map.containsKey("message")) {
            // AppData.showInSnackBar(context, (map["details"][0]["message"]??""));
            abhaResponseModel = AbhaResponseModel.fromJson(map);
            // UserModel userModel=UserMode

            userModel = UserRegistrationModel();
            userModel.fName = abhaResponseModel.firstName;
            userModel.lName = abhaResponseModel.lastName;
            userModel.mobile = abhaResponseModel.mobile;

            userModel.typeAbha = "AADHAR_INTEGRATION";
            userModel.abhaResponseModel = abhaResponseModel;
            userModel.aadharNo = widget.model.abhaadhar;

            userModel.country = AbhaMobileVerification.countryModel.key;
            userModel.countryCode = AbhaMobileVerification.countryModel.code;
            userModel.stateCode = AbhaMobileVerification.stateModel.code;
            userModel.state = AbhaMobileVerification.stateModel.key;
            userModel.districtid = AbhaMobileVerification.districtModel.key;
            userModel.cityid = AbhaMobileVerification.cityModel.key;
            // userModel.title=AbhaRegForm.titleModel.key;
            userModel.gender = (abhaResponseModel.gender.toLowerCase() == "m")
                ? "Male"
                : "Female";
            userModel.abhaResponseModel = abhaResponseModel;
            userModel.title == "";

            // dev.log(">>>>>>>>PRINT dev.logO>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n" + jsonEncode(abhaResponseModel.toJson())+"\n\n\n\n\n\n\n\n\n\n\n\n\n");
            dev.log(">>>>>>>>PRINT AHBHH>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n" +
                jsonEncode(userModel.toJson()) +
                "\n\n\n\n\n\n\n\n\n\n\n\n\n");

            postOurServer(userModel);
            setState(() {});
          } else {
            AppData.showInSnackBar(context, map["message"]);
            // AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });
  }

  postOurServer(UserRegistrationModel userModel) {
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
              dev.log("Version>>>" + useridd + "<>>" + password);
              //popup(msg, context,password,useridd);
            });
            //popup(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, msg);
            // AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
          // AppData.showInSnackDone(context, "Hey");
          // postAbhaServer();
          //log("LOGIN RESPONSE>>>>"+jsonEncode(userModel.toJson()));
        },
        child: Container(
          height: 60,
          color: AppData.kPrimaryColor,
          child: Center(
            child: Text(
              "Close",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: (abhaResponseModel != null)
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    /*Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Image.asset(
                      "assets/dev.logo1.png",
                      fit: BoxFit.fitWidth,
                      //width: ,
                      height: 150.0,
                    ),
                  ),
                ),
              ),*/
                    Stack(
                      children: [
                        Container(
                            height: 300,
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/congrat1.gif",
                              fit: BoxFit.fill,
                              height: 300,
                            )),
                        Container(
                          height: 300,
                          // margin: EdgeInsets.only(left: 25,bottom: 15),
                          padding: EdgeInsets.only(left: 25,bottom: 15),
                          child: Center(
                            child: Text(
                              "Congratulation",
                              style: TextStyle(
                                // color: Color(0xFF4f0d13),
                                color: Color(0xFFc91430),
                                fontSize: 24,
                              fontFamily: "sans-serif-thin",
                              // fontFamily: "Gujarati Sangam MN",
                              shadows: [
                                Shadow(
                                  color: Color(0xFF4f0d13).withOpacity(0.6),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                              fontWeight: FontWeight.w600
                              /*  foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Colors.blue[700],*/


                              ),

                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                            child: Image.memory(
                              base64Decode(abhaResponseModel.profilePhoto),
                              height: 100,
                              width: 100,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          abhaResponseModel.name,
                          // patientProfileModel?.body?.fullName ?? "N/A",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          abhaResponseModel.healthIdNumber,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        /*  Text(
                          "Your User Id is "+(useridd??""),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),*/

                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "User Id: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: useridd ?? "",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          )
                        ])),
                        SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Password: ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: password ?? "",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          )
                        ])),
                        //Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("First Name"),
                            subtitle: Text(abhaResponseModel.firstName),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          /* ListTile(
                      title: Text("Middle Name"),
                      subtitle: Text("Middle Name"),
                    ),*/
                          /* Divider(
                      thickness: 2,
                    ),*/
                          ListTile(
                            title: Text("Last Name"),
                            subtitle: Text(abhaResponseModel.lastName),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: Text("Date Of Birth"),
                            subtitle: Text(abhaResponseModel.dayOfBirth +
                                "/" +
                                abhaResponseModel.monthOfBirth +
                                "/" +
                                abhaResponseModel.yearOfBirth),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: Text("Gender"),
                            subtitle: Text(abhaResponseModel.gender == "M"
                                ? "Male"
                                : "Female"),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: Text("Aadhar No."),
                            subtitle: Text(widget.model.abhaadhar),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: Text("Mobile No."),
                            subtitle: Text(abhaResponseModel.mobile),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: Text("Country"),
                            subtitle:
                                Text(AbhaMobileVerification.countryModel.name),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: Text("State"),
                            subtitle:
                                Text(AbhaMobileVerification.stateModel.name),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: Text("Dist"),
                            subtitle:
                                Text(AbhaMobileVerification.districtModel.name),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          ListTile(
                            title: Text("City"),
                            subtitle:
                                Text(AbhaMobileVerification.cityModel.name),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : MyWidgets.loading1(context),
      ),
    );
  }
}
