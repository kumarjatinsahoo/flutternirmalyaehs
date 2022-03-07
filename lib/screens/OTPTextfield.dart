import 'dart:async';
import 'dart:convert';
import 'dart:io' as plat;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:package_info/package_info.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/models/MasterLoginResponse.dart' as master;

// import 'package:user/models/LoginResponse1.dart';
// import 'package:user/providers/Contsants.dart';
// import 'package:user/providers/FileProvider.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
// import 'package:user/scoped-model/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OTPTextfield extends StatefulWidget {
  // final String email;
  MainModel model;
  master.MasterLoginResponse masterLoginResponse;
  String token;

  // final bool isGuestCheckOut;

  OTPTextfield({
    Key key,
    this.model,
    this.masterLoginResponse,
    this.token,
  }) : super(key: key);

  @override
  OTPTextfieldState createState() => new OTPTextfieldState();
}

class OTPTextfieldState extends State<OTPTextfield> with SingleTickerProviderStateMixin,CodeAutoFill  {
  // Constants
  final int time = 180;
  AnimationController _controller;
  master.MasterLoginResponse masterResponse;
  // Variables
  Size _screenSize;
  int _currentDigit;
  int _fourthDigit;

  TextEditingController otpController  =TextEditingController();

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;
  bool _submitBtn=false;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;
  int otpGenerate;
  String otpGenerateStr;
  int otpType;
  String otpTypeStr;
  bool isLoading = false;

  SharedPref sharedPref = SharedPref();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  // CredentialModel credentialModel;
String formattedDate;
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  String imei,deviceid;

  @override
  void initState() {
    _initPackageInfo();
    getDeviceSerialNumber();
    listenForCode();
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(now);

    totalTimeInSeconds = time;
   //LoginResponse1 loginResponse = LoginResponse1();
    // loginResponse.acceptValue(data[i]);
    //Body body = Body();
    otpGenerateStr = widget.masterLoginResponse.body[0].otp;
    print("OTP IS>>>>>>>>>>>>>>>>>>>>>>" +otpGenerateStr);
    masterResponse=widget.masterLoginResponse;

    super.initState();
   // AppData.showInSnackBar(context, otpGenerateStr);
    // loadAsset();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  Future<void> _initPackageInfo() async {
    if (plat.Platform.isAndroid) {
      final PackageInfo info = await PackageInfo.fromPlatform();
      setState(() {
        _packageInfo = info;
      });
    }
  }

  Future<String> getDeviceSerialNumber() async {
    // Ask user permission
    /*await AndroidMultipleIdentifier.requestPermission();
    // Get device information async
    Map idMap = await AndroidMultipleIdentifier.idMap;
    Map iosMap = await .idMap;

    imei = idMap["imei"];
    String serial = idMap["serial"];
    String androidID = idMap["androidId"];

    return imei;*/
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (plat.Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        // deviceName = build.model;
        // deviceVersion = build.version.toString();
        // identifier = build.androidId;  //UUID for Android
        setState(() {
          // deviceid=build.model;
          imei = build.androidId;
        });
      } else if (plat.Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        // deviceName = data.name;
        // deviceVersion = data.systemVersion;
        // identifier = data.identifierForVendor;  //UUID for iOS
        setState(() {
          // deviceid=data.name;
          imei = data.identifierForVendor;
        });
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  // Future<CredentialModel> loadAsset() async {
  //   /*var s = await rootBundle.loadString('assets/File.txt');
  //   credentialModel = CredentialModel.fromJson(jsonDecode(s));
  //   print(credentialModel.toString());
  //   return credentialModel;*/

  //   String serverCredential = await FileProvider.readFileCredential();
  //   if (serverCredential != null && serverCredential != "") {
  //     print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n IN SERVER FILE");
  //     credentialModel = CredentialModel.fromJson(jsonDecode(serverCredential));
  //     print(credentialModel.toString());
  //     return credentialModel;
  //   } else {
  //     print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n IN ASSET FILE");
  //     var s = await rootBundle.loadString('assets/File.txt');
  //     credentialModel = CredentialModel.fromJson(jsonDecode(s));
  //     print(credentialModel.toString());
  //     return credentialModel;
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    cancel();
    super.dispose();
    otpController.clear();
  }
 
  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppbar,
      backgroundColor: AppData.kPrimaryColor,
      body: Stack(
        children: <Widget>[
          Container(
            width: _screenSize.width,
            //height:_screenSize.height,
            color: AppData.matruColor,
            //
            //padding: new EdgeInsets.only(bottom: 16.0),
           /* child: SingleChildScrollView(*/
        child: ListView(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: _screenSize.height * 0.1),
            _getVerificationCodeLabel,
            // SizedBox(height: _screenSize.height * 0.01 ),
            _getEmailLabel,
            // SizedBox(height: _screenSize.height * 0.1 ),
            // _getInputFieldNew,
           SizedBox(height: _screenSize.height * 0.06 ),
            _hideResendButton ? _getTimerText : _getResendButton1(context),
            // Container(),
            // _getOtpKeyboard
            // TextFieldPinAutoFill(
            //     currentCode: otpGenerateStr,
            //     codeLength: 4,
            //   ),
            //  SizedBox(height: _screenSize.height * 0.0),
              Padding(
                padding: const EdgeInsets.only(left:50.0, right: 50.0),
                child: PinFieldAutoFill(
                  codeLength: 4,
                  enableInteractiveSelection: false,
                 cursor: Cursor(
    width: 1,
    height: 20,
    color: Colors.white,
    radius: Radius.circular(1),
    enabled: true,
  ),
                  decoration: UnderlineDecoration(
                    lineHeight: 1.0,
                    textStyle: TextStyle(fontSize: 20, color: Colors.white),
                    colorBuilder: FixedColorBuilder(Colors.white),
                  ),
                  currentCode: otpController.text,
                  autoFocus:  false,
                  onCodeSubmitted: (code) {
                    setState(() {
                      _fourthDigit = 4;
                      _submitBtn=true;
                    });
                  },
                  onCodeChanged: (code) {
                    if (code.length == 4) {                      
                      otpController.text= code;         
                      setState(() {                        
                        _fourthDigit =4; 
                        // print('code Changed ' + _fourthDigit.toString());
                        _submitBtn=true;
                      });            
                      // FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
              ),
        SizedBox(height: _screenSize.height * 0.08 ),
          _submitBtn?  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: (_fourthDigit == 4)?true:false,
                      child: Padding(
                        padding: const EdgeInsets.only(left:30.0, right: 30.0 ),
                        child: Container(
                          width: double.infinity,
                          height: 42,
                          child: RaisedButton(
                            textColor: AppData.matruColor, 
                            // elevation: 0,
                            color: Colors.white,
                            child: Text("Submit"),
                            onPressed: () {
                              if(_hideResendButton) {
                                print('otpGenerate ' + otpGenerate.toString());
                                print(
                                    'otpController.text ' + otpController.text);
                                if (otpGenerateStr == otpController.text) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        dialogUserView(context,
                                            widget.masterLoginResponse.body),
                                  );
                                }
                                else {
                                  AppData.showInSnackBar(
                                      context, "Please enter valid OTP");
                                }
                              }else{
                                AppData.showInSnackBar(
                                    context, "OTP Timeout. Please resend OTP");
                              }
                            },
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      )
                  ):Container(),
          ],
        ),
        /*),*/
          ),
          isLoading
              ? Stack(
                  children: [
                    new Opacity(
                      opacity: 0.1,
                      child: const ModalBarrier(dismissible: false, color: Colors.grey),
                    ),
                    new Center(
                      child: new CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  // Returns "Appbar"
  get _getAppbar {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
     /* leading: InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pop(context);
         // Navigator.pop(context);
        },
      ),*/
      centerTitle: true,
    );
  }

  // Return "Verification Code" label
  get _getVerificationCodeLabel {
    return Text(MyLocalizations.of(context).text("VERIFICATION_PIN"),
      /*"Verification Code"*/
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 28.0, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  // Return "Email" label
  get _getEmailLabel {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Text(
        MyLocalizations.of(context).text("PLEASE_ENTER_PIN"),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Return "OTP" input field

   get _getInputFieldNew {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _otpTextFieldNew(_fourthDigit),
        // _otpTextFieldNew(_secondDigit),
        // _otpTextFieldNew(_thirdDigit),
        // _otpTextFieldNew(_fourthDigit),
      ],
    );
  }

  popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        title: "Application Ref. No. : " + msg,
        desc: "Sign-up Completed. Proceed for Registration.",
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
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.white,
            ),
            SizedBox(
              width: 5.0,
            ),
             OtpTimer(_controller, 15.0, Colors.white)
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
 
  Widget _getResendButton1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyWidgets.nextButton(
        text: "Resend OTP", context: context, fun: () {
          otpController..clear();
      MyWidgets.showLoading(context);
      widget.model.GETMETHODCALL(
          api: ApiFactory.LOGIN_Otp(widget.model.phnNo),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            //log("LOGIN RESPONSE>>>>" + jsonEncode(map));
            //log("LOGIN RESPONSE>>>>" + jsonEncode(map));
            //AppData.showInSnackBar(context, map[Const.MESSAGE]);
            if (map[Const.CODE] == Const.SUCCESS) {

              _startCountdown();
              setState(() {
               // LoginResponse1 loginResponse = LoginResponse1.fromJson(map);
                masterResponse = master.MasterLoginResponse.fromJson(map);
               // widget.loginData=loginResponse;
                otpGenerateStr = masterResponse.body[0].otp;
                otpGenerate = int.parse(otpGenerateStr);
                // otpController.text=otpGenerate.toString();
                _submitBtn =true;
              /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          OTPTextfield(
                            loginData: loginResponse,
                            model: widget.model,
                          )),
                );*/

              });

            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
    });
  }

  updateStatus(data){
    Map<String, dynamic> postmap = {
      "userId" : data.user,
      "imeiNo" : imei??"",
      "version" :(plat.Platform.isAndroid)? _packageInfo.version:Const.IOS_VERSION,
      "deviceId" : deviceid??"",
      "activityDate": formattedDate,
      "activityTime" :  currentTime,
      "type" :"LOGIN",
      "status" :"SUCCESS",
      "deviceToken" :widget.token
    };
    // AppData.showInSnackDone(context,"Print data>>>>"+jsonEncode(postmap));
    // MyWidgets.showLoading(context);
    widget.model.POSTMETHOD(
      //api: ApiFactory.POST_APPOINTMENT,
        api: ApiFactory.POST_ACTIVITYLOG,
        //token: widget.model.token,
        json: postmap,
        fun: (Map<String, dynamic> map) {
          // Navigator.pop(context);
        });
  }

  // Returns "Resend" button
  

  // Returns "Otp" keyboard
  Widget dialogUserView(BuildContext context, List<master.Body> data) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 20),
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 450,
            child: Column(
              children: [
                Text(
                  "Login Users",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        ListView.separated(
                          separatorBuilder: (c, i) {
                            return Divider();
                          },
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return ListTile(
                              leading: Icon(
                                CupertinoIcons.person_alt_circle,
                                size: 44,
                              ),
                              title: Text(data[i].userName),
                              subtitle: Text(data[i].user),
                              onTap: () {
                                /*  sharedPref.save(Const.LOGIN_phoneno, _loginId.text);
                                sharedPref.save(Const.LOGIN_password, passController.text);
                                LoginResponse1 loginResponse = LoginResponse1();
                                // loginResponse.acceptValue(data[i]);
                                Body body=Body();
                                body.user=data[i].user;
                                body.userName=data[i].userName;
                                body.userAddress=data[i].userAddress;
                                body.userPassword=data[i].userPassword;
                                body.userMobile=data[i].userMobile;
                                body.userStatus=data[i].userStatus;
                                body.token=data[i].token;
                                body.roles.add(value)
                                loginResponse.body=body;
                                widget.model.token = data[i].token;
                                widget.model.user = data[i].user;
                                log("Response after assign>>>>"+jsonEncode(loginResponse.toJson()));
                                sharedPref.save(Const.LOGIN_DATA, loginResponse);
                                widget.model.setLoginData1(loginResponse);
                                sharedPref.save(Const.IS_LOGIN, "true");*/
                                // updateStatus(data[i]);
                                roleUpdateApi(data[i].user, data[i]);
                              },
                              trailing: Icon(Icons.arrow_right),
                            );
                          },
                          itemCount: data.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      /*actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("Cancel"),
        ),
        new FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: const Text('SEARCH'),
        ),
      ],*/
    );
  }

  roleUpdateApi(userId, data) {
    MyWidgets.showLoading(context);
    widget.model.GETMETHODCALL(
        api: ApiFactory.GET_ROLE + userId,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          print("Respomnse for role>>>>>" + jsonEncode(map));
          if (map["code"] == "success") {
            LoginResponse1 loginResponse = LoginResponse1();
            // loginResponse.acceptValue(data[i]);
            Body body = Body();
            body.user = data.user;
            body.userName = data.userName;
            body.userAddress = data.userAddress;
            body.userPassword = data.userPassword;
            body.userMobile = data.userMobile;
            body.userStatus = data.userStatus;
            body.token = data.token;
            body.roles = [];
            body.roles.add(map["body"]["roleid"]);
            loginResponse.body = body;
            widget.model.token = data.token;
            widget.model.masterResponse = masterResponse;
            widget.model.user = data.user;
            print("Response after assign>>>>" + jsonEncode(loginResponse.toJson()));
            sharedPref.save(Const.LOGIN_DATA, loginResponse);
            sharedPref.save(Const.MASTER_RESPONSE, masterResponse);
            widget.model.setLoginData1(loginResponse);
            sharedPref.save(Const.IS_LOGIN, "true");


            updateStatus(data);


            if (map["body"]["roleid"] == "1".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "2".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashDoctor', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "5".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboardreceptionlist', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "7".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboardpharmacy', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "8".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/labDash', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "12".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/ambulancedash', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "13".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/bloodBankDashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "22".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/syndicateDashboard', (Route<dynamic> route) => false);
            } else if (map["body"]["roleid"] == "24".toLowerCase()) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/admin', (Route<dynamic> route) => false);
            } else {
              AppData.showInSnackBar(context, "No Role Assign");
            }
          }
        });
  }
Widget _otpTextFieldNew(int digit) {
return OTPTextField(
            // controller: otpController,
            length: 4,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.center,
            fieldWidth: 50,
            fieldStyle: FieldStyle.underline,
            outlineBorderRadius: 0,
            otpFieldStyle: OtpFieldStyle(disabledBorderColor: Colors.white,  enabledBorderColor: Colors.white),
            style: TextStyle(fontSize: 17, color: Colors.white),
            onChanged: (pin) {
              print("Changed: " + pin);
            },
            onCompleted: (pin) {
              print("Completed: " + pin);
              otpController.text = pin;
              print( otpController.text);
              _fourthDigit = int.parse(pin);
            });
      
}

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1.5, color: Colors.grey[300])),
          ),
      child: Center(
          child: Text(
        digit != null ? digit.toString() : "",
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      )),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
      clearOtp();
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    setState(() {
      otpController.text="";
    });
  }

  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
setState(() {
      otpController.text = code;
      print('otpController.text ' + otpController.text);
    });
  }

  // void checkValue() async {
  //   Credentialslist credential = await AppData.getCredentialSearch(
  //       list: credentialModel.credentialslist,
  //       mobileNo: widget.model.phnNo,
  //       pass: otpTypeStr);
  //   if (credential == null) {
  //     AppData.showInSnackBar(context, "Login id & password is not correct");
  //   } else {
  //     LoginResponse1 loginResponse = LoginResponse1.changePattern(credential);
  //     sharedPref.save(Const.LOGIN_DATA, loginResponse);
  //     widget.model.setLoginData1(loginResponse);
  //     sharedPref.save(Const.IS_LOGIN, "true");
  //     if (loginResponse.ashadtls[0].userType ==
  //         describeEnum(UserType.USER).toLowerCase()) {
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //           '/navigation', (Route<dynamic> route) => false);
  //     } else {
  //       Navigator.of(context)
  //           .pushNamedAndRemoveUntil('/dash', (Route<dynamic> route) => false);
  //     }
  //   }
  // }

}


class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Text(
            timerString,
            style: TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
