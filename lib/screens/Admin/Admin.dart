import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/DocumentListModel.dart' as document;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/NewsupdateModel.dart'as news;
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Admin/Form.dart';

class AdminUser extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const AdminUser({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  LoginResponse1 loginResponse1;
  bio.BiomedicalModel biomedicalModel;
  document.DocumentListModel documentListModel;
 news. NewsupdateModel newsupdatemodel;
  ScrollController _scrollController = ScrollController();
  bool checkBoxValue = false;
  int currentMax = 1;
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = false;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');
  String profilePath = null, idproof = null;
  String doccategory,rolee;
  TextEditingController _date = TextEditingController();
  TextEditingController _reason = TextEditingController();
  TextEditingController _name = TextEditingController();
  SharedPref sharedPref = SharedPref();

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  List<bool> error = [false, false, false, false, false, false];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  AddBioMedicalModel addBioMedicalModel = AddBioMedicalModel();
  String eHealthCardno;
  static final List<String> languageCodesList = application.supportedLanguagesCodes;
  static final List<String> languagesList = application.supportedLanguages;
  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2],
    languagesList[3]: languageCodesList[3],
  };
  final Map<dynamic, dynamic> languageCodeMap = {
    languageCodesList[0]: languagesList[0],
    languageCodesList[1]: languagesList[1],
    languageCodesList[2]: languagesList[3],
    languageCodesList[3]: languagesList[3],
  };

  void _update(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Lan", locale.toString());
    application.onLocaleChanged(locale.toString());
  }

  int _selectedDestination = -1;
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    eHealthCardno = widget.model.patientseHealthCard;
    //loginResponse1=widget.eHealthCardno;

    doccategory = widget.model.documentcategories;
    rolee = widget.model.uploadbyrole;
    callAPI();
    /*callAPI(currentMax);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (documentListModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });*/
  }

  callAPI() {
    widget.model.GETMETHODCALL(
        api: ApiFactory.NEWSUPDATE_VIEW,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              // pocReportModel = PocReportModel.fromJson(map);
              newsupdatemodel = news.NewsupdateModel.fromJson(map);
            } else {
              setState(() {
                //isDataNoFound = true;
                // AppData.showInSnackBar(context, msg);
              });
            }
          });
        });
  }


  getFormatType(String ext) {
    switch (ext.toLowerCase()) {
      case 'jpg':
        return 'img';
      case 'png':
        return 'img';
      case 'jpeg':
        return 'img';
      case 'heif':
        return 'img';

      case 'pdf':
        return 'doc';
      case 'doc':
        return 'doc';
      case 'pdf':
        return 'doc';

      case 'mp4':
        return 'vdo';
      case 'mkv':
        return 'vdo';
      case '3gp':
        return 'vdo';
      case 'mov':
        return 'vdo';
      case 'avp':
        return 'vdo';
    }
  }

  IconData getIconFormat(String ext) {
    switch (ext.toLowerCase()) {
      case 'jpg':
        return Icons.image;
      case 'png':
        return Icons.image;
      case 'jpeg':
        return Icons.image;
      case 'heif':
        return Icons.image;

      case 'pdf':
        return Icons.document_scanner;
      case 'doc':
        return Icons.document_scanner;
      case 'pdf':
        return Icons.document_scanner;

      case 'mp4':
        return Icons.video_collection;
      case 'mkv':
        return Icons.video_collection;
      case '3gp':
        return Icons.video_collection;
      case 'mov':
        return Icons.video_collection;
      case 'avp':
        return Icons.video_collection;
      case 'avi':
        return Icons.video_collection;
      default:
        return Icons.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          title: Text("News & Media"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Mediaupdate(model: widget.model)))
                      .then((value) {
                    setState(() {
                      currentMax = 1;
                    });
                    //callAPI(currentMax);
                  });
                  // displayTextInputDialog(context);
                },
                child: Icon(
                  Icons.add_circle_outline_sharp,
                  size: 26.0,
                ),
              ),
            ),
          ]),
      body:

      isdata == true
          ? Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ) : newsupdatemodel == null || newsupdatemodel.body == null
          ? Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),
             Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
            ],
          ),
        ),
      ) :Container(
        child: SingleChildScrollView(
          child:
          (newsupdatemodel != null && newsupdatemodel.body!=null) ?
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              news.Body body = newsupdatemodel.body[i];
              print("video###############"+body.vdoURL);
              // String docTyp=getFormatType(body.extension);
              return Container(
                //width: size.width * 0.20,
               //width: 200,
                //height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      side: BorderSide(
                          width: 1,
                          color: AppData.kPrimaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Text("Title :",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight.bold)),
                              SizedBox(
                                width: 5,
                              ),
                               Text(body.title ?? "N/A",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight:
                                          FontWeight.normal)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("SubTitle   :",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight.bold)),
                              SizedBox(
                                width: 5,
                              ),
                               Text(body.subTitle ?? "N/A",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight:
                                          FontWeight.normal)),
                            ],
                          ),
                           SizedBox(height: 10,),
                           Container(
                            // height:100,
                             child: InkWell(
                               onTap: (){
                                 AppData.launchURL(
                                  body.vdoURL );

                               },
                                 child: body.fileName != null
                                     ? Image.network(
                                   (body.fileName),
                                   height: 200,
                                   width: 350,
                                   fit: BoxFit.cover,
                                 )
                                     : Image.network(
                                     AppData.defultImgUrll),

                             ),
                           ),
                        ]),
                    ),
                  ),
                ),
              );
            },
            itemCount: newsupdatemodel.body.length,
          )
              : Container(),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // height: 120,
                    color: AppData.kPrimaryColor,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 40.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            foregroundColor:
                            Colors
                                .white,
                            backgroundColor: Colors.white,
                            child:
                            Image.asset(
                              'assets/images/user.png',
                              height:
                              size.height *
                                  0.07,
                              width:
                              size.width *
                                  0.13,
                              //fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "Hi " + loginResponse1.body.userName ?? "N/A",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(right: 0,
                    child:  Container(
                      width: size.width,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      margin: EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            alignment: Alignment.center,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: AppData.selectedLanguage,
                                iconEnabledColor: Colors.white,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    AppData.setSelectedLan(newValue);
                                    _update(Locale(languagesMap[newValue]));
                                  });
                                  print(AppData.selectedLanguage);
                                },
                                dropdownColor: Colors.black,
                                items: languagesList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),),
                ],
              ),
              ListTile(
                  leading: Icon(Icons.dashboard,
                      color: AppData.menublueColor, size: 27),
                  title: Text(MyLocalizations.of(context).text("DASHBOARD"),),
                  selected: _selectedDestination == 0,
                  onTap: () {
                    selectDestination(0);
                    Navigator.pop(context);
                    //Navigator.pushNamed(context, "/dashboard");
                    // Navigator.pushNamed(context, "/dashboard1");
                  }
                // onTap: (){},

              ),
              ListTile(
                leading: Image.asset(
                  "assets/images/myprofile.png",
                  height: 30,
                  //color: Colors.redAccent,
                ),
                title: Text(MyLocalizations.of(context).text("MY_PROFILE"),),
                selected: _selectedDestination == 1,
                onTap: () {
                  selectDestination(1);
                  Navigator.pushNamed(context, "/docMyProf");
                },

                /*onTap: () {
                  selectDestination(1);
                  Navigator.pushNamed(context, "/labprofile");
                },*/
              ),
              /* ListTile(
                leading: Image.asset(
                  "assets/images/home.png",
                  height: 30,
                ),
                // leading: Icon(Icons.person),
                title: Text('Home'),
                selected: _selectedDestination == 2,
                onTap: () {
                  selectDestination(2);
                  //Navigator.pushNamed(context, "/profile");
                 // Navigator.pushNamed(context, "/dashboardpharmacy");
                },
              ),*/
              /* ListTile(
                leading: Image.asset(
                  "assets/images/account.png",
                  height: 30,
                ),
                // leading: Icon(Icons.person),
                title: Text('Manage Account'),
                selected: _selectedDestination == 3,
                onTap: () {
                  selectDestination(3);
                  // Navigator.pushNamed(context, "/patientDashboard");
                },
              ),*/
              /*  ListTile(
                leading: Image.asset(
                  "assets/images/aboutus.png",
                  height: 30,
                ),
                // leading: Icon(Icons.person),
                title: Text(MyLocalizations.of(context).text("ABOUT_US")),
                selected: _selectedDestination == 4,
                onTap: () {
                  selectDestination(4);
                  Navigator.pushNamed(context, "/aboutus");
                  //Navigator.pushNamed(context, "/biomedicalimplants");
                },
              ),
              ListTile(
                  leading: Image.asset(
                    "assets/images/share.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("SHARE")),
                  selected: _selectedDestination == 5,
                  onTap: () {
                    selectDestination(5);
                    //Navigator.pushNamed(context, "/dashboard1");
                    Navigator.pushNamed(context, "/emergencydetails");
                  }),
                           ListTile(
                  leading: Image.asset(
                    "assets/images/contact us.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("CONTACT_US")),
                  selected: _selectedDestination == 6,
                  onTap: () {
                    selectDestination(6);
                    widget.model.contactscreen = "Contact Screen";
                    Navigator.pushNamed(context, "/contactus");
                    //Navigator.pushNamed(context, "/discountoffer");
                  }),
              ListTile(
                  leading: Image.asset(
                    "assets/images/support.png",
                    height: 30,
                  ),
                  title: Text(MyLocalizations.of(context).text("SUPPORT")),
                  selected: _selectedDestination == 7,
                  onTap: () {
                    selectDestination(7);
                    widget.model.contactscreen = "Support Screen";
                    Navigator.pushNamed(context, "/contactus");
                  }),
*/
              ListTile(
                leading: Image.asset(
                  "assets/images/logout.png",
                  height: 30,
                ),
                title:Text(MyLocalizations.of(context).text("LOGOUT"),),
                selected: _selectedDestination == 10,
                onTap: () {
                  selectDestination(10);
                  //Navigator.pushNamed(context, "/dashboard");
                  // if (loginResponse.body.roles[0].toString().toLowerCase() == "4")
                  //   _exitApp();
                  /* else
                    initUniqueIdentifierState();*/
                  _exitApp();
                },
                /*  onTap: () {

                  selectDestination(10);
                  Navigator.pushNamed(context, "/login");
                },*/
              ),

            ],
          ),
        ),
      ),
    );
  }

  _exitApp() async {
    sharedPref.save(Const.IS_LOGIN, false.toString());
    sharedPref.save(Const.IS_REGISTRATION, false.toString());
    sharedPref.remove(Const.IS_REGISTRATION);
    sharedPref.remove(Const.IS_LOGIN);
    sharedPref.remove(Const.LOGIN_DATA);
    sharedPref.remove(Const.IS_REG_SERVER);
    sharedPref.remove(Const.MASTER_RESPONSE);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }}
