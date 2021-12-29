import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/OrganizationRegistrationModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/TextFormatter.dart';
import 'package:user/widgets/text_field_container.dart';
import 'dart:async';
import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';
import '../../../providers/app_data.dart';


enum gender{
  Male,
  Female,
}
// ignore: must_be_immutable
class OrganisationSignUpForm extends StatefulWidget {

  final bool isConfirmPage;
  final bool isFromDash;
  String profilePath = null,
      idproof = null,
      labReport = null,
      helathCheckup = null;

  MainModel model;

  static KeyvalueModel districtModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel bloodgroupModel = null;
  static KeyvalueModel countryModel = null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel citymodel = null;
  static KeyvalueModel healthcareProviderModel = null;
  static KeyvalueModel doctorModel = null;


  OrganisationSignUpForm({
    Key key,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  OrganisationSignUpFormState createState() => OrganisationSignUpFormState();
}

class OrganisationSignUpFormState extends State<OrganisationSignUpForm> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  OrganizatioRegistrationModel organizationRegistrationModel = new OrganizatioRegistrationModel();
  DateTime selectedDate = DateTime.now();
  var dio = Dio();
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),

  ];

  List<bool> error = [false, false, false, false, false, false];
  bool _isSignUpLoading = false;

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();

  TextEditingController _email = TextEditingController();
  FocusNode emailFocus_ = FocusNode();
  String profilePath = null,
      idproof = null,
      idproof1 = null,
      idproof2 = null,
      idproof3 = null,
      labReport = null,
      helathCheckup = null;
  String extension;
  String extension1;
  String extension2;
  String extension3;
  File selectFile;
  File selectFile1;
  File selectFile2;
  File selectFile3;
  List<bool> dropdownError = [false, false, false];
  var color = Colors.black;
  var strokeWidth = 3.0;
  File _imageCertificate;
  bool selectGallery = false;
  var image;
  var pngBytes;
  String selectDob;
  KeyvalueModel selectedKey = null;
  final df = new DateFormat('dd/MM/yyyy');
  bool ispartnercode = false;
  bool _checkbox = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now().subtract(Duration(days: 6570)),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now()
            .subtract(Duration(days: 6570))); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        textEditingController[2].value =
            TextEditingValue(text: df.format(picked));
      });
  }

  bool fromLogin = false;

  StreamSubscription _connectionChangeStream;
  bool isOnline = false;
  List<KeyvalueModel> BloodGroup = [
    KeyvalueModel(name: "A+", key: "1"),
    KeyvalueModel(name: "B+", key: "2"),
    KeyvalueModel(name: "O+", key: "3"),
    KeyvalueModel(name: "AB+", key: "4"),
    KeyvalueModel(name: "A-", key: "5"),
    KeyvalueModel(name: "B-", key: "6"),
    KeyvalueModel(name: "O-", key: "7"),
    KeyvalueModel(name: "AB-", key: "8"),
  ];
  List<KeyvalueModel> Gender=[
    KeyvalueModel(name: "Male",key: "0"),
    KeyvalueModel(name: "Female",key: "1"),
    KeyvalueModel(name: "Transgender",key: "2"),
  ];

  @override
  void initState() {
    super.initState();
    OrganisationSignUpForm.districtModel = null;
    OrganisationSignUpForm.blockModel = null;
    OrganisationSignUpForm.genderModel = null;
    OrganisationSignUpForm.bloodgroupModel = null;
    /*setState(() {
      masterClass = widget.model.masterDataResponse;
    });
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    setState(() {
      isOnline = connectionStatus.hasConnection;
    });*/
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Add  Your Organization"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10.0,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                                child: Image.asset(
                                  "assets/logo1.png",
                                  fit: BoxFit.fitWidth,
                                  //width: ,
                                  height: 110.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _formKey,
                              autovalidate: _autovalidate,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(MyLocalizations.of(context).text("FILL_IN_PERSONAL_INFORMATION"),
                                          style: TextStyle(fontSize: 18, color: Colors.black),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  formField1(0, "Organization Name"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  formFieldPassPortno(1, "License No",),
                                 /* SizedBox(
                                    height: 8,
                                  ),
                                  formField1(2, "Address"),*/

                                  DropDown.networkDropdownGetpartUser(
                                      MyLocalizations.of(context)
                                          .text("COUNTRY"),
                                      ApiFactory.COUNTRY_API,
                                      "country",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.COUNTRY_API);
                                      OrganisationSignUpForm.countryModel = data;
                                      OrganisationSignUpForm.stateModel = null;
                                      OrganisationSignUpForm.districtModel = null;
                                      OrganisationSignUpForm.citymodel = null;
                                    });
                                  }),
                                  DropDown.countryList(
                                      MyLocalizations.of(context).text("STATE"),
                                      ApiFactory.STATE_API +
                                          (OrganisationSignUpForm?.countryModel?.key ?? ""),"stateph",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.STATE_API);
                                      OrganisationSignUpForm.stateModel = data;
                                      OrganisationSignUpForm.districtModel = null;
                                      OrganisationSignUpForm.citymodel = null;
                                    });
                                  }),

                                  DropDown.countryList(
                                      MyLocalizations.of(context).text("DIST"),
                                      ApiFactory.DISTRICT_API +
                                          (OrganisationSignUpForm?.stateModel?.key ??
                                              ""),
                                      "districtph",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.DISTRICT_API);
                                      OrganisationSignUpForm.districtModel = data;
                                      OrganisationSignUpForm.citymodel = null;
                                    });
                                  }),

                                  DropDown.countryList(
                                      MyLocalizations.of(context).text("CITY"),
                                      ApiFactory.CITY_API +
                                          (OrganisationSignUpForm
                                              ?.districtModel?.key ??""),
                                      "cityph",
                                      Icons.location_on_rounded,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.CITY_API);
                                      OrganisationSignUpForm.citymodel = data;
                                      // LabSignUpForm3.districtModel = null;
                                    });
                                  }),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  formField1(2, "Address"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  formFieldzip(
                                      3,
                                      MyLocalizations.of(context)
                                          .text("ENTER_ZIP_CODE")),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  formFieldzip(
                                      4,
                                      "Enter GST/VAT"),
                                  DropDown.networkDropdownGetpartUser(
                                      "Select Type",
                                      ApiFactory.HEALTHPROVIDER_API,
                                      "healthcareProvider",
                                      Icons.mail,
                                      23.0, (KeyvalueModel data) {
                                    setState(() {
                                      print(ApiFactory.HEALTHPROVIDER_API);
                                      OrganisationSignUpForm.healthcareProviderModel = data;

                                      // UserSignUpForm.cityModel = null;
                                    });
                                  }),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  formField1(5, "Document Name 1"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text("Upload Document 1",style: TextStyle(color:AppData.kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                          SizedBox(width:5),
                                          Material(
                                            elevation: 3,
                                            color:AppData.kPrimaryColor,
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                if (textEditingController[5].text == "" ||
                                                    textEditingController[5].text == null) {
                                                  AppData.showInSnackBar(context, "Please Enter Document Name 1");
                                                }else {
                                                  _settingModalBottomSheet(context);
                                                }
                                              },
                                              minWidth: 120,
                                              height: 30.0,
                                              child: Text(MyLocalizations.of(context).text("UPLOAD"),
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 17.0),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  (idproof != null)
                                      ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(

                                            child: Text(

                                              "Report Path :" + idproof,
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: SizedBox(
                                              width: 50.0,
                                              child: Icon(Icons.clear)),
                                          onTap: () {
                                            setState(() {
                                              idproof = null;
                                              // registrationModel.profilePhotoBase64 =
                                              null;
                                              //registrationModel.profilePhotoExt =
                                              null;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                      : Container(),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  (idproof != null)
                                      ?  formField1(6, "Document Name 2"):Container(),
                                  (idproof != null)
                                      ? SizedBox(
                                    height: 8,
                                  ):Container(),
                                  (idproof != null)
                                      ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text("Upload Document 2",style: TextStyle(color:AppData.kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                          SizedBox(width:5),
                                          Material(
                                            elevation: 3,
                                            color:AppData.kPrimaryColor,
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: MaterialButton(
                                              onPressed: ( ) {
                                                if (textEditingController[6].text == "" ||
                                                    textEditingController[6].text == null) {
                                                  AppData.showInSnackBar(context, "Please Enter Document Name 2");
                                                }else {
                                                  _settingModalBottomSheet1(
                                                      context);
                                                }
                                              },
                                              minWidth: 120,
                                              height: 30.0,
                                              child: Text(MyLocalizations.of(context).text("UPLOAD"),
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 17.0),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ):Container(),
                                  SizedBox(height: 10,),
                                  (idproof1 != null)
                                      ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(

                                            child: Text(

                                              "Report Path :" + idproof1,
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: SizedBox(
                                              width: 50.0,
                                              child: Icon(Icons.clear)),
                                          onTap: () {
                                            setState(() {
                                              idproof1 = null;
                                              // registrationModel.profilePhotoBase64 =
                                              null;
                                              //registrationModel.profilePhotoExt =
                                              null;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                      : Container(),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  (idproof1 != null)
                                      ? formField1(7,"Document Name 3"):Container(),
                                  (idproof1 != null)
                                      ? SizedBox(
                                    height: 8,
                                  ):Container(),
                                  (idproof1 != null)
                                      ?Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text("Upload Document 3",style: TextStyle(color:AppData.kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                          SizedBox(width:5),
                                          Material(
                                            elevation: 3,
                                            color:AppData.kPrimaryColor,
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                if (textEditingController[7].text == "" ||
                                                    textEditingController[7].text == null) {
                                                  AppData.showInSnackBar(context, "Please Enter Document Name 3");
                                                }else {
                                                  _settingModalBottomSheet2(
                                                      context);
                                                }
                                              },
                                              minWidth: 120,
                                              height: 30.0,
                                              child: Text(MyLocalizations.of(context).text("UPLOAD"),
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 17.0),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ):Container(),

                                  //SizedBox(height: 10,),
                                  (idproof2 != null)
                                      ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(

                                            child: Text(

                                              "Report Path :" + idproof2,
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: SizedBox(
                                              width: 50.0,
                                              child: Icon(Icons.clear)),
                                          onTap: () {
                                            setState(() {
                                              idproof2 = null;
                                              // registrationModel.profilePhotoBase64 =
                                              null;
                                              //registrationModel.profilePhotoExt =
                                              null;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                      : Container(),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  (idproof2 != null)
                      ?formField1(8, "Document Name 4"):Container(),
                                  (idproof2 != null)
                                      ? SizedBox(
                                    height: 8,
                                  ):Container(),
                                  (idproof2 != null)
                      ?Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text("Upload Document 4",style: TextStyle(color:AppData.kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                          SizedBox(width:5),
                                          Material(
                                            elevation: 3,
                                            color:AppData.kPrimaryColor,
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                if (textEditingController[8].text == "" ||
                                                    textEditingController[8].text == null) {
                                                  AppData.showInSnackBar(context, "Please Enter Document Name 4");
                                                }else {
                                                  _settingModalBottomSheet3(
                                                      context);
                                                }

                                              },
                                              minWidth: 120,
                                              height: 30.0,
                                              child: Text(MyLocalizations.of(context).text("UPLOAD"),
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 17.0),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ):Container(),
                                  SizedBox(height: 10,),
                                  (idproof3 != null)
                                      ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(

                                            child: Text(

                                              "Report Path :" + idproof3,
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: SizedBox(
                                              width: 50.0,
                                              child: Icon(Icons.clear)),
                                          onTap: () {
                                            setState(() {
                                              idproof3 = null;
                                              // registrationModel.profilePhotoBase64 =
                                              null;
                                              //registrationModel.profilePhotoExt =
                                              null;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                      : Container(),
                                  SizedBox(height: 20,),
                                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: nextButton1(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),

                      ],),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
  /*_
            ],
          ),
        ),
      ),
    );
  }*/
  // Widget gender() {
  //   return DropDown.searchDropdowntyp("Gender", "genderPartner", genderList,
  //           (KeyvalueModel model) {
  //         LabSignUpForm2.genderModel = model;
  //       });
  // }


  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                      Navigator.pop(context),
                      getCameraImage(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),


                    /* MultiImagePicker.pickImages(
                  maxImages: 300,
                  enableCamera: true,
                  //selectedAssets: images,
                  materialOptions: MaterialOptions(
                  actionBarTitle: "FlutterCorner.com",
                  ),
                  ),*/
                    getCerificateImage()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload(),
                    }),
              ],
            ),
          );
        });
  }
  Future getCameraImage() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile = image1;
      idproof = image1.path;
      //adduploaddocument.extension = extName;
      extension = extName;
      print("Message is: " +
          extension); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future getCerificateImage() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile = image1;
      idproof = image1.path;
      //adduploaddocument.extension = extName;
      extension = extName;
      print("Message is: " +
          extension); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future<void> getPdfAndUpload() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile = file;
        idproof = file.path;
//        adduploaddocument.extension = extName;
        extension = extName;
        print("Message is: " +
            extension); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
  void _settingModalBottomSheet1(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                      Navigator.pop(context),
                      getCameraImage1(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),


                    /* MultiImagePicker.pickImages(
                  maxImages: 300,
                  enableCamera: true,
                  //selectedAssets: images,
                  materialOptions: MaterialOptions(
                  actionBarTitle: "FlutterCorner.com",
                  ),
                  ),*/
                    getCerificateImage1()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload1(),
                    }),
              ],
            ),
          );
        });
  }
  Future getCameraImage1() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile1 = image1;
      idproof1 = image1.path;
      //adduploaddocument1.extension = extName;
      extension1 = extName;
      print("Message is: " +
          extension1); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future getCerificateImage1() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile1 = image1;
      idproof1 = image1.path;
      //adduploaddocument1.extension = extName;
      extension1 = extName;
      print("Message is: " +
          extension1); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future<void> getPdfAndUpload1() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile1 = file;
        idproof1 = file.path;
        //adduploaddocument1.extension = extName;
        extension1 = extName;
        print("Message is: " +
            extension1); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
  void _settingModalBottomSheet2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                      Navigator.pop(context),
                      getCameraImage2(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),


                    /* MultiImagePicker.pickImages(
                  maxImages: 300,
                  enableCamera: true,
                  //selectedAssets: images,
                  materialOptions: MaterialOptions(
                  actionBarTitle: "FlutterCorner.com",
                  ),
                  ),*/
                    getCerificateImage2()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload2(),
                    }),
              ],
            ),
          );
        });
  }
  Future getCameraImage2() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile2 = image1;
      idproof2 = image1.path;
      //adduploaddocument1.extension = extName;
      extension2 = extName;
      print("Message is: " +
          extension2); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future getCerificateImage2() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile2 = image1;
      idproof2 = image1.path;
      //adduploaddocument1.extension = extName;
      extension2 = extName;
      print("Message is: " +
          extension2); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future<void> getPdfAndUpload2() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile2 = file;
        idproof2 = file.path;
        //adduploaddocument1.extension = extName;
        extension2 = extName;
        print("Message is: " +
            extension2); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
  void _settingModalBottomSheet3(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () => {
                      Navigator.pop(context),
                      getCameraImage3(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),

                    getCerificateImage3()},
                ),
                new ListTile(
                    leading: new Icon(Icons.file_copy),
                    title: new Text('Document'),
                    onTap: () => {
                      Navigator.pop(context),
                      getPdfAndUpload3(),
                    }),
              ],
            ),
          );
        });
  }
  Future getCameraImage3() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile3 = image1;
      idproof3 = image1.path;
      //adduploaddocument1.extension = extName;
      extension3 = extName;
      print("Message is: " +
          extension3); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future getCerificateImage3() async {
    var image1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image1.readAsBytes();
    String _path = image1.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile3 = image1;
      idproof3 = image1.path;
      //adduploaddocument1.extension = extName;
      extension3 = extName;
      print("Message is: " +
          extension3); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }
  Future<void> getPdfAndUpload3() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path;

    String _fileName = _path != null ? _path
        .split('/')
        .last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile3 = file;
        idproof3 = file.path;
        //adduploaddocument1.extension = extName;
        extension3 = extName;
        print("Message is: " +
            extension3); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
  Widget formFieldzip(
      int index,
      String hint,
      ) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
      const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  enabled: widget.isConfirmPage ? false : true,
                  controller: textEditingController[index],
                  //focusNode: fnode7,
                  cursorColor: AppData.kPrimaryColor,
                  textInputAction: TextInputAction.next,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    counterText: "",
                    hintText: hint,
                    hintStyle:
                    TextStyle(color: AppData.hintColor, fontSize: 15),
                  ),

                  onFieldSubmitted: (value) {
                    // print(error[2]);
                    error[4] = false;
                    setState(() {});
                    AppData.fieldFocusChange(context, fnode7, fnode8);
                  },
                  onSaved: (value) {
                    //userPersonalForm.phoneNumber = value;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget formFieldGst(
      int index,
      String hint,
      ) {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
      const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppData.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  enabled: widget.isConfirmPage ? false : true,
                  controller: textEditingController[index],
                  //focusNode: fnode7,
                  cursorColor: AppData.kPrimaryColor,
                  textInputAction: TextInputAction.next,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9. ]")),
                  ],
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.phone),
                    border: InputBorder.none,
                    counterText: "",
                    hintText: hint,
                    hintStyle:
                    TextStyle(color: AppData.hintColor, fontSize: 15),
                  ),

                  onFieldSubmitted: (value) {
                    // print(error[2]);
                    error[4] = false;
                    setState(() {});
                    AppData.fieldFocusChange(context, fnode7, fnode8);
                  },
                  onSaved: (value) {
                    //userPersonalForm.phoneNumber = value;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mobileNoOTPSearch() {
    return Row(
      children: <Widget>[
        Expanded(
          //flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 0.0),
            child: Container(
              // padding: EdgeInsets.only(left: 2),
              height: 50.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 0.3)),
              // decoration: BoxDecoration(
              //     color: AppData.kPrimaryLightColor,
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(color: Colors.black, width: 0.3)),
              child: mobileNumber(),
            ),
          ),
        ),
      ],
    );
  }

  /*Future getCerificateImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);

    setState(() {
      _imageCertificate = image;
      selectGallery = true;
      print('Image Path $_imageCertificate');
    });
  }*/

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    var enc = await image.readAsBytes();

    print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
    if (50000 < enc.length) {
      /*AppData.showToastMessage(
          "Please select image with maximum size 50 KB ", Colors.red);*/
      return;
    }

    setState(() {
      _image = image;

      print('Image Path $_image');
    });
  }

  Widget errorMsg(text) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget inputFieldContainer(child) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // decoration: BoxDecoration(
        //     // color: AppData.kPrimaryLightColor,
        //     borderRadius: BorderRadius.circular(29),
        //     border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }

  Widget fromField(int index, String hint, bool enb, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type) {
    // print(index);
    // print(currentfn);
    return TextFieldContainer(
      //color: error[index] ? Colors.red : AppData.kPrimaryLightColor,
      child: TextFormField(
        enabled: !enb,
        controller: textEditingController[index],
        focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          // ignore: deprecated_member_use
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value.isEmpty) {
            error[index] = true;
            return null;
          } else {
            error[index] = false;
            return null;
          }
        },
        onFieldSubmitted: (value) {
          print("ValueValue" + error[index].toString());

          setState(() {
            error[index] = false;
          });
          AppData.fieldFocusChange(context, currentfn, nextFn);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

  Widget nextButton1() {
    return MyWidgets.nextButton(
      text:  "SUBMIT",
      context: context,
      fun: () {
        if (textEditingController[0].text == "" ||
            textEditingController[0].text == null) {
          AppData.showInSnackBar(context, "Please Enter Organisation Name");
        }else if (textEditingController[1].text == "" ||
            textEditingController[1].text == null) {
          AppData.showInSnackBar(context, "Please Enter Licenece No");
        }else if (OrganisationSignUpForm.countryModel == null ||
            OrganisationSignUpForm.countryModel == "") {
          AppData.showInSnackBar(context, "Please Select Country");
        }else if (OrganisationSignUpForm.stateModel == null ||
            OrganisationSignUpForm.stateModel == "") {
          AppData.showInSnackBar(context, "Please Select State");
        }else if (OrganisationSignUpForm.districtModel == null ||
            OrganisationSignUpForm.districtModel == "") {
          AppData.showInSnackBar(context, "Please Select District");
        }else if (OrganisationSignUpForm.citymodel == null ||
            OrganisationSignUpForm.citymodel == "") {
          AppData.showInSnackBar(context, "Please Select City");
        }else if (textEditingController[2].text == "" ||
            textEditingController[2].text == null) {
          AppData.showInSnackBar(context, "Please Enter Address");

        }
        else if (textEditingController[3].text == "" ||
            textEditingController[3].text == null) {
          AppData.showInSnackBar(context, "Please Enter Zip/Pin Code");
        }
        else if (textEditingController[4].text == "" ||
            textEditingController[4].text == null) {
          AppData.showInSnackBar(context, "Please Enter GST/VAT");
        }
        else if (OrganisationSignUpForm.healthcareProviderModel == null ||
            OrganisationSignUpForm.healthcareProviderModel == "") {
          AppData.showInSnackBar(context, "Please Select Type");
        }
        else if (textEditingController[5].text == "" ||
            textEditingController[5].text == null) {
          AppData.showInSnackBar(context, "Please Enter Document name");
        }else if (textEditingController[5].text != "" &&
            idproof == null) {
          AppData.showInSnackBar(context, "Please Upload Document 1");
        }else if (textEditingController[6].text != "" &&
            idproof1 == null) {
          AppData.showInSnackBar(context, "Please Upload Document 2");
        }else if (textEditingController[7].text != "" &&
            idproof2 == null) {
          AppData.showInSnackBar(context, "Please Upload Document 3");

        }else if (textEditingController[8].text != "" &&
            idproof3 == null) {
          AppData.showInSnackBar(context, "Please Upload Document 4");

        } else {
          postMultiPart();

        }
      },
    );
  }
  Future<FormData> FormData2() async {
    log("File extension is:::::>>>>>" + textEditingController[0].text + "," + textEditingController[1].text + "," + textEditingController[2].text + "," +  OrganisationSignUpForm.countryModel.key);
    var formData = FormData();
    formData.fields..add(MapEntry('orgname', textEditingController[0].text))..add(
        MapEntry(
          'licno',
          textEditingController[1].text,
        ))..add(MapEntry(
      'address',
      textEditingController[2].text,
    ))..add(MapEntry(
      'country',
      OrganisationSignUpForm.countryModel.key,
    ))..add(MapEntry(
      'state',
      OrganisationSignUpForm.stateModel.key,
    ))..add(MapEntry(
      'dist',
        OrganisationSignUpForm.districtModel.key,
    ))..add(MapEntry(
      'city',
      OrganisationSignUpForm.citymodel.key,
    ))..add(MapEntry(
      'pincode',
      textEditingController[3].text,
    ))..add(MapEntry(
      'gst',
      textEditingController[4].text,
    ))..add(MapEntry(
      'healthprovider',
        OrganisationSignUpForm.healthcareProviderModel.key,
    ))..add(MapEntry(
      'docnameone',
      textEditingController[5].text,
    ))..add(MapEntry(
      'docnametwo',
      textEditingController[6].text,
    ))..add(MapEntry(
      'docnamethree',
      textEditingController[7].text,
    ))..add(MapEntry(
      'docnamefour',
      textEditingController[8].text,
    )) ..add(MapEntry(
      'extone',
      extension,
    ))..add(MapEntry(
      'exttwo',
      extension1,
    ))
    ..add(MapEntry(
    'extthree',
      extension2,
    ))
    ..add(MapEntry(
    'extfour',
      extension3,
    ));

    if(selectFile!=null) {
      formData.files.add(MapEntry(
        'fileone',
        MultipartFile.fromFileSync(
          selectFile.path,
          filename: selectFile.path,
          //contentType: new MediaType('','')
        ),
      ));
    }
    if(selectFile1!=null) {
    formData.files.add(MapEntry(
      'filetwo',
      MultipartFile.fromFileSync(
        selectFile1.path,
        filename: selectFile1.path,
        //contentType: new MediaType('','')
      ),
    )); }
    if(selectFile2!=null) {
    formData.files.add(MapEntry(
      'filethree',
      MultipartFile.fromFileSync(
        selectFile2.path,
        filename: selectFile2.path,
        //contentType: new MediaType('','')
      ),
    ));}
    if(selectFile3!=null) {
    formData.files.add(MapEntry(
      'filefour',
      MultipartFile.fromFileSync(
        selectFile3.path,
        filename: selectFile3.path,
        //contentType: new MediaType('','')
      ),
    ));}

    return formData;

  }
  void postMultiPart() async {
    MyWidgets.showLoading(context);
    try {
      Response response;
      response = await dio.post(
        ApiFactory.ADD_ORGANIZATION,
        data: await FormData2(),
        onSendProgress: (received, total) {
          if (total != -1) {
            setState(() {
              print((received / total * 100).toStringAsFixed(0) + '%');
            });
          }
        },
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
        log("value" + jsonEncode(response.data));
        if (response.data["code"] == "success") {
          //Navigator.pushNamed(context, "/uploaddocument");

          popup(context);
        } else {
          AppData.showInSnackBar(context, "Something went wrong");
        }
      } else {
        Navigator.pop(context);
        AppData.showInSnackBar(context, "Something went wrong");
      }
    } on DioError catch (e) {
     /* if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        log(e.response.data);
      }*/
      /*if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        log(e.response.data);
      }*/
     /* if (e.type == DioErrorType.DEFAULT) {
        log(e.response.data);
      }*/
      /*if (e.type == DioErrorType.RESPONSE) {
        log(e.response.data);
      }*/
    }
    //print(response);
  }
  popup(BuildContext context) {
    return Alert(
        context: context,
        title: "Successfully Upload",
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
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }


  // Widget nextButton1() {
  //   return GestureDetector(
  //     onTap: () {
  //
  //       Navigator.pushNamed(context, "/pharmasignupform3");
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       margin: EdgeInsets.only(left:180, right: 0),
  //       decoration: BoxDecoration(
  //           color: AppData.kPrimaryColor,
  //           borderRadius: BorderRadius.circular(10.0),
  //           gradient: LinearGradient(
  //               begin: Alignment.bottomRight,
  //               end: Alignment.topLeft,
  //               colors: [Colors.blue, AppData.kPrimaryColor])),
  //       child: Padding(
  //         padding:
  //         EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
  //         child: Text(
  //           MyLocalizations.of(context).text("NEXT"),
  //           textAlign: TextAlign.center,
  //           style: TextStyle(color: Colors.white, fontSize: 16.0),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.blue, AppData.kPrimaryColor])),
        child: Padding(
          padding:
          EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            MyLocalizations.of(context).text("SIGN_BTN"),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget mobileNumber() {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
      const EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 0.0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: AppData.kPrimaryLightColor,
        //   borderRadius: BorderRadius.circular(29),
        //   /*border: Border.all(
        //        color: Colors.black,width: 0.3)*/
        // ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButton<String>(
                // hint: Text("Select Device"),
                underline: Container(
                  color: Colors.grey,
                ),
                value: AppData.currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    AppData.currentSelectedValue = newValue;
                  });
                  print(AppData.currentSelectedValue);
                },
                items: AppData.phoneFormat.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 35.0,
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            new Expanded(
              child: TextFormField(
                enabled: widget.isConfirmPage ? false : true,
                controller: textEditingController[4],
                focusNode: fnode7,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText:
                  MyLocalizations.of(context).text("PHONE_NUMBER") + "*",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    error[4] = true;
                    return null;
                  }
                  error[4] = false;
                  return null;
                },
                onFieldSubmitted: (value) {
                  // print(error[2]);
                  error[4] = false;
                  setState(() {});
                  AppData.fieldFocusChange(context, fnode7, fnode8);
                },
                onSaved: (value) {
                  //userPersonalForm.phoneNumber = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dob() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => widget.isConfirmPage ? null : _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            //height: 45,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            alignment: Alignment.center,
            // width: size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 0.3,
                color: Colors.grey[800],
                // border: Border.all(color: Colors.black, width: 0.3)
              ),
            ),
            child: TextFormField(
              focusNode: fnode3,
              enabled: !widget.isConfirmPage ? false : true,
              controller: textEditingController[2],
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              onSaved: (value) {
                //userPersonalForm.dob = value;
                selectDob = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  error[2] = true;
                  return null;
                }
                error[2] = false;
                return null;
              },
              onFieldSubmitted: (value) {
                error[2] = false;
                // print("error>>>" + error[2].toString());

                setState(() {});
                AppData.fieldFocusChange(context, fnode3, fnode4);
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: MyLocalizations.of(context).text("DOB1"),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                prefixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget continueButton() {
    return InkWell(
      child: Center(
        child: CircleAvatar(
          radius: 20.0,
          //backgroundColor: Colors.amber.shade600,
          backgroundColor: AppData.kPrimaryColor,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
      onTap: () {
        setState(() {});
        validate();
      },
    );
  }

  validate() async {
    _formKey.currentState.validate();

    if (error[0] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_FIRST_NAME"));
      FocusScope.of(context).requestFocus(fnode1);
    } else if (error[1] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_lAST_NAME"));
      FocusScope.of(context).requestFocus(fnode2);
    } else if (OrganisationSignUpForm.genderModel == null || OrganisationSignUpForm.genderModel == "") {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_SELECT_GENDER"));
      FocusScope.of(context).requestFocus(fnode4);
    } else if (textEditingController[5].text == '') {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_AADHAAR_NUMBER"));
      FocusScope.of(context).requestFocus(fnode4);
    } else if (error[3] == true) {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_FATHER_NAME"));
      FocusScope.of(context).requestFocus(fnode6);
    } else if (error[2] == true) {
      AppData.showInSnackBar(
          context, MyLocalizations.of(context).text("PLEASE_ENTER_DOB"));
      FocusScope.of(context).requestFocus(fnode3);
    } else if (error[4] == true) {
      AppData.showInSnackBar(context,
          MyLocalizations.of(context).text("PLEASE_ENTER_PHONE_NUMBER"));
      FocusScope.of(context).requestFocus(fnode7);
    } else if (OrganisationSignUpForm.districtModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT DISTRICT");
    } else if (OrganisationSignUpForm.blockModel == null) {
      AppData.showInSnackBar(context, "PLEASE SELECT BLOCK/ULB");
    } else {
      _formKey.currentState.save();

      if (isOnline) {
        setState(() {
          _isSignUpLoading = true;
        });
        await Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _isSignUpLoading = false;
          });
        });
      } else {
        AppData.showInSnackBar(context, "INTERNET_CONNECTION");
      }
    }
  }

  Widget mobileNumber1(int index, String hint, mobileModel) {
    return Container(
      margin:
      const EdgeInsets.only(top: 11.0, left: 8.0, right: 8.0, bottom: 0.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border:
          Border.all(color: AppData.matruColor, width: 3)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: AppData.currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    AppData.currentSelectedValue = newValue;
                  });
                  print(AppData.currentSelectedValue);
                },
                items: AppData.phoneFormat.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 35.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          new Expanded(
            child: TextFormField(
              // enabled: widget.isConfirmPage ? false : true,
              controller: textEditingController[index],
              cursorColor: AppData.matruColor,
              textInputAction: TextInputAction.done,
              maxLength: 10,
              style: TextStyle(fontSize: 13),
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  Icons.phone,
                  size: 19,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget formField1(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: textEditingController[index],
            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },
            inputFormatters: [
              WhitelistingTextInputFormatter(
                  RegExp("[a-zA-Z ]")),
            ],
          ),
        ),
      ),
    );
  }
  Widget formFieldPassPortno(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8),
      child: Container(
        height: 50,
        padding:
        EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
              color: Colors.black, width: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              counterText: '',
              /* prefixIcon:
              Icon(Icons.person_rounded),*/
              hintStyle: TextStyle(
                  color: AppData.hintColor,
                  fontSize: 15),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: textEditingController[index],
            maxLength: 10,

            //focusNode: fnode1,
            textAlignVertical:
            TextAlignVertical.center,
            onFieldSubmitted: (value) {
              print("ValueValue" + error[index].toString());

              setState(() {
                error[index] = false;
              });
              AppData.fieldFocusChange(context, fnode1, null);
            },
            inputFormatters: [
              UpperCaseTextFormatter(),
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
            ],

          ),
        ),
      ),
    );
  }
  /*Widget formFieldPassPortno(
      int controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        *//*Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),*//*
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              //focusNode: currentfn,

              inputFormatters: [
                UpperCaseTextFormatter(),
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
              ],
              maxLength: 10,
              // Validator.getKeyboardTyp(validateModel.fieldType.toLowerCase()),
              style: TextStyle(fontSize: 15),

              decoration: InputDecoration(
                //hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
              onChanged: (newValue) {},
              onFieldSubmitted: (value) {
                //AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }*/

// Widget formFieldPass(int index, String hint, int obqueTxt) {
//   return TextFieldContainer(
//     child: TextFormField(
//       controller: controller[index],
//       textInputAction: TextInputAction.done,
//       obscureText: !isViewList[obqueTxt],
//       keyboardType: Validator.getKeyboardTyp(Const.PASS),
//       style: TextStyle(fontSize: 13),
//       textAlignVertical: TextAlignVertical.center,
//       decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
//           border: InputBorder.none,
//           suffixIcon: InkWell(
//             onTap: () {
//               setState(() {
//                 isViewList[obqueTxt] = !isViewList[obqueTxt];
//               });
//             },
//             child: Icon(
//               isViewList[obqueTxt]
//                   ? CupertinoIcons.eye_slash_fill
//                   : CupertinoIcons.eye_fill,
//               size: 19,
//               color: Colors.grey,
//             ),
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
//     ),
//   );
// }
//


}
