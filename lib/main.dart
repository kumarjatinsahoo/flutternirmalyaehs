import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Users/AboutUs.dart';
import 'package:user/screens/Users/BiomediImplants.dart';
import 'package:user/screens/Pharmacists/Screens/Deliverdorder.dart';
import 'package:user/screens/Pharmacists/Screens/PaymentCollection.dart';
import 'package:user/screens/Pharmacists/Screens/PharmaMyProfile.dart';
import 'package:user/screens/Users/Allergiclist.dart';
import 'package:user/screens/Users/BookAppointmentPage.dart';
import 'package:user/screens/Users/CountDownPage.dart';
import 'package:user/screens/Users/EmergencyDetails.dart';
import 'package:user/screens/Users/VideosPage.dart';
import 'package:user/screens/cowin/CovidMobilePage.dart';
import 'package:user/screens/cowin/CovidOtpPage.dart';
import 'package:user/screens/labrotry/Screen/LabProfile.dart';
import 'package:user/screens/labrotry/SearchPocReportPage.dart';
import 'screens/Users/AYUSH Doctors.dart';
import 'screens/Users/AddWitness.dart';
import 'screens/Users/AirAmbulanceList.dart';
import 'package:user/screens/AllAppointmentPage.dart';
import 'package:user/screens/Ambulance/Registration/ambulanceSignUpForm.dart';
import 'package:user/screens/Ambulance/Registration/ambulanceSignUpForm2.dart';
import 'package:user/screens/BookanAppointmentlist.dart';
import 'package:user/screens/Pharmacists/Screens/MyOrders.dart';
import 'screens/Pharmacists/Screens/ConfirmedOrders.dart';
import 'screens/Users/Daashboard.dart';
import 'package:user/screens/DocAponmnttListPage.dart';
import 'package:user/screens/Doctor/Dashboard/Appointment1.dart';
import 'package:user/screens/Doctor/Dashboard/DasboardDoctor.dart';
import 'package:user/screens/Doctor/Dashboard/DocAppointmentMangement.dart';
import 'package:user/screens/Doctor/Dashboard/DocMyProfile.dart';
import 'package:user/screens/Doctor/Dashboard/DocWalkPatient.dart';
import 'package:user/screens/Doctor/Dashboard/DoctorMedicationTab.dart';
import 'screens/Users/DoctorconsultationPage.dart';
import 'package:user/screens/Doctor/Dashboard/EmergencyAccess.dart';
import 'package:user/screens/Doctor/Dashboard/MedicationAddScreen.dart';
import 'package:user/screens/Doctor/Dashboard/PrintReportWebVIEW.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';
import 'package:user/screens/Doctor/VitalDoctor.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm2.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm3.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm4.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm5.dart';
import 'package:user/screens/DonorApplication.dart';
import 'package:user/screens/DonorOrganisation.dart';
import 'screens/Users/EmergencyHelp.dart';
import 'screens/Users/EmergencyRoom.dart';
import 'package:user/screens/FindHealthcareService.dart';
import 'package:user/screens/ForgotPassword.dart';
import 'package:user/screens/ForgotUserID.dart';
import 'package:user/screens/GenericStores.dart';
import 'package:user/screens/GenericStoresList.dart';
import 'package:user/screens/GovtSchemes.dart';
import 'package:user/screens/GovtSchemesList.dart';
import 'package:user/screens/HealthCheckup.dart';
import 'screens/Users/Immunizationlist.dart';
import 'package:user/screens/InsuranceDet.dart';
import 'package:user/screens/Insurancelist.dart';
import 'package:user/screens/IntroScreen.dart';
import 'package:user/screens/LabOrders.dart';
import 'package:user/screens/LifeStyleSolution.dart';
import 'package:user/screens/LoginScreen.dart';
import 'package:user/screens/LoginwithOTP.dart';
import 'package:user/screens/Users/MedicalRecordPage.dart';
import 'package:user/screens/MedicalService.dart';
import 'screens/Users/MedicalServiceOngooglePage.dart';
import 'screens/Users/MedicineReminder.dart';
import 'screens/Users/MedicineReminderOther.dart';
import 'package:user/screens/Pharmacists/Screens/MonthlyView.dart';
import 'package:user/screens/MyAppointment.dart';
import 'screens/Pharmacists/Screens/OnlineChats.dart';
import 'package:user/screens/Users/OrganDonation.dart';
import 'package:user/screens/Pharmacists/Screens/DashboardPharmacy.dart';
import 'package:user/screens/SetupContactsPage.dart';
import 'package:user/screens/TestAppointmentPage1.dart';
import 'package:user/screens/TestReportListUser.dart';
import 'package:user/screens/TestReportListUser1.dart';
import 'package:user/screens/Users/HealthProviderTabview.dart';
import 'package:user/screens/Users/GoogleSearchDetails.dart';
import 'package:user/screens/Users/IdcardPage.dart';
import 'package:user/screens/Users/UserAppointments.dart';
import 'package:user/screens/Users/UserMedicineTab.dart';
import 'package:user/screens/labrotry/LabDashboard.dart';
import 'package:user/screens/Patient/PatientRegistration.dart';
import 'package:user/screens/Patient/PatientRegistration2.dart';
import 'package:user/screens/Patient/PatientRegistration3.dart';
import 'package:user/screens/Patient/PatientRegistration4.dart';
import 'package:user/screens/Pharmacists/registration/PharmaSignUpForm2.dart';
import 'package:user/screens/Pharmacists/registration/PharmaSignUpForm3.dart';
import 'package:user/screens/Pharmacists/registration/pharmaSignUpForm.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/screens/PocReportListPage.dart';
import 'screens/Pharmacists/Screens/ProcessedOrders.dart';
import 'package:user/screens/Users/ProfileScreen.dart';
import 'package:user/screens/ProfileScreen1.dart';
import 'package:user/screens/RIP.dart';
import 'package:user/screens/RequestHealthCheakup.dart';
import 'package:user/screens/SampleTracking.dart';
import 'package:user/screens/Search.dart';
import 'package:user/screens/Pharmacists/Screens/SetDiscount.dart';
import 'package:user/screens/SetReminder.dart';
import 'package:user/screens/SetReminderOther.dart';
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
import 'package:user/screens/TreatmentCenters.dart';
import 'package:user/screens/UserAppointmentPage.dart';
import 'package:user/screens/UserSignUpForm.dart';
import 'screens/Users/UserVitalSigns.dart';
import 'package:user/screens/WalkInUserProfile.dart';
import 'package:user/screens/WalkinRegisterListPage.dart';
import 'package:user/screens/WorldwideHospitals.dart';
import 'screens/Users/FindPage.dart';
import 'screens/Users/MedipediaPage.dart';
import 'package:user/screens/labrotry/registration/LabSignUpForm.dart';
import 'package:user/screens/labrotry/registration/LabSignUpForm2.dart';
import 'package:user/screens/labrotry/registration/LabSignUpForm3.dart';
import 'package:user/screens/labrotry/registration/LabSignUpForm4.dart';
import 'package:user/screens/splash.dart';
import 'package:user/screens/DiscountOffer.dart';
import 'package:user/screens/Doctor/Dashboard/DoctorAppointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/application.dart';
import 'localization/initialize_i18n.dart';
import 'localization/localizations.dart';
import 'screens/Users/DashboardUserNew.dart';

String selectedLan;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

 AndroidNotificationChannel channel;
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ////////////////////Notification//////////////////
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  /////////////////////////////////////////////////


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
            debugShowCheckedModeBanner: false,
            locale: Locale(selectedLan),
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: ''),
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
              '/emergencydetails': (context) => EmergencyDetails(
                    model: _model,
                  ),
              '/profile': (context) => ProfileScreen(
                    model: _model,
                  ),
              '/pharmaprofile': (context) => PharmaMyProfile(
                    model: _model,
                  ),
              '/labprofile': (context) => LabProfile(
                    model: _model,
                  ),
              '/laborders': (context) => LabOrders(
                    model: _model,
                  ),
              '/processedorders': (context) => ProccesedOrders(
                    model: _model,
              ),
              '/paymentcollection': (context) => PaymentCollection(
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
              '/pharmacists': (context) => PharmaSignUpForm(
                    model: _model,
                  ),
              '/monthlyview': (context) => LabSignUpForm(
                    model: _model,
                  ),
              '/monthloveryview': (context) => MonthlyView(
                    model: _model,
              ),
              '/deliverdorder': (context) => DeliverdOrder(
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
              '/biomedicalimplants': (context) => BiomediImplants(
                    model: _model,
                  ),
              '/donorApplication': (context) => DonorApplication(
                    model: _model,
                  ),
              '/addWitness': (context) => AddWitness(
                    model: _model,
                  ),
              '/findScreen': (context) => FindPage(
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
              // '/testReport': (context) => TestReport1(
              //       model: _model,
              //     ),
              '/docApntlist': (context) => DocAponmnttListPage(
                    model: _model,
                  ),
              '/docApnt': (context) => AllAppointmentPage(
                    model: _model,
                  ),
              '/userApnt': (context) => UserAppointmentPage(
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
              '/patientDashboard': (context) => LabDashboard(
                    model: _model,
                  ),
              '/chemistspage': (context) => ChemistsTabview(
                    model: _model,
                  ),
              '/emergencyroom': (context) => EmergencyRoom(
                    model: _model,
                  ),
              '/testappointmentpage': (context) => TestAppointmentPage(
                    model: _model,
                  ),
              '/testappointmentpage1': (context) => TestAppointmentPage1(
                    model: _model,
                  ),
              '/pocreportlist': (context) => PocReportListPage(
                    model: _model,
                  ),
              '/walkInProfile': (context) => WalkInUserProfile(
                    model: _model,
                  ),
              '/walkRegList': (context) => WalkinRegisterListPage(
                    model: _model,
                  ),

              //////////////////DOCTOR USER//////////////////////
              '/dashDoctor': (context) => DasboardDoctor(
                    model: _model,
                  ),
              '/apntMange': (context) => DocAppointmentMangement(
                    model: _model,
                  ),
              '/apntMange1': (context) => Appointment1(
                    model: _model,
                  ),
              '/showEmr': (context) => ShowEmr(
                    model: _model,
                  ),
              '/docMyProf': (context) => DocMyProfile(
                    model: _model,
                  ),
              '/docWalkInReg': (context) => DocWalkPatient(
                    model: _model,
                  ),
              '/emegencyAc': (context) => EmergencyAccess(
                    model: _model,
                  ),
              '/printRep': (context) => PrintReportWebView(
                    model: _model,
                  ),
              '/doctorconsultationPage': (context) => DoctorconsultationPage(
                    model: _model,
                  ),
              '/doctorAppointment': (context) => DoctorAppointment(
                    model: _model,
                  ),
              '/medi': (context) => MedicationAddScreen(
                    model: _model,
                  ),
              '/vitalDoctor': (context) => VitalDoctor(
                    model: _model,
                  ),
              // '/Healthchart': (context) => HealthChart1(
              //       model: _model,
              //     ),
              '/testReportList': (context) => TestReportListUser(
                    model: _model,
                  ),
              '/setupcontacts': (context) => SetupContactsPage(
                    model: _model,
                  ),
              '/testReportListUser1': (context) => TestReportListUser1(
                model: _model,
              ),
              '/userAppoint': (context) => UserAppointments(
                model: _model,
              ),
              '/doctorMedicationTab': (context) => DoctorMedicationTab(
                model: _model,
              ),
              '/medicalsServiceOngooglePage': (context) => MedicalsServiceOngooglePage(
                model: _model,
              ),
              '/googleSearch': (context) => GoogleSearchDetails(
                model: _model,
              ),
              '/idCard': (context) => IdCardPage(
                model: _model,
              ),
              '/dashboardpharmacy': (context) => DashboardPharmacy(
                model: _model,
              ),
           /*'/dashboardpharmacy': (context) => DashboardPharmacy(
                model: _model,
              ),*/
              '/usermedicinelist': (context) => UserMedicineTab(
                model: _model,
              ),
              '/docConsult1': (context) => BookAppointmentPage(
                model: _model,
              ),
              '/ambulance': (context) => AmbulanceSignUpForm(
                model: _model,
              ),
              '/ngo': (context) => AmbulanceSignUpForm(
                model: _model,
              ),
              '/bloodbank': (context) => AmbulanceSignUpForm(
                model: _model,
              ),
              '/ambulancesignupform2': (context) => AmbulanceSignUpForm2(
                model: _model,
              ),
              '/covidMobile': (context) => CovidMobilePage(
                model: _model,
              ),
              '/covidOtp': (context) => CovidOtpPage(
                model: _model,
              ),
              '/searchPoc': (context) => SearchPocReportPage(
                model: _model,
              ),
              '/allergicListList': (context) => AllergicListList(
                model: _model,
              ),
              '/showemr': (context) => ShowEmr(
                model: _model,
              ),
              '/countDown': (context) => CountDownPage(
                //model: _model,
              ),
              '/support': (context) => SupportScreen(
                //model: _model,
              ),
              '/aboutus': (context) => AboutUs(
                //model: _model,
              ),
              '/videos': (context) => VideosPage(
                //model: _model,
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
