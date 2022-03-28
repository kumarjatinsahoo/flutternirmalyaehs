import 'package:flutter/cupertino.dart';

class Const {
  static List<String> acdYrList = [
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030",
    "2031",
    "2032",
    "2033",
    "2034"
  ];

  static String REGISTRATION = "registrationForm";
  static String LOGIN_DATA = "loginResponse";
  static String REMEMBER_USERID = "RememberUserId";
  static String REMEMBER_PASSWORD = "RememberPassword";
  static String MASTER_RESPONSE = "masterData";
  static String LOGIN_phoneno = 'phoneno';
  static String LOGIN_password = 'password';
  static String IS_LOGIN = "IS_LOGIN";
  static String IS_REGISTRATION = "IS_REGISTRATION";
  static String IS_DETAIL_VIEW = "IS_VIEW_SHOWING";
  static String IS_REG_SERVER = "is_already_register";

  static const String DEATH = "DEATH BENEFIT";
  static const String TRUE = "true";
  static const String FUNERAL = "FUNERAL EXPENSES";
  static const String MARRIAGE = "ASSISTANCE FOR MARRIAGE";
  static const String EDUCATION = "ASSISTANCE FOR THE EDUCATION OF CHILDREN";
  static const String MATERNITY = "MATERNITY BENEFIT";
  static const String REG_CODE = "P001";
  static const String RENEW_CODE = "P002";
  static const String RESUMPTION_CODE = "P003";
  static const String DAUGHTER_CODE = "8";
  static const String RESULT_OK = "OK";
  static const String RESULT_CANCEL = "CANCEL";
  static const String FEMALE_CODE = "1";
  static const String MALE_CODE = "0";
  static const String TRANSGENDER_CODE = "3";
  static const String SON_CODE = "7";
  static const String STATUS = "code";
  static const String STATUS1 = "status";
  static const String CODE = "code";
  static const String SUCCESS = "success";
  static const String BODY = "body";
  static const String FAILED = "failed";
  static const String MESSAGE = "message";
  static const String ALREADY_REG = "Already Registered !!";
  static const String NETWORK_ISSUE = "Sorry Network Issue";
  static const String NEXT_SERVER_LOAD = "next_server_load";
  static const String ALREADY_REG_STATUS = "registered";
  static const String APP_ID = "8036d1868bd71fb6b500cb18eeec3936";
  static String DOC_APNT = "DOC_APNT";
  static String HEALTH_SCREENING_APNT = "HEALTH_SCREENING_APNT";
  static String CONFIRMED = "CONFIRMED";
  static String REQUESTED = "REQUESTED";
  static String TREATED = "TREATED";
  static String HEALTH_SCREENING_USER_APNT = "HEALTH_SCREENING_USER_APNT";
  static String PATINTDETAILS = "PATINTDETAILS";
  static String HEALTH_CHKUP_APNT = "HEALTH_CHKUP_APNT";
  static String HEALTH_CHKUP_USER_APNT = "HEALTH_CHKUP_USER_APNT";
  static const String DEATH_CODE = "B3";
  static const String FUNERAL_CODE = "B5";
  static const String MATERNITY_CODE = "B8";
  static const String MARRIAGE_CODE = "B4";
  static const String EDUCATION_CODE = "B6";
  static const String TIMEOUT = "TIMEOUT";
  static const String SELF = "Self";
  static const String DAUGHTER = "Daughter";
  static const String INTERNET_CONNECTION = "PLEASE CHECK YOUR INTERNET";
  static const String EDIT_BENEFICIARY = "Edit Beneficiary";
  static const String POST = "Edit Beneficiary";
  static const String ANDROID = "7";
  static const String IOS = "7";
  static const String IOS_VERSION = "2.0.2";

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static getMode(String payMode) {
    /*if (payMode1 == PayMode1.cash) payModeCode = "1";
    if (payMode1 == PayMode1.cheque) payModeCode = "2";
    if (payMode1 == PayMode1.online) payModeCode = "3";*/
    switch (payMode) {
      case "1":
        return "Cash";
      case "2":
        return "Cheque";
      case "3":
        return "Online";
    }
  }

  static DateTime getExpireDate(String date, String month) {
    month=month.replaceAll("  ", " ");
    List<String> split = month.split(" ");
    switch (split[0]) {
      case "JANUARY":
        return DateTime(int.tryParse(split[1]),1,int.tryParse(date));
      case "FEBRUARY":
        return DateTime(int.tryParse(split[1]),2,int.tryParse(date));
        // return [date, '2', split[1]];
      case "MARCH":
        return DateTime(int.tryParse(split[1]),3,int.tryParse(date));
        // return [date, '3', split[1]];
      case "APRIL":
        // return [date, '4', split[1]];
        return DateTime(int.tryParse(split[1]),4,int.tryParse(date));
      case "MAY":
        // return [date, '5', split[1]];
        return DateTime(int.tryParse(split[1]),5,int.tryParse(date));
      case "JUNE":
        // return [date, '6', split[1]];
        return DateTime(int.tryParse(split[1]),6,int.tryParse(date));
      case "JULY":
        return DateTime(int.tryParse(split[1]),7,int.tryParse(date));
        // return [date, '7', split[1]];
      case "AUGUST":
        // return [date, '8', split[1]];
        return DateTime(int.tryParse(split[1]),8,int.tryParse(date));
      case "SEPTEMBER":
        // return [date, '9', split[1]];
        return DateTime(int.tryParse(split[1]),9,int.tryParse(date));
      case "OCTOBER":
        // return [date, '10', split[1]];
        return DateTime(int.tryParse(split[1]),10,int.tryParse(date));
      case "NOVEMBER":
        // return [date, '11', split[1]];
        return DateTime(int.tryParse(split[1]),11,int.tryParse(date));
      case "DECEMBER":
        // return [date, '12', split[1]];
        return DateTime(int.tryParse(split[1]),12,int.tryParse(date));
    }
  }
}

enum CallFor {
  PROOF_EXP,
  PHYSICAL,
  AGEPROOF,
  PASSBOOK,
  AADHAR,
  SELF_CERTIFICATION,
  MATERNITY_BIRTH,
  MARRIAGE_CERT,
  EDUCATION_CERT,
  DEATH_CERT,
  LEGALHEIR_CERT,
  FUNERAL_CERT,
}

enum PayFor { REGISTRATION, RENEWAL }
enum DobFor { DEATH, FUNERAL, EDUCATION }

enum UserType {
  ADMIN, // ADMIN USER
  USER, //Pregnant Patient
  HOSPITAL, //Hospital Checkup
  KIT, //KIT Supplier
  ASHA, //Asha worker
  ACCOUNT, //Accounts
  CDMO, //CDMO
  DSWO //DSWO
}
