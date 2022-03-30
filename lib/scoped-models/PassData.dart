// import 'package:device_calendar/device_calendar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:user/models/AbhaTokenModel.dart';
import 'package:user/models/ForgetUseridModel.dart' as forgotuser;
import 'package:user/models/MasterLoginResponse.dart';
import 'package:user/models/PharmacyorderModel.dart' as cnfrm;
import 'package:user/models/TakeMedModel.dart';
import 'package:user/models/UserListModel.dart' as test;
import 'package:user/models/UserDetailsModel.dart';
import 'package:user/models/LabBookModel.dart' as lab;
import 'package:user/models/PatientListModel.dart' as patiet;
import 'package:user/models/DocterAppointmentlistModel.dart' as doc;
import 'package:user/models/AppointmentlistModel.dart' as pharma;
import 'package:user/models/MedicineListModel.dart' as medicine;

class PassData extends Model {
  String empid;
  String phnNo;
  String passWord;

  String apntUserType;
  String apntType;
  UserDetailsModel userModel;

  String slempid;
  String fromdate;
  String todate;
  patiet.Body model;
  String pdfUrl;
  String pdfUrlUser;
  lab.Body bodyUser;

  String token;
  String user;
  String patientName;
  String patientphnNo;
  String patientimg;
  String patientimgtype;
  String patientgender;
  String patientage;
  String patientheight;
  String patientweight;
  String patientemail;
  String patientaadhar;
  String patienStatekey;
  String patienStatecode;
  String patienCitykey;
  String patienCitycode;
  String districtid;
  String wtodate;
  String wfromdate;

  String patienCountrykey;
  String patienCountrycode;

  String organisationname;
  String title;
  String professionalname;

  String education;
  String speciality;
  String dateofbirth;
  String bloodgroup;
  String gender;

  String patientseHealthCard;

  //////////////
  String organization;
  String title1;
  String labprofessionalname;
  String labeducation;
  String labdob;
  String labbloodgroup;
  String labgender;
  String labaddress;
  String labcountry;
  String labstate;
  String labdistrict;
  String labcity;
  String labpin;
  String labhomephone;
  String labofficephone;
  String labmobile;
  String labemailid;
  String labalteremail;
  String longi;
  String lati;
  String city;
  String emgmobile;
  String placeIdno;
  String placeIdno1;
  String addr;
  String healthpro;
  String healthproname;
  String type;
  String typename;
  String medicallserviceType;
  String placeId;
  doc.Body appointmentlist;
  forgotuser.Body forgotuserid;

/////
  String pharmaorganisation;
  String pharmartitle;
  String pharmaprofessional;
  String pharmaaddress;
  String pharmaexperience;
  String pharmagender;
  pharma.Body userappointment;
  String userid;
  medicine.Body medicinelist;
  test.Body testList;
  String pharmacyaddress;
  String pharmacity;
  String pharamctorderid;
  String appno;
  String meddatest;
  String contMobileno;
  String doctorst;
  cnfrm.Body pharmacyorderModel;

////////////
  String ambulanceorganisation;
  String ambulancetitle;
  String ambulanceprofessional;
  String ambulanceaddress;
  String ambulanceexperience;
  String ambulancegender;

////////////
  String ngoorganisation;
  String ngotitle;
  String ngoprofessional;
  String ngoaddress;
  String ngoexperience;
  String ngogender;

  //////////////////
  String bloodbankorganisation;
  String bloodbanktitle;
  String bloodbankprofessional;
  String bloodbankaddress;
  String bloodbankexperience;
  String bloodbankgender;

  String txnId;

////////
  String profilebloodgroup;
  String profilespeciality;
  String profilegender;
  String profilerelation;

  String medicineStore;
  String regNoValue;
  String labregNoValue;

  String insuranceid;
  String pdfurl;
  String recentpdfurl;
  String diesepdf;

  String emergencyrelation;

  String documentcategories;
  String uploadbyrole;
  String emrdocumentcategories;
  String receptionhospitalid;
  String receptionpatientid;
  String hospitalNo;

  // Event selectEvent;

  String contactscreen;
  MasterLoginResponse masterResponse;

  ///usersignupform
String firstname;
String lastname;
String usertitle;
String usergender;
String userphoneno;
String usercountry;
String userstate;
String userdistrict;
String usercity;
String countrycode;
String statecode;
String userrphoneno;
String userproimage;
String userextesion;

String activitytoken;
String uhid;
String otpText;
int emergencyContact;

TakeMedModel medicineData;




//////ABHA MODEL?????
AbhaTokenModel abhaTokenModel;
String txnIDAdhar;

String abhaadhar;
String abhaphoneno;



}
