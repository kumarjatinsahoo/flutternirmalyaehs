import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/AYUSH%20Doctors.dart';
import 'package:user/screens/AddWitness.dart';
import 'package:user/screens/AirAmbulanceList.dart';
import 'package:user/screens/BookanAppointmentlist.dart';
import 'package:user/screens/ConfirmedOrders.dart';
import 'package:user/screens/Daashboard.dart';
import 'package:user/screens/DonorApplication.dart';
import 'package:user/screens/DonorOrganisation.dart';
import 'package:user/screens/EmergencyHelp.dart';
import 'package:user/screens/FindHealthcare%20Service.dart';
import 'package:user/screens/ForgotPassword.dart';
import 'package:user/screens/ForgotUserID.dart';
import 'package:user/screens/GenericStores.dart';
import 'package:user/screens/GenericStoresList.dart';
import 'package:user/screens/GovtSchemes.dart';
import 'package:user/screens/GovtSchemesList.dart';
import 'package:user/screens/LabOrders.dart';
import 'package:user/screens/LifeStyleSolution.dart';
import 'package:user/screens/LoginScreen.dart';
import 'package:user/screens/LoginwithOTP.dart';
import 'package:user/screens/MedicalService.dart';
import 'package:user/screens/MedicineReminder.dart';
import 'package:user/screens/MedicineReminderOther.dart';
import 'package:user/screens/MonthlyView.dart';
import 'package:user/screens/MyOrders.dart';
import 'package:user/screens/OnlineChats.dart';
import 'package:user/screens/OrganDonation.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/screens/ProcessedOrders.dart';
import 'package:user/screens/ProfileScreen.dart';
import 'package:user/screens/ProfileScreen1.dart';
import 'package:user/screens/RIP.dart';
import 'package:user/screens/SampleTracking.dart';
import 'package:user/screens/Search.dart';
import 'package:user/screens/SetDiscount.dart';
import 'package:user/screens/SetReminder.dart';
import 'package:user/screens/SetReminderOther.dart';
import 'package:user/screens/SignUpForm.dart';
import 'package:user/screens/SignUpForm1.dart';
import 'package:user/screens/SignupScreen.dart';
import 'package:user/screens/SupportScreen.dart';
import 'package:user/screens/TermsandConditions.dart';
import 'package:user/screens/TreatmentCenters.dart';
import 'package:user/screens/UserSignUpForm.dart';
import 'package:user/screens/find.dart';
import 'package:user/screens/splash.dart';
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
                    model: _model, updateTab: (int , bool ) {  },
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
              '/monthlyview': (context) => MonthlyView(
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
              '/findHealthcareService': (context) =>FindHealthcareService(
                model: _model,
              ),
              '/bookanAppointmentlist': (context) =>BookanAppointmentlist(
                model: _model,
              ),
              '/signUpForm1': (context) =>SignUpForm1(
                model: _model,
              ),
              '/userSignUpForm': (context) =>UserSignUpForm(
                model: _model,
              ),
              '/donorApplication': (context) =>DonorApplication(
                model: _model,
              ),
              '/addWitness': (context) =>AddWitness(
                model: _model,
              ),
              '/findScreen': (context) =>FindScreen(
                model: _model,
              ),
              '/searchScreen': (context) =>SearchScreen(
                model: _model,
              ),
              '/medicalService': (context) =>MedicalService(
                model: _model,
              ),
              '/aYUSHDoctors': (context) =>AYUSHDoctors(
                model: _model,
              ),
              '/donorOrganisation': (context) =>DonorOrganisation(
                model: _model,
              ),
              '/rPScreen': (context) =>RIPScreen(
                model: _model,
              ),
              '/lifeStyleSolution': (context) =>LifeStyleSolution(
                model: _model,
              ),
          '/treatmentCenters': (context) =>TreatmentCenters(
          model: _model,
          ),
              '/airAmbulanceList': (context) =>AirAmbulanceList(
          model: _model,
              ),
              '/emergencyHelp': (context) =>EmergencyHelp(
                model: _model,
              ),
              '/profileScreen1': (context) =>ProfileScreen1(
                model: _model,
              ),
              '/termsAndConditions': (context) =>TermsAndConditions(
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
