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
  static String IS_LOGIN = "IS_LOGIN";
  static String IS_REGISTRATION = "IS_REGISTRATION";
  static String IS_DETAIL_VIEW = "IS_VIEW_SHOWING";

  static const String DEATH = "DEATH BENEFIT";
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
  static const String STATUS = "status";
  static const String SUCCESS = "success";
  static const String FAILED = "failed";
  static const String MESSAGE = "message";
  static const String ALREADY_REG = "Already Registered !!";
  static const String NETWORK_ISSUE = "Sorry Network Issue";
  static const String NEXT_SERVER_LOAD = "next_server_load";
  static const String ALREADY_REG_STATUS = "registered";

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
