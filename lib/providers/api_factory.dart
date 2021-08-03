class ApiFactory {
  static String SERVERIP =
      'https://sidhudkl.000webhostapp.com/api/master1.php?';

  static String MAIN_URL = "http://192.168.29.105:8062/nirmalyaRest/api/";
//https://sidhudkl.000webhostapp.com/api/master1.php?flag=viewemployeeDetailslist&employeeId=126
  ////?//////////////MASTER DATA//////////////////
  static String STATE_API = MAIN_URL + 'get-country-list';
  static String CITY_API = MAIN_URL + 'get-state-list?country=';
  static String LOGIN_PASS(String mob, String pass) {
    return MAIN_URL + "login?mobileNo=$mob&password=$pass";
  }

  static String EMPL_DETAILS = SERVERIP + 'flag=viewemployeeDetailslist&employeeId=';
  static String VENDOR_LIST = SERVERIP + 'flag=getVendorlist&prtnrId=';
  static String VIEWSERVICELIST_LIST =
      SERVERIP + 'flag=viewServicelist&partnerId=';
  static String VIEWITEMLIST_LIST = SERVERIP + 'flag=viewItem&partnerId=';
  static String VIEWBOOKINGLIST_LIST = SERVERIP + 'flag=viewbooking&partnerId=';
  static String VIEW_SALARYSTATEMENT= SERVERIP + 'flag=viewSalaryStatement&partnerId=';
  static String VIEW_PAYSLIP= SERVERIP + 'flag=viewPaySlip&empId=';
  static String GET_BENE_DETAILS = SERVERIP + 'get-regDetails?regNo=';
  static String POST_HEALTH_SCREEN = SERVERIP + 'post-addLabAppointment';
  static String POST_HEALTH_CHCKUP = SERVERIP + 'post-addchkupAppointment';


  static String STATUSCHANGELIST_LIST = SERVERIP + 'flag=statusChange&bstatus=';
  static String VIEWBOOKINGDTLIST_LIST =
      SERVERIP + 'flag=viewBookingDetails&partnerId=';
  static String ACCEPTORREJECT_ORDER =
      SERVERIP + 'flag=acceptOrrejectOrder&orderId=';
  static String DELETEEACH_SERVICE =
      SERVERIP + 'flag=deleteEachService&workorderId=';
  static String POST_ADDITIONAL_SERVICE =
      SERVERIP + 'flag=deleteEachService&workorderId=';
  static String ADDDISCOUNT_SERVICE =
      SERVERIP + 'flag=addDiscount&workorderNo=';
  static String BOOK_ADDITIONAL = SERVERIP + 'flag=additionalbooking';
  static String PARTNER_PROFILE =
      SERVERIP + 'flag=viewpartnerProfile&partnerId=';
  static String DISABLEEPLOYEE = SERVERIP + 'flag=disableemployee&partnerId=';

  //static String PARTNER_PROFILE = SERVERIP + 'flag=viewpartnerProfile&partnerId=';
  static String ATTENDANCEVIEW_DETAILS =
      SERVERIP + 'flag=attendanceviewdetails&partnerId=';
  static String APPROVELIST = SERVERIP + 'flag=approvelist&partnerId=';
  static String ADD_SERVICE = SERVERIP + 'flag=additionalbooking';
  static String VIEW_BILLING = SERVERIP + 'flag=viewBilling&partnerId=';
  static String GENERATE_BILL = SERVERIP + 'flag=addbillingfrmsrvc';
//  static String PAYMENT_METHOD = SERVERIP + 'flag=addPaymentmode';

  static String POST_ADDNEWCLINT = SERVERIP + 'flag=addnewclient';

 /* static String SALOON_TECH_SERVICES =
      SERVERIP1 + 'flag=saloonservicetechndetail&salid=';

  static String SERVICE_LIST1({String salID, String gender}) {
    return SERVERIP1 + "flag=saloonservices&saloonid=$salID&gender=$gender";
  }

  static String TECH_TIMING2(
      {String salID, String bookDate, String stylishid}) {
    return SERVERIP1 +
        "flag=stylishtimingdetails&saloonid=$salID&bookdate=$bookDate&stylishid=$stylishid";
  }*/

  static String PAYMENT_METHOD(
      {String invoiceNo, String paymentMode, String paymentRefNo, String partnerId}) {
    return SERVERIP +
        "flag=addPaymentmode&partnerId=$partnerId&invoiceNo=$invoiceNo&paymentMode=$paymentMode&paymentRefNo=$paymentRefNo";
  }

  static String VIEW_ATTENDANCE(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=attendanceviewondate&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }
  static String VIEW_SALARYPROCESS(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=viewSalaryProcess&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }
  static String VIEW_EPF(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=viewEPFReports&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }
  static String VIEW_ESIC(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=viewEPFReports&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }
  static String VIEW_TAX(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=viewIncomeTax&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }
  static String VIEW_GRN(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=viewGrn&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }
  static String VIEW_GRNREPORT(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=viewGrnReport&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }

  static String APPROVE_LIST(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=approvelist&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }

  static String CANCELLED_BOOKING(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=cancelBookinglist&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }

  static String COMPLETE_API(
      {String partnerId, String orderId, String discount}) {
    return SERVERIP +
        "flag=completeBooking&partnerId=$partnerId&orderId=$orderId&completestatus=6&discount=$discount";
  }

  static String ADD_ITEM_MASTER(
      {String partnerId, String itemname, String desc, String minqty}) {
    return SERVERIP +
        'flag=additemmaster&partnerId=$partnerId&itemname=$itemname&desc=$desc&minqty=$minqty';
  }

  static String UPDATE_ITEM_MASTER(
      {String id, String itemname, String desc, String minqty}) {
    return SERVERIP +
        'flag=updateitemmaster&id=$id&itemname=$itemname&desc=$desc&minqty=$minqty';
  }

  static String EMP_ABSENTORLEAVE =
      SERVERIP + 'flag=employeeAbsentorleave&partnerId=';
  //static String EMP_ADDATTENCE = SERVERIP + 'flag=addattendance&partnerId=';
  static String EMP_ADDATTENCE = SERVERIP + 'flag=addattendance&partnerId=';
  static String ADDSHIFTS = SERVERIP + 'flag=addshifts&partnerId=';
  static String VIEWSHIFTS = SERVERIP + 'flag=viewshifts&partnerId=';
  static String VIEWBILLING_LIST = SERVERIP + 'flag=viewBilling&partnerId=';
  static String VIEW_ITEM_MASTER = SERVERIP + 'flag=getitemmasterlist&partnerId=';
  static String VIEWBILLINGDETAIL_LIST = SERVERIP + 'flag=viewBillingDetails&partnerId=';
  static String PURCHASE_ORDER_DROP = SERVERIP + 'flag=getPurchaseOrdrlist&prtnrId=';
  static String CHANGE_STATUS_CHKUP = SERVERIP + "post-chkupAppointmentStatus";
  static String CHANGE_STATUS_SCREENING = SERVERIP + "post-appointmentStatus";
  static String HEALTH_CHKUP_LIST =
      SERVERIP + 'view-chkupAppointmentlist?appontdt=';


  static String HEALTH_SCREENING_LIST =
      SERVERIP + 'view-labAppointmentlist?appontdt=';

  //static String VIEWPURCHASED_LIST = SERVERIP + 'flag=viewPurchaseOrder&partnerId=';
  static String VIEWPURCHASED_LIST(
      {String partnerId, String fromdate, String todate}) {
    return SERVERIP +
        "flag=viewPurchaseOrder&fromdate=$fromdate&todate=$todate&partnerId=$partnerId";
  }

  //
  // static String VIEW_ITEM_MASTER =
  //     SERVERIP + 'flag=getitemmasterlist&partnerId=';
  // static String VIEWBILLINGDETAIL_LIST =
  //     SERVERIP + 'flag=viewBillingDetails&partnerId=';
}
//https://sidhudkl.000webhostapp.com/api/master1.php?flag=viewBilling&partnerId==26
