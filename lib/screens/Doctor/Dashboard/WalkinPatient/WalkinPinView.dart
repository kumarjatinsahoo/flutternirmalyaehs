import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/ForgetUseridModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
// import 'package:user/models/CredentialModel.dart';

// import 'package:user/models/LoginResponse1.dart';
// import 'package:user/providers/Contsants.dart';
// import 'package:user/providers/FileProvider.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/ConfirmPassword.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';
import 'package:user/screens/Users/UserId/UserList.dart';
// import 'package:user/scoped-model/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WalkinPinView extends StatefulWidget {
  // final String email;
  MainModel model;
  LoginResponse1 loginData;
  String userId;
  String otp;
  String uhid;
  ForgotUseridModel userResponse;

  // final bool isGuestCheckOut;

  WalkinPinView({
    Key key,
    this.model,
    this.loginData,
    this.userResponse,
    this.otp,
    this.uhid,
  }) : super(key: key);

  @override
  _WalkinPinViewState createState() => new _WalkinPinViewState();
}

class _WalkinPinViewState extends State<WalkinPinView> with SingleTickerProviderStateMixin {
  // Constants
  final int time = 120;
  AnimationController _controller;

  // Variables
  Size _screenSize;
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;
  int otpGenerate;
  String otpGenerateStr;
  int otpType;
  String otpTypeStr;
  bool isLoading = false;

  SharedPref sharedPref = SharedPref();

  // CredentialModel credentialModel;

  @override
  void initState() {

    //totalTimeInSeconds = time;
    // otpGenerateStr = widget.loginData.body.otp;
    //otpGenerate = int.parse(otpGenerateStr);

    print("OTP IS>>>>>>>>>>>>>>>>>>>>>>" + otpGenerate.toString());

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
    super.dispose();
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
            color: AppData.kPrimaryColor,
            //        padding: new EdgeInsets.only(bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                _getVerificationCodeLabel,
                _getEmailLabel,
                _getInputField,
                _hideResendButton ? _getTimerText : _getResendButton1(context),
                _getOtpKeyboard
              ],
            ),
          ),
          isLoading
              ? Stack(
            children: [
              new Opacity(
                opacity: 0.1,
                child: const ModalBarrier(
                    dismissible: false, color: Colors.grey),
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
    return Text(
      "Verification PIN",
      /*"Verification Code"*/
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 28.0, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  // Return "Email" label
  get _getEmailLabel {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        //MyLocalizations.of(context).text("PLEASE_ENTER_THE_OTP_SENT"),
        "Please enter the PIN",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
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
  Widget _getResendButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.85,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: AppData.kPrimaryColor,
          onPressed: () {
            // Resend you OTP via API or anything
            clearOtp();
            _startCountdown();
            //setState(()  {
            /*if (!widget.fromLogin) {
              setState(() {
                otpGenerate = Math.generate();
                postDataOtp(otpGenerate);
              });
            } else {
              _login(
                  widget.loginData.phone, widget.loginData.aadharno, context);
            }*/
            //
            // });
          },
          child: Text(
            MyLocalizations.of(context).text("OTP_RSND"),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _getResendButton1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyWidgets.nextButton(
        text: "Resend OTP", context: context, fun: () {
      MyWidgets.showLoading(context);
      widget.model.GETMETHODCALL(
          api: ApiFactory.LOGIN_Otp(widget.model.phnNo),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            //log("LOGIN RESPONSE>>>>" + jsonEncode(map));
            //log("LOGIN RESPONSE>>>>" + jsonEncode(map));
            //AppData.showInSnackBar(context, map[Const.MESSAGE]);
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                LoginResponse1 loginResponse = LoginResponse1.fromJson(map);
                // widget.loginData=loginResponse;
                otpGenerateStr = loginResponse.body.otp;
                otpGenerate = int.parse(otpGenerateStr);
                /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PinView(
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

  _login(String mobile, String userId, BuildContext context) async {}

  // Returns "Resend" button
  get _getVerifyButton {
    return Container(
      height: 50,
      width: 200,
      child: MaterialButton(
          splashColor: Colors.red.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          color: Colors.blueAccent,
          onPressed: () {

            // You can dall OTP verification API.
          },
          child: Text(
            "Verify OTP",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )),
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return Container(
        height: _screenSize.width - 80,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _fourthDigit != null,
                      child: RaisedButton(
                        textColor: AppData.matruColor,
                        color: Colors.white,
                        child: Text("Submit"),
                        onPressed: () {
                          if(otpType==int.tryParse(widget.otp)) {
                            // Navigator.pushNamed(context, "/cnfpwd");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => ShowEmr(
                                  model: widget.model,
                                  uhid:widget.uhid,

                                ),
                              ),
                            );
                          }
                          else
                            AppData.showInSnackBar(context,"Invalid otp entered");
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      )
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: Icon(
                        Icons.backspace,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
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

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();
        otpType = int.parse(otp.toString());
        otpTypeStr = otp.toString();

        // Verify your otp by here. API call
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
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
