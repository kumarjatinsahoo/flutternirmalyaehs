import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/AYUSH%20Doctors.dart';
import 'package:user/screens/AddWitness.dart';
import 'package:user/screens/AirAmbulanceList.dart';
import 'package:user/screens/AllAppointmentPage.dart';
import 'package:user/screens/BookanAppointmentlist.dart';
import 'package:user/screens/ChemistsPage.dart';
import 'package:user/screens/ConfirmedOrders.dart';
import 'package:user/screens/Daashboard.dart';
import 'package:user/screens/DocAponmnttListPage.dart';
import 'package:user/screens/Doctor/DoctorSignUpForm.dart';
import 'package:user/screens/Doctor/DoctorSignUpForm2.dart';
import 'package:user/screens/Doctor/DoctorSignUpForm3.dart';
import 'package:user/screens/Doctor/DoctorSignUpForm4.dart';
import 'package:user/screens/Doctor/DoctorSignUpForm5.dart';
import 'package:user/screens/DonorApplication.dart';
import 'package:user/screens/DonorOrganisation.dart';
import 'package:user/screens/EmergencyHelp.dart';
import 'package:user/screens/EmergencyRoom.dart';
import 'package:user/screens/FindHealthcare%20Service.dart';
import 'package:user/screens/ForgotPassword.dart';
import 'package:user/screens/ForgotUserID.dart';
import 'package:user/screens/GenericStores.dart';
import 'package:user/screens/GenericStoresList.dart';
import 'package:user/screens/GovtSchemes.dart';
import 'package:user/screens/GovtSchemesList.dart';
import 'package:user/screens/HealthCheckup.dart';
import 'package:user/screens/Immunizationlist.dart';
import 'package:user/screens/InsuranceDet.dart';
import 'package:user/screens/Insurancelist.dart';
import 'package:user/screens/IntroScreen.dart';
import 'package:user/screens/LabOrders.dart';
import 'package:user/screens/LifeStyleSolution.dart';
import 'package:user/screens/LoginScreen.dart';
import 'package:user/screens/LoginwithOTP.dart';
import 'package:user/screens/MedicalRecordPage.dart';
import 'package:user/screens/MedicalService.dart';
import 'package:user/screens/MedicineReminder.dart';
import 'package:user/screens/MedicineReminderOther.dart';
import 'package:user/screens/MonthlyView.dart';
import 'package:user/screens/MyAppointment.dart';
import 'package:user/screens/MyAppointment_Requested.dart';
import 'package:user/screens/MyOrders.dart';
import 'package:user/screens/OnlineChats.dart';
import 'package:user/screens/OrganDonation.dart';
import 'package:user/screens/PatientDaashboard.dart';
import 'package:user/screens/PatientRegistration.dart';
import 'package:user/screens/PatientRegistration2.dart';
import 'package:user/screens/PatientRegistration3.dart';
import 'package:user/screens/PatientRegistration4.dart';
import 'package:user/screens/Pharmacists/PharmaSignUpForm2.dart';
import 'package:user/screens/Pharmacists/PharmaSignUpForm3.dart';
import 'package:user/screens/Pharmacists/pharmaSignUpForm.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/screens/PocReportListPage.dart';
import 'package:user/screens/ProcessedOrders.dart';
import 'package:user/screens/ProfileScreen.dart';
import 'package:user/screens/ProfileScreen1.dart';
import 'package:user/screens/RIP.dart';
import 'package:user/screens/RequestHealthCheakup.dart';
import 'package:user/screens/SampleTracking.dart';
import 'package:user/screens/Search.dart';
import 'package:user/screens/SetDiscount.dart';
import 'package:user/screens/SetReminder.dart';
import 'package:user/screens/SetReminderOther.dart';
import 'package:user/screens/SignUpForm.dart';
import 'package:user/screens/SignUpForm1.dart';
import 'package:user/screens/SignupScreen.dart';
import 'package:user/screens/SupportScreen.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction2.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction3.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction4.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction5.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction6.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction7.dart';
import 'package:user/screens/TermsandConditions.dart';
import 'package:user/screens/TestAppointmentPage.dart';
import 'package:user/screens/TestReport.dart';
import 'package:user/screens/TreatmentCenters.dart';
import 'package:user/screens/UserSignUpForm.dart';
import 'package:user/screens/VitalSigns.dart';
import 'package:user/screens/WorldwideHospitals.dart';
import 'package:user/screens/find.dart';
import 'package:user/screens/MedipediaPage.dart';
import 'package:user/screens/labrotry/LabSignUpForm.dart';
import 'package:user/screens/labrotry/LabSignUpForm2.dart';
import 'package:user/screens/labrotry/LabSignUpForm3.dart';
import 'package:user/screens/labrotry/LabSignUpForm4.dart';
import 'package:user/screens/splash.dart';
import 'package:user/screens/DiscountOffer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization/application.dart';
import 'localization/initialize_i18n.dart';
import 'localization/localizations.dart';
import 'screens/DashBoardNew.dart';

String selectedLan;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> localizedValues = await initializeI18n();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  selectedLan = (preferences.getString('Lan') ?? "en");
  AppData.setSelectedLanCode(selectedLan);
  print("selectedLan : ${selectedLan}");
  runApp(MyApp(
    localizedValues: localizedValues,
  ));
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;

  const MyApp({Key key, this.localizedValues}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  MyLocalizationsDelegate myLocalizationsDelegate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myLocalizationsDelegate = MyLocalizationsDelegate(widget.localizedValues);
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(String locale) {
    print("main dart locale>>>" + locale);
    myLocalizationsDelegate = MyLocalizationsDelegate(widget.localizedValues);
    setState(() {
      selectedLan = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return MaterialApp(
            locale: Locale(selectedLan),
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Monte'),
            /*home: SplashScreen(
              model: _model,
            ),*/

            home: SplashScreen(
              model: _model,
            ),
            routes: {
              '/login': (context) => LoginScreen(
                    model: _model,
                  ),
              '/loginwithotp': (context) => LoginwithOTP(
                    model: _model,
                  ),
              '/signUp': (context) => SignupScreen(
                    model: _model,
                    updateTab: (int, bool) {},
                  ),
              '/forgotpassword': (context) => ForgotPassword(
                    model: _model,
                  ),
              '/forgotuserid': (context) => ForgotUserID(
                    model: _model,
                  ),
              '/dashboard': (context) => DashboardUserNew(
                    model: _model,
                  ),
              '/dashboardd': (context) => Dashboard(
                    model: _model,
                  ),
              '/profile': (context) => ProfileScreen(
                    model: _model,
                  ),
              '/laborders': (context) => LabOrders(
                    model: _model,
                  ),
              '/processedorders': (context) => ProccesedOrders(
                    model: _model,
                  ),
              '/sampletracking': (context) => SampleTracking(
                    model: _model,
                  ),
              '/setdiscount': (context) => SetDisount(
                    model: _model,
                  ),
              '/onlinechats': (context) => OnlineChats(
                    model: _model,
                  ),
              '/help': (context) => PharmaSignUpForm(
                    model: _model,
                  ),
              '/pharmasignupform2': (context) => PharmaSignUpForm2(
                    model: _model,
                  ),
              '/pharmasignupform3': (context) => PharmaSignUpForm3(
                    model: _model,
                  ),
              '/doctorsignupform': (context) => DoctorSignUpForm(
                    model: _model,
                  ),
              '/share': (context) => DoctorSignUpForm(
                    model: _model,
                  ),
              '/doctorsignupform2': (context) => DoctorSignUpForm2(
                    model: _model,
                  ),
              '/doctorsignupform3': (context) => DoctorSignUpForm3(
                    model: _model,
                  ),
              '/doctorsignupform4': (context) => DoctorSignUpForm4(
                    model: _model,
                  ),
              '/doctorsignupform5': (context) => DoctorSignUpForm5(
                    model: _model,
                  ),
              '/labsignupform': (context) => LabSignUpForm(
                    model: _model,
                  ),
              '/monthlyview': (context) => LabSignUpForm(
                    model: _model,
                  ),
              '/labsignup2': (context) => LabSignUpForm2(
                    model: _model,
                  ),
              '/labsignup3': (context) => LabSignUpForm3(
                    model: _model,
                  ),
              '/labsignup4': (context) => LabSignUpForm4(
                    model: _model,
                  ),
              '/myorder': (context) => MyOrders(
                    model: _model,
                  ),
              '/confirmorder': (context) => ConfirmOrders(
                    model: _model,
                  ),
              '/deliveredorder': (context) => SampleTracking(
                    model: _model,
                  ),
              '/pinview': (context) => PinView(
                    model: _model,
                  ),
              '/support': (context) => SupportScreen(
                    model: _model,
                  ),
              '/geneicstores': (context) => GenericStores(
                    model: _model,
                  ),
              '/geneicstoreslist': (context) => GenericStoresList(
                    model: _model,
                  ),
              '/govtschemes': (context) => GovtSchemes(
                    model: _model,
                  ),
              '/govtschemeslist': (context) => GovtSchemesList(
                    model: _model,
                  ),
              '/medicinereminder': (context) => MedicineReminder(
                    model: _model,
                  ),
              '/medicinereminderother': (context) => MedicineReminderOther(
                    model: _model,
                  ),
              '/organdonation': (context) => OrganDonation(
                    model: _model,
                  ),
              '/setreminder': (context) => SetReminder(
                    model: _model,
                  ),
              '/setreminderother': (context) => SetReminderOther(
                    model: _model,
                  ),
              '/findHealthcareService': (context) => FindHealthcareService(
                    model: _model,
                  ),
              '/bookanAppointmentlist': (context) => BookanAppointmentlist(
                    model: _model,
                  ),
              '/signUpForm1': (context) => SignUpForm1(
                    model: _model,
                  ),
              '/userSignUpForm': (context) => UserSignUpForm(
                    model: _model,
                  ),
              '/donorApplication': (context) => DonorApplication(
                    model: _model,
                  ),
              '/addWitness': (context) => AddWitness(
                    model: _model,
                  ),
              '/findScreen': (context) => FindScreen(
                    model: _model,
                  ),
              '/searchScreen': (context) => SearchScreen(
                    model: _model,
                  ),
              '/medicalService': (context) => MedicalService(
                    model: _model,
                  ),
              '/aYUSHDoctors': (context) => AYUSHDoctors(
                    model: _model,
                  ),
              '/donorOrganisation': (context) => DonorOrganisation(
                    model: _model,
                  ),
              '/rPScreen': (context) => RIPScreen(
                    model: _model,
                  ),
              '/lifeStyleSolution': (context) => LifeStyleSolution(
                    model: _model,
                  ),
              '/treatmentCenters': (context) => TreatmentCenters(
                    model: _model,
                  ),
              '/airAmbulanceList': (context) => AirAmbulanceList(
                    model: _model,
                  ),
              '/emergencyHelp': (context) => EmergencyHelp(
                    model: _model,
                  ),
              '/profileScreen1': (context) => ProfileScreen1(
                    model: _model,
                  ),
              '/termsAndConditions': (context) => TermsAndConditions(
                    model: _model,
                  ),
              '/myAppointment': (context) => MyAppointment(
                    model: _model,
                  ),
              '/intro': (context) => IntroScreen(),
              '/insuranceList': (context) => InsuranceList(
                    model: _model,
                  ),
              '/healthCheckup': (context) => HealthCheckup(
                    model: _model,
                  ),
              '/vitalSigns': (context) => VitalSigns(
                    model: _model,
                  ),
              '/discountoffer': (context) => DiscountOffer(
                    model: _model,
                  ),
              '/medipedia': (context) => MedipediaPage(
                    model: _model,
                  ),
              '/medicalrecordpage': (context) => MedicalRecordPage(
                    model: _model,
                  ),
              '/immunizationlist': (context) => Immunizationlist(
                    model: _model,
                  ),
              '/worldwidehospital': (context) => WorldwideHospitals(
                    model: _model,
                  ),
              '/requestHealthCheakup': (context) => RequestHealthCheakup(
                    model: _model,
                  ),
              '/insuranceDetalis': (context) => InsuranceDetalis(
                    model: _model,
                  ),
              '/testReport': (context) => TestReport(
                    model: _model,
                  ),
              '/docApntlist': (context) => DocAponmnttListPage(
                    model: _model,
                  ),
              '/docApnt': (context) => AllAppointmentPage(
                    model: _model,
                  ),
              '/tabinstruction': (context) => TabInstruction(
                    model: _model,
                  ),
              '/tabinstruction2': (context) => TabInstruction2(
                    model: _model,
                  ),
              '/tabinstruction3': (context) => TabInstruction3(
                    model: _model,
                  ),
              '/tabinstruction4': (context) => TabInstruction4(
                    model: _model,
                  ),
              '/tabinstruction5': (context) => TabInstruction5(
                    model: _model,
                  ),
              '/tabinstruction6': (context) => TabInstruction6(
                    model: _model,
                  ),
              '/tabinstruction7': (context) => TabInstruction7(
                    model: _model,
                  ),
              '/patientRegistration': (context) => PatientRegistration(
                    model: _model,
                  ),
              '/patientRegistration3': (context) => PatientRegistration3(
                    model: _model,
                  ),
              '/patientRegistration2': (context) => PatientRegistration2(
                    model: _model,
                  ),
              '/patientRegistration4': (context) => PatientRegistration4(
                    model: _model,
                  ),
              '/patientDashboard': (context) => PatientDashboard(
                    model: _model,
                  ),
              '/chemistspage': (context) => ChemistsPage(
                    model: _model,
                  ),
              '/emergencyroom': (context) => EmergencyRoom(
                    model: _model,
                  ),
              '/testappointmentpage': (context) => TestAppointmentPage(
                    model: _model,
                  ),
              '/pocreportlist': (context) => PocReportListPage(
                    model: _model,
                  ),
            },
            localizationsDelegates: [
              MyLocalizationsDelegate(widget.localizedValues),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale("en", ""),
              const Locale("hi", ""),
            ],
          );
        },
      ),
    );
  }
}

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MainModel _model = new MainModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(
        model: _model,
      ),
      routes: {
        "/login": (context) => LoginScreen(
              model: _model,
            ),
      },
    );
  }
}*/
