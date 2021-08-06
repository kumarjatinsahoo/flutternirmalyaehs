import 'package:scoped_model/scoped_model.dart';
import 'package:user/models/UserDetailsModel.dart';
import 'package:user/models/PatientListModel.dart' as patiet;

class PassData extends Model {
  String empid;
  String phnNo;

  String apntUserType;
  UserDetailsModel userModel;
  String slempid;
  String fromdate;
  String todate;
  patiet.Body model;
  String pdfUrl;

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

}
