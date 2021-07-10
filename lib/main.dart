import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/ConfirmedOrders.dart';
import 'package:user/screens/Daashboard.dart';
import 'package:user/screens/ForgotPassword.dart';
import 'package:user/screens/ForgotUserID.dart';
import 'package:user/screens/LabOrders.dart';
import 'package:user/screens/LoginScreen.dart';
import 'package:user/screens/LoginwithOTP.dart';
import 'package:user/screens/MonthlyView.dart';
import 'package:user/screens/MyOrders.dart';
import 'package:user/screens/OnlineChats.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/screens/ProcessedOrders.dart';
import 'package:user/screens/ProfileScreen.dart';
import 'package:user/screens/SampleTracking.dart';
import 'package:user/screens/SetDiscount.dart';
import 'package:user/screens/SignUpForm.dart';
import 'package:user/screens/SignupScreen.dart';
import 'package:user/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization/application.dart';
import 'localization/initialize_i18n.dart';
import 'localization/localizations.dart';

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
              '/dashboard': (context) => Dashboard(
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
