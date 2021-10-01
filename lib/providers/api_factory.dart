class ApiFactory {
  static String REG_DEVICE = "https://cca.medtel.in/Ziniai/manageDeviceId";
  //static String MAIN_URL = "http://api.ehealthsystem.com/nirmalyaRest/api/";
  static String MAIN_URL = "http://192.168.29.108:8062/nirmalyaRest/api/";
  static String VITALS_REPORT = MAIN_URL + 'medtel-screening-test-report';
  static String COUNTRY_API = MAIN_URL + 'get-country-list';
  static String TITLE_API = MAIN_URL + 'get-user-title-list';
  static String NAME_API = MAIN_URL + 'get-allergy-name-list';
  static String TYPE_API = MAIN_URL + 'get-allergy-type-list';
  static String ORGANISATION_API = MAIN_URL + 'get-all-organization-list';
  static String PHARMACY_ORGANISATION_API = MAIN_URL + 'get-pharmacy-org-list';
  static String AMBULANCE_ORGANISATION_API = MAIN_URL + 'get-ambulance-org-list';
  static String BlOODBANK_ORGANISATION_API = MAIN_URL + 'get-bloodbank-org-list';
  static String NGO_ORGANISATION_API = MAIN_URL + 'get-ngo-org-list';
  static String BIOMEDICAL_IMPLANTS = MAIN_URL + 'view-user-biomedical-implant-list-api?userid=';

  static String GENDER_API = MAIN_URL + 'get-gender-list';
  static String ADM_EQUIPMENT_API = MAIN_URL + 'get-adm-equipment-list';
  static String SPECIALITY_API = MAIN_URL + 'get-doctor-speciality-list';
  static String BLOODGROUP_API = MAIN_URL + 'get-bloodgroup-list';
  static String MEDICINE_API = MAIN_URL + 'get-medicine-list-with-type';
  static String USER_REGISTRATION = MAIN_URL + 'user-self-registration';
  static String DOCTOR_REGISTRATION = MAIN_URL + 'doctor-registration-details';
  static String PHARMACY_REGISTRATION = MAIN_URL + 'post-pharmacy-registration';
  static String ALLERGIC_POST = MAIN_URL + 'post-allergies-api';
  static String PHARMACY_LIST = MAIN_URL + 'get-pharmacy-list-by-location';
  static String LAB_LIST = MAIN_URL + 'get-pathology-list-by-location' ;
  static String USER_DASHBOARD = MAIN_URL + 'user-dashboard?userid=';
  static String PERSONAL_DETAILS = MAIN_URL + 'user-personal-information-doctor?userid=';
  static String IABTEST_REPORTDOCTER = MAIN_URL + 'user-labtest-report-doctor?userid=';
  static String MEDICATION_DOCTER = MAIN_URL + 'user-medication-doctor?userid=';
  static String USER_UPDATEPROFILE = MAIN_URL + 'update-user-profile';
  static String RELATION_API = MAIN_URL + 'get-relation-list';
  static String POST_APPOINTMENT = MAIN_URL + 'post-doctor-appointment';
  static String POST_MEDICATION = MAIN_URL + 'post-user-medication-doctor';
  static String PATIENT_PROFILE = MAIN_URL + 'get-patient-details?userid=';
  static String USER_PROFILE = MAIN_URL + 'other-user-profile?userid=';
  static String STATE_API = MAIN_URL + 'get-state-list?country=';
  static String DISTRICT_API = MAIN_URL + 'get-district-list?state=';
  static String CITY_API = MAIN_URL + 'get-city-list?district=';
  static String DOCTOOR_API = MAIN_URL + 'get-doctor-list?type=';
  static String HOSPITAL_API = MAIN_URL + 'get-hospital-list?doctor=';
  static String TESTNAME_LIST = MAIN_URL + 'get-testname-list';
  static String SPECIALITY_API2 = MAIN_URL + 'get-doctor-speciality-list';
  static String ORGANIZATION_API = MAIN_URL + 'get-all-organization-list';
  static String HEALTHPROVIDER_API = MAIN_URL + 'get-health-provider-list';
  static String DOCTER_AVAILABLE = MAIN_URL + 'doctor-available-by-date?doctor=';
  static String FIND_HEALTH_PROVIDER1 = MAIN_URL + 'find-health-provider-details';
  static String DELETE_MEDICINE_LIST= MAIN_URL + 'delete-medicine-by-app-no?appno=';
  static String VITAL_SIGN_DETAIS= MAIN_URL + 'view-user-vital-sign-details?userid=';
  static String UPDATE_VITAL_SIGN= MAIN_URL + 'update-vital-signs';
  static String POST_PHARMACY_REQUST= MAIN_URL + 'post-pharmacy-request-api';
  static String ADD_BIOMEDICAL_IMPLANTS= MAIN_URL + 'post-biomedical-implants-api';

  static String ALERGY_LIST= MAIN_URL + 'get-allergy-name-list';
  static String VIEW_USER_MEDICINE_DETAILS = MAIN_URL + 'view-user-medicine-details-by-appno?appno=';
  static String LOGIN_PASS(String mob, String pass) {return MAIN_URL + "login?mobileNo=$mob&password=$pass";}
  static String FIND_HEALTH_PROVIDER(String longi, String lati,String addr,String city,String healthpro,String type){
    return MAIN_URL + "find-health-provider-details?longi=$longi&lati=$lati&addr=$addr&city=$city&healthpro=$healthpro&type=$type";}
    static String GOOGLE_API(
     {String longi, String lati, String healthpro, String type}){
    return "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$healthpro&location=$lati%2C$longi&radius=10000&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";

  }
 static String GOOGLE_PIC(
     {String ref}){
   //https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=Aap_uEAtFwLkonRuDN5tIlx1azLnZgdL8X6IKGY6mU56a_j_QCXfJmxGiJ9QInvT6psLc0DxSpEEsN7MtjjQ-nNexU7hjkF3nyK_VKOzqFx-TM3vuUuk_OpRbMU-KdGfkE49pXVNNxmrc5E5XYRVSfW8JA-W0x134Aj7JWa0Rsa2SIojRkuO&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$ref&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";
  }
static String GOOGLE_LOC(
     {String lat,String long}){
    return "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE";
  }
  static String GOOGLE_SEARCH(
      {String place_id}){
    return "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE&place_id=$place_id";
  }
  //https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyD-o-8txzrqCvKZaf35i-zILm2ooG851uE&place_id=ChIJ9UsgSdYJGToRiGHjtrS-JNc

  static String POST_SIGNUP = MAIN_URL + 'signup-by-pathologist';
  static String LAB_SIGNUP = MAIN_URL + 'doctor-registration-details';
  static String GET_BENE_DETAILS = MAIN_URL +'get-regDetails?regNo=';
  static String POST_HEALTH_SCREEN = MAIN_URL +'post-addLabAppointment';
  static String POST_HEALTH_CHCKUP = MAIN_URL +'post-addchkupAppointment';
  static String POST_EMERGENCY_MESSAGE = MAIN_URL +'post-user-emergency-message';
  static String POC_REPORT_LIST = MAIN_URL + 'view-medteltest-list';
  static String UPDATE_EMERGENCY_CONTACT = MAIN_URL + 'post-emergency-contact-api';
  static String EMERGENCY_HELP = MAIN_URL + 'view-user-emergency-details-api?userid=';
  static String CHANGE_STATUS_CHKUP = MAIN_URL + "post-chkupAppointmentStatus";
  static String AVAILABLE_DATE_CHKUP =MAIN_URL + "doctor-available-by-date?doctor=";
  static String AVAILABLE_TIME_CHKUP =MAIN_URL + "doctor-available-by-time?doctor=";
  static String CHANGE_STATUS_SCREENING =MAIN_URL + "post-appointmentStatus";
  static String WALK_IN_REG_LIST =MAIN_URL + "get-patient-registration-list?userid=";
  static String HEALTH_CHKUP_LIST =MAIN_URL + 'view-chkupAppointmentlist?appontdt=';
  static String HEALTH_SCREENING_LIST =MAIN_URL + 'view-labAppointmentlist?appontdt=';
  static String HEALTH_APPOINTMENT_SCREENING_LIST =MAIN_URL + 'view-user-screentest-appointment-list?userid=';
  static String HEALTH_APPOINTMENT_CHKUP_LIST =MAIN_URL + 'view-user-checkup-appointment-list?userid=';
  static String USER_APPOINTMENT_LIST =MAIN_URL + 'get-user-appointment-list?userid=';
  static String doctor_APPOINTMENT_LIST =MAIN_URL + 'view-doctor-appointment-list?userid=';
  static String doctor_MEDICINE_LIST =MAIN_URL + 'view-user-medicine-details-by-appno?appno=';
  static String user_APPOINTMENT_status =MAIN_URL + 'change-user-appointment-status?appid=';
  static String TEST_REPORT_USER = MAIN_URL + 'view-medteltest-list-throughId';
  static String USER_APPOINTMENTS = MAIN_URL + 'get-user-appointment-list?userid=';
  static String PHARMACY_ORDER_LIST = MAIN_URL + 'view-user-pharmacy-orderlist-by-id?userid=';
  static String PHARMACY_CNFRM_ORDER_LIST = MAIN_URL + 'view-requested-medicine-details?orderid=';
  static String ALLERGY_LIST = MAIN_URL + 'view-user-allergy-list-api?userid=';
  static String CHANGE_STATUS = MAIN_URL + 'change-pharmacy-status?orderid=';
  static String HEALTH_CHART = "https://www.matrujyoti.in/api/view-screeningReport?regNo=9121389950648015";


  ///COWIN
  static String COWIN_SERVER = "https://cdn-api.co-vin.in/api";
  static String GENERATE_OTP = COWIN_SERVER+"/v2/auth/public/generateOTP";
  static String CONFIRM_OTP = COWIN_SERVER+"/v2/auth/public/confirmOTP";




}
