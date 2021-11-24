import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/AddUploadDocumentModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/ImmunizationPostModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AddImmunization extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;
  static KeyvalueModel getdocumentmodel = null;
  static KeyvalueModel immunizationmodel = null;

  const AddImmunization({Key key, this.model}) : super(key: key);

  @override
  _AddImmunizationState createState() => _AddImmunizationState();
}

class _AddImmunizationState extends State<AddImmunization> {
  LoginResponse1 loginResponse1;
  bio.BiomedicalModel biomedicalModel;
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = false;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');
  String profilePath = null, idproof = null;
  File pathUsr1 = null;
  AddUploadDocumentModel adduploaddocument = AddUploadDocumentModel();
  String eHealthCardno;

  TextEditingController _date = TextEditingController();
  TextEditingController _reason = TextEditingController();
  TextEditingController _name = TextEditingController();

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
  String extension;
  File selectFile;
  var dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    eHealthCardno = widget.model.patientseHealthCard;

    //callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Add Immunization"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropDown.networkDropdownGetpartUser1("Immunization Type",
                      ApiFactory.IMMUNIZATION_API,
                      "immunization",
                      Icons.location_on_rounded,
                      23.0, (KeyvalueModel data) {
                        setState(() {
                          print(ApiFactory.IMMUNIZATION_API);
                          AddImmunization.immunizationmodel = data;
                        });
                      }),
                  SizedBox(height: 8),
                  dob(),
                  SizedBox(height: 8),
                  formField(1,"Prescribed By"),
                  SizedBox(height: 8),
                  formField(2,"Immunization Details"),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black12),
                                  color: AppData.kPrimaryColor),
                              child: RaisedButton(
                                onPressed: null,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                disabledColor: AppData.kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (AddImmunization.immunizationmodel == null ||
                                  AddImmunization.immunizationmodel == "") {
                                AppData.showInSnackBar(
                                    context, "Please Select Immunization Type ");
                              } else if (_date.text == "" || _date.text == null) {
                                AppData.showInSnackBar(context, "Please Enter Date");
                              } else if (textEditingController[1].text == "" ||
                                  textEditingController[1].text == null) {
                                AppData.showInSnackBar(
                                    context, "Please Enter Prescribed By");
                              } else if (textEditingController[2].text == "" ||
                                  textEditingController[2].text == null) {
                                AppData.showInSnackBar(
                                    context, "Please Enter Immunization Details ");
                              }  else {
                                MyWidgets.showLoading(context);
                                ImmunizationPostModel immunizationmodel = ImmunizationPostModel();
                                immunizationmodel.patientId = eHealthCardno;
                                immunizationmodel.immunizationId =
                                    AddImmunization.immunizationmodel.key;
                                immunizationmodel.immunizationDate = _date.text;
                                immunizationmodel.doctorName =
                                    textEditingController[1].text;
                                immunizationmodel.immunizationDetails =
                                    textEditingController[2].text;
                                immunizationmodel.status = "yes";
                                print(">>>>>>>>>>>>>>>>>>>>>>>>>>>" +
                                    immunizationmodel.toJson().toString());
                                widget.model.POSTMETHOD2(
                                  api: ApiFactory.ADD_IMMUNIZATION,
                                  json: immunizationmodel.toJson(),
                                  token: widget.model.token,
                                  fun: (Map<String, dynamic> map) {
                                    Navigator.pop(context);
                                      if (map["code"] == Const.SUCCESS) {
                                        Navigator.pop(context,true);
                                        AppData.showInSnackDone(
                                            context, map[Const.MESSAGE]);
                                      } else {
                                        AppData.showInSnackBar(context, map[Const.MESSAGE]);
                                      }
                                  },
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: AppData.kPrimaryColor),
                                  color: AppData.kPrimaryColor),
                              child: RaisedButton(
                                onPressed: null,
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                disabledColor: AppData.kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<FormData> FormData2() async {
    log("File extension is:::::>>>>>"+extension+","+textEditingController[1].text+","+AddImmunization.getdocumentmodel.key+","+loginResponse1.body.user);
    var formData = FormData();
    formData.fields
      ..add(MapEntry('userid', loginResponse1.body.user))
      ..add(MapEntry(
        'docType',
        AddImmunization.getdocumentmodel.key,
      ))
      ..add(MapEntry(
        'docName',
        textEditingController[1].text,
      ))
      ..add(MapEntry(
        'extension',
        extension,
      ));
    formData.files.add(MapEntry(
      'mulFile',
      MultipartFile.fromFileSync(
        selectFile.path,
        filename: selectFile.path,
        //contentType: new MediaType('','')
      ),
    ));

    return formData;
  }

  void postMultiPart() async {
    // view();
    MyWidgets.showLoading(context);
    //dio.options.headers["Content-Type"] = "multipart/form-data";
    //dio.options.baseUrl = 'https://eramps.in/';
    //dio.interceptors.add(LogInterceptor());
    Response response;
    response = await dio.post(
      ApiFactory.ADD_UPLOAD_DOCUMENT,
      data: await FormData2(),

      onSendProgress: (received, total) {
        if (total != -1) {
          setState(() {
            //popup(context);
            Navigator.pushNamed(context, "/uploaddocument");

            //Navigator.pop(context);
            //percentage = (received / total * 100).toStringAsFixed(0) + '%';
          });
          print((received / total * 100).toStringAsFixed(0) + '%');
        }
      },
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
      log("value" + jsonEncode(response.data));
      if (response.data["status"] == "success") {
        //Navigator.pushNamed(context, "/uploaddocument");

        // popup("Successfully Uploaded", context);
      } else {
        AppData.showInSnackBar(context, response.data["message"]);
      }
    }
    print(response);
  }
  Widget dob() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: TextFormField(
              focusNode: fnode3,
              // enabled: !widget.isConfirmPage ? false : true,
              controller: _date,
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
                hintText: (MyLocalizations.of(context).text("IMMUNIZATION_DATE")),
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 15,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate:
        DateTime.now().add(new Duration(days: 5))); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        error[2] = false;
        _date.value = TextEditingValue(text: df.format(picked));
        addBioMedicalModel.bioMDate = df.format(picked);
      });
  }


  Widget formField(
      int index,
      String hint,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
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
          // controller: _reason,
          controller:textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
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

    String _fileName = _path != null ? _path.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    if (file != null) {
      setState(() {
        selectFile = file;
        idproof = file.path;
        adduploaddocument.extension = extName;
        extension = extName;
        print("Message is: " +extension);        // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +extName);        // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }

  popup( BuildContext context) {
    return Alert(
        context: context,
        title: "Success",
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
            onPressed: (){
              //Navigator.pop(context, true);
              //Navigator.pop(context, true);
              Navigator.pushNamed(context, "/uploaddocument");

            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
}
