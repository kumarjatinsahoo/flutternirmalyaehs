import 'dart:async';
import 'dart:math';
import 'dart:convert' show base64, utf8;

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class AppData {
  static String appId = "com.";
  static String appName = "Construction Workers";
  static String baseUrl = 'http://sug.sugamatourists.com';
  static String ODISHA = 'ODISHA';
  static String defaultImgUrl =
      'https://thumbs.dreamstime.com/b/faceless-businessman-avatar-man-suit-blue-tie-human-profile-userpic-face-features-web-picture-gentlemen-85824471.jpg';

  static int bgColor = 00000000;
  static int textColor = 00000000;
  static String SALT_KEY = "kimarhs";

  //static Color kPrimaryColor = Color(0xFF5bc878);
  static Color kPrimaryColor1 = Colors.blue[600];
  static Color kPrimaryColor = Color(0xFF2372B6) ;
  static Color kPrimaryRedColor = Color(0xFFCF3564) ;
  static Color matruColor = Colors.indigo;
  static Color kPrimaryLightColor = Color(0xFFe9f7ea);
  //static Color kPrimaryLightColor = Color(0xFF92CA91);
  static Color grey = Color(0xFFF2F2F2);
  static Color newColor = Color(0xFF7c48ed);
  static Color deepPurple = Colors.deepPurple;
  static String currentSelectedValue = "+91";
  static String currentSelectedValue1 = "S/o";
  static String currency = "₹";
  static Color grey100 = Color(0xFFF4F4F4);
  static Color greyBorder = Color(0xFFD7D7D7);
  static Color greyText = Color(0xFF616267);
  static const Color white = Color(0xFFFFFFFF);
  static List<String> phoneFormat = [
    "+91" /*, "+80", "+78"*/
  ];
  static List<String> catagoryFormat = [
    "S/o","D/o","W/o"
  ];
  static String selectedLanguage;

  static setSelectedLan(lan) {
    selectedLanguage = lan;
  }

  static setSelectedLanCode(code) {
    (code == "en") ? selectedLanguage = "English" : selectedLanguage = "ଓଡିଆ";
  }

  static getColor(String code) {
    (code == "en") ? selectedLanguage = "English" : selectedLanguage = "ଓଡିଆ";
  }


  static double properSafeArea(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return availableHeight;
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }



  static buildDefaultText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.grey[700]),
    );
  }

  static buildSmallText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black),
    );
  }

  static TextStyle defaultTextStyle() {
    return TextStyle(
        fontSize: 15.0, color: Colors.grey[700], fontWeight: FontWeight.w400);
  }

  static TextStyle defaultHintTextStyle() {
    return TextStyle(
        fontSize: 15.0, color: Colors.grey[400], fontWeight: FontWeight.w400);
  }

  static filtterInputType({String format}) {
    return FilteringTextInputFormatter.allow(RegExp(r'['+format+']'));
  }
  static bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showInternetError(
      BuildContext context, Function closeApp, Function retryInternet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "No Internet..!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
          ),
          content: Text(
            "There may be a problem in your internet connection. Please try again!",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16.0,
                height: 1.5,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "Cancel".toUpperCase(),
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                closeApp();
              },
            ),
            FlatButton(
              child: Text(
                "Retry".toUpperCase(),
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                retryInternet();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showAlertDialog(BuildContext context, String btnName,
      String title, String message, Function function) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            content: Text(
              message,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                  height: 1.5,
                  fontWeight: FontWeight.w400),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text(
                  btnName.toUpperCase(),
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  function();
                },
              ),
            ],
          );
        });
  }

  static loading(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        });
  }

  static popup(BuildContext context, String message,Function fun) {
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
            onPressed: fun,
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  static Future<bool> showConfirmationAlertDialog(
      BuildContext context,
      String btnName,
      String btnNegName,
      String title,
      String message,
      Function closePopUp,
      Function function) {
    return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
              content: Text(
                message,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                    height: 1.5,
                    fontWeight: FontWeight.w400),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  child: Text(
                    btnName.toUpperCase(),
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    function();
                  },
                ),
                FlatButton(
                  child: Text(
                    btnNegName.toUpperCase(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    closePopUp();
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  static String getName(String first,String midle,String last){
    if(midle!=null && midle!=""){
      return first+" "+midle+" "+last;
    }else{
      return first+" "+last;
    }
  }

  static void showInSnackBar(BuildContext context, String value) {
    // final scaffold = Scaffold.of(context);
    // scaffold.showSnackBar(
    //   SnackBar(
    //     content: new Text(
    //       value.toUpperCase(),
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     duration: Duration(seconds: 1),
    //     backgroundColor: Colors.red,
    //   ),
    // );

    Flushbar(
      //  title:  "Hey SuperHero",
      message: value,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 6),
    )..show(context);
  }

  static void showInSnackDone(BuildContext context, String value) {
    Flushbar(
      //  title:  "Hey SuperHero",
      message: value,

      backgroundColor: Colors.lightGreen,
      duration: Duration(seconds: 6),
    )..show(context);
  }

  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  static String getExt(String file) {
    String _fileName = file != null ? file.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);
    return extName;
  }

  static String getFileName(String file) {
    return file != null ? file.split('/').last : '...';
  }

  static String base64Encd(String data) {
    return base64.encode(utf8.encode(data));
  }



}
