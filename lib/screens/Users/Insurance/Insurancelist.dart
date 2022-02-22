import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddUploadDocumentModel.dart';
import 'package:user/models/InsuranceModel.dart' as insurance;
import 'package:user/models/InsurancePostModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class InsuranceList extends StatefulWidget {
  MainModel model;

  InsuranceList({Key key, this.model}) : super(key: key);

  @override
  _InsuranceListState createState() => _InsuranceListState();
}

class _InsuranceListState extends State<InsuranceList> {
  var selectedMinValue;
  var dio = Dio();
  LoginResponse1 loginResponse1;
  String extension;
  String extension1;
  String extension2;
  String extension3;
  File selectFile;
  File selectFile1;
  File selectFile2;
  File selectFile3;
  insurance.InsuranceModel insuranceModel;
  AddUploadDocumentModel adduploaddocument = AddUploadDocumentModel();

  String profilePath = null,
      idproof = null,
      idproof1 = null,
      idproof2 = null,
      idproof3 = null,
      labReport = null,
      helathCheckup = null;
  DateTime selectedDate = DateTime.now();
  String selectDob;
  TextEditingController _startdate = TextEditingController();
  TextEditingController _enddate = TextEditingController();
  TextEditingController _premiumdate = TextEditingController();
  List<bool> error = [false, false, false, false, false, false];
  final df = new DateFormat('dd/MM/yyyy');

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
    new TextEditingController(),];
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
  FocusNode fnode14 = new FocusNode();

  bool isShown = true;
  bool isData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.INSURANCE_list + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                isData=false;
                insuranceModel = insurance.InsuranceModel.fromJson(map);
              });
            } else {
              setState(() {
                isData=false;
                // isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              backgroundColor: AppData.kPrimaryColor,
              title: Text(MyLocalizations.of(context).text("INSURANCE")),
              centerTitle: true,
              iconTheme: IconThemeData(color: AppData.white),
              actions: <Widget>[
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(20.00),
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context,"/addinsuranceForm");
                  }/* async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          dialogaddnomination(context),
                    );
                  },*/
                ),
              ]),
          body: isData == true
              ? Container(
              child:
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppData.matruColor,
                ),
              )
          ):
          (insuranceModel != null)
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: insuranceModel.body.length,
                      // itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        insurance.Body body = insuranceModel.body[i];
                        String insuranceid = body.key;
                        widget.model.insuranceid = insuranceid;
                        return InkWell(
                          onTap: () {
                            widget.model.insuranceid = body.key;
                            Navigator.pushNamed(context, "/insuranceDetalis");
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            shadowColor: Colors.grey,
                            elevation: 10,
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              child: Container(
                                  decoration: (i % 2 == 0)
                                      ? BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryRedColor,
                                                  width: 5)))
                                      : BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: AppData.kPrimaryColor,
                                                  width: 5))),
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
                                                body.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                body.code,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(MyLocalizations.of(context).text("PREMIUM_AMOUNT"),
                                                overflow: TextOverflow.clip,
                                                style:
                                                    TextStyle(color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //Icon(Icons.arrow_forward_ios, size: 30,color: Colors.black),
                                        Image.asset(
                                          "assets/forwardarrow.png",
                                          fit: BoxFit.fitWidth,
                                          /*width: 50,*/
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Container(
            child: Center(
                child: Image.asset("assets/NoRecordFound.png",
                  // height: 25,
                )
            ),
          ),
        ),
        (isShown)?Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black54,
          child: MaterialButton(
            onPressed: () {
              setState(() {
                isShown = false;
              });
            },
          ),
        ):Container(),
        Positioned(
            right: 22,
            top: 22,
            child: Visibility(
              visible: isShown,
              child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      isShown = false;
                    });
                  },
                  enableFeedback: false,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Visibility(
                      visible: isShown,
                      child: SafeArea(
                          child:
                          Image.asset("assets/images/indication.png")))),
            ))
      ],
    );
  }

  Widget dialogaddnomination(BuildContext context) {
    textEditingController[1].text = "";
    textEditingController[2].text = "";
    textEditingController[3].text = "";
    _startdate.text = "";
    textEditingController[5].text = "";
    _enddate.text = "";
    textEditingController[7].text = "";
    textEditingController[8].text = "";
    textEditingController[9].text = "";
    _premiumdate.text = "";
    textEditingController[11].text = "";
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialog) {

          return Container(

            width: MediaQuery.of(context).size.width * 0.86,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            MyLocalizations.of(context).text("ADD_INSURANCE"),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        formField(
                            1,
                            MyLocalizations.of(context)
                                .text("INSURANCE_COMPANY")),
                        SizedBox(
                          height: 8,
                        ),
                        formField(
                            2,
                            MyLocalizations.of(context)
                                .text("HEALTH_INSURANCE_TYPE")),
                        SizedBox(
                          height: 8,
                        ),
                        formField(
                            3, MyLocalizations.of(context).text("POLICY_NO")),
                        SizedBox(
                          height: 8,
                        ),
                        startdate(),
                        // formField(4,"Policy Start Date"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(
                            5,
                            MyLocalizations.of(context)
                                .text("TOTAL_INSURANCE_AMOUNT")),
                        SizedBox(
                          height: 8,
                        ),
                        premiumDate(),
                        //  formField(6,"Premium Due Date"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(7,
                            MyLocalizations.of(context).text("INSURANCE_TYPE")),
                        SizedBox(
                          height: 8,
                        ),
                        formField1(8,
                            MyLocalizations.of(context)
                                .text("THIRDPARTY_ADMINSTRATOR")),
                        SizedBox(
                          height: 8,
                        ),
                        formField(9,
                            MyLocalizations.of(context).text("PREMIUM_AMOUNT")),
                        SizedBox(
                          height: 8,
                        ),
                        policyendDate(),
                        //formField(10,"Policy End Date"),
                        SizedBox(
                          height: 8,
                        ),
                        formField(
                            11,
                            MyLocalizations.of(context)
                                .text("SUM_ASSURED_AMOUNT")),
                        SizedBox(
                          height: 16,
                        ),

                        formField1(12, "Document Name 1"),
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
                                      if (textEditingController[12].text == "" ||
                                          textEditingController[12].text == null) {
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
                            ?  formField1(13, "Document Name 2"):Container(),
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
                                      if (textEditingController[13].text == "" ||
                                          textEditingController[13].text == null) {
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
                            ? formField1(14,"Document Name 3"):Container(),
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
                                      if (textEditingController[14].text == "" ||
                                          textEditingController[14].text == null) {
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
                            ?formField1(15, "Document Name 4"):Container(),
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
                                      if (textEditingController[15].text == "" ||
                                          textEditingController[15].text == null) {
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
                      ],
                    ),
                  ),

                  // fromAddress(0, "Remark", TextInputAction.next,
                  //     TextInputType.text, "remark"),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            textEditingController[1].text = "";
            textEditingController[2].text = "";
            textEditingController[3].text = "";
            _startdate.text = "";
            textEditingController[5].text = "";
            _enddate.text = "";
            textEditingController[7].text = "";
            textEditingController[8].text = "";
            textEditingController[9].text = "";
            _premiumdate.text = "";
            textEditingController[11].text = "";

            // textEditingController[0].text = "";
          },
          child: Text(
            MyLocalizations.of(context).text("CANCEL"),
            style: TextStyle(color: AppData.kPrimaryRedColor),
          ),
        ),
        new FlatButton(
          child: Text(
            MyLocalizations.of(context).text("SAVE"),
            style: TextStyle(color: AppData.matruColor),
          ),
          onPressed: () {
            if (textEditingController[1].text == null ||
                textEditingController[1].text == "") {
              AppData.showInSnackBar(
                  context, "Please Enter Insurance Company Name ");
            } else if (textEditingController[2].text == null ||
                textEditingController[2].text == "") {
              AppData.showInSnackBar(
                  context, "Please Enter Health Insurance Type");
            } else if (textEditingController[3].text == null ||
                textEditingController[3].text == "") {
              AppData.showInSnackBar(context, "Please Enter Policy No ");
            } else if (_startdate.text == "" || _startdate.text == null) {
              AppData.showInSnackBar(context, "Please Enter Policy Start Date");
            } else if (textEditingController[5].text == "" ||
                textEditingController[5].text == null) {
              AppData.showInSnackBar(
                  context, "Please Enter Total Insurance Amount");
            } else if (_premiumdate.text == "" || _premiumdate.text == null) {
              AppData.showInSnackBar(context, "Please Enter Premium Due Date");
            } else if (textEditingController[7].text == "" ||
                textEditingController[7].text == null) {
              AppData.showInSnackBar(context, "Please Enter Insurance Type");
            } else if (textEditingController[8].text == "" ||
                textEditingController[8].text == null) {
              AppData.showInSnackBar(
                  context, "Please Enter Third Party Adminstrator");
            } else if (textEditingController[9].text == "" ||
                textEditingController[9].text == null) {
              AppData.showInSnackBar(context, "Please Enter Premium Amount");
            } else if (_enddate.text == "" || _enddate.text == null) {
              AppData.showInSnackBar(context, "Please Enter Policy End  Date");
            } else if (textEditingController[11].text == "" ||
                textEditingController[11].text == null) {
              AppData.showInSnackBar(
                  context, "Please Enter Sum Assured Amount");
            }else if (textEditingController[12].text == "" ||
    textEditingController[12].text == null) {
    AppData.showInSnackBar(context, "Please Enter Document name 1");
    }else if (textEditingController[12].text != "" &&
    idproof == null) {
    AppData.showInSnackBar(context, "Please Upload Document 1");
    }else if (textEditingController[13].text != "" &&
    idproof1 == null) {
    AppData.showInSnackBar(context, "Please Upload Document 2");
    }else if (textEditingController[14].text != "" &&
    idproof2 == null) {
    AppData.showInSnackBar(context, "Please Upload Document 3");

    }else if (textEditingController[15].text != "" &&
    idproof3 == null) {
    AppData.showInSnackBar(context, "Please Upload Document 4");

    /*} else {
    postMultiPart();*/
            } else {
              postMultiPart();
              /*MyWidgets.showLoading(context);
              InsurancePostModel insurancepostmodel = InsurancePostModel();
              insurancepostmodel.patientId = loginResponse1.body.user;
              insurancepostmodel.insCompany = textEditingController[1].text;
              insurancepostmodel.healthInsType = textEditingController[2].text;
              insurancepostmodel.policyNo = textEditingController[3].text;
              insurancepostmodel.policyStartDt = _startdate.text;
              insurancepostmodel.totalInsAmount = textEditingController[5].text;
              insurancepostmodel.premiumDueDt = _premiumdate.text;
              insurancepostmodel.insType = textEditingController[7].text;
              insurancepostmodel.thirdPartyAdm = textEditingController[8].text;
              insurancepostmodel.premiumAmount = textEditingController[9].text;
              insurancepostmodel.policyEndDt = _enddate.text;
              insurancepostmodel.sumAssuredAmt = textEditingController[11].text;
              print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" + insurancepostmodel.toJson().toString());
              widget.model.POSTMETHOD2(
                  api: ApiFactory.INSURANCE_POST,
                  json: insurancepostmodel.toJson(),
                  token: widget.model.token,
                  fun: (Map<String, dynamic> map) {
                    //  setState(() {
                    Navigator.pop(context);
                    String msg = map[Const.MESSAGE];
                    if (map[Const.CODE] == Const.SUCCESS) {
                      popup(msg, context);
                    } else {
                      // isDataNotAvail = true;
                      AppData.showInSnackBar(context, msg);
                    }
                  });
                 */
            }

            // Navigator.of(context).pop();
            // AllergicListList.nameModel.key="";
            // AllergicListList.typeModel.key="";
            // AllergicListList.severitylistModel.key="";
            // textEditingController[1].text="";
            // textEditingController[2].text="";
          },
        ),
      ],
    );
  }



  Future<FormData> FormData2() async {
    log("File extension is:::::>>>>>" + textEditingController[0].text + "," + textEditingController[1].text + "," + textEditingController[2].text + "," +  textEditingController[3].text);
    var formData = FormData();
    formData.fields..add(MapEntry('patientId',loginResponse1.body.user))..add(
        MapEntry(
          'insCompany',
          textEditingController[1].text,
        ))
      ..add(
        MapEntry(
          'healthInsType',
          textEditingController[2].text,
        ))..add(MapEntry(
      'policyNo',
      textEditingController[3].text,
    ))..add(MapEntry(
      'policyStartDt',
        _startdate.text,
    ))..add(MapEntry(
      'totalInsAmount',
      textEditingController[5].text,
    ))..add(MapEntry(
      'premiumDueDt',
      _premiumdate.text,
    ))..add(MapEntry(
      'insType',
      textEditingController[7].text,
    ))..add(MapEntry(
      'thirdPartyAdm',
      textEditingController[8].text,
    ))..add(MapEntry(
      'premiumAmount',
      textEditingController[9].text,
    ))..add(MapEntry(
      'policyEndDt',
        _enddate.text,
    ))..add(MapEntry(
      'sumAssuredAmt',
      textEditingController[11].text,

    ));
    if( textEditingController[12].text!=null) {
      formData.fields.add(MapEntry(
        'docName1',
        textEditingController[12].text,
      ));
    }
    if( textEditingController[13].text!=null) {
      formData.fields.add( MapEntry(
        'docName2',
        textEditingController[13].text,
      ));
    }
    if( textEditingController[14].text!=null) {
      formData.fields.add( MapEntry(
        'docName3',
        textEditingController[14].text,
      ));
    }
    if( textEditingController[14].text!=null) {
      formData.fields.add( MapEntry(
        'docName4',
        textEditingController[15].text,
      ));
    }
    if(extension!=null){
      formData.fields.add(MapEntry(
        'ext1',
        extension,
      ));
    }
    if(extension1!=null){
      formData.fields.add(MapEntry(
        'ext2',
        extension1,
      ));
    }
    if(extension2!=null){
      formData.fields.add(MapEntry(
        'ext3',
        extension2,
      ));}
    if(extension3!=null) {
      formData.fields.add(MapEntry(
        'ext4',
        extension3,
      ));
    }

    /*..add(MapEntry(
        'docName1',
        textEditingController[12].text,
      ))..add(MapEntry(
      'docName2',
      textEditingController[13].text,
    ))..add(MapEntry(
      'docName3',
      textEditingController[14].text,
    ))..add(MapEntry(
      'docName4',
      textEditingController[15].text,
    )) ..add(MapEntry(
      'ext1',
      extension,
    ))..add(MapEntry(
      'ext2',
      extension1,
    ))
      ..add(MapEntry(
        'ext3',
        extension2,
      ))
      ..add(MapEntry(
        'ext4',
        extension3,
      ));*/
    if(selectFile!=null) {
      formData.files.add(MapEntry(
        'img1',
        MultipartFile.fromFileSync(
          selectFile.path,
          filename: selectFile.path,
          //contentType: new MediaType('','')
        ),
      ));
    }
    if(selectFile1!=null) {
      formData.files.add(MapEntry(
        'img2',
        MultipartFile.fromFileSync(
          selectFile1.path,
          filename: selectFile1.path,
          //contentType: new MediaType('','')
        ),
      )); }
    if(selectFile2!=null) {
      formData.files.add(MapEntry(
        'img3',
        MultipartFile.fromFileSync(
          selectFile2.path,
          filename: selectFile2.path,
          //contentType: new MediaType('','')
        ),
      ));}
    if(selectFile3!=null) {
      formData.files.add(MapEntry(
        'img4',
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
        ApiFactory.INSURANCE_POST,
        options: Options(
          headers: {
            "Authorization": widget.model.token,
          },
        ),
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
      adduploaddocument.extension = extName;
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
      adduploaddocument.extension = extName;
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
        adduploaddocument.extension = extName;
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
  Widget formField(
    int index,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
          ],
        ),
      ),
    );
  }

  Widget formField1(
    int index,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }

  Widget policyendDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _endDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: _enddate,
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
                hintText: (MyLocalizations.of(context).text("POLICY_END_DATE")),
                hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
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
        ),
      ),
    );
  }

  Widget premiumDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _premiumDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: _premiumdate,
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
                hintText:
                    (MyLocalizations.of(context).text("PREMIUM_DUE_DATE")),
                hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
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
        ),
      ),
    );
  }

  Widget startdate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _startDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              controller: _startdate,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              onSaved: (value) {
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
                hintText:
                    (MyLocalizations.of(context).text("POLICY_START_DATE")),
                hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
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
        ),
      ),
    );
  }

  Future<Null> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate:
            DateTime.now()/*.add(new Duration(days: 5))*/); //18 years is 6570 days
   // if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        _startdate.value = TextEditingValue(text: df.format(picked));
        //addBioMedicalModel.bioMDate = df.format(picked);
      });
  }

  Future<Null> _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 6570))); //18 years is 6570 days
  //  if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        _enddate.value = TextEditingValue(text: df.format(picked));
        //addBioMedicalModel.bioMDate = df.format(picked);
      });
  }

  Future<Null> _premiumDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate:
            DateTime.now().add(new Duration(days: 6570))); //18 years is 6570 days
   /// if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        _premiumdate.value = TextEditingValue(text: df.format(picked));
        //addBioMedicalModel.bioMDate = df.format(picked);
      });
  }

  /*popup(String msg, BuildContext context) {
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
              callApi();
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }*/
}
