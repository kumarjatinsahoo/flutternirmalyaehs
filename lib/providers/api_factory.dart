class ApiFactory {
  static String REG_DEVICE = "https://cca.medtel.in/Ziniai/manageDeviceId";

// static String MAIN_URL = "http://api.ehealthsystem.com/nirmalyaRest/api/";
  static String MAIN_URL = "http://192.168.29.25:8062/nirmalyaRest/api/";
 // static String MAIN_URLlocal = "http://192.168.29.108:8062/nirmalyaRest/api/";

  static String COUNTRY_API = MAIN_URL + 'get-country-list';
  static String TITLE_API = MAIN_URL + 'get-user-title-list';
  static String GENDER_API = MAIN_URL + 'get-gender-list';
  static String SPECIALITY_API = MAIN_URL + 'get-speciality-list';
  static String RELATION_API = MAIN_URL + 'get-relation-list';
  static String BLOODGROUP_API = MAIN_URL + 'get-bloodgroup-list';
  static String USER_REGISTRATION = MAIN_URL + 'user-self-registration';
  static String USER_DASHBOARD = MAIN_URL + 'user-dashboard?userid=5093626841904641';

  static String USER_UPDATEPROFILE = MAIN_URL + 'update-user-profile';


  static String PATIENT_PROFILE = MAIN_URL + 'get-patient-details?userid=5093626841904641';

  static String STATE_API = MAIN_URL + 'get-state-list?country=';
  static String DISTRICT_API = MAIN_URL + 'get-district-list?state=';
  static String CITY_API = MAIN_URL + 'get-city-list?district=';
  static String DOCTOOR_API = MAIN_URL + 'get-doctor-list?type=';
  static String HOSPITAL_API = MAIN_URL + 'get-hospital-list?doctor=';
  static String SPECIALITY_API2 = MAIN_URL + 'get-speciality-list';




  static String LOGIN_PASS(String mob, String pass) {
    return MAIN_URL + "login?mobileNo=$mob&password=$pass";
  }

  static String POST_SIGNUP = MAIN_URL + 'signup-by-pathologist';

  static String GET_BENE_DETAILS = MAIN_URL + 'get-regDetails?regNo=';

  static String POST_HEALTH_SCREEN = MAIN_URL + 'post-addLabAppointment';

  static String POST_HEALTH_CHCKUP = MAIN_URL + 'post-addchkupAppointment';
  static String POST_APPOINTMENT= MAIN_URL + 'post-doctor-appointment';

  static String POC_REPORT_LIST = MAIN_URL + 'view-medteltest-list';

  static String CHANGE_STATUS_CHKUP = MAIN_URL + "post-chkupAppointmentStatus";
  static String AVAILABLE_DATE_CHKUP = MAIN_URL + "doctor-available-by-date?doctor=";

  static String CHANGE_STATUS_SCREENING = MAIN_URL + "post-appointmentStatus";

  static String WALK_IN_REG_LIST = MAIN_URL + "get-patient-registration-list?userid=";

  static String HEALTH_CHKUP_LIST =
      MAIN_URL + 'view-chkupAppointmentlist?appontdt=';

  static String HEALTH_SCREENING_LIST =
      MAIN_URL + 'view-labAppointmentlist?appontdt=';
}
