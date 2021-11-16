import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/AddOrganDonModel.dart';
import 'package:user/models/TissueModel.dart' as tissue;
import 'package:user/models/OrganModel.dart' as organ;
import 'package:user/models/OrganModel.dart';
import 'package:user/models/TissueModel.dart';
import 'package:user/models/WitnessModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';
import '../../../localization/localizations.dart';
import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';

// ignore: must_be_immutable
class DonorApplication extends StatefulWidget {
  final Function(int, bool) updateTab;

  final bool isConfirmPage;
  final bool isFromDash;
  MainModel model;
  static KeyvalueModel districtModel = null;
  static KeyvalueModel bloodgroupModel = null;
  static KeyvalueModel blockModel = null;
  static KeyvalueModel genderModel = null;
  static KeyvalueModel relationmodel = null;
  static List<KeyvalueModel> UserType1 = [];

  DonorApplication({
    Key key,
    @required this.updateTab,
    this.isConfirmPage = false,
    this.isFromDash = false,
    this.model,
  }) : super(key: key);

  @override
  DonorApplicationState createState() => DonorApplicationState();
}

enum PayMode1 { cash, cheque, online }

class DonorApplicationState extends State<DonorApplication> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  PayMode1 payMode1 = PayMode1.cash;

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
  tissue.TissueModel tissueModel;
  List<tissue.Body> selectetissue = [];
  organ.OrganModel organModel;
  List<organ.Body> selectedorgan = [];
  List<WitnessModel> witnessModle = [];
  List<bool> dropdownError = [false, false, false];
  var color = Colors.black;
  var strokeWidth = 3.0;
  File _imageCertificate;
  bool selectGallery = false;
  var image;
  var pngBytes;
  String selectDob;
  KeyvalueModel selectedKey = null;
  KeyvalueModel selectedUser;
  KeyvalueModel selectedUser1;
  List<KeyvalueModel> UserType = [
    KeyvalueModel(key: "S", name: "S/o"),
    KeyvalueModel(key: "D", name: "D/o"),
    KeyvalueModel(key: "W", name: "W/o"),
  ];
  List<KeyvalueModel> UserType1 = [
    KeyvalueModel(key: "S", name: "S/o"),
    KeyvalueModel(key: "D", name: "D/o"),
    KeyvalueModel(key: "W", name: "W/o"),
  ];
  List<KeyvalueModel> _dropdownItems = [
    KeyvalueModel(key: "S", name: "S/o"),
    KeyvalueModel(key: "D", name: "D/o"),
    KeyvalueModel(key: "W", name: "W/o"),
  ];
  List<KeyvalueModel> _dropdownItems1 = [
    KeyvalueModel(key: "S", name: "S/o"),
    KeyvalueModel(key: "D", name: "D/o"),
    KeyvalueModel(key: "W", name: "W/o"),
  ];

  List<DropdownMenuItem<KeyvalueModel>> _dropdownMenuItems;
  KeyvalueModel _selectedItem;
  List<DropdownMenuItem<KeyvalueModel>> _dropdownMenuItems1;
  KeyvalueModel _selectedItem1;
  final df = new DateFormat('dd/MM/yyyy');
  bool ispartnercode = false;
  bool _checkbox = false;
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  bool _checkbox4 = false;
  bool _checkbox5 = false;
  bool _checkbox6 = false;
  bool _checkbox7 = false;
  bool _checkbox8 = false;
  bool _checkbox9 = false;
  bool _checkbox0 = false;

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
  List<KeyvalueModel> genderList = [
    KeyvalueModel(name: "0.5", key: "1"),
    KeyvalueModel(name: "0.6", key: "2"),
    KeyvalueModel(name: "0.7", key: "3"),
  ];
  List<KeyvalueModel> districtList = [
    KeyvalueModel(name: "3", key: "1"),
    KeyvalueModel(name: "4", key: "1"),
    KeyvalueModel(name: "5", key: "1"),
    KeyvalueModel(name: "6", key: "1"),
  ];

  List<String> selectedOrganList = [];
  List<String> selectedTissueList = [];

  @override
  void initState() {
    super.initState();
    DonorApplication.districtModel = null;
    DonorApplication.blockModel = null;
    DonorApplication.bloodgroupModel = null;
    //DonorApplication.genderModel = null;
    selectedUser = UserType[0];
    selectedUser1 = UserType1[0];
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
    _dropdownMenuItems1 = buildDropDownMenuItems(_dropdownItems1);
    _selectedItem1 = _dropdownMenuItems1[0].value;
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
    organcallAPI();
    tissuecallAPI();
  }

  List<DropdownMenuItem<KeyvalueModel>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<KeyvalueModel>> items = List();
    for (KeyvalueModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<KeyvalueModel>> buildDropDownMenuItems1(
      List listItems) {
    List<DropdownMenuItem<KeyvalueModel>> items = List();
    for (KeyvalueModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  tissuecallAPI() {
    widget.model.GETMETHODCALL_TOKEN(
      api: ApiFactory.TISSUE_API,
      token: widget.model.token,
      fun: (Map<String, dynamic> map) {
        String msg = map[Const.MESSAGE];
        //String msg = map[Const.MESSAGE];
        if (map[Const.CODE] == Const.SUCCESS) {
          setState(() {
            log("Response from sagar>>>>>" + jsonEncode(map));
            tissueModel = TissueModel.fromJson(map);
          });
        } else {
          setState(() {
            //isDataNoFound = true;
          });
          /* Center(
            child: Text(
              'Data Not Found',
              style: TextStyle(fontSize: 12),
            ),
          );*/
          // AppData.showInSnackBar(context, msg);
        }
      },
    );
  }

  organcallAPI() {
    widget.model.GETMETHODCALL_TOKEN(
      api: ApiFactory.ORGAN_API,
      token: widget.model.token,
      fun: (Map<String, dynamic> map) {
        String msg = map[Const.MESSAGE];
        //String msg = map[Const.MESSAGE];
        if (map[Const.CODE] == Const.SUCCESS) {
          setState(() {
            log("Response from sagar>>>>>" + jsonEncode(map));
            organModel = OrganModel.fromJson(map);
          });
        } else {
          setState(() {
            //  isDataNoFound = true;
          });
          /* Center(
            child: Text(
              'Data Not Found',
              style: TextStyle(fontSize: 12),
            ),
          );*/
          // AppData.showInSnackBar(context, msg);
        }
      },
    );
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
        centerTitle: true,
        title: Text(
          MyLocalizations.of(context).text("DONOR_APPLICATION"),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: textEditingController[0],
                  decoration: InputDecoration(
                      hintText: MyLocalizations.of(context).text("NAME"),
                      hintStyle: TextStyle(color: Colors.grey)),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: mobileNumber(),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: dob(),
              ),
              /* Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: textEditingController[2],
              decoration: InputDecoration(
                  hintText: "Date Of Birth",
                  hintStyle: TextStyle(color: Colors.grey)),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              inputFormatters: [
                WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z,0-9 ]")),
              ],
            ),
          ),*/
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: textEditingController[3],
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: MyLocalizations.of(context).text("AGE"),
                      hintStyle: TextStyle(color: Colors.grey)),
                  textInputAction: TextInputAction.next,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9]")),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropDown.networkDropdownGetpartUserundreline(
                    MyLocalizations.of(context).text("BLOODGROUP"),
                    ApiFactory.BLOODGROUP_API,
                    "bloodgroupdn", (KeyvalueModel data) {
                  setState(() {
                    print(ApiFactory.BLOODGROUP_API);
                    DonorApplication.bloodgroupModel = data;
                    //DonorApplication.bloodgroupModel = null;
                  });
                }),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: textEditingController[4],
                  decoration: InputDecoration(
                      counterText: "",
                      hintText:
                          MyLocalizations.of(context).text("PHONE_NUMBER"),
                      hintStyle: TextStyle(color: Colors.grey)),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9]")),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: textEditingController[5],
                  decoration: InputDecoration(
                      hintText: MyLocalizations.of(context).text("EMAILID"),
                      hintStyle: TextStyle(color: Colors.grey)),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  //           inputFormatters: [
                  //  WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                  //           ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: textEditingController[6],
                  decoration: InputDecoration(
                      hintText: MyLocalizations.of(context).text("ADDRESS"),
                      hintStyle: TextStyle(color: Colors.grey)),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9,a-zA-Z./-]")),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                    color: Colors.black26,
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 6),
                        Text(
                          MyLocalizations.of(context).text("ORGAN"),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 15),
                        ),
                        SizedBox(width: 180),
                        Expanded(
                          child: Text(
                            MyLocalizations.of(context).text("TISSUE"),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(children: [
                        CheckboxListTile(
                          activeColor: Colors.blue[300],
                          dense: true,
                          title: new Text(
                            MyLocalizations.of(context).text("ALL_ORGAN"),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          value: isChecked,
                          onChanged: (val) {
                            setState(() {
                              isChecked = val;
                            });
                          },
                        ),
                      ])),
                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                            CheckboxListTile(
                              activeColor: Colors.blue[300],
                              dense: true,
                              title: new Text(
                                MyLocalizations.of(context).text("ALL_TISUES"),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                              value: isChecked,
                              onChanged: (val) {
                                setState(() {
                                  isChecked = val;
                                });
                              },
                            ),
                          ])),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  (organModel != null)
                      ? Flexible(
                          child: ListView.builder(
                            itemBuilder: (context, i) {
                              organ.Body body = organModel.body[i];
                              // widget.model.medicinelist = ;
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CheckboxListTile(
                                  activeColor: Colors.blue[300],
                                  dense: true,
                                  //font change
                                  title: new Text(
                                    body.name ?? "N/A",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5),
                                  ),
                                  value: body.isChecked,
                                  onChanged: (val) {
                                    setState(() {
                                      body.isChecked = val;
                                      if (val) {
                                        selectedorgan.add(body);
                                        selectedOrganList
                                            .add(body.key.toString());
                                      } else {
                                        selectedorgan.remove(body);
                                        selectedOrganList
                                            .remove(body.key.toString());
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                            itemCount: organModel.body.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        )
                      : Container(),
                  (tissueModel != null)
                      ? Flexible(
                          child: ListView.builder(
                            itemBuilder: (context, i) {
                              tissue.Body body = tissueModel.body[i];
                              // widget.model.medicinelist = ;
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CheckboxListTile(
                                  activeColor: Colors.blue[300],
                                  dense: true,
                                  //font change
                                  title: new Text(
                                    body.name ?? "N/A",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5),
                                  ),
                                  value: body.isChecked,
                                  onChanged: (val) {
                                    setState(() {
                                      body.isChecked = val;
                                      if (val) {
                                        selectetissue.add(body);
                                        selectedTissueList.add(body.key);
                                      } else {
                                        selectetissue.remove(body);
                                        selectedTissueList.remove(body.key);
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                            itemCount: tissueModel.body.length ?? 0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        )
                      : Container(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black26,
                  height: 40,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          MyLocalizations.of(context).text("ADD_WITNESS"),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      //Spacer(),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                dialogaddnomination(context),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.add_box,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemBuilder: (context, i) {
                  //= witnessModle[i];
                  // widget.model.medicinelist = ;
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      shadowColor: Colors.grey,
                      elevation: 4,
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Container(
                            height: 100,
                            width: double.maxFinite,
                            /*  margin: const EdgeInsets.only(top: 6.0),*/
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Witness Name: " +
                                              witnessModle[i].donorName,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Mobile No.: " + witnessModle[i].mob,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Age: " + witnessModle[i].age,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Address: " + witnessModle[i].address,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        //witnessModle.remove(i);
                                        witnessModle.remove(witnessModle[i]);
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete_forever,
                                      // color: Colors.red,
                                    ),
                                  ),
                                  /*Image.asset(
                                "assets/forwardarrow.png",
                                fit: BoxFit.fitWidth,
                                */ /*width: 50,*/ /*
                                height: 30,
                              ),*/
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            )),
                        /* clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                          ),*/
                      ),
                    ),

                    /* */
                  );
                },
                itemCount: witnessModle.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _submitButton(),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogaddnomination(BuildContext context) {
    WitnessModel witness = WitnessModel();
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text("Add Witness"),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingController[7],
                    decoration: InputDecoration(
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.grey)),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[a-zA-Z., ]")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  //padding: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 10.0, right: 5.0, bottom: 0.0),
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
                          child: DropdownButton<KeyvalueModel>(
                              underline: Container(
                                color: Colors.grey,
                              ),
                              value: _selectedItem1,
                              items: _dropdownMenuItems1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem1 = value;
                                });
                              }),
                        ),
                        Container(
                          height: 35.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        new Expanded(
                          child: TextFormField(
                            enabled: widget.isConfirmPage ? false : true,
                            controller: textEditingController[8],
                            // focusNode: fnode8,
                            cursorColor: AppData.kPrimaryColor,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(
                                  RegExp("[a-zA-Z., ]")),
                            ],
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              // border: InputBorder.none,
                              counterText: "",
                              hintText: "S/O,D/O,W/O",
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
                              //AppData.fieldFocusChange(context, fnode7, fnode8);
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
                /*Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: witnmobileNumber(),
                ),*/
                SizedBox(
                  height: 8,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingController[9],
                    decoration: InputDecoration(
                        counterText: "",
                        hintText: "Age: Years",
                        hintStyle: TextStyle(color: Colors.grey)),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                    ],
                  ),
                ),

                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropDown.networkDropdownGetpartUserundreline(
                      "Relation", ApiFactory.RELATION_API, "relation",
                      (KeyvalueModel model) {
                    setState(() {
                      DonorApplication.relationmodel = model;
                    });
                  }),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingController[10],
                    decoration: InputDecoration(
                        counterText: "",
                        hintText: "Mobile Number",
                        hintStyle: TextStyle(color: Colors.grey)),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingController[11],
                    decoration: InputDecoration(
                        hintText:
                            /*MyLocalizations.of(context)
                            .text("Email ID(optional)"*/
                            "Email ID(Optional)",
                        hintStyle: TextStyle(color: Colors.grey)),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    //           inputFormatters: [
                    //  WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                    //           ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingController[12],
                    decoration: InputDecoration(
                        hintText: "Address",
                        hintStyle: TextStyle(color: Colors.grey)),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9,a-zA-Z ]")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            textEditingController[7].text = "";
            textEditingController[8].text = "";
            textEditingController[9].text = "";
            textEditingController[10].text = "";
            textEditingController[11].text = "";
            textEditingController[12].text = "";
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel'),
        ),
        new FlatButton(
          onPressed: () {
            setState(() {
              if (textEditingController[7].text == "" ||
                  textEditingController[7].text == null) {
                AppData.showInSnackBar(context, "Please enter Person Name");
              } else if (textEditingController[8].text != "" &&
                  textEditingController[8].text == null) {
                AppData.showInSnackBar(context, "Please enter S/o,D/0,W/o");
              } else if (textEditingController[9].text == "" ||
                  textEditingController[9].text == null) {
                AppData.showInSnackBar(context, "Please enter Dob");
              } else if (textEditingController[9].text == "" ||
                  textEditingController[9].text == null) {
                AppData.showInSnackBar(context, "Please enter Age: Years");
              } else if (DonorApplication.relationmodel == null ||
                  DonorApplication.relationmodel == "") {
                AppData.showInSnackBar(context, "Please select Blood Relation");
              } else if (textEditingController[10].text != "" &&
                  textEditingController[10].text.length != 10) {
                AppData.showInSnackBar(context, "Please enter Mobile No");
              } else if (textEditingController[11].text != '' &&
                  !AppData.isValidEmail(textEditingController[11].text)) {
                AppData.showInSnackBar(context, "Please enter a valid E-mail");
              } else if (textEditingController[12].text != "" &&
                  textEditingController[12].text == null) {
                AppData.showInSnackBar(context, "Please enter Address");
              } else {
                WitnessModel witness = WitnessModel();
                witness.donorName = textEditingController[7].text;
                witness.donorType = _selectedItem1.key;
                witness.typeUserName = textEditingController[8].text;
                witness.relation = DonorApplication.relationmodel.key;
                witness.age = textEditingController[9].text;
                witness.mob = textEditingController[10].text;
                witness.email = textEditingController[11].text;
                witness.address = textEditingController[12].text;

                //nomineeModel.relaion = AddEmployeePage.RelationModel.key;

                setState(() {
                  witnessModle.add(witness);
                });
              }
            });
            Navigator.of(context).pop();
            textEditingController[7].text = "";
            textEditingController[8].text = "";
            textEditingController[9].text = "";
            textEditingController[10].text = "";
            textEditingController[11].text = "";
            textEditingController[12].text = "";
            /*controller[0].text="";
             controller[1].text="";*/
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget viewMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.cash,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Daily"),
        SizedBox(
          width: 10,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.cheque,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Weekly"),
        SizedBox(
          width: 10,
        ),
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: PayMode1.online,
          groupValue: payMode1,
          onChanged: (PayMode1 value) {
            setState(() {
              payMode1 = value;
            });
          },
        ),
        Text("Monthly"),
      ],
    );
  }

  Widget mobileNoOTPSearch() {
    return Row(
      children: <Widget>[
        Expanded(
          //flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 2.0),
            child: Container(
              // padding: EdgeInsets.only(left: 2),
              height: 50.0,

              child: mobileNumber(),
            ),
          ),
        ),
      ],
    );
  }

  Future getCerificateImage() async {
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
  }

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

  Widget _submitButton() {
    return MyWidgets.nextButton(
        text: MyLocalizations.of(context).text("SUBMIT"),
        context: context,
        fun: () {
          //Navigator.pushNamed(context, "/addWitness");
          if (textEditingController[0].text == "" ||
              textEditingController[0].text == null) {
            AppData.showInSnackBar(context, "Please enter Person Name");
          } else if (textEditingController[1].text == "" ||
              textEditingController[1].text == null) {
            AppData.showInSnackBar(context, "Please enter S/o,D/0,W/o");
          } else if (textEditingController[2].text == "" ||
              textEditingController[2].text == null) {
            AppData.showInSnackBar(context, "Please enter DOB");
          } else if (textEditingController[3].text == "" ||
              textEditingController[3].text == null) {
            AppData.showInSnackBar(context, "Please enter Age: Years");
          } else if (DonorApplication.bloodgroupModel == null ||
              DonorApplication.bloodgroupModel == "") {
            AppData.showInSnackBar(context, "Please select Blood Group");
          } else if (textEditingController[4].text == "" ||
              textEditingController[4].text == null) {
            AppData.showInSnackBar(context, "Please enter Mobile Number");
          } else if (textEditingController[4].text != "" &&
              textEditingController[4].text.length != 10) {
            AppData.showInSnackBar(context, "Please enter valid Mobile Number");
          } else if (textEditingController[5].text != '' &&
              !AppData.isValidEmail(textEditingController[5].text)) {
            AppData.showInSnackBar(context, "Please enter a valid E-mail");
          } else if (textEditingController[6].text == "" ||
              textEditingController[6].text == null) {
            AppData.showInSnackBar(context, "Please enter Address");
          } else {
            // Navigator.pushNamed(context, "/addWitness");
            MyWidgets.showLoading(context);
            AddOrganDonModel addOrganDonModel = AddOrganDonModel();
            addOrganDonModel.patientId = widget.model.user;
            addOrganDonModel.donorName = textEditingController[0].text;
            addOrganDonModel.donorType = _selectedItem.key;
            addOrganDonModel.typeUserName = textEditingController[1].text;
            addOrganDonModel.dob = textEditingController[2].text;
            addOrganDonModel.age = textEditingController[3].text;
            addOrganDonModel.bldGr = DonorApplication.bloodgroupModel.key;
            addOrganDonModel.mob = textEditingController[4].text;
            addOrganDonModel.email = textEditingController[5].text;
            addOrganDonModel.address = textEditingController[6].text;
            addOrganDonModel.witnessList = witnessModle;
            addOrganDonModel.organList = selectedOrganList;
            addOrganDonModel.tissueList = selectedTissueList;

            log("Post json>>>>" + jsonEncode(addOrganDonModel.toJson()));

            //AppData.showInSnackBar(context, "add Successfully");
            widget.model.POSTMETHOD1(
                api: ApiFactory.POST_ORGAN_DONOR,
                token: widget.model.token,
                json: addOrganDonModel.toJson(),
                fun: (Map<String, dynamic> map) {
                  Navigator.pop(context);
                  if (map[Const.STATUS] == Const.SUCCESS) {
                    popup(context, map[Const.MESSAGE]);
                  } else {
                    AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  }
                });
          }
        });
  }

  /* saveDb() {
    Map<String, dynamic> map = {
      //"regNo": loginRes.ashadtls[0].id,
      "patientId": widget.model.user,
      "donorName": textEditingController[0].text.toString(),
      "typeUserName": DoctorconsultationPage.timeModel.name*/ /*"23:10"*/ /**/ /*time*/ /*,
      "dob": DoctorconsultationPage.timeModel.code,//validitytime.text,
      "age": DoctorconsultationPage.doctorModel.key.toString(),
      "mob": textEditingController[1].text,
      "email": DoctorconsultationPage.hospitalModel.key,
      "address": DoctorconsultationPage.hospitalModel.key,
      "organList": DoctorconsultationPage.hospitalModel.key,
    };

    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_ORGAN_DONOR,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map[Const.STATUS] == Const.SUCCESS) {
            popup(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/

  //Navigator.pushNamed(context, "/navigation");
  /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

  //       Navigator.pushNamed(context, "/addWitness");
  //       //}
  //     },
  //   );
  // }
  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
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
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        // validate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
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
          const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
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
              child: DropdownButton<KeyvalueModel>(
                  underline: Container(
                    color: Colors.grey,
                  ),
                  value: _selectedItem,
                  items: _dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  }),
              /*DropdownButton<KeyvalueModel>(
                underline: Container(
                  color: Colors.grey,
                ),
                value: selectedUser,
                isDense: true,
                onChanged:(KeyvalueModel newValue) {
                  DonorApplication.genderModel=newValue;
                  setState(() {
                    selectedUser = newValue;
                    DonorApplication.genderModel=selectedUser;
                  });
                },
                items: UserType.map((KeyvalueModel value) {
                  return new DropdownMenuItem<KeyvalueModel>(
                    value: value,
                    child: new Text(
                      value.name,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),*/
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
                controller: textEditingController[1],
                /*  focusNode: fnode7,*/
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z. ]")),
                ],
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  counterText: "",
                  hintText: MyLocalizations.of(context).text("RELATION_OF"),
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
                  //AppData.fieldFocusChange(context, fnode7, fnode8);
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

  Widget witnmobileNumber() {
    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding:
          const EdgeInsets.only(top: 0.0, left: 10.0, right: 5.0, bottom: 0.0),
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
              child:
                  /*DropdownButton<KeyvalueModel>(
               items: UserType
                   .map((data) => DropdownMenuItem<KeyvalueModel>(
                 child: Text(data.name),
                 value: data,
               ))
                   .toList(),
               onChanged: (KeyvalueModel value) {
                 setState(() => selectedUser = value);
               },
              // hint: Text('Select Key'),
             ),*/
                  DropdownButton<KeyvalueModel>(
                // hint: Text("Select Device"),
                underline: Container(
                  color: Colors.grey,
                ),
                value: selectedUser1,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    selectedUser1 = newValue;
                  });
                  print(selectedUser1);
                },
                items: UserType1.map((KeyvalueModel value) {
                  return DropdownMenuItem<KeyvalueModel>(
                    value: value,
                    child: new Text(
                      value.name,
                      style: new TextStyle(color: Colors.black),
                    ),
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
                controller: textEditingController[8],
                // focusNode: fnode8,
                cursorColor: AppData.kPrimaryColor,
                textInputAction: TextInputAction.next,

                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  counterText: "",
                  hintText: "S/O,D/O,W/O",
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
                  //AppData.fieldFocusChange(context, fnode7, fnode8);
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
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () => widget.isConfirmPage ? null : _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
              // color: AppData.kPrimaryLightColor,
              // borderRadius: BorderRadius.circular(29),
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
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
              decoration: InputDecoration(
                hintText: MyLocalizations.of(context).text("DOB1"),
                //"Date of Birth",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey,
                ),
                /*prefixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AppData.kPrimaryColor,
                ),*/
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
        //validate();
      },
    );
  }

  Widget _applicationButton() {
    return MyWidgets.nextButton(
      text: "Application",
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        Navigator.pushNamed(context, "/donorApplication");

        //}
      },
    );
  }
}
