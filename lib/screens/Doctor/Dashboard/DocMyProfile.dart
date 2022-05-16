import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'dart:html';
import 'dart:typed_data';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
/*import 'package:image_crop/image_crop.dart';*/
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/ProfileModel1.dart';
import 'package:user/models/UpdateDocProfileModel.dart';
import 'package:user/providers/Aadhar.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/providers/text_field_container.dart';
import 'package:flutter/rendering.dart';


import 'package:user/scoped-models/MainModel.dart';
import 'package:user/models/PatientListModel.dart';
//import 'package:user/screens/Doctor/Dashboard/CropimageProfile.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/TextFormatter.dart';
import 'package:user/widgets/signature.dart';

import '../../../main.dart';

class DocMyProfile extends StatefulWidget {
  MainModel model;
  static KeyvalueModel gendermodel = null;
  static KeyvalueModel countrymodel = null;
  static KeyvalueModel statemodel = null;
  static KeyvalueModel districtmodel = null;
  static KeyvalueModel citymodel = null;
  static KeyvalueModel bloodgroupmodel = null;
  DocMyProfile({Key key, this.model}) : super(key: key);
  @override
  _DocMyProfileState createState() => _DocMyProfileState();
}
/*late AppState state;*/
File imageFile;
File _selectedFile;
String _imagepath;

class _DocMyProfileState extends State<DocMyProfile> {
  String loAd = "Loading..";
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
  ];
  //Body model;
  File pathUsr = null;
  bool _inProcess = false;
  LoginResponse1 loginResponse;
  bool isDataNotAvail = false;
  ProfileModel1 profileModel1;
  List<bool> error = [false, false, false, false, false, false];

  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  FocusNode fnode5 = new FocusNode();
  FocusNode fnode6 = new FocusNode();
  FocusNode fnode7 = new FocusNode();
  FocusNode fnode8 = new FocusNode();
  FocusNode fnode9 = new FocusNode();
  FocusNode fnode10 = new FocusNode();
  FocusNode fnode11 = new FocusNode();
  FocusNode fnode12 = new FocusNode();
  FocusNode fnode13 = new FocusNode();

  final df = new DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();
  UpdateDocProfileModel updateProfileModel = UpdateDocProfileModel();

  bool selectGallery = false;
  //final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  var image;
  var pngBytes;
  //File _imageSign;

  final _sign = GlobalKey<Signature1State>();

  String signImg, signExt, signBase64;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    callAPI();
    //model = widget.model.model;
  }
  String birthdatestr;
  static final List colors = [
  Colors.black,
  Colors.purple,
  Colors.green,
  ];
  static final List lineWidths = [3.0, 5.0, 8.0];
  // File imageFile;
  int selectedLine = 0;
  Color selectedColor = colors[0];

  int curFrame = 0;
  bool isClear = false;
  callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.USER_PROFILE + loginResponse.body.user,
        userId: loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Json Response>>>" + JsonEncoder().convert(map));
          String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
            //AppData.showInSnackDone(context, "demo");
              // pocReportModel = PocReportModel.fromJson(map);
             /* if (profileModel1?.body?.birthdate != null) {
                birthdatestr = toDate(profileModel1.body.birthdate);
              }else{
                birthdatestr="";
              }
              */
              profileModel1 = ProfileModel1.fromJson(map);

              if (profileModel1?.body?.gender != null) {
                DocMyProfile.gendermodel = KeyvalueModel(
                     key: profileModel1.body.gender,
                    name: profileModel1.body.gendername);
              } else {
                DocMyProfile.gendermodel = null;
              }
              if (profileModel1?.body?.country != null) {
                DocMyProfile.countrymodel = KeyvalueModel(
                    key: profileModel1.body.country,
                    name: profileModel1.body.countryName);
              } else {
                DocMyProfile.countrymodel = null;
              }
              if (profileModel1?.body?.state != null) {
                DocMyProfile.statemodel = KeyvalueModel(
                    key: profileModel1.body.state,
                    name: profileModel1.body.stateName);
              } else {
                DocMyProfile.statemodel = null;
              }if (profileModel1?.body?.district != null) {
                  DocMyProfile.districtmodel = KeyvalueModel(
                      key: profileModel1.body.district,
                      name: profileModel1.body.districtName);
                      } else {
                      DocMyProfile.districtmodel = null;
                      }
            if (profileModel1?.body?.city != null) {
            DocMyProfile.citymodel = KeyvalueModel(
            key: profileModel1.body.city,
            name: profileModel1.body.cityName);
            } else {
            DocMyProfile.citymodel = null;
            }
              if (profileModel1?.body?.bldGr != null) {
                DocMyProfile.bloodgroupmodel = KeyvalueModel(
                    key: profileModel1.body.bldGr,
                    name: profileModel1.body.bldGrname);
              } else {
                DocMyProfile.bloodgroupmodel = null;
              }
             /* if (profileModel1?.body?.state != null) {
                DocMyProfile.statemodel = KeyvalueModel(
                    key: profileModel1.body.state,
                    name: profileModel1.body.stateName);
              }if (profileModel1?.body?.district != null) {
                DocMyProfile.districtmodel= KeyvalueModel(
                    key: profileModel1.body.district,
                    name: profileModel1.body.districtName);
              }if (profileModel1?.body?.city != null) {
                DocMyProfile.citymodel = KeyvalueModel(
                    key: profileModel1.body.city,
                    name: profileModel1.body.cityName);
              } else {


                DocMyProfile.statemodel = null;
                DocMyProfile.districtmodel = null;
                DocMyProfile.citymodel = null;
              }*/
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  getGender(String gender) {
    switch (gender) {
      case "1":
        return "Male";
        break;
      case "2":
        return "Female";
        break;
      case "3":
        return "Other";
        break;
    }
  }
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
                    onTap: () {
                      Navigator.pop(context);
                    getImage(ImageSource.camera);
                      //getCameraImage(),
                    }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: (){
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  //_openImage();
                   // _loadPicker(ImageSource.camera);
                    //_buildOpenImage(),
                  /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cropimage()),
                  ),*/
                    //_sample == null ? _buildOpeningImage() : _buildCroppingImage(),
                    //_buildCroppingImage(),
                   // getGalleryImage(),
                    //_openImage(),
                    //_cropImage(),
                  },
                ),
              ],
            ),

          );


        });
  }

  getImage(ImageSource source) async {
    this.setState((){
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if(image != null){
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
           // textAlign: TextAlign.center,
            toolbarColor: AppData.kPrimaryColor,
            toolbarTitle: "Image Cropper",
            toolbarWidgetColor: Colors.white,
            //centerTitle: true,
            //toolbar.setTitleTextColor(Color.RED);
            ///statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          )
      );
      if (cropped != null) {
        var enc = await cropped.readAsBytes();
        String _path = image.path;
        setState(() => pathUsr = cropped);

        String _fileName = _path != null ? _path.split('/').last : '...';
        var pos = _fileName.lastIndexOf('.');
        String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
        print(extName);
        print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
        setState(() {
          pathUsr = cropped;
          _inProcess = false;

          // callApii();
          // widget.model.patientimg =base64Encode(enc);
          //widget.model.patientimgtype =extName;
          //updateProfileModel.profileImage = base64Encode(enc) as List<Null>;
          //updateProfileModel.profileImageType = extName;
          updateProfile(base64Encode(enc), extName);
        });
      }
      /*this.setState((){
        pathUsr = cropped;
        //updateProfile(base64Encode(cropped), extName);
        _inProcess = false;
      });*/
    } else {
      this.setState((){
        _inProcess = false;
      });
    }
  }

  void SaveImage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", path);
  }

  void LoadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString("imagepath");
    });
  }
  // Widget _buildOpeningImage() {
  //   return Ce/nter(child: _buildOpenImage());
  // }
  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 45);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    if (image != null) {
      var enc = await image.readAsBytes();
      String _path = image.path;
      setState(() => pathUsr = File(_path));

      String _fileName = _path != null ? _path.split('/').last : '...';
      var pos = _fileName.lastIndexOf('.');
      String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
      print(extName);

      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
      setState(() {
        pathUsr = File(_path);
        // callApii();
        // widget.model.patientimg =base64Encode(enc);
        //widget.model.patientimgtype =extName;
        //updateProfileModel.profileImage = base64Encode(enc) as List<Null>;
        //updateProfileModel.profileImageType = extName;
        updateProfile(base64Encode(enc), extName);
      });
    }
  }


  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 45);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    if (image != null) {
      var enc = await image.readAsBytes();
      String _path = image.path;
      setState(() => pathUsr = File(image.path)); /*File(_path));*/

      String _fileName = _path != null ? _path.split('/').last : '...';
      var pos = _fileName.lastIndexOf('.');
      String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
      print(extName);
      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
      setState(() {
        pathUsr = File(_path);
        //_cropImage();
        //widget.model.patientimg =base64Encode(enc);
        //widget.model.patientimgtype =extName;
        //updateProfileModel.profileImage = base64Encode(enc) as List<Null>;
        //updateProfileModel.profileImageType = extName;
        updateProfile(base64Encode(enc), extName);
      });
    }
  }
  List<KeyvalueModel> genderList = [
    KeyvalueModel(key: "1", name: "Male"),
    KeyvalueModel(key: "2", name: "Female"),
    KeyvalueModel(key: "3", name: "Other"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          /* leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
              InkWell(
                onTap:(){
                  //_cropImage();
                },
                child: Center(
                  child: Text(
                    MyLocalizations.of(context).text("MY_PROFILE"),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              //Spacer(),
                 Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: InkWell(
                    onTap: () {
                     // _displayTextInputDialog(context);
                      if (profileModel1 != null) {
                        _displayTextInputDialog(context);
                      } else {
                        AppData.showInSnackBar(context,"Please wait until we are fetching your data");
                      }
                    },
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
              /*Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/idCard");
                  },
                  child: Text(
                    "ID CARD",
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),*/
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
              )
            ],
          ),
          backgroundColor: AppData.kPrimaryColor,
          //centerTitle: true,
          // iconTheme: IconThemeData(color: AppData.kPrimaryColor,),
        ),
        /*appBar: AppBar(
          title: Text("User Profile"),
          titleSpacing: 2,
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),*/
        body: (profileModel1 != null)
            ?/*(_sample == null)?*/ Container(
                height: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: AppData.matruColor.withOpacity(0.7),
                            ),
                          ),
                          _buildHeader(context)
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                         MyLocalizations.of(context).text("USER_INFORMATION").toUpperCase(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.calendar_today),
                                        title: Text(MyLocalizations.of(context).text("DOB1").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.birthdate!="" ?profileModel1.body.birthdate:
                                                "N/A"),
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        leading: Icon(Icons.wc),
                                        title: Text(MyLocalizations.of(context).text("GENDER").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.gendername!="" ?profileModel1.body.gendername:"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.call),
                                        title: Text(MyLocalizations.of(context).text("MOBILE_NO").toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1?.body.mobile!="" ?profileModel1.body.mobile:
                                            "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.mail),
                                        title: Text(MyLocalizations.of(context).text("EMAILID").toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1?.body?.email!=""?profileModel1.body.email:"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.bloodtype_outlined),
                                        title: Text(MyLocalizations.of(context).text("BLOODGROUP").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.bldGrname!="" ?profileModel1.body.bldGrname: "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text(MyLocalizations.of(context).text("ADDRESS").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.address!="" ?profileModel1.body.address:"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text(MyLocalizations.of(context).text("COUNTRY").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.countryName!="" ?profileModel1.body.countryName:"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text(MyLocalizations.of(context).text("STATE").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.stateName!="" ?profileModel1.body.stateName: "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text(MyLocalizations.of(context).text("DIST").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.districtName!=""?profileModel1.body.districtName: "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text(MyLocalizations.of(context).text("CITY").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.cityName!=""?profileModel1.body.cityName: "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.location_on_rounded),
                                        title: Text(MyLocalizations.of(context).text("PIN_CODE").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.pincode!=""? profileModel1.body.pincode: "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.book),
                                        title: Text(MyLocalizations.of(context).text("EDUCATION").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1?.body?.education !=""? profileModel1.body.education:
                                            "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.work_outlined),
                                        title: Text(MyLocalizations.of(context).text("SPECIALITY").toUpperCase(),),
                                        subtitle: Text(
                                            profileModel1?.body?.speciality !=""?  profileModel1.body.speciality:
                                            "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.home_work_sharp),
                                        title: Text(MyLocalizations.of(context).text("ORGANIZATION").toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1?.body?.organization !=""?profileModel1.body.organization:
                                        "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.work_outlined),
                                        title: Text(MyLocalizations.of(context).text("EXPERIENCE").toUpperCase()),
                                        //subtitle: Text("NIRMALYA"),
                                        subtitle: Text(profileModel1?.body?.experience!=""?profileModel1.body.experience:
                                            "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.contact_phone),
                                        title: Text(MyLocalizations.of(context).text("IMA_NO").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.imano!=""?profileModel1.body.imano:"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("PAN_CARD_NO").toUpperCase(),
                                        ),
                                        subtitle:
                                            Text(profileModel1?.body?.pancardno!=""?profileModel1.body.pancardno:"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("PASSPORT_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1?.body?.passportno!=""?profileModel1.body.passportno:"N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("VOTER_CARD_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1?.body?.votercardno!=""?profileModel1.body.votercardno:
                                                "N/A"),
                                      ),

                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("LICENCE_NO").toUpperCase(),
                                        ),
                                        subtitle: Text(
                                            profileModel1?.body?.licenceno!=""?profileModel1.body.licenceno: "N/A"),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.credit_card_rounded),
                                        title: Text(MyLocalizations.of(context).text("LICENSE_AUTHORITY").toUpperCase()),
                                        subtitle: Text(
                                            profileModel1?.body?.licenseauthority!=""? profileModel1.body.licenseauthority: "N/A"),
                                      ),

                                      InkWell(
                                        onTap: () {
                                        //  _displayTextInputDialog(context);
                                          openSignaturePage();


                                        },
                                      child:ListTile(
                                        leading:Icon(Icons.satellite_outlined),
                                        title:Text(MyLocalizations.of(context).text("DIGITAL_SIGNATURE").toUpperCase()),
                                        /*subtitle: Text(
                                            profileModel1.body.address+profileModel1.body.address1?? "N/A"),*/
                                          trailing:Icon(Icons.edit),
                                      ),

                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 100,
                                    height: 70,
                                    child: profileModel1.body.digsign!=""
                                        ? Image.network(/*"http://192.168.34.208:8062/document/profile/35_1639748020550.jpg"*/
                                      profileModel1.body.digsign,
                                      height: 80.0,
                                    )
                                        : /*null*/Container(),
                                  ),

                                ],

                              )
                            ],
                          ),
                        ),
                      ),
                    /*  (_inProcess)?Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.95,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ):Center(),*/
                      SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        height: 13,
                      )
                    ],
                  ),
                ),
              )/*:_buildCroppingImage()*/
            : Center(
                child: Text(
                  loAd,
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
              ));
  }
  Future<void> _displayTextInputDialog(BuildContext context) async {
    textEditingController[0].text = profileModel1.body.birthdate !=""?toDate(profileModel1.body.birthdate):"";
    textEditingController[1].text =  profileModel1.body.education ??"";
    textEditingController[2].text =  profileModel1.body.experience ?? "";
    textEditingController[3].text =  profileModel1.body.imano ?? "";
   // textEditingController[2].text =  profileModel1.body.imano ?? "";
    textEditingController[4].text = profileModel1.body.aadhaar ?? "";
    textEditingController[5].text = profileModel1.body.passportno ??"";
    textEditingController[6].text = profileModel1.body.votercardno ?? "";
    textEditingController[7].text = profileModel1.body.licenceno ??"";
    textEditingController[8].text = profileModel1.body.licenseauthority ??"";
    textEditingController[9].text = profileModel1.body.pancardno ?? "";
    textEditingController[10].text = profileModel1.body.email ?? "";
    textEditingController[11].text = profileModel1.body.pincode ?? "";
    textEditingController[12].text = profileModel1.body.mobile ?? "";
    textEditingController[13].text = profileModel1.body.address ?? "";
    if (profileModel1?.body?.gender == null ||
        profileModel1?.body?.gender == "") {
      DocMyProfile.gendermodel = null;
    }
    if (profileModel1?.body?.country == null ||
        profileModel1?.body?.country == "") {
      DocMyProfile.countrymodel = null;
    }
    if (profileModel1?.body?.state == null ||
        profileModel1?.body?.state == "") {
      DocMyProfile.statemodel = null;
    }
    if (profileModel1?.body?.district == null ||
        profileModel1?.body?.district == "") {
      DocMyProfile.districtmodel = null;
    }
    if (profileModel1?.body?.city == null ||
        profileModel1?.body?.city == "") {
      DocMyProfile.citymodel = null;
    }
    if (profileModel1?.body?.bldGr == null ||
        profileModel1?.body?.bldGr == "") {
      DocMyProfile.bloodgroupmodel = null;
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            MyLocalizations.of(context).text("UPDATE_PROFILE"),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          dob(MyLocalizations.of(context).text("DOB")),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context).text("GENDER"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                gender(),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context).text("BLOODGROUP"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    MyLocalizations.of(context).text("BLOODGROUP"),
                                    ApiFactory.BLOODGROUP_API,
                                    "bloodgroupdop", (KeyvalueModel model) {
                                  setState(() {
                                    DocMyProfile.bloodgroupmodel = model;
                                    profileModel1.body.bldGr = model.key;
                                    profileModel1.body.bldGrname =
                                        model.name;
                                    // updateProfileModel.bloodGroup = model.key;
                                  });
                                }),
                              ]),

                          SizedBox(
                            height: 10,
                          ),
                          formFieldEducation(
                              1,
                              MyLocalizations.of(context).text("EDUCATION"),
                              fnode1,
                              fnode2),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldExperince(
                              2,
                              MyLocalizations.of(context).text("EXPERIENCE"),
                              fnode2,
                              fnode3),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldMobileno(
                              3,
                              MyLocalizations.of(context).text("IMA_NO"),
                              fnode3,
                              fnode4),

                          SizedBox(
                            height: 10,
                          ),
                          formFieldAadhaaerno(
                              4,
                              MyLocalizations.of(context).text("AADHAAR_NO"),
                              fnode4,
                              fnode5),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldPassPortno(
                              5,
                              MyLocalizations.of(context).text("PASSPORT_NO"),
                              fnode5,
                              fnode6),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldPassPortno(
                              6,
                              MyLocalizations.of(context).text("VOTER_CARD_NO"),
                              fnode6,
                              fnode7),
                          SizedBox(
                            height: 10,
                          ),
                          licenceno(
                              7,
                              MyLocalizations.of(context).text("LICENCE_NO"),
                              fnode7,
                              fnode8),
                          SizedBox(
                            height: 10,
                          ),
                          formField(
                              8,
                              MyLocalizations.of(context).text("LICENSE_AUTHORITY"),
                              fnode8,
                              fnode9),
                          SizedBox(height: 10),
                          formFieldPassPortno(
                              9,
                              MyLocalizations.of(context).text("PAN_CARD_NO"),
                              fnode9,
                              fnode10),
                          SizedBox(
                            height: 10,
                          ),
                          formFieldemail(
                          10,
                              MyLocalizations.of(context).text("EMAILID"),
                          fnode10,
                          fnode11),
                      SizedBox(height: 10),
                          formFieldZipno(
                          11,
                              MyLocalizations.of(context).text("PIN_CODE"),
                          fnode11,
                          fnode12),
                      SizedBox(height: 10),
                          formFieldMoileno(
                          12,
                              MyLocalizations.of(context).text("MOBILE_NO"),
                          fnode12,
                          fnode13),
                          SizedBox(height: 10),
                          formFieldAddress(
                              13,
                              MyLocalizations.of(context).text("USER_ADDRESS"),
                              fnode13,
                              null),
                      SizedBox(height: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context)
                                        .text("COUNTRY"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "Country",
                                    ApiFactory.COUNTRY_API,
                                    "countrydocp", (KeyvalueModel model) {
                                  setState(() {
                                    print(ApiFactory.COUNTRY_API);
                                    DocMyProfile.countrymodel = model;
                                    profileModel1.body.country = model.key;
                                    profileModel1.body.countryName = model.name;
                                    DocMyProfile.statemodel = null;
                                    DocMyProfile.districtmodel = null;
                                    DocMyProfile.citymodel = null;
                                    // updateProfileModel.bloodGroup = model.key;
                                  });
                                }),
                              ]),
                          SizedBox(height: 10),

                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context)
                                        .text("STATE"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "State",
                                    ApiFactory.STATE_API +
                                        (DocMyProfile?.countrymodel?.key ??
                                            ""),
                                    "statedocp", (KeyvalueModel model) {
                                  setState(() {
                                    print(ApiFactory.STATE_API);
                                    DocMyProfile.statemodel = model;
                                    profileModel1.body.state = model.key;
                                    profileModel1.body.stateName= model.name;
                                    DocMyProfile.districtmodel = null;
                                    DocMyProfile.citymodel = null;
                                    // updateProfileModel.bloodGroup = model.key;
                                  });
                                }),
                              ]),
                          SizedBox(height: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context)
                                        .text("DIST"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "District",
                                    ApiFactory.DISTRICT_API +
                                        (DocMyProfile?.statemodel?.key ??
                                            ""),
                                    "districtdocp", (KeyvalueModel model) {
                                  setState(() {
                                    print(ApiFactory.DISTRICT_API);
                                    DocMyProfile.districtmodel = model;
                                    profileModel1.body.district = model.key;
                                    profileModel1.body.districtName=model.name;
                                    DocMyProfile.citymodel = null;

                                    // updateProfileModel.bloodGroup = model.key;
                                  });
                                }),
                              ]),
                          SizedBox(height: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, bottom: 0),
                                  child: Text(
                                    MyLocalizations.of(context)
                                        .text("CITY"),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                DropDown.networkDropdownlabler1(
                                    "City",
                                    ApiFactory.CITY_API +
                                        (DocMyProfile?.districtmodel?.key ??
                                            ""),
                                    "citydocp",
                                        (KeyvalueModel model) {
                                      setState(() {
                                        print(ApiFactory.CITY_API);
                                        DocMyProfile.citymodel = model;
                                        profileModel1.body.city = model.key;
                                        profileModel1.body.cityName = model.name;
                                        // updateProfileModel.bloodGroup = model.key;
                                      });
                                    }),
                              ]),
                        ]),

                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  setState(() {
                    callAPI();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(MyLocalizations.of(context).text("UPDATE")),
                onPressed: () {
                  //AppData.showInSnackBar(context, "click");
                  setState(() {
                 if (textEditingController[0].text == "N/A" ||
                        textEditingController[0].text == null ||
                        textEditingController[0].text == "") {
                   AppData.showInSnackBar(context, "Please enter DOB");
                 } else if (DocMyProfile.gendermodel == null ||
                     DocMyProfile.gendermodel == "") {
                AppData.showInSnackBar(context, "Please select gender");
                }  else if (DocMyProfile.bloodgroupmodel == null ||
          DocMyProfile.bloodgroupmodel == "") {
          AppData.showInSnackBar(context, "Please select blood group");
          }
                   //        bool isAllBlank = true;
                   //        textEditingController.forEach((element) {
                   // if (element.text != "") isAllBlank = false;
                   // });if (isAllBlank)
                   // {
                   // //AppData.showInSnackBar(context, "Please select Smoking");
                   // AppData.showInSnackBar(
                   // context, "Please Fill Up all details ");
                 else if (textEditingController[1].text == "N/A" ||
                        textEditingController[1].text == null ||
                        textEditingController[1].text == "") {
                      AppData.showInSnackBar(
                          context, "Please enter education name");
                 }  else if (textEditingController[1].text.length<3) {
                   AppData.showInSnackBar(context, "Please enter valid education name");
                    } else if (textEditingController[2].text == "N/A" || textEditingController[2].text == null ||
                        textEditingController[2].text == "" || double.tryParse(textEditingController[2].text)>99) {
                      AppData.showInSnackBar(
                          context, "Please enter your experience ");
                    // } else if (textEditingController[3].text == "" ||
                    //     textEditingController[3].text == null ||
                    //     textEditingController[3].text == "") {
                    //   AppData.showInSnackBar(
                    //       context, "Please enter IMA No.");
                 } else if (textEditingController[4].text != ""  && (!Aadhar.validateVerhoeff(
                     textEditingController[4].text.replaceAll("-", "").toString())|| textEditingController[4].text.length!=12)) {
                   AppData.showInSnackBar(context, "Please enter valid aadhar no");
                    // } else if (textEditingController[5].text == "N/A" ||
                    //     textEditingController[5].text == null ||
                    //     textEditingController[5].text == "") {
                    //   AppData.showInSnackBar(context, "Please enter passport No");
                 // } else if (textEditingController[6].text == "N/A" ||
                 //     textEditingController[6].text == null ||
                 //     textEditingController[6].text == "") {
                 //   AppData.showInSnackBar(context, "Please enter voter card No");
                 // } else if (textEditingController[7].text == "N/A" ||
                 //     textEditingController[7].text == null ||
                 //     textEditingController[7].text == "") {
                 //   AppData.showInSnackBar(context, "Please enter licence No");
                 // } else if (textEditingController[8].text == "N/A" ||
                 //     textEditingController[8].text == null ||
                 //     textEditingController[8].text == "") {
                 //   AppData.showInSnackBar(context, "Please enter licence authority");
                 // } else if (textEditingController[9].text == "N/A" ||
                 //     textEditingController[9].text == null ||
                 //     textEditingController[9].text == "") {
                 //   AppData.showInSnackBar(context, "Please enter PAN No");
                 } else if (textEditingController[10].text == "N/A" ||
                     textEditingController[10].text == null ||
                     textEditingController[10].text == "") {
                   AppData.showInSnackBar(context, "Please enter email id");
                 } else if (textEditingController[10].text != "" &&
                     !AppData.isValidEmail(textEditingController[10].text)) {
                   AppData.showInSnackBar(context, "Please enter a valid e-mail id");
                 } else if (textEditingController[11].text == "N/A" ||
                     textEditingController[11].text == null ||
                     textEditingController[11].text == "") {
                   AppData.showInSnackBar(context, "Please enter pin code");
                 }else if (textEditingController[11].text != "" &&
                     textEditingController[11].text.length != 6) {
                   AppData.showInSnackBar(context, "Please enter a valid pin code ");
                 } else if (textEditingController[12].text == "N/A" ||
                     textEditingController[12].text == null ||
                     textEditingController[12].text == "") {
                   AppData.showInSnackBar(context, "Please enter mobile no");
                 }else if (textEditingController[12].text != "" &&
                     textEditingController[12].text.length != 10) {
                   AppData.showInSnackBar(context, "Please enter a valid mobile no ");
                 } else if (textEditingController[13].text == "N/A" ||
                     textEditingController[13].text == null ||
                     textEditingController[13].text == "") {
                   AppData.showInSnackBar(context, "Please enter address");
                 }  else if (textEditingController[13].text.length<3) {
                   AppData.showInSnackBar(context, "Please enter valid address");
                    } else if (DocMyProfile.countrymodel == null ||
          DocMyProfile.countrymodel == "") {
          AppData.showInSnackBar(context, "Please select country");
                 } else if (DocMyProfile.statemodel == null ||
                     DocMyProfile.statemodel == "") {
                   AppData.showInSnackBar(context, "Please select state");
                 } else if (DocMyProfile.districtmodel == null ||
                     DocMyProfile.districtmodel == "") {
                   AppData.showInSnackBar(context, "Please select district");
                 } else if (DocMyProfile.citymodel == null ||
                     DocMyProfile.citymodel == "") {
                   AppData.showInSnackBar(context, "Please select city");
                 }
                 else {
                      updateProfileModel.dctrid = loginResponse.body.user;
                      updateProfileModel.dob = textEditingController[0].text;
                      updateProfileModel.gender = DocMyProfile.gendermodel.key;
                      updateProfileModel.educationid = textEditingController[1].text;
                      updateProfileModel.experience = textEditingController[2].text;
                      updateProfileModel.imaNo = textEditingController[3].text;
                      //Emergency
                      updateProfileModel.adhaarNo = textEditingController[4].text;
                      updateProfileModel.passportNo = textEditingController[5].text;
                      updateProfileModel.votterId = textEditingController[6].text;
                      updateProfileModel.liceneceNo = textEditingController[7].text;
                      updateProfileModel.liceneceAuthority = textEditingController[8].text;
                      updateProfileModel.panNo = textEditingController[9].text;
                      updateProfileModel.email = textEditingController[10].text;
                      updateProfileModel.pincode = textEditingController[11].text;
                      updateProfileModel.mobno = textEditingController[12].text;
                      updateProfileModel.address = textEditingController[13].text;
                      updateProfileModel.countryid =  DocMyProfile.countrymodel.key;
                      updateProfileModel.stateid =  DocMyProfile.statemodel.key;
                      updateProfileModel.districtid =  DocMyProfile.districtmodel.key;
                      updateProfileModel.cityid =  DocMyProfile.citymodel.key;
                      updateProfileModel.bloodgroup =  DocMyProfile.bloodgroupmodel.key;

                      log("Post json2>>>>" + jsonEncode(updateProfileModel.toJson()));
                      log("Post api>>>>" +ApiFactory.UPDATE_DOCTER_PROFILE);
                      widget.model.POSTMETHOD_TOKEN(
                          api: ApiFactory.UPDATE_DOCTER_PROFILE,
                          json: updateProfileModel.toJson(),
                          token: widget.model.token,
                          fun: (Map<String, dynamic> map) {
                            Navigator.pop(context);
                            if (map[Const.STATUS] == Const.SUCCESS) {
                              // popup(context, map[Const.MESSAGE]);
                              print("Post json>>>>"+jsonEncode(updateProfileModel.toJson()));
                              AppData.showInSnackDone(
                                  context, map[Const.MESSAGE]);

                              callAPI();
                            } else {
                              AppData.showInSnackBar(context, map[Const.MESSAGE]);
                              callAPI();
                            }
                          });
                    }
                  });
                },
              ),
            ],
          );
        });
  }


  Widget formFieldAddress(
      int controller,
      String hint,
      FocusNode currentfn,
      FocusNode nextFn,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              focusNode: currentfn,
              /*inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9]"),
                ),
              ],*/

              ///maxLength: 10,
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }



  openSignaturePage() async {
    Size size = MediaQuery.of(context).size;

    var color = Colors.black;
    var strokeWidth = 3.0;
    print("signature");
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 290,
                child: SizedBox.expand(
                    child: Signature1(
                      color: color,
                      key: _sign,
                      strokeWidth: strokeWidth,
                    )),
                margin: EdgeInsets.only(bottom: 40, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned(
              top: size.height / 1.65,
              left: 12,
              right: 12,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text(MyLocalizations.of(context).text("CLEAR")),
                          onPressed: () {
                            _sign.currentState.clear();
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          child: Text(MyLocalizations.of(context).text("SAVE")),
                          onPressed: () {
                            var img = _sign.currentState.getData();
                            print(img);
                            setRenderedImage(context);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );

  }

  setRenderedImage(BuildContext context) async {
    ui.Image renderedImage = await _sign.currentState.getData();

    setState(() {
      image = renderedImage;
      print(image);
    });

    showImage(context);
  }

  Future<Null> showImage(BuildContext context) async {
    pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    ByteData data = pngBytes;
    var list = data.buffer.asUint8List();
   /* String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);*/
    String extName  = "png";
    signBase64 = base64.encode(list);
    updateSign(base64Encode(list), extName);
    /*registrationModel.signUploadBase64 = signBase64;
    registrationModel.signUploadExt = "png";
*/
    //log(">>>>" + base);
    setState(() {

      selectGallery = false;
    });
  }


  updateSign(String image, String ext) {
    MyWidgets.showLoading(context);
    var value = {
      "digSignType": ext,
      "digSign": [image],
      "dctrid": loginResponse.body.user
    };

    log("Post data>>\n\n" + jsonEncode(value));
    widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.OTHER_PROFILE_SIGN,
        token: widget.model.token,
        json: value,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              AppData.showInSnackDone(context, msg);
              callAPI();
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
              callAPI();
            }
          });
        });
  }
  updateProfile(String image, String ext) {
    MyWidgets.showLoading(context);
    var value = {
      "profileImageType": ext,
      "profileImage": [image],
      "dctrid": loginResponse.body.user
    };

    log("Post data>>\n\n" + jsonEncode(value));
    widget.model.POSTMETHOD_TOKEN(
        api: ApiFactory.OTHER_PROFILE_IMAGE,
        token: widget.model.token,
        json: value,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              AppData.showInSnackDone(context, msg);
              callAPI();
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
              callAPI();
            }
          });
        });
  }
 /* Future getSignatureImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var enc = await image.readAsBytes();

    print(
        "size>>>" + AppData.formatBytes(enc.length, 0).split('')[1].toString());
    var ext = AppData.formatBytes(enc.length, 0).split(' ')[1];
    int size = int.parse(AppData.formatBytes(enc.length, 0).split(' ')[0]);
    int requiredSize = int.parse(AppData.formatBytes(15000, 0).split(' ')[0]);

    if (ext == "KB" && size <= requiredSize) {
      var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      print(decodedImage.width);
      print(decodedImage.height);
      setState(() {
        _imageSignature = image;
        selectGallery = true;
        pngBytes = null;
        print('Image Path $_imageSignature');
      });
    } else {
      AppData.showToastMessage(
          MyLocalizations.of(context).text("SELECT_IMAGE_WITH_MAXIMUM_SIZE"),
          *//* "Please select image with maximum size 15 KB "*//* Colors.red);
      return;
    }
  }*/




  static String toDate(String date) {
    if (date != null && date != "") {
      DateTime formatter = new DateFormat("dd-MM-yyyy").parse(date);
      DateFormat toNeed = DateFormat("dd/MM/yyyy");
      final String formatted = toNeed.format(formatter);
      return formatted;
    } else {
      return "";
    }
  }
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

        textEditingController[0].value = TextEditingValue(text: df.format(picked));
        //updateProfileModel.dob = df.format(picked);
      });
  }
  Widget gender() {
    return DropDown.staticDropdown4(
        MyLocalizations.of(context).text("GENDER"), "gender1", genderList,
            (KeyvalueModel model) {
          DocMyProfile.gendermodel = model;
          profileModel1.body.gender = model.key;
          profileModel1.body.gendername = model.name;
        });
  }




  Widget dob(String hint) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => _selectDate(
          context,
        ),
        child: AbsorbPointer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 5, bottom: 8),
                child: Text(
                  hint,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: "",
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                // width: size.width * 0.8,
                /*decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.grey, width: 0.3)),*/
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextFormField(
                    //focusNode: fnode4,
                    //enabled: !widget.isConfirmPage ? false : true,
                    controller: textEditingController[0],
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    onSaved: (value) {
                      // registrationModel.dathOfBirth = value;
                    },
                    /*validator: (value) {
                      if (value.isEmpty) {
                        error[3] = true;
                        return null;
                      }
                      error[3] = false;
                      return null;
                    },*/
                    onFieldSubmitted: (value) {
                      //error[3] = false;
                      // print("error>>>" + error[2].toString());

                      setState(() {});
                      // AppData.fieldFocusChange(context, fnode4, fnode5);
                    },
                    decoration: InputDecoration(
                      hintText: //"Last Period Date",
                      MyLocalizations.of(context).text("DOB") ,
                      border: InputBorder.none,
                      //contentPadding: EdgeInsets.symmetric(vertical: 10),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )/*,*/
            ],
          ),
        ),
      ),
    );
  }
  Widget formField(
      int index, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[index],
              textInputAction: TextInputAction.done,
              focusNode: currentfn,
              keyboardType: TextInputType.text,
              /*inputFormatters: [
                WhitelistingTextInputFormatter(RegExp("[a-zA-Z .]")),
              ],*/
              // Validator.getKeyboardTyp(validateModel.fieldType.toLowerCase()),
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                //hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
              onChanged: (newValue) {},
              onFieldSubmitted: (value) {
                print("ValueValue" + error[index].toString());

                setState(() {
                  error[index] = false;
                });
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget formFieldemail(
      int index, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[index],
              textInputAction: TextInputAction.done,
              focusNode: currentfn,
              keyboardType: TextInputType.text,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z0-9.@]")),
              ],
              // Validator.getKeyboardTyp(validateModel.fieldType.toLowerCase()),
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                //hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2, horizontal: 0)),
              onChanged: (newValue) {},
              onFieldSubmitted: (value) {
                print("ValueValue" + error[index].toString());

                setState(() {
                  error[index] = false;
                });
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget formFieldMobileno(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: currentfn,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9]"),
                ),
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget formFieldPassPortno(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              focusNode: currentfn,

              inputFormatters: [
                //UpperCaseTextFormatter(),
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget licenceno(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              focusNode: currentfn,

              inputFormatters: [
                //UpperCaseTextFormatter(),
                WhitelistingTextInputFormatter(RegExp("[a-z-A-Z0-9/ ]")),
              ],
              maxLength: 20,
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }
  /*Widget IdNoFieldNew(String hint, bool enb, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
      child: TextFormField(
        autofocus: false,
        controller: textEditingController[controller],
        focusNode: currentfn,
        textInputAction: inputAct,
        //inputFormatters: [AppData.filtterInputType(format: "0-9")],
        inputFormatters: [
          UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
        ],
        decoration: InputDecoration(
          //prefixIcon: Icon(Icons.insert_drive_file_outlined),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          labelText: hint,
          alignLabelWithHint: false,
          //border: ,
          contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
        ),
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }*/
  Widget formFieldEducation(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              focusNode: currentfn,
              maxLength: 15,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[a-zA-Z 0-9.]"),
                ),
              ],
             //maxLength: 10,
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget formFieldExperince(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              focusNode: currentfn,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9.]"),
                ),
              ],
              maxLength: 4,
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget formFieldAadhaaerno(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: currentfn,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9]"),
                ),
              ],
              maxLength: 12,
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget formFieldMoileno(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: currentfn,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9]"),
                ),
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget formFieldZipno(
      int controller, String hint, FocusNode currentfn, FocusNode nextFn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "",
                fontWeight: FontWeight.w400),
          ),
        ),
        TextFieldContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: textEditingController[controller],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: currentfn,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                  RegExp("[0-9]"),
                ),
              ],
              maxLength: 6,
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
                AppData.fieldFocusChange(context, currentfn, nextFn);
              },
            ),
          ),
        ),
      ],
    );
  }
  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 200.0,
      child: Stack(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: .0),
            width: double.maxFinite,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
                bottomLeft: const Radius.circular(15.0),
                bottomRight: const Radius.circular(15.0),
              ),
              /*image: DecorationImage(
                  image: AssetImage(
                    "assets/card.png",
                  ),
                  fit: BoxFit.fitWidth,
                ),*/
              /*gradient: LinearGradient(
                  colors: [AppData.matruColor, Colors.black54],
                ),*/
              color: AppData.matruColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*SizedBox(
                  height: 45.0,
                ),*/
                Text(
                  profileModel1.body.name ?? "N/A",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(MyLocalizations.of(context).text("AADHAAR_NO1")
                 + ": " + profileModel1.body.aadhaar ?? "N/A",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 83,
              width: 83,
              child: Stack(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (pathUsr != null)
                      ? Material(
                    elevation: 5.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: FileImage(pathUsr),
                    ),
                  )
                      : Material(
                    elevation: 5.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(/*"http://192.168.34.208:8062/document/profile/35_1639748020550.jpg"*/
                          (profileModel1?.body?.profileimage !="")
                              ? profileModel1?.body?.profileimage
                              : AppData.defaultImgUrl),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: AppData.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
         /* Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(AppData.defaultImgUrl),
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
