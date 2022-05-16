import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'dart:convert' show base64, utf8;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:user/models/KeyvalueModel.dart';

class AppData {
  static String ODISHA = 'ODISHA';
  static String defaultImgUrl =
      'https://thumbs.dreamstime.com/b/faceless-businessman-avatar-man-suit-blue-tie-human-profile-userpic-face-features-web-picture-gentlemen-85824471.jpg';
static String defultImgUrll="https://pixabay.com/photos/tree-sunset-clouds-sky-silhouette-736885";
  static int bgColor = 00000000;
  static int textColor = 00000000;

  static Color kPrimaryColor = Color(0xFF2372B6);
  static Color menublueColor = Color(0xFF014E91);
  static Color hintColor = Color(0xFF666666);
  static Color BG1RED = Color(0xFFFEF7F8);
  static Color BG2BLUE = Color(0xFFF5FAFE);
  static Color klightblurColor = Color(0xFFF0F8FF);
  static Color kappbarColor = Color(0xFFF2F2F2);

  static Color green1 = Color(0xFFE5FAEB);
  static Color green2 = Color(0xFFBCF9C5);
  static Color green3 = Color(0xFFA0F7AD);
  static Color green4 = Color(0xFF8CF69C);
  static Color green5 = Color(0xFF70ED49);
  static Color black1 = Color(0xFF3A4557);
  static Color black2 = Color(0xFF2D3645);

  static Color kPrimaryRedColor = Color(0xFFCF3564);
  static Color kPrimaryBlueColor = Color(0xFF2372B6);

  static Color klightRedColor = Color(0xFFFEF9F6);
  static Color matruColor = Color(0xFF2372B6);
  static Color kPrimaryLightColor = Color(0xFFe9f7ea);
  static Color bluLightColor = Color(0xFF80daff);
  static Color bluLightColor1 = Color(0xFF01B1D6);

  //static Color kPrimaryLightColor = Color(0xFF92CA91);
  static Color grey = Color(0xFFF2F2F2);
  static Color newColor = Color(0xFF7c48ed);
  static Color deepPurple = Colors.deepPurple;
  static String currentSelectedValue = "+91";
  static String currentSelectedValue1 = "S/o";
  static String currency = "₹";
  static const channel = const MethodChannel("com.eHealthSystem/goAnotherApp");


  /////Agora//////
  /// Get your own App ID at https://dashboard.agora.io/
  static const String appId = 'fb2d58904b944dd597b1fe5b4b13a754';

  /// Please refer to https://docs.agora.io/en/Agora%20Platform/token
  static const String token = '006fb2d58904b944dd597b1fe5b4b13a754IAAXNkeIQ3CoLkztKxSXcocu2nvsZyuq0uG+HEkPfDpigeWvmVoAAAAAEACAl3NzIIzCYQEAAQAgjMJh';

  /// Your channel ID
  static const String channelId = 'TestEhs';

  /// Your int user ID
  static const int uid = 0;

  /// Your string user ID
  static const String stringUid = '0';
  ////////////////


  static Color grey100 = Color(0xFFF4F4F4);
  static Color greyBorder = Color(0xFFD7D7D7);
  static Color lightgreyBorder = Color(0xFF949494);
  static Color greyText = Color(0xFF616267);
  static const Color white = Color(0xFFFFFFFF);
  static List<String> phoneFormat = [
    "+91",
    //"+60" /*, "+80", "+78"*/
  ];
  static List<String> catagoryFormat = ["S/o", "D/o", "W/o"];


  static List<KeyvalueModel> catagoryFormat1 = [
    KeyvalueModel(key: "S", name: "S/o"),
    KeyvalueModel(key: "D", name: "D/o"),
    KeyvalueModel(key: "W", name: "W/o"),

  ];
  static KeyvalueModel currentSelectedValue2 = catagoryFormat1[0];
  static String selectedLanguage;

  static setSelectedLan(lan) {
    selectedLanguage = lan;
  }

  static setSelectedLanCode(code) {
    switch (code) {
      case "en":
        selectedLanguage = "English";
        break;
      case "bn":
        selectedLanguage = "ଓଡିଆ";
        break;
      case "mr":
        selectedLanguage = "मराठी";
        break;
      case "hi":
        selectedLanguage = "हिन्दी";
        break;
    }
    //(code == "en") ? selectedLanguage = "English" : selectedLanguage = "ଓଡିଆ";
  }

  static subStringBy(String code) {
    return code.substring(0, 4) +
        " " +
        code.substring(4, 8) +
        " " +
        code.substring(8, 12) +
        " " +
        code.substring(12, 16);
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
      dev.log('Could not launch ' + url);
    }
  }


  static getMonth(String monthNumber) {
    switch (monthNumber) {
      case "01":
        return "JAN";
      case "1":
        return "JAN";
      case "02":
        return "FEB";
      case "2":
        return "FEB";
      case "03":
        return "MAR";
      case "3":
        return "MAR";
      case "04":
        return "APR";
      case "4":
        return "APR";
      case "05":
        return "MAY";
      case "5":
        return "MAY";
      case "06":
        return "JUN";
      case "6":
        return "JUN";
      case "07":
        return "JUL";
      case "7":
        return "JUL";
      case "08":
        return "AUG";
      case "8":
        return "AUG";
      case "09":
        return "SEP";
      case "9":
        return "SEP";
      case "10":
        return "OCT";
      case "11":
        return "NOV";
      case "12":
        return "DEC";
      default:
        return "";
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
    return FilteringTextInputFormatter.allow(RegExp(r'[' + format + ']'));
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
static bool validateStructure(String value){
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-8])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
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
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static popup(BuildContext context, String message, Function fun) {
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

  static String getName(String first, String midle, String last) {
    if (midle != null && midle != "") {
      return first + " " + midle + " " + last;
    } else {
      return first + " " + last;
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

  static String toDate(String date) {
    if (date != null && date != "") {
      final DateTime formatter = DateFormat("yyyy-MM-dd").parse(date);
      DateFormat toNeed = DateFormat("dd-MM-yyyy");
      final String formatted = toNeed.format(formatter);
      return formatted;
    } else {
      return "";
    }
  }


  static void showbar(BuildContext context, String value) {
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
      backgroundColor: Colors.green,
      isDismissible: true,
      dismissDirection:FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve:Curves.easeOutCirc,
       margin: EdgeInsets.only(top: 60.0),
      duration: Duration(seconds: 6),
      maxWidth: 370,
    )..show(context);
  }

  static String getYoutubeThumbnail(String videoUrl) {
    final Uri uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }

    //return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/maxresdefault.jpg';
    //return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/mqdefault.jpg';
  }

  static void showInSnackBargreen(BuildContext context, String value) {
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
      backgroundColor: Colors.green,
      duration: Duration(seconds: 6),
    )..show(context);
  }

  static void showInSnackDone(BuildContext context, String value) {
    Flushbar(
      //  title:  "Hey SuperHero",
      message: value,

      backgroundColor: Colors.green,
      duration: Duration(seconds: 6),
    )..show(context);
  }
  static void showInSnackDone1(BuildContext context, String value) {
    Flushbar(
      //  title:  "Hey SuperHero",
      message: value,

      backgroundColor: Colors.green,
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

  static String address = "Address: 1073, Bhosale Mystiqa,Gokhale,\n"
      "Road Model Colony,Pune - 411016, (MH) INDIA";
  static String aboutus =
      "Together, we’re on a path to wellness for body, mind, and spirit. Now anyone can take charge of their health and transform their life using our easy-to-use, yet powerful, healthcare technologies & tools.The eHealthSystem supports WHO eHealth Strategy (WHA 58:28) eHealth stressing that eHealth is the cost-effective and secure use of information and communications technologies in support of health and health-related services. \n"
      "eHealthSystem works as a LiveWire of Connectivity connecting different healthcare stakeholders that include clinics, pharmacies, blood banks, hospitals, ambulances, organ donors, laboratories and patients on a single platform."
      "We are a digital healthcare solutions provider. We dedicate ourselves to improving the existing Electronic Health Record technology further, by providing users the power to carry their health records globally in a portable, user-friendly and secure manner.";

  static String organ1 =
      "We humbly request all the professionals working in the healthcare sector to come forward and make a contribution by wilfully submitting your consent form for organ donation. Only you can save someone’s life by donating your organs. Even, in case, if you are in need of an organ in your lifetime, you would get preference in getting in an organ if you have pledged yourself to donate an organ using eHealthSystem.";
  static String organ11 =
      "Organ donation is the act of giving organs (living or dead) to someone who needs an organ to survive. Organ donation remains strictly confidential for both the donor and the recipient.";

  static String organ2 =
      "A living, brain dead or deceased person can donate organs. If living, any person above 18 years of age is eligible to donate. A brain dead person can donate upto 8 organs. After death, the whole body can be donated.";
  static String organ22 =
      "The total and irreversible loss of all brain functions. The ability to breath is lost and the person’s body can only be maintained artificially for few hours." +
          "Family members of such patients should immediately contact the transplant coordinator for donating the organs. There is no age limit for brain-dead cases and any person male or female can donate the organs.";

  static String organ3 =
      "While alive, you can donate a kidney, some portion of liver, and bone marrow. If in a brain dead state, one can donate Heart, Kidney, Liver, Intestines, Skin, Cornea, Lungs and Pancreas.";
  static String organ33 =
      "After approval from the transplant center, concerned health authorities, and the family members, doctors can begin the necessary procedure.";


  static String organ4="Any living person can sign up the organ donation form and pledge to be an organ donor. When the person is brain dead, the family members should immediately contact transplant coordinators. After medical evaluation, the necessary organs are retrieved for transplantation. "+
  "Anyone who has pledged to be an organ donor should always inform the close family members about their wish."+
  "After donation there is no difficulty during cremation. All the information of the donor and the receiver is kept confidential.";
  //static String organ44="After approval from the transplant center, concerned health authorities, and the family members, doctors can begin the necessary procedure.";
  static String tearm=
    "i. Organ donation is a family decision.Therefore ,it is important that you discuss your decision with family members and loved ones so that it will be easier tofollow through with your wishes.";
  static String govtschem1=
      "The scheme aimed to help road accident victims get instant treatment at the trauma care hospitals across the state.";
  static String govtschem11=
      "Under the Bal Thackeray Upgath Vima Yojana, the accident victims will be treated for free in trauma care hospitals for up to 3 days. The state government will cover the cost of treatment of up to Rs. 30,000/-.";
  static String govtschem12=
      "Complete Details are not available yet.";
  static String govtschem2=
      "The objective of JSSK Programme is that each and every pregnant woman and sick infant upto age of 1 year gets timely access to the health care system for required quality antenatal, intra-natal, post-natal and immunization and diagnostics free of cost.";
  static String govtschem21=
      "Prgenant Womens.";
  static String govtschem22=
    "1.	Ration Card\n2.	Aadhar Card\n3.	Antyodaya or Annapurna Card";
  static String govtschem23=
      "Services are provided by a network of Sub-centers, Primary health centers, Rural hospitals, Sub-district hospitals, District/Woman hospitals, Govt. medical college hospitals etc government institutes.";
  static String govtschem3=
      "To improve access of Below Poverty Line (BPL) and Above Poverty Line (APL) families (excluding White Card Holders as defined by Civil Supplies Department) to quality medical care for identified speciality services requiring hospitalization for surgeries and therapies or consultations through an identified Network of health care providers.";
  static String govtschem31=
      "1.	People from Below & Above Poverty line categories having Orange card(annual family income below 1 lac), Yello/white Card, Antyodaya and Annapurna Card holders.\n2.	Ashramshal, orphanage, old age homes and journalists.\n3.	Farmers from 14 identified distressed districts of Maharashtra.";
  static String govtschem32=
      "1.	Insurance upto 2 lakh per family annually.\n2.	Amount will be incresed to 2.5-3 lakh in case of kidney transplant.\n3.	1100 identified ailments are covered such as knee replacement, sickle cell, anamia treatment and old age issues.\n4.	Scheme covers treatment, follow up charges, consultation charges and kidney tranplant charges.";
  static String govtschem33=
      "People can directly visit to network hospitals with the required documents for treatment. Visit given link for list of networked hopsitals.";
  static String govtschem4=
      "To strengthen effective monitoring of mortality indicators IMR and MMR through tracking of health Services to pregnant women & children is the main objective of project. Tracking & monitoring of health services delivered to severe anaemic & high risk mothers as well as low birth weight babies, monitoring of health services of beneficiaries in view of fully protected mothers and fully protected child, generation of monthly action plans in the form of work plans at health facility and health worker level as per the beneficiaries allotted are the other objectives of this project.";
  static String govtschem41=
      "Womens from BPL families";
  static String govtschem42=
      "1.	Beneficiary information regarding services given and services recorded in the MCTS Software is verified through telephonic calls pushed to beneficiary’s mobile number by state MCTS Call Centre. Janani Suraksha Yojana (JSY), Janani Shishu Suraksha Karyakram (JSSK) etc. Government health programs information is also being made available to them through telephonic calls.\n2.	New registered beneficiaries as well as services updated beneficiaries information is sent in the form of text SMS on the mobile numbers of various officers working at State, District, Block, Facility level.\n3.	SMS work plans regarding due services for a particular month are being sent on mobile numbers of health workers as per beneficiary allotted.\n4.	Information regarding AADHAR Number and Bank Account number of Eligible beneficiary under Janani Suraksha Yojana (JSY) is collected in MCTS Software for Aadhar Enabled Payment System (AEPS) through Direct Benefit Transfer (DBT). The beneficiary list is synchronised with Central Government’s CPSMS Portal on daily basis.";
  static String govtschem5=
      "The objective of JSSK Programme is that each and every pregnant woman and sick infant upto age of 1 year gets timely access to the health care system for required quality antenatal, intra-natal, post-natal and immunization and diagnostics free of cost.";
  static String govtschem51=
      "BPL families";
  static String govtschem52=
      "All the mental health care services and diet are being provided free of cost to the below poverty give patients/families";
  static String govtschem53=
      "Govt. Mental Care/Hospitals";
  static String govtschem6=
      "1.	To provide an easy access to promotional, preventive, curative and rehabilitative services to the elderly through community based primary health care approach\n2.	To identify health problems in the elderly and provide appropriate health interventions in the community with a strong referral backup support. \n3.	To build capacity of the medical and paramedical professionals as well as the care-takers within the family for providing health care to the elderly.\n4.	To provide referral services to the elderly patients through district hospitals, regional medical institutions.";
  static String govtschem61=
      "In Maharashtra, this programme is being implemented in 6 districts namely Amravati, Bhandara, Chandrapur, Gadchiroli, Wardha & Washim. ";
  static String govtschem62=
      "Health promotion and Prevention Referral of difficult cases to District Hospital/higher healthcare facility";
  static String govtschem63=
      "Primary Health cares in ";
  static String govtschem64=
      "a)	First phase (2 dist.): Wardha and Washim\nb)	Second phase (4 dist.): Bhandara, Gadchiroli, Chandrapur and Amaravati";
  static String govtschem7=
      "To improve the health of population in Tribal areas by providing them health services, ample clean water, by providing food supply, giving proper treatment to malnourished children and ultimately giving productive and long life to tribal population is the main aim of Navsanjivani scheme.";
  static String govtschem71=
      "People belonging to Tribal Areas ";
  static String govtschem72=
      "A pregnant women is paid Rs. 400 /- in cash for visiting health center for antenatal check up along with medicines worth Rs. 400/- to ensure a better health. This Scheme is applicable to tribal women having current pregnancy and live two issues.";
  static String govtschem73=
      "In tribal areas for tribal people, mostly for women & children to provide medical health at their homes and if required to shift nearest health centre Bharari Pathaks are functional.172 Bharari Pathaks have been constituted with one Medical officer with 2 Para-Medical staff which are appointed on deputation. 172 Bharari Pathaks are doing medical checkup and provide medicines. Bharari Pathaks Medical Officers are being provided Govt grants and grant of Rs. 6000/- per month per Pathak is provided. Additional funds of Rs 12000/- through RCH PIP (NRHM) are provided.";
  static String govtschem74=
      "In this scheme regular re-orientation regarding safe motherhood & neonatal care of trained and untrained Dais is being carried out by organizing quarterly meetings of Dais at sub centre level.\n\nProvision of food and loss of wages for SAM /MAM children and their relatives - Provision of food and loss of wages to relatives accompanying SAM/MAM children taking treatment at PHC/RH. Relatives accompanying SAM/MAM children Rs.40 per day is given as compensation for loss of wages till the child is admitted and Rs 65 per child is given, for food till the child is admitted. The funds for same are distributed to Zillah Parishad from Tribal Development Dept.";
  static String govtschem75=
      "Accessibility in tribal area is a problem in monsoon season due to geographical situation of area & limited transport facilities. Hence it is planned to conduct Health check up Immunization / Nutritional assessment of all tribal Population in said area. In the months of May & June various Bharari Pathaks are deputed in hilly areas to facilitate uninterrupted treatment, vaccination, referral services";
  static String govtschem76=
      "Under Navsanjivani Yojana in tribal area Rural Hospital, PHC, Subcentres, Ayurvedic Hospital give free services for patients, Bharari Pathaks also provide such Health Services.";
  static String govtschem8=
      "1.	To improve the health status of the urban poor community by provision of quality integrated primary health care services.\n2.	To strengthen the existing urban health infrastructure by renovation/ upgradation of existing facilities.\n3.	To support the development of referral system for institutional deliveries, emergency obstetric care and terminal method of family planning.\n4.	Involvement of NGO's / Private sector in the provision of primary health care services and also as part of referral system.\n5.	Integration of the existing health infrastructure with the proposed urban health programme. Funding will be performance based and the same principle will apply to the urban bodies receiving grants for the programme.";
  static String govtschem81=
      "urban poor children";
  static String govtschem82=
      "Parental iron supply, Gynecologist visit, supply of lab chemical & consumable, Maternal Death Audit, Pediatrician services, Child Death Audit, ARSH Clinic establishment. Outreach activities & provided value added services to adolescent girls and boys. Organizing Diagnostic camps which include HB testing, blood grouping, treatment of minor ailments, RCH Camps, Capacity building workshop & Training etc. services have been provided.";
  static String govtschem83=
      "Services are provided by health posts established under the 26 Municipal Corporations & 219 Municipal Councils.";








}

