import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/AddUploadDocumentModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
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

class AddUploadDocument extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;
  static KeyvalueModel getdocumentmodel = null;

  const AddUploadDocument({Key key, this.model}) : super(key: key);

  @override
  _AddUploadDocumentState createState() => _AddUploadDocumentState();
}

class _AddUploadDocumentState extends State<AddUploadDocument> {
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
    //callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        title: Text("Upload Document"),
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
                  DropDown.networkDropdownGetpartUser1(
                      "Document Category",
                      ApiFactory.GET_DOCUMENT_API,
                      "documentlist",
                      Icons.location_on_rounded,
                      23.0, (KeyvalueModel data) {
                    setState(() {
                      print(ApiFactory.GET_DOCUMENT_API);
                      AddUploadDocument.getdocumentmodel = data;
                    });
                  }),
                  SizedBox(height: 10),
                  formField(1, "Document Name"),
                  SizedBox(height: 15),

                  InkWell(
                    onTap: () {
                      getPdfAndUpload();
                    },
                    child: Material(
                      elevation: 5,
                      color: AppData.kPrimaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        minWidth: 150,
                        height: 40.0,
                        child: Text(
                          /*'Confirmed'*/
                          "Click Upload Document",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //dob(),
                  SizedBox(height: 8),
                  (idproof != null)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    width: 50.0, child: Icon(Icons.clear)),
                                onTap: () {
                                  setState(() {
                                    idproof = null;
                                    // registrationModel.profilePhotoBase64 =
                                    null;
                                    //registrationModel.profilePhotoExt =
                                    null;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
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
                            if (AddUploadDocument.getdocumentmodel == null ||
                                AddUploadDocument.getdocumentmodel == "") {
                              AppData.showInSnackBar(
                                  context, "Please select Document Category ");
                            } else if (textEditingController[1].text == "" ||
                                textEditingController[1].text == null) {
                              AppData.showInSnackBar(
                                  context, "Please Enter Document Name");
                            } else if (idproof == "" || idproof == null) {
                              AppData.showInSnackBar(
                                  context, "Please Upload Document");
                            } else {
                              postMultiPart();
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
                                'Upload',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<FormData> FormData2() async {
    log("File extension is:::::>>>>>"+extension+","+textEditingController[1].text+","+AddUploadDocument.getdocumentmodel.key+","+loginResponse1.body.user);
    var formData = FormData();
    formData.fields
      ..add(MapEntry('userid', loginResponse1.body.user))
      ..add(MapEntry(
        'docType',
        AddUploadDocument.getdocumentmodel.key,
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

  formField(int index, String hint) {
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
}
