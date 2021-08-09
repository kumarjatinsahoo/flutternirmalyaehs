class ApiFactory {
  static String REG_DEVICE = "https://cca.medtel.in/Ziniai/manageDeviceId";
  //static String MAIN_URL ="http://192.168.29.108:8062/nirmalyaRest/api/";
  static String MAIN_URL = "http://api.ehealthsystem.com/nirmalyaRest/api/";
  //static String MAIN_URL = "http://192.168.29.245:8062/nirmalyaRest/api/";
  static String STATE_API = MAIN_URL + 'get-country-list';

  static String CITY_API = MAIN_URL + 'get-state-list?country=';

  static String LOGIN_PASS(String mob, String pass) {
    return MAIN_URL + "login?mobileNo=$mob&password=$pass";
  }

  static String POST_SIGNUP = MAIN_URL + 'signup-by-pathologist';

  static String GET_BENE_DETAILS = MAIN_URL + 'get-regDetails?regNo=';

  static String POST_HEALTH_SCREEN = MAIN_URL + 'post-addLabAppointment';

  static String POST_HEALTH_CHCKUP = MAIN_URL + 'post-addchkupAppointment';

  static String POC_REPORT_LIST = MAIN_URL + 'view-medteltest-list';

  static String CHANGE_STATUS_CHKUP = MAIN_URL + "post-chkupAppointmentStatus";

  static String CHANGE_STATUS_SCREENING = MAIN_URL + "post-appointmentStatus";

  static String WALK_IN_REG_LIST = MAIN_URL + "get-patient-registration-list?userid=";

  static String HEALTH_CHKUP_LIST =
      MAIN_URL + 'view-chkupAppointmentlist?appontdt=';

  static String HEALTH_SCREENING_LIST =
      MAIN_URL + 'view-labAppointmentlist?appontdt=';
}
