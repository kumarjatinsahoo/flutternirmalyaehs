class ApiFactory {

  /////////////////Configure//////////////////

  ////Production : isLocal:false && isProduction:true
  ////Staging : isLocal:false && isProduction:false
  ////Local : isLocal:true && isProduction:false

  static bool isProduction = false;
  static bool isLocal = false;
  static String LOCAL_URL = "http://192.168.0.124:8062/nirmalyaRest/api/";

  static String REG_DEVICE = "https://cca.medtel.in/Ziniai/manageDeviceId";
  static String MAIN_URL = (!isLocal)
      ? (isProduction)
          ? "http://api.ehealthsystem.com/nirmalyaRest/api/"
          : "http://api-demo.ehealthsystem.com/nirmalyaRest/api/"
      : LOCAL_URL;

  static String MAIN_URL1 = "https://1331.co.in/api";
  static String REPORT_URL1 = (!isLocal)
      ? (isProduction)
          ? "https://ehealthsystem.com/"
          : "http://demo.ehealthsystem.com/"
      : LOCAL_URL.replaceAll("nirmalyaRest/api/", "");


  static String VITALS_REPORT = MAIN_URL + 'medtel-screening-test-report';
  static String GET_PATIENTALLLAB = MAIN_URL + 'get-patient-all-lab-request-list?userid=';
  static String GET_PATIENTALLMEDICIN = MAIN_URL + 'get-patient-all-medicine-request-list?userid=';
  static String COUNTRY_API = MAIN_URL + 'get-country-list';
  static String VIEW_PATIENT_HEALTH_API =
      REPORT_URL1 + 'user/mobile-view-patient-health-chart?id=';
  static String MEDICATION_VIEW_PRESCRIPTION =
      REPORT_URL1 + 'user/view-patient-medication-view-prescription?userid=';
  static String TEST_VIEW_PRESCRIPTION =
      REPORT_URL1 + 'user/view-patient-test-report-pdf-download-digital?id=';
  static String TEST_VIEW_ORGANCARD = REPORT_URL1 + 'user/patient-organ-donation-card?id=';

  //static String VIEW_PATIENT_HEALTH_API = MAIN_URL + 'user/mobile-view-patient-health-chart?id=';
  static String AMBULANCE_API = MAIN_URL + 'get-ambulance-orglist';
  static String BLOODBBANKNAME_API = MAIN_URL + 'get-bloodbank-orglist';
  static String TITLE_API = MAIN_URL + 'get-user-title-list';
  static String INSURANCE_TITLE = MAIN_URL + 'get-insurance-title-list';
  static String INSURANCE_PINCODE = MAIN_URL + 'get-Insurance-Pincode-Autosearch?id=';
  static String INSURANCE_MARITALSTATUS = MAIN_URL + 'get-insurance-maritalstatus-list';
  static String INSURANCE_OCCUPATION = MAIN_URL + 'get-insurance-ocupation-list';
  static String INSURANCE_RELATION = MAIN_URL + 'get-insurance-relationCode-list';


  static String NAME_API = MAIN_URL + 'get-allergy-name-list';
  static String TYPE_API = MAIN_URL + 'get-allergy-type-list';
  static String ORGAN_API = MAIN_URL + 'get-organ-list';
  static String TISSUE_API = MAIN_URL + 'get-tissue-list';
  static String ORGANISATION_API = MAIN_URL + 'get-all-organization-list';
  static String SYNDICATE_ORGANISATION_API =
      MAIN_URL + 'get-syndicate-partner-organization';
  static String PHARMACY_ORGANISATION_API = MAIN_URL + 'get-pharmacy-list';
  static String AMBULANCE_ORGANISATION_API =
      MAIN_URL + 'get-ambulance-org-list';
  static String BlOODBANK_ORGANISATION_API =
      MAIN_URL + 'get-bloodbank-org-list';
  static String NGO_ORGANISATION_API = MAIN_URL + 'get-ngo-org-list';
  static String POST_TEST = MAIN_URL + 'post-user-test-by-doctor';
  static String POST_REMINDER = MAIN_URL + 'post-medicine-reminder-api';
  static String DELETE_TEST_LIST = MAIN_URL + 'delete-test-by-app-no?appno=';
  static String BIOMEDICAL_IMPLANTS =
      MAIN_URL + 'view-user-biomedical-implant-list-api?userid=';
  static String lab_list_by_searchvalue =
      MAIN_URL + 'get-lab-list-by-searchvalue?search=';
  static String GET_VERSION = MAIN_URL + 'get-version';

  /*static String BIOMEDICAL_IMPLANTS =
  MAIN_URL + 'view-user-biomedical-implant-list-api?userid=';*/
  static String UPLOAD_DOCUMENT =
      MAIN_URL + 'get-medical-upload-details-api?userid=';
  static String DIESEINFO = MAIN_URL + 'get-disease-info-list';
  static String IMMUNIZATION_LIST =
      MAIN_URL + 'get-immunization-patient-details?userid=';
  static String INSURANCE_list =
      MAIN_URL + 'get-patient-insurance-list-api?userid=';
  static String UPDATE_DOCTER_PROFILE = MAIN_URL + 'update-doctor-profile';
  static String INSURANCE_Details =
      MAIN_URL + 'get-patient-insurance-details-api?key=';
  static String MONTHLY_OVERVIEW =
      MAIN_URL + 'get-doctor-month-overviewlist?drid=';
  static String AMBULANCE_MONTH_OVERVIEW =
      MAIN_URL + 'get-ambulance-month-overviewlist?ambid=';
  static String GET_BLDBANK_MONTHOVERVIEW =
      MAIN_URL + 'get-bldbnk-month-overviewlist?bldbnkid=';
  static String GET_PHARMACY_MONTHOVERVIEW =
      MAIN_URL + 'get-pharmacy-month-overviewlist?pharmacyid=';
  static String GENDER_API = MAIN_URL + 'get-gender-list';
  static String pharmacy_list_by_searchvalue =
      MAIN_URL + 'get-pharmacy-list-by-searchvalue?search=';
  static String IMMUNIZATION_STATUS =
      MAIN_URL + 'get-update-immunization-status?slno=';
  static String ADM_EQUIPMENT_API = MAIN_URL + 'get-adm-equipment-list';
  static String SHARE_APPOINTMENT_UHID =
      MAIN_URL + 'get-confirmed-patient-list?drid=';
  static String RECEPTIONLIST_DOCTOR =
      MAIN_URL + 'get-doctor-list-by-org?userid=';
  static String SHARE_APPOINTMENT_DOCTORRECEPTIONIST =
      MAIN_URL + 'get-doctorreceptionist-list?drid=';




  static String DELETE_REMINDER =
      MAIN_URL + 'delete-medicine-reminder-details?reminderId=';


  static String GET_DOCUMENT_API = MAIN_URL + 'get-document-type-list';
  static String IMMUNIZATION_API = MAIN_URL + 'get-immunization-type-list';
  static String SPECIALITY_API = MAIN_URL + 'get-doctor-speciality-list';
  static String MARITAL_API =
      'http://api.ehealthsystem.com/nirmalyaRest/user/getmaritalstatusListnew';
  static String BLOODGROUP_API = MAIN_URL + 'get-bloodgroup-list';
  static String MEDICINE_API = MAIN_URL + 'get-medicine-list-with-type';
  static String USER_REGISTRATION = MAIN_URL + 'user-self-registration';
  static String DOCTOR_REGISTRATION = MAIN_URL + 'doctor-registration-details';
  static String NEWS_UPDATE_POST = MAIN_URL + 'post-data-for-news-media';
  static String PHARMACY_REGISTRATION = MAIN_URL + 'post-pharmacy-registration';
  static String ALLERGIC_POST = MAIN_URL + 'post-allergies-api';
  static String INSURANCE_POST = MAIN_URL + 'post-insurance-details';
  static String PHARMACY_LIST = MAIN_URL + 'get-pharmacy-list-by-location';
  static String LAB_LIST = MAIN_URL + 'get-pathology-list-by-location';
  static String USER_PROFILE_IMAGE = MAIN_URL + 'update-user-profile-image';
  static String OTHER_PROFILE_SIGN =
      MAIN_URL + 'update-doctor-digitalsignature';
  static String OTHER_PROFILE_IMAGE = MAIN_URL + 'update-other-profileimage';
  static String USER_DASHBOARD = MAIN_URL + 'user-dashboard?userid=';
  static String PERSONAL_DETAILS =
      MAIN_URL + 'user-personal-information-doctor?userid=';
  static String IABTEST_REPORTDOCTER =
      MAIN_URL + 'user-labtest-report-doctor?userid=';
  static String MEDICATION_DOCTER = MAIN_URL + 'user-medication-doctor?userid=';
  static String FAMILY_DOCTER = MAIN_URL + 'get-patient-family-details?userid=';
  static String USER_UPDATEPROFILE = MAIN_URL + 'update-user-profile';
  static String POST_ACTIVITYLOG = MAIN_URL + 'post-activity-log-api';
  static String RELATION_API = MAIN_URL + 'get-relation-list';
  static String smoking_API = MAIN_URL + 'get-smoking-details-list';
  static String alchohol_API = MAIN_URL + 'get-alchohol-details-api';
  static String PETLIST_API = MAIN_URL + 'get-pet-list';
  static String POST_APPOINTMENT = MAIN_URL + 'post-doctor-appointment';
  static String POST_AMBULANCEDETAILS = MAIN_URL + 'post-ambulance-details';
  static String POST_USERHEALTHRECORD =
      MAIN_URL + 'post-user-health-record-api';
  static String POST_BlOODBANKDETAILS = MAIN_URL + 'post-bloodbank-details';
  static String POST_MEDICATION = MAIN_URL + 'post-user-medication-doctor';
  static String PATIENT_PROFILE = MAIN_URL + 'get-patient-details?userid=';
  static String USER_PROFILE = MAIN_URL + 'other-user-profile?userid=';
  static String STATE_API = MAIN_URL + 'get-state-list?country=';
  static String DISTRICT_API = MAIN_URL + 'get-district-list?state=';
  static String CITY_API = MAIN_URL + 'get-city-list?district=';


  static String PATIENT_REG_ADDRESS = MAIN_URL + 'view-lab-technician-details?labTechId=';


  static String DOCTOOR_API = MAIN_URL + 'get-doctor-list?type=';
  static String HOSPITAL_API = MAIN_URL + 'get-hospital-list?doctor=';
  static String POST_ORGAN_DONOR = MAIN_URL + 'post-organ-donor-details';
  static String GET_PATIENT_MEDICAL_HISTORY =
      MAIN_URL + 'get-patient-medical-history?userid=';
  static String OPD_MODEL = MAIN_URL + 'doctor-opd-weekly?drid=';

  //static String SPECIALITY_API2 = MAIN_URL + 'get-speciality-list';
  static String TESTNAME_LIST = MAIN_URL + 'get-testname-list';
  static String SPECIALITY_API2 = MAIN_URL + 'get-doctor-speciality-list';
  static String ORGANIZATION_API = MAIN_URL + 'get-all-organization-list';
  static String HEALTHPROVIDER_API = MAIN_URL + 'get-health-provider-list';
  static String FORGOT_OTP = MAIN_URL + 'forgot-password-get-otp';
  static String EMERGENCY_OTP = MAIN_URL + 'get-otp-emergency-access?userid=';
  static String FORGOT_USERID = MAIN_URL + 'forgot-userid-get-otp';
  static String CHNG_PASS = MAIN_URL + 'change-password';
  static String DOCTER_AVAILABLE =
      MAIN_URL + 'doctor-available-by-date?doctor=';
  static String FIND_HEALTH_PROVIDER1 =
      MAIN_URL + 'find-health-provider-details';
  static String DELETE_MEDICINE_LIST =
      MAIN_URL + 'delete-medicine-by-app-no?appno=';
  static String VITAL_SIGN_DETAIS =
      MAIN_URL + 'view-user-vital-sign-details?userid=';
  static String IIFESTYLE_DETAIS =
      MAIN_URL + 'get-patient-lifestyle-details?userid=';
  static String UPDATE_VITAL_SIGN = MAIN_URL + 'update-vital-signs';
  static String CHANGE_PASSWORD_USER = MAIN_URL + 'change-password-user-wise';
  static String patient_lifestyle_details =
      MAIN_URL + 'post-patient-lifestyle-details';
  static String POST_PHARMACY_REQUST = MAIN_URL + 'post-pharmacy-request-api';
  static String ALERGY_LIST = MAIN_URL + 'get-allergy-name-list';
  static String VIEW_USER_MEDICINE_DETAILS =
      MAIN_URL + 'view-user-medicine-details-by-appno?appno=';

  static String EMERGENCY_HELP_NEW =
      MAIN_URL + "sms-to-emergency-contact-users";

  static String LOGIN_PASS(String mob, String pass) {
    return MAIN_URL + "login?mobileNo=$mob&password=$pass";
  }

  static String REMINDER_LIST(String uid, String date) {
    return MAIN_URL + "view-medicine-details-byid?userid=$uid&date=$date";
  }

  static String LOGIN_PASS_MULTIPLE(String mob, String pass) {
    return MAIN_URL + "login-multiple-user?mobileNo=$mob&password=$pass";
  }

  /*static String LOGIN_Otp(String mob) {
    return MAIN_URL + "login-with-otp?mobileNo=$mob";
  }*/
  static String LOGIN_Otp(String mob) {
    return MAIN_URL + "login-multiple-user-with-otp?mobileNo=$mob";
  }

  static String GET_OTP_USERID(String uhid, String username) {
    return MAIN_URL + "get-otp-for-username?uhid=$uhid&username=$username";
  }

  static String POST_USERID = MAIN_URL + 'post-update-username';

  static String INTREST_SIGNUP = MAIN_URL + 'get-catagory-subcategory-list';
  static String ADD_BIOMEDICAL_IMPLANTS =
      MAIN_URL + 'post-biomedical-implants-api';
  static String POST_SHARE_APPOINTMENT =
      MAIN_URL + 'post-share-appointment-api';
  static String ADD_UPLOAD_DOCUMENT = MAIN_URL + 'post-medical-dataupload-api';
  static String ADD_ORGANIZATION = MAIN_URL + 'post-add-organization-api';
  static String ADD_IMMUNIZATION =
      MAIN_URL + 'post-patient-immunization-details';
  static String SMS_TO_EMERGENCY =
      MAIN_URL + 'sms-to-emergency-contact-users?userid=';
  static String USER_SOME_DETAILS =
      MAIN_URL + 'get-user-some-details-api?userid=';

  static String POST_ADD_TRACKER =
      MAIN_URL + 'post-treatment-tracker';

  static String FIND_HEALTH_PROVIDER(String longi, String lati, String addr,
      String city, String healthpro, String type) {
    return MAIN_URL +
        "find-health-provider-details?longi=$longi&lati=$lati&addr=$addr&city=$city&healthpro=$healthpro&type=$type";
  }

  static String GOVET_SCHEMES_LIST(
      String contry, String state /*, String dist,
      String city*/
      ) {
    return MAIN_URL +
        "view-government-scheme-list?country=$contry&state=$state"; /*&dist=$dist&city=$city*/
  }

  static String GOOGLE_QUERY_API(
      {String longi,
      String lati,
      String healthpro,
      String type,
      String rankby,
      String radius}) {
    return "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$healthpro&location=$lati,$longi&radius=$radius&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";
  }

  static String GOOGLE_PAGINATION_API({String pagetoken}) {
    return "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=$pagetoken&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";
  }

  static String GOOGLE_NEARBY_API(
      {String longi,
      String lati,
      String healthpro,
      String type,
      String rankby,
      String radius}) {
    return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=20.2983537,85.8142227&radius=5000&type=Book a Hearse Van&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";
  }

  static String googleMapUrl({String longi, String lati}) {
    return "https://www.google.com/maps/search/?api=1&query=$longi%2C$lati";
    // return "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$healthpro&location=$lati%2C$longi&radius=10000&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";
  }

  static String GOOGLE_QUERY_API1 =
      "https://maps.googleapis.com/maps/api/place/textsearch/json?radius=10000&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE&query=";

  static String GOOGLE_PIC({String ref}) {
    //https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=Aap_uEAtFwLkonRuDN5tIlx1azLnZgdL8X6IKGY6mU56a_j_QCXfJmxGiJ9QInvT6psLc0DxSpEEsN7MtjjQ-nNexU7hjkF3nyK_VKOzqFx-TM3vuUuk_OpRbMU-KdGfkE49pXVNNxmrc5E5XYRVSfW8JA-W0x134Aj7JWa0Rsa2SIojRkuO&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$ref&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";
  }

  static String GOOGLE_LOC({String lat, String long}) {
    return "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";
  }

  static String GOOGLE_SEARCH({String place_id}) {
    return "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE&place_id=$place_id";
  }

  //https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE&place_id=ChIJ9UsgSdYJGToRiGHjtrS-JNc
  static String GOOGLE_MAP_IMG({String lat, String long}) {
    return "https://maps.google.com/maps/api/staticmap?zoom=16&size=1200x400&maptype=hybrid&sensor=false&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE&markers=$lat,$long";
    //return "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE&place_id=$place_id";
  }

  static String AUTO_COMPLETE =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE&input=";

  static String POST_SIGNUP = MAIN_URL + 'signup-by-pathologist';
  static String AMBULANCE_ALL = MAIN_URL + 'get-ambulance-actionlist?userid=';
  static String GET_DOCTEROVERVIEWLIST =
      MAIN_URL + 'get-doctor-overviewlist-bystatus?drid=';
  static String GET_AMBULANCE_OVERVIEWLIST =
      MAIN_URL + 'get-ambulance-overviewlist-bystatus?ambid=';
  static String GET_BLDBANK_OVERVIEWLIST =
      MAIN_URL + 'get-bldbnk-overviewlist-bystatus?bldbnkid=';
  static String GET_Farmacy_OVERVIEWLIST =
      MAIN_URL + 'get-pharmacy-overviewlist-bystatus?pharmacyid=';
  static String BLOODBANK_ALL = MAIN_URL + 'get-bloodbank-actionlist?userid=';
  static String AMBULANCE_APPOINTMENT =
      MAIN_URL + 'get-ambulance-actionlist?userid=';
  static String LAB_SIGNUP = MAIN_URL + 'doctor-registration-details';
  static String GET_BENE_DETAILS = MAIN_URL + 'get-regDetails?regNo=';
  static String POST_HEALTH_SCREEN = MAIN_URL + 'post-addLabAppointment';
  static String POST_HEALTH_CHCKUP = MAIN_URL + 'post-addchkupAppointment';
  static String POST_EMERGENCY_MESSAGE =
      MAIN_URL + 'post-user-emergency-message';
  static String POC_REPORT_LIST = MAIN_URL + 'user-view-test-list?';

  // static String POC_REPORT_LISTT = MAIN_URL + 'view-medteltest-list?userid=';
  static String POC_REPORT_LISTT = MAIN_URL + 'view-medteltest-list?userid=';
  static String POC_REPORT_SMS = MAIN_URL + 'post-update-report-sms-status';
  static String UPDATE_EMERGENCY_CONTACT =
      MAIN_URL + 'post-emergency-contact-api';
  static String DOCTOR_RATING = MAIN_URL + 'post-doctor-rating-api';
  static String UPDATE_DOCTOR_CONTACT = MAIN_URL + 'post-family-doctor-api';
  static String UPDATE_FAMILY_CONTACT = MAIN_URL + 'post-family-details-api';
  static String Delete_profile_CONTACT = MAIN_URL + 'delete-from-list-api?id=';
  static String EMERGENCY_HELP =
      MAIN_URL + 'view-user-emergency-details-api?userid=';
  static String CHANGE_STATUS_CHKUP = MAIN_URL + "post-chkupAppointmentStatus";
  static String AVAILABLE_DATE_CHKUP =
      MAIN_URL + "doctor-available-by-date?doctor=";
  static String AVAILABLE_TIME_CHKUP =
      MAIN_URL + "doctor-available-by-time?doctor=";
  static String CHANGE_STATUS_SCREENING = MAIN_URL + "post-appointmentStatus";
  static String WALK_IN_REG_LIST =
      MAIN_URL + "get-patient-registration-list?userid=";
  static String HEALTH_CHKUP_LIST =
      MAIN_URL + 'view-chkupAppointmentlist?appontdt=';
  static String HEALTH_SCREENING_LIST =
      MAIN_URL + 'view-labAppointmentlist?appontdt=';
  static String HEALTH_APPOINTMENT_SCREENING_LIST =
      MAIN_URL + 'view-user-screentest-appointment-list?userid=';
  static String HEALTH_APPOINTMENT_CHKUP_LIST =
      MAIN_URL + 'view-user-checkup-appointment-list?userid=';
  static String USER_APPOINTMENT_LIST =
      MAIN_URL + 'get-user-appointment-list?userid=';
  static String doctor_APPOINTMENT_LIST =
      MAIN_URL + 'view-doctor-appointment-list?userid=';
  static String doctor_MEDICINE_LIST =
      MAIN_URL + 'view-user-medicine-details-by-appno?appno=';
  static String MEDICAL_PRESCRIPTION =
      MAIN_URL + 'view-user-medical-prescription?userid=';
  static String TEST_PRESCRIPTION =
      MAIN_URL + 'view-user-test-prescription?userid=';
  static String doctor_TEST_LIST =
      MAIN_URL + 'view-user-test-details-by-appno?appno=';
  static String UHID_LIST = MAIN_URL + 'get-ehealth-user?search=';
  static String user_APPOINTMENT_status =
      MAIN_URL + 'change-user-appointment-status?appid=';
  static String ambulance_APPOINTMENT_status =
      MAIN_URL + 'change-ambulance-status?orderid=';
  static String bloodbank_status =
      MAIN_URL + 'change-bloodbank-status?orderid=';
  static String TEST_REPORT_USER = MAIN_URL + 'view-medteltest-list-throughId';
  static String VALIDATE_AADHAR = MAIN_URL + 'get-patient-aadhaar-exists?aadhhar=';



  static String USER_APPOINTMENTS =
      MAIN_URL + 'get-user-appointment-list?userid=';
  static String ORDER_LIST =
      MAIN_URL + 'view-user-pharmacy-orderlist-by-id?userid=';

  static String ORDER_LIST_STATUS =
      MAIN_URL + 'view-status-lab-orderlist-by-id?userid=';
  static String PHARMACY_CNFRM_ORDER_LIST =
      MAIN_URL + 'view-requested-medicine-details?orderid=';
  static String ORDER_DETAILS_LAB =
      MAIN_URL + 'view-requested-test-details?orderid=';
  static String ALLERGY_LIST = MAIN_URL + 'view-user-allergy-list-api?userid=';
  static String RECENT_DOCUMENT_LIST =
      MAIN_URL + 'get-documents-using-limit?userid=';
  static String NEWSUPDATE_VIEW =
      MAIN_URL + 'get-news-media-details-api?patid=';
  static String AMBULANCE_LIST =
      MAIN_URL + 'get-patient-ambulance-details?userid=';

  //static String AMBULANCE_LIST = MAIN_URL + 'get-patient-ambulance-details?userid=';
  static String MYPATIENTLIST_LIST =
      MAIN_URL + 'get-doctor-my-patientlist?drid=';
  static String BLDBANK_LIST = MAIN_URL + 'get-patient-bldbank-details?userid=';
  static String REFFERED_LIST = MAIN_URL + 'get-referred-user-list-api?userid=';
  static String ORGAN_LIST = MAIN_URL + 'view-user-donated-organ-list?userid=';
  static String CHANGE_STATUS_PHARMACY =
      MAIN_URL + 'change-pharmacy-status?orderid=';
  static String CHANGE_STATUS_LAB = MAIN_URL + 'change-lab-status?orderid=';
  static String HEALTH_CHART =
      "https://www.matrujyoti.in/api/view-screeningReport?regNo=9121389950648015";

  ///COWIN
  static String COWIN_SERVER = "https://cdn-api.co-vin.in/api";
  static String GENERATE_OTP = COWIN_SERVER + "/v2/auth/public/generateOTP";
  static String CONFIRM_OTP = COWIN_SERVER + "/v2/auth/public/confirmOTP";

  ///////////////?DEMO//////

  static String APPOINT_LIST = MAIN_URL1 + "/Doc/GetAptList?userid=";
  static String DOC_LIST = MAIN_URL1 + "/Doc/GetDocList?speciality=";
  static String TAKE_APNTMENT = MAIN_URL1 + "/Doc";
  static String POST_DOC_API = MAIN_URL + "geo-post-doctor-appointment";
  static String LAB_REQUEST = MAIN_URL + "post-lab-request-api";
  static String LAB_LIST_LOC = MAIN_URL + "get-lab-list-by-location";

  static String TIME_SLOT(
      String doctor, String appointdate, String hospitalid) {
    return MAIN_URL1 +
        "/Doc/GetDocSlotInfo?doctor=$doctor&appointdate=$appointdate&hospitalid=$hospitalid";
  }

  static String TIME_SLOT1 = MAIN_URL + "/Doc/GetDocSlotInfo?doctor=";
  static String GET_ROLE = MAIN_URL + "get-role-api?id=";

  static String API_VERSION = MAIN_URL + "get-version";







  //////////////////////////////
  // static String ABHA_BASE_URL = "https://dev.abdm.gov.in/gateway/v0.5/sessions";
  static String SESSION = "https://dev.abdm.gov.in/gateway/v0.5/sessions";
  static String GET_ADHAR_OTP = "https://healthidsbx.abdm.gov.in/api/v1/registration/aadhaar/generateOtp";
  static String POST_ADHAR_VERIFY_OTP = "https://healthidsbx.abdm.gov.in/api/v1/registration/aadhaar/verifyOTP";
  static String POST_ABHA_REGISTRATION = "https://healthidsbx.abdm.gov.in/api/v1/registration/aadhaar/createHealthIdWithPreVerified";
  static String SEND_PERSONAL_NO = "https://healthidsbx.abdm.gov.in/api/v1/registration/aadhaar/generateMobileOTP";
  static String VERIFY_MOBILE_NO = "https://healthidsbx.abdm.gov.in/api/v1/registration/aadhaar/verifyMobileOTP";



  //////////////////////////////////////////////////////////////////////////////////////////////////////












}

