import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Ambulance/Dashboard/AcceptAmbulance.dart';
import 'package:user/screens/Ambulance/Dashboard/AllAmbulance.dart';
import 'package:user/screens/Ambulance/Dashboard/AmbulanceDashboard.dart';
import 'package:user/screens/Ambulance/Dashboard/MonthlyOverview/MonthlyOverviewAmbulanc.dart';
import 'package:user/screens/Ambulance/Dashboard/MonthlyOverview/MonthlyOverviewAmbulancelist.dart';
import 'package:user/screens/Ambulance/Dashboard/RejectAmbulance.dart';
import 'package:user/screens/Ambulance/Dashboard/RequestAmbulance.dart';
import 'package:user/screens/BloodBank/Dashboard/AcceptBloodBank.dart';
import 'package:user/screens/BloodBank/Dashboard/AllBloodBank.dart';
import 'package:user/screens/BloodBank/Dashboard/BloodBankDashboard.dart';
import 'package:user/screens/BloodBank/Dashboard/RejectBloodBank.dart';
import 'package:user/screens/BloodBank/Dashboard/RequestBloodBank.dart';
import 'package:user/screens/BloodBank/MonthlyOverview/MonthlyOverviewBlodBank.dart';
import 'package:user/screens/BloodBank/MonthlyOverview/MonthlyOverviewBoldbanklist.dart';
import 'package:user/screens/BloodBank/Registration/BloodBankSignUpForm2.dart';
import 'package:user/screens/BloodBank/Registration/BloodbankSignUpForm.dart';
import 'package:user/screens/ConfirmPassword.dart';
import 'package:user/screens/Doctor/Dashboard/ContactUs.dart';
import 'package:user/screens/Doctor/Dashboard/EmergencyAccess/QrEmergencyAccess.dart';
import 'package:user/screens/Doctor/Dashboard/MonthlyOverview/MonthlyOverViewList.dart';
import 'package:user/screens/Doctor/Dashboard/MonthlyOverview/MonthlyOverview.dart';
import 'package:user/screens/Doctor/Dashboard/MyOpdPage.dart';
import 'package:user/screens/Doctor/Dashboard/MyPatientlist.dart';
import 'package:user/screens/Doctor/Dashboard/NewDashboardDoctor.dart';
import 'package:user/screens/Doctor/Dashboard/ShareAppointment/ShareAppointment.dart';
import 'package:user/screens/Doctor/Dashboard/Showemr/AddImmunization.dart';
import 'package:user/screens/Doctor/Dashboard/WalkinPatient/QRViewExample1.dart';
import 'package:user/screens/FindPage1.dart';
import 'package:user/screens/Ngo/Registration/NgoSignUpForm.dart';
import 'package:user/screens/Ngo/Registration/NgoSignUpForm2.dart';
import 'package:user/screens/OrganisationSignUpForm.dart';
import 'package:user/screens/Pharmacists/MonthlyOverview/MonthlyOverviewPharma.dart';
import 'package:user/screens/Pharmacists/MonthlyOverview/MonthlyOverviewPharmalist.dart';
import 'package:user/screens/Pharmacists/Screens/NewDashboardPharmacy.dart';
import 'package:user/screens/Receptionlist/Dashboard/DashboardReceptionlist.dart';
import 'package:user/screens/Receptionlist/Dashboard/RefferedPatients/BookAppointment.dart';
import 'package:user/screens/Receptionlist/Dashboard/RefferedPatients/RefferedPatients.dart';
import 'package:user/screens/Receptionlist/registration/ReceptionlistSignUpForm.dart';
import 'package:user/screens/Receptionlist/registration/ReceptionlistSignUpForm1.dart';
import 'package:user/screens/Receptionlist/registration/ReceptionlistSignUpForm2.dart';
import 'package:user/screens/Receptionlist/registration/ReceptionlistSignUpFormm.dart';
import 'package:user/screens/Users/BookAmbulance/BookAmbulance.dart';
import 'package:user/screens/Users/BookAmbulance/BookAmbulancelist.dart';
import 'package:user/screens/Users/BookBloodBank/BookBloodBank.dart';
import 'package:user/screens/Users/BookBloodBank/BookBloodBanklist.dart';
import 'package:user/screens/Users/Dashboard/ChangePassword.dart';
import 'package:user/screens/Users/Dashboard/QrcodePage.dart';
import 'package:user/screens/Users/Dashboard/TermsandConditionPage.dart';
import 'package:user/screens/Users/GovermentSchemes/GovermentSchemesDitelsPage.dart';
import 'package:user/screens/Users/GovermentSchemes/GovernmentSchemesList.dart';
import 'package:user/screens/Pharmacists/screens/OrdersTabPharmacy.dart';
import 'package:user/screens/Users/Dashboard/AboutUs.dart';
import 'package:user/screens/Users/FindHealthCare/BookAppointment/BookAppointmentPage.dart';
import 'package:user/screens/Users/FindHealthCare/BookAppointment/BookAppointmentTab.dart';
import 'package:user/screens/Users/FindHealthCare/BookAppointment/DoctorconsultationPage.dart';
import 'package:user/screens/Users/FindHealthCare/FindHealthcareService.dart';
import 'package:user/screens/Users/FindHealthCare/MedicalService/AyushDoctors/MedicalServiceOngooglePage.dart';
import 'package:user/screens/Users/FindHealthCare/MedicalService/DonerOrganisation/DonorOrganisation.dart';
import 'package:user/screens/Users/FindHealthCare/MedicalService/LifeStyleSolution/LifeStyleSolution.dart';
import 'package:user/screens/Users/FindHealthCare/MedicalService/RIP/RIP.dart';
import 'package:user/screens/Users/FindHealthCare/MedicalService/TreatmentCenter/TreatmentCenters.dart';
import 'package:user/screens/Users/FindHealthCare/MyAppointment/AppointmentTab.dart';
import 'package:user/screens/Users/GovermentSchemes/GovetListPage1.dart';
import 'package:user/screens/Users/GovermentSchemes/GovetListPage2.dart';
import 'package:user/screens/Users/GovermentSchemes/GovetListPage3.dart';
import 'package:user/screens/Users/GovermentSchemes/GovetListPage4.dart';
import 'package:user/screens/Users/GovermentSchemes/GovetListPage5.dart';
import 'package:user/screens/Users/GovermentSchemes/GovetListPage6.dart';
import 'package:user/screens/Users/GovermentSchemes/GovetListPage7.dart';
import 'package:user/screens/Users/GovermentSchemes/GovetListPage8.dart';
import 'package:user/screens/Users/Insurance/AddInsuranceForm.dart';
import 'package:user/screens/Users/Medication/UserMedicineList.dart';
import 'package:user/screens/Users/Medication/UserTestList.dart';
import 'package:user/screens/Users/MedicineReminder/EditReminder.dart';
import 'package:user/screens/Users/Medipedia/DieseInfo.dart';
import 'package:user/screens/Users/Medipedia/Diesepdf.dart';
import 'package:user/screens/Users/Medipedia/HealthTipsList.dart';
import 'package:user/screens/Users/Medication/UserMedicineTab.dart';
import 'package:user/screens/Users/MyMedicalRecord/HealthChat1/Healthchatlist.dart';
import 'package:user/screens/Users/MyMedicalRecord/Medication/DigitalprescriptionPage.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/AddUploadDocument.dart';
import 'package:user/screens/Users/MyMedicalRecord/BiomediImplants.dart';
import 'package:user/screens/Pharmacists/Screens/Deliverdorder.dart';
import 'package:user/screens/Pharmacists/Screens/PaymentCollection.dart';
import 'package:user/screens/Pharmacists/Screens/PharmaMyProfile.dart';
import 'package:user/screens/Users/MyMedicalRecord/Allergiclist.dart';
import 'package:user/screens/Users/EmergencyHelp/CountDownPage.dart';
import 'package:user/screens/Users/Discount&Offer/DiscountOffersDetails.dart';
import 'package:user/screens/Users/Dashboard/EmergencyDetails.dart';
import 'package:user/screens/Users/GenericMedicine/GenericMedicine.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/DocumentImageView.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/DocumentList.dart';
import 'screens/Syndicate Partner/Dashboard/SyndicateDashboard.dart';
import 'screens/Syndicate Partner/Registration/Syndicatepartner.dart';
import 'screens/Users/MyMedicalRecord/HealthChat1/HealthChart.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/UploadDocument.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/VideoDetailsPage.dart';
import 'package:user/screens/Users/organ/OrganPreviewPage.dart';
import 'package:user/screens/Users/organ/Organlist.dart';
import 'package:user/screens/VideoCall/VideoCallPage.dart';
import 'package:user/screens/walkin_labrotry/LabDashboard.dart';
import 'package:user/screens/walkin_labrotry/Screen/LabQrCode.dart';
import 'package:user/widgets/PdfViewPage.dart';
import 'screens/Users/MyMedicalRecord/LifeStyleHistory.dart';
import 'package:user/screens/Users/MyMedicalRecord/Medication/UserMedicineTab1.dart';
import 'package:user/screens/Users/MyMedicalRecord/Medication/UserMedicineUrl.dart';
import 'package:user/screens/Users/SearchPage.dart';
import 'package:user/screens/Users/Medipedia/VideosPage.dart';
import 'package:user/screens/Users/organ/Organ1Page.dart';
import 'package:user/screens/Users/organ/Organ2Page.dart';
import 'package:user/screens/Users/organ/Organ3Page.dart';
import 'package:user/screens/Users/organ/Organ4Page.dart';
import 'package:user/screens/cowin/CovidMobilePage.dart';
import 'package:user/screens/cowin/CovidOtpPage.dart';
import 'package:user/screens/labortory/DashboardLabortory.dart';
import 'package:user/screens/walkin_labrotry/Screen/ConfirmOrdersLab.dart';
import 'package:user/screens/walkin_labrotry/Screen/LabProfile.dart';
import 'package:user/screens/walkin_labrotry/Screen/MyOrdersLab.dart';
import 'package:user/screens/walkin_labrotry/Screen/OrderDetails.dart';
import 'package:user/screens/walkin_labrotry/Screen/OrdersTabLab.dart';
import 'package:user/screens/walkin_labrotry/SearchPocReportPage.dart';
import 'notification/TokenMonitor.dart';
import 'notification/local_notification_service.dart';
import 'screens/Users/organ/AddWitness.dart';
import 'screens/Users/FindHealthCare/MedicalService/AirAmbulance/AirAmbulanceList.dart';
import 'package:user/screens/walkin_labrotry/Screen/AllAppointmentPage.dart';
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
import 'package:user/screens/Doctor/Dashboard/WalkinPatient/DocWalkPatient.dart';
import 'package:user/screens/Doctor/Dashboard/DoctorMedicationTab.dart';
import 'package:user/screens/Doctor/Dashboard/EmergencyAccess/EmergencyAccess.dart';
import 'package:user/screens/Doctor/Dashboard/MedicationAddScreen.dart';
import 'package:user/screens/Doctor/Dashboard/PrintReportWebVIEW.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';
import 'package:user/screens/walkin_labrotry/Screen/UpdationData.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm2.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm3.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm4.dart';
import 'package:user/screens/Doctor/registartion/DoctorSignUpForm5.dart';
import 'package:user/screens/Users/organ/DonorApplication.dart';
import 'screens/Users/EmergencyHelp/EmergencyHelp.dart';
import 'screens/Users/EmergencyRoom.dart';
import 'package:user/screens/ForgotPassword.dart';
import 'package:user/screens/Users/UserId/ForgotUserID.dart';
import 'package:user/screens/Users/GenericMedicine/GenericStores.dart';
import 'package:user/screens/Users/GenericMedicine/GenericStoresList.dart';
import 'package:user/screens/Users/GovermentSchemes/GovtSchemes.dart';
import 'package:user/screens/Users/GenericMedicine/GovtSchemesList.dart';
import 'package:user/screens/Users/HealthCheckUp/HealthCheckup.dart';
import 'screens/Users/FindHealthCare/MedicalService/AyushDoctors/AYUSH Doctors.dart';
import 'screens/Users/FindHealthCare/MedicalService/MedicalService.dart';
import 'screens/Users/MyMedicalRecord/Immunizationlist.dart';
import 'package:user/screens/Users/Insurance/InsuranceDet.dart';
import 'package:user/screens/Users/Insurance/Insurancelist.dart';
import 'package:user/screens/IntroScreen.dart';
import 'package:user/screens/LabOrders.dart';
import 'package:user/screens/LoginScreen.dart';
import 'package:user/screens/LoginwithOTP.dart';
import 'package:user/screens/Users/MyMedicalRecord/MedicalRecordPage.dart';
import 'screens/Users/MedicineReminder/MedicineReminder.dart';
import 'screens/Users/MedicineReminder/MedicineReminderOther.dart';
import 'package:user/screens/Pharmacists/Screens/MonthlyView.dart';
import 'package:user/screens/Users/FindHealthCare/MyAppointment/MyAppointment.dart';
import 'screens/Pharmacists/Screens/OnlineChats.dart';
import 'package:user/screens/Users/organ/OrganDonation.dart';
import 'package:user/screens/Pharmacists/Screens/DashboardPharmacy.dart';
import 'screens/Users/EmergencyHelp/SetupContactsPage.dart';
import 'screens/walkin_labrotry/Screen/TestAppointmentPage1.dart';
import 'package:user/screens/TestReportListUser.dart';
import 'screens/Users/MyMedicalRecord/TestReportListUser.dart';
import 'package:user/screens/Users/FindHealthCare/Find/HealthProviderTabview.dart';
import 'package:user/screens/Users/FindHealthCare/Find/GoogleSearchDetails.dart';
import 'package:user/screens/Users/Dashboard/IdcardPage.dart';
import 'package:user/screens/Users/FindHealthCare/MyAppointment/UserMyAppointments.dart';
import 'package:user/screens/Patient/PatientRegistration.dart';
import 'package:user/screens/Patient/PatientRegistration2.dart';
import 'package:user/screens/Patient/PatientRegistration3.dart';
import 'package:user/screens/Patient/PatientRegistration4.dart';
import 'package:user/screens/Pharmacists/registration/PharmaSignUpForm2.dart';
import 'package:user/screens/Pharmacists/registration/PharmaSignUpForm3.dart';
import 'package:user/screens/Pharmacists/registration/pharmaSignUpForm.dart';
import 'package:user/screens/walkin_labrotry/Screen/PocReportListPage.dart';
import 'screens/Pharmacists/Screens/ProcessedOrders.dart';
import 'package:user/screens/Users/Dashboard/ProfileScreen.dart';
import 'package:user/screens/ProfileScreen1.dart';
import 'package:user/screens/RequestHealthCheakup.dart';
import 'package:user/screens/SampleTracking.dart';
import 'package:user/screens/Search.dart';
import 'package:user/screens/Pharmacists/Screens/SetDiscount.dart';
import 'screens/Users/MedicineReminder/SetReminder.dart';
import 'package:user/screens/SetReminderOther.dart';
import 'package:user/screens/SignUpForm1.dart';
import 'package:user/screens/SignupScreen.dart';
import 'screens/Users/Dashboard/SupportScreen.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction2.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction3.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction4.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction5.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction6.dart';
import 'package:user/screens/TabInstructionPage/TabInstruction7.dart';
import 'screens/Users/organ/TermsandConditions.dart';
import 'screens/walkin_labrotry/Screen/TestAppointmentPage.dart';
import 'package:user/screens/UserAppointmentPage.dart';
import 'screens/Users/UserSignUpForm.dart';
import 'screens/Users/MyMedicalRecord/UserVitalSigns.dart';
import 'package:user/screens/WalkInUserProfile.dart';
import 'package:user/screens/walkin_labrotry/Screen/WalkinRegisterListPage.dart';
import 'package:user/screens/WorldwideHospitals.dart';
import 'screens/Users/FindHealthCare/Find/FindPage.dart';
import 'screens/Users/Medipedia/MedipediaPage.dart';
import 'package:user/screens/walkin_labrotry/registration/LabSignUpForm.dart';
import 'package:user/screens/walkin_labrotry/registration/LabSignUpForm2.dart';
import 'package:user/screens/walkin_labrotry/registration/LabSignUpForm3.dart';
import 'package:user/screens/walkin_labrotry/registration/LabSignUpForm4.dart';
import 'package:user/screens/splash.dart';
import 'screens/Users/Discount&Offer/DiscountOffer.dart';
import 'package:user/screens/Doctor/Dashboard/DoctorAppointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/application.dart';
import 'localization/initialize_i18n.dart';
import 'localization/localizations.dart';
import 'screens/Users/Dashboard/DashboardUserNew.dart';

String selectedLan;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
  //print('Handling a background message ${message.messageId}');
  //LocalNotificationService.initialize(context);
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
  String _token;
  SharedPref sharedPref=SharedPref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myLocalizationsDelegate = MyLocalizationsDelegate(widget.localizedValues);
    application.onLocaleChanged = onLocaleChange;
    // application.logoutCallBack = logouCallBack;
    ////tokem=FirebaseMessaging.instance.getToken(vapidKey: "");

    /* FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        Navigator.pushNamed(context, '/aboutus');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
        //popup("View one",context);

        Navigator.pushNamed(context, '/emergencydetails');
        //AppData.showInSnackBar(context, "Dataa");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/aboutus');
    });*/
  }

  popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        title: "Success",
        desc: msg,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
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
            navigatorKey: Const.navigatorKey,
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
              '/orderDetails': (context) => OrderDetails(
                    model: _model,
                  ),
              '/deliveredorder': (context) => SampleTracking(
                    model: _model,
                  ),
              /* '/pinview': (context) => PinView(
                    model: _model,
                  ),*/
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
              '/editReminder': (context) => EditReminder(
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
              '/govetschemeslist': (context) => GovernmentSchemesList(
                    model: _model,
                  ),
              '/discountofferdetails': (context) => DiscountOffersDetails(
                    model: _model,
                  ),
              '/medicalrecordpage': (context) => MedicalRecordPage(
                    model: _model,
                  ),
              '/immunizationlist': (context) => Immunization(
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
              '/patientDashboard': (context) => DashboardUserNew(
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
              '/medicinelisturl': (context) => UserMedicineUrl(
                    model: _model,
                  ),
              '/shareappointment': (context) => ShareAppointment(
                    model: _model,
                  ),

              //////////////////DOCTOR USER//////////////////////
              /*   '/dashDoctor': (context) => DasboardDoctor(
                    model: _model,
                  ),*/
              '/dashDoctor': (context) => NewDashboardDoctor(
                    model: _model,
                  ),
              '/myopdpage': (context) => MyOpdPage(
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
              '/emegencyAccess': (context) => EmergencyAccess(
                    model: _model,
                  ),
              '/qrEmergencyAccess': (context) => QrEmergencyAccess(
                    model: _model,
                  ),
              '/contactus': (context) => ContactScreen(
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
              '/vitalDoctor': (context) => UpdationData(
                    model: _model,
                  ),
              '/Newdashboard': (context) => NewDashboardDoctor(
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
              '/Appointtab': (context) => MyAppointmentTab(
                    model: _model,
                  ),
              '/doctorMedicationTab': (context) => DoctorMedicationTab(
                    model: _model,
                  ),
              '/medicalsServiceOngooglePage': (context) =>
                  MedicalsServiceOngooglePage(
                    model: _model,
                  ),
              '/googleSearch': (context) => GoogleSearchDetails(
                    model: _model,
                  ),
              '/idCard': (context) => IdCardPage(
                    model: _model,
                  ),
              '/dashboardpharmacy': (context) => NewDashboardPharmacy(
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
              '/appointmenttab': (context) => BookAppointmentTab(
                    model: _model,
                  ),
              '/ambulance': (context) => AmbulanceSignUpForm(
                    model: _model,
                  ),
              '/ambulancesignupform2': (context) => AmbulanceSignUpForm2(
                    model: _model,
                  ),
              '/ngo': (context) => NgoSignUpForm(
                    model: _model,
                  ),
              '/ngosignupform2': (context) => NgoSignUpForm2(
                    model: _model,
                  ),
              '/bloodbank': (context) => BloodBankSignUpForm(
                    model: _model,
                  ),
              '/bloodbanksignupform2': (context) => BloodBankSignUpForm2(
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
                    model: _model,
                  ),
              '/support': (context) => SupportScreen(
                    model: _model,
                  ),
              '/aboutus': (context) => AboutUs(
                    model: _model,
                  ),
              '/videos': (context) => VideosPage(
                    model: _model,
                  ),
              '/healthtipslist': (context) => HealthTipsList(
                    model: _model,
                  ),
              '/findPage1': (context) => FindPage1(
                    model: _model,
                  ),
              '/userTab1': (context) => UserMedicineTab1(
                    model: _model,
                  ),
              '/autoComplete': (context) => SearchPage(
                    model: _model,
                  ),
              '/genericMed': (context) => GenericMedicine(
                    model: _model,
                  ),
              '/organ1': (context) => Organ1Page(
                    model: _model,
                  ),
              '/organ2': (context) => Organ2Page(
                    model: _model,
                  ),
              '/organ3': (context) => Organ3Page(
                    model: _model,
                  ),
              '/organ4': (context) => Organ4Page(
                    model: _model,
                  ),
              '/govetschem1': (context) => GovetListPage1(
                    model: _model,
                  ),
              '/govetschem2': (context) => GovetListPage2(
                    model: _model,
                  ),
              '/govetschem3': (context) => GovetListPage3(
                    model: _model,
                  ),
              '/govetschem4': (context) => GovetListPage4(
                    model: _model,
                  ),
              '/govetschem5': (context) => GovetListPage5(
                    model: _model,
                  ),
              '/govetschem6': (context) => GovetListPage6(
                    model: _model,
                  ),
              '/govetschem7': (context) => GovetListPage7(
                    model: _model,
                  ),
              '/govetschem8': (context) => GovetListPage8(
                    model: _model,
                  ),
              '/qrViewExample1': (context) => QRViewExample1(
                    model: _model,
                  ),
             /* '/labDash': (context) => DashboardLabortory(
                    model: _model,
                  ),*/
              '/labDash': (context) => LabDashboard(
                    model: _model,
                  ),
              '/myOrderTest': (context) => MyOrdersLab(
                    model: _model,
                  ),
              '/confirmOrder': (context) => OrdersTabLab(
                    model: _model,
                  ),
              '/ordersPharma': (context) => OrdersTabPharmacy(
                    model: _model,
                  ),
              '/cnfpwd': (context) => ConfirmPassword(
                    model: _model,
                  ),
              '/qrcode': (context) => QrcodePage(
                    model: _model,
                  ),
              '/ambulancedash': (context) => AmbulanceDashboard(
                    model: _model,
                  ),
              '/allambulance': (context) => AllAmbulance(
                    model: _model,
                  ),
              '/requestambulance': (context) => RequestAmbulance(
                    model: _model,
                  ),
              '/acceptambulance': (context) => AcceptAmbulance(
                    model: _model,
                  ),
              '/rejectambulance': (context) => RejectAmbulance(
                    model: _model,
                  ),
              '/allbloodbank': (context) => AllBloodBank(
                    model: _model,
                  ),
              '/requestbloodbank': (context) => RequestBloodBank(
                    model: _model,
                  ),
              '/acceptbloodbank': (context) => AcceptBloodBank(
                    model: _model,
                  ),
              '/rejectbloodbank': (context) => RejectBloodBank(
                    model: _model,
                  ),
              '/bookAmbulancelist': (context) => BookAmbulancelist(
                    model: _model,
                  ),
              '/bookAmbulancePage': (context) => BookAmbulancePage(
                    model: _model,
                  ),
              '/bookBloodBanklist': (context) => BookBloodBanklist(
                    model: _model,
                  ),
              '/bookBloodBankPage': (context) => BookBloodBankPage(
                    model: _model,
                  ),
              '/bloodBankDashboard': (context) => BloodBankDashboard(
                    model: _model,
                  ),
              '/lifeStyleHistory': (context) => LifeStyleHistory(
                    model: _model,
                  ),
              '/myPatientlist': (context) => MyPatientlist(
                    model: _model,
                  ),
              '/uploaddocument': (context) => DocumentList(
                    model: _model,
                  ),
              '/upload': (context) => UploadDocument(
                    model: _model,
                  ),
              /*'/emrupload': (context) => EmrDocumentupload(
                    model: _model,
                  ),*/
              '/adduploaddocument': (context) => AddUploadDocument(
                    model: _model,
                  ),
              '/documentpdf': (context) => PdfViewPage(
                    model: _model,
                  ),
              '/govermentSchemesDitelsPage': (context) => GovermentSchemesDitelsPage(
                model: _model,
              ),

              '/documentimage': (context) => DocumentImage(
                    model: _model,
                  ),
              '/documentvideo': (context) => VideoDetailsPage(
                    model: _model,
                  ),
              '/labqrcode': (context) => LabQrcode(
                    model: _model,
                  ),
              '/dieseinfo': (context) => DieseInfo(
                    model: _model,
                  ),
              '/diesepdf': (context) => Diesepdf(
                    model: _model,
                  ),
              '/addimmunization': (context) => AddImmunization(
                    model: _model,
                  ),
              '/termsandConditionPage': (context) => TermsandConditionPage(
                    model: _model,
                  ),
              '/userMedicineList': (context) => UserMedicineList(
                    model: _model,
                  ),
              '/userTestList': (context) => UserTestList(
                    model: _model,
                  ),

              '/monthlyoverview': (context) => MonthlyOverview(
                    model: _model,
                  ),
              '/healthchart': (context) => HealthChart(
                    model: _model,
                  ),
              '/receptionlistsignup': (context) => MonthlyOverviewlist(
                    model: _model,
                  ),
              '/healthChaatlist': (context) => HealthChaatlist(
                model: _model,
              ),

////////////////////////////////////////////////////////////////////////////////
             // syndicate partner
              '/syndicatesignUpformm': (context) =>
                  SyndicateSignupform(
                    model: _model,
                  ),

              '/syndicateDashboard': (context) =>
                  SyndicateDashboard(
                    model: _model,
                  ),
              // RECEPTIONLIST
              '/receptionlistsignUpformm': (context) =>
                  ReceptionlistSignUpFormm(
                    model: _model,
                  ),
              '/dashboardreceptionlist': (context) => DashboardReceptionlist(
                    model: _model,
                  ),
              '/refferedpatientsbookAppoint': (context) => BookAppointment(
                    model: _model,
                  ),
              '/refferedpatients': (context) => RefferedPatients(
                    model: _model,
                  ),
              '/receptionlistsignup1': (context) => ReceptionlistSignupForm1(
                    model: _model,
                  ),
              '/receptionlistSignupform2': (context) =>
                  ReceptionlistSignupForm2(
                    model: _model,
                  ),
              '/monthlyOverviewAmbulanc': (context) => MonthlyOverviewAmbulanc(
                    model: _model,
                  ),
              '/monthlyOverviewAmbulancelist': (context) =>
                  MonthlyOverviewAmbulancelist(
                    model: _model,
                  ),
              '/monthlyOverviewBloodBank': (context) =>
                  MonthlyOverviewBloodBank(
                    model: _model,
                  ),
              '/monthlyOverviewBloodbanklist': (context) =>
                  MonthlyOverviewBloodbanklist(
                    model: _model,
                  ),
              '/monthlyOverviewPharma': (context) => MonthlyOverviewPharma(
                    model: _model,
                  ),
              '/monthlyOverviewPharmaklist': (context) =>
                  MonthlyOverviewPharmaklist(
                    model: _model,
                  ),
              '/organlist': (context) =>
                  Organlist(
                    model: _model,
                  ),
              '/changePassword': (context) =>
                  ChangePassword(
                    model: _model,
                  ),
              '/labMyProfile': (context) =>
                  DocMyProfile(
                    model: _model,
                  ),
              '/organisationSignUpForm': (context) =>
                  OrganisationSignUpForm(
                    model: _model,
                  ),
              '/organPriviewPage': (context) =>
                  OrganPriviewPage(
                    model: _model,
                  ),
              '/addinsuranceForm': (context) =>
                  AddinsuranceForm(
                    model: _model,
                  ),
              '/disitalPrescriptionPage': (context) =>
                  DisitalPrescriptionPage(
                    model: _model,
                  ),
              '/vdo': (context) =>
                  VideoCallPage(
               //     model: _model,
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
              const Locale("bn", ""),
              const Locale("mr", ""),
            ],
          );
        },
      ),
    );
  }
}
