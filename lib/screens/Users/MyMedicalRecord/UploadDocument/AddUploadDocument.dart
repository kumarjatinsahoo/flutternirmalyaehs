import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/AddUploadDocumentModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
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
  String doccategory, rolee;
  String uploadby="1";
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
  var childButtons = List<UnicornButton>();

  String selectedDocument;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    doccategory = widget.model.documentcategories;
    rolee = widget.model.uploadbyrole;
    AddUploadDocument.getdocumentmodel = null;
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Image",
        currentButton: FloatingActionButton(
          heroTag: "Image",
          backgroundColor: Colors.amber,
          mini: true,
          child: Icon(Icons.photo),
          onPressed: () {
            selectedDocument = "img";
            getCerificateImage();
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Document",
        currentButton: FloatingActionButton(
          heroTag: "/Document",
          backgroundColor: AppData.kPrimaryColor,
          mini: true,
          child: Icon(Icons.file_copy),
          onPressed: () {
            selectedDocument = "doc";
            getPdfAndUpload();
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Video",
        currentButton: FloatingActionButton(
          heroTag: "Video",
          backgroundColor: AppData.kPrimaryRedColor,
          mini: true,
          child: Icon(Icons.airplay),
          onPressed: () {
            selectedDocument = "vdo";
            getVideoUpload();
          },
        )));
    //callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        title: Text(MyLocalizations.of(context).text("UPLOAD_DOCUMENT")),
      ),
      /*floatingActionButton: UnicornDialer(
          childPadding: 4.00,
          backgroundColor: Colors.transparent,
          // parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons),*/
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*DropDown.networkDropdownGetpartUser1(
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
                  SizedBox(height: 10),*/
                  formField(
                      1, MyLocalizations.of(context).text("DOCUUMENT_NAME")),
                  SizedBox(height: 10),
                  dob(),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      getPdfAndUpload();
                    },
                    child: Text(
                      /*'Confirmed'*/
                      "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                  ),
                  //dob(),
                  //SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Column(
                          children: [
                            UnicornButton(
                                hasLabel: true,
                                labelText: "Image",
                                currentButton: FloatingActionButton(
                                  heroTag: "Image",
                                  backgroundColor: Colors.amber,
                                  mini: true,
                                  child: Icon(Icons.photo),
                                  onPressed: () {
                                    selectedDocument = "img";
                                    getCerificateImage();
                                  },
                                )),
                            Text(
                              /*'Confirmed'*/
                              "Imagse",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            UnicornButton(
                                hasLabel: true,
                                labelText: "Document",
                                currentButton: FloatingActionButton(
                                  heroTag: "/Document",
                                  backgroundColor: AppData.kPrimaryColor,
                                  mini: true,
                                  child: Icon(Icons.file_copy),
                                  onPressed: () {
                                    selectedDocument = "doc";
                                    getPdfAndUpload();
                                  },
                                )),
                            Text(
                              /*'Confirmed'*/
                              "Document",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            UnicornButton(
                                hasLabel: true,
                                labelText: "Video",
                                currentButton: FloatingActionButton(
                                  heroTag: "Video",
                                  backgroundColor: AppData.kPrimaryRedColor,
                                  mini: true,
                                  child: Icon(Icons.airplay),
                                  onPressed: () {
                                    selectedDocument = "vdo";
                                    getVideoUpload();
                                  },
                                )),
                            Text(
                              /*'Confirmed'*/
                              "Video",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
                  InkWell(
                    onTap: () {
                      if (textEditingController[1].text == "" ||
                          textEditingController[1].text == null) {
                        AppData.showInSnackBar(
                            context, "Please enter document name");
                      } else if (_date.text == "" || _date.text == null) {
                        AppData.showInSnackBar(
                            context, "Please enter document date");
                      } else if (idproof == "" || idproof == null) {
                        AppData.showInSnackBar(context,
                            "Please select  at least one image,video,document");
                      } else {
                        postMultiPart();
                      }
                    },
                    child: Container(
                      width: 370,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppData.kPrimaryColor),
                          color: AppData.kPrimaryColor),
                      child: RaisedButton(
                        onPressed: null,
                        child: Text(
                          MyLocalizations.of(context).text("UPLOAD"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        disabledColor: AppData.kPrimaryColor,
                      ),
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
    log("File extension is:::::>>>>>" +
        extension +
        "," +
        textEditingController[1].text +
        "," +
        doccategory +
        "," +uploadby+","+
        widget.model.patientseHealthCard);
    var formData = FormData();
    formData.fields
      ..add(MapEntry('userid',
          widget.model.patientseHealthCard))
      ..add(MapEntry(
        'docType',
        doccategory,
      ))
      ..add(MapEntry(
        'uploadedBy',
        uploadby,
      ))
      ..add(MapEntry(
        'docName',
        textEditingController[1].text,
      ))..add(MapEntry(
        'uploadDate',
        _date.text,
      ))
      ..add(MapEntry(
        'filetype',
        selectedDocument,
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
    MyWidgets.showLoading(context);
    try {
      Response response;
      response = await dio.post(
        ApiFactory.ADD_UPLOAD_DOCUMENT,
        data: await FormData2(),
        onSendProgress: (received, total) {
          if (total != -1) {
            setState(() {
              print((received / total * 100).toStringAsFixed(0) + '%');
            });
          }
        },
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        log("value" + jsonEncode(response.data));
        if (response.data["code"] == "success") {
          //Navigator.pushNamed(context, "/uploaddocument");

          popup(context,);
        } else {
          AppData.showInSnackBar(context, "Something went wrong");
        }
      } else {
        Navigator.pop(context);
        AppData.showInSnackBar(context, "Something went wrong");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        log(e.response.data);
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        log(e.response.data);
      }
      if (e.type == DioErrorType.DEFAULT) {
        log(e.response.data);
      }
      if (e.type == DioErrorType.RESPONSE) {
        log(e.response.data);
      }
    }
    //print(response);
  }

  formField(int index, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 11),
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
            //hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: textEditingController[index],
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z 0-9.-]")),
          ],
        ),
      ),
    );
  }

  Future getVideoUpload() async {
    var video = await ImagePicker.pickVideo(
      source: ImageSource.gallery,
    );
    var enc = await video.readAsBytes();
    String _path = video.path;

    String _fileName = _path != null ? _path.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print(extName);

    setState(() {
      selectFile = video;
      idproof = video.path;
      adduploaddocument.extension = extName;
      extension = extName;
      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
      if (104857600 < enc.length) {
        AppData.showInSnackBar(
          context,
          "Please select video with maximum size 100 MB ",
        );
        idproof = "";
        return;
      }
      print("Message is: " +
          extension); // adduploaddocument.mulFile=file.path as MultipartFile;
      print("Message isssss: " +
          extName); // adduploaddocument.mulFile=file.path as MultipartFile;
    });
  }

  Future getCerificateImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    var enc = await image.readAsBytes();
    String _path = image.path;

    String _fileName = _path != null ? _path.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print("EXT NAME?????>>>>>>>"+extName);

    setState(() {
      selectFile = image;
      idproof = image.path;
      adduploaddocument.extension = extName;
      extension = extName;
      print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
      if (104857600 < enc.length) {
        AppData.showInSnackBar(
          context,
          "Please select video with maximum size 100 MB ",
        );
        idproof = "";
        return;
      }
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
        'pdf'
      ], //here you can add any of extention what you need to pick
    );
    var enc = await file.readAsBytes();
    String _path = file.path+".pdf";
    log("Full path>>>>"+file.path);

    String _fileName = _path != null ? _path.split('/').last : '...';
    var pos = _fileName.lastIndexOf('.');
    String extName = (pos != -1) ? _fileName.substring(pos + 1) : _fileName;
    print("??????????EXT NAME"+extName);

    if (file != null) {
      setState(() {
        selectFile = file;
        idproof = file.path;
        adduploaddocument.extension = extName;
        extension = extName;
        print("size>>>" + AppData.formatBytes(enc.length, 0).toString());
        if (104857600 < enc.length) {
          AppData.showInSnackBar(
            context,
            "Please select video with maximum size 100 MB ",
          );
          idproof = "";
          return;
        }
        print("Message is: " +
            extension); // adduploaddocument.mulFile=file.path as MultipartFile;
        print("Message isssss: " +
            extName); // adduploaddocument.mulFile=file.path as MultipartFile;
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }

  popup(BuildContext context) {
    return Alert(
        context: context,
        title: "Successfully Uploaded",
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
                hintText: (MyLocalizations.of(context).text("DOCUUMENT_DATE")),
                //  hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
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
        lastDate: DateTime
            .now() /*.add(new Duration(days: 5))*/); //18 years is 6570 days
    // if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      error[2] = false;
      _date.value = TextEditingValue(text: df.format(picked));
      //addBioMedicalModel.bioMDate = df.format(picked);
    });
  }
}
