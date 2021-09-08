class ApiFactory {
  static String REG_DEVICE = "https://cca.medtel.in/Ziniai/manageDeviceId";

  //static String MAIN_URL = "http://api.ehealthsystem.com/nirmalyaRest/api/";
  static String MAIN_URL = "http://192.168.29.25:8062/nirmalyaRest/api/";

  static String VITALS_REPORT = MAIN_URL + 'medtel-screening-test-report';
  static String COUNTRY_API = MAIN_URL + 'get-country-list';
  static String TITLE_API = MAIN_URL + 'get-user-title-list';
  static String ORGANISATION_API = MAIN_URL + 'get-all-organization-list';
  static String GENDER_API = MAIN_URL + 'get-gender-list';
  static String SPECIALITY_API = MAIN_URL + 'get-speciality-list';
  static String BLOODGROUP_API = MAIN_URL + 'get-bloodgroup-list';
  static String MEDICINE_API = MAIN_URL + 'get-medicine-list-with-type';
  static String USER_REGISTRATION = MAIN_URL + 'user-self-registration';
  static String DOCTOR_REGISTRATION = MAIN_URL + 'doctor-registration-details';
  static String USER_DASHBOARD = MAIN_URL + 'user-dashboard?userid=';
  static String PERSONAL_DETAILS =
      MAIN_URL + 'user-personal-information-doctor?userid=';
  static String IABTEST_REPORTDOCTER =
      MAIN_URL + 'user-labtest-report-doctor?userid=';
  static String MEDICATION_DOCTER = MAIN_URL + 'user-medication-doctor?userid=';
  static String USER_UPDATEPROFILE = MAIN_URL + 'update-user-profile';
  static String RELATION_API = MAIN_URL + 'get-relation-list';
  static String POST_APPOINTMENT = MAIN_URL + 'post-doctor-appointment';
  static String POST_MEDICATION = MAIN_URL + 'post-user-medication-doctor';
  static String PATIENT_PROFILE = MAIN_URL + 'get-patient-details?userid=';
  static String STATE_API = MAIN_URL + 'get-state-list?country=';
  static String DISTRICT_API = MAIN_URL + 'get-district-list?state=';
  static String CITY_API = MAIN_URL + 'get-city-list?district=';
  static String DOCTOOR_API = MAIN_URL + 'get-doctor-list?type=';
  static String HOSPITAL_API = MAIN_URL + 'get-hospital-list?doctor=';
  static String SPECIALITY_API2 = MAIN_URL + 'get-speciality-list';
  static String ORGANIZATION_API = MAIN_URL + 'get-all-organization-list';

  static String LOGIN_PASS(String mob, String pass) {
    return MAIN_URL + "login?mobileNo=$mob&password=$pass";
  }

  static String POST_SIGNUP = MAIN_URL + 'signup-by-pathologist';
  static String LAB_SIGNUP = MAIN_URL + 'doctor-registration-details';
  static String GET_BENE_DETAILS = MAIN_URL + 'get-regDetails?regNo=';

  static String POST_HEALTH_SCREEN = MAIN_URL + 'post-addLabAppointment';

  static String POST_HEALTH_CHCKUP = MAIN_URL + 'post-addchkupAppointment';

  static String POC_REPORT_LIST = MAIN_URL + 'view-medteltest-list';

  static String EMERGENCY_HELP = MAIN_URL + 'view-user-emergency-details-api?userid=';

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
  static String user_APPOINTMENT_status =
      MAIN_URL + 'change-user-appointment-status?appid=';
  static String TEST_REPORT_USER = MAIN_URL + 'view-medteltest-list-throughId';
  static String USER_APPOINTMENTS = MAIN_URL + 'get-user-appointment-list?userid=';
}
