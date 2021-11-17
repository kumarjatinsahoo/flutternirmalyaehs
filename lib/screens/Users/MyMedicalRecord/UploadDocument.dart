import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
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

class UploadDocument extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const UploadDocument({Key key, this.model}) : super(key: key);

  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  LoginResponse1 loginResponse1;
  bio.BiomedicalModel biomedicalModel;
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = false;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');
  String profilePath = null, idproof = null;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    //callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.BIOMEDICAL_IMPLANTS + loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                biomedicalModel = bio.BiomedicalModel.fromJson(map);
              });
            } else {
              setState(() {
                isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          title: Text("Upload Document"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/adduploaddocument");
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
          /*isdata == true
          ? CircularProgressIndicator(
              backgroundColor: AppData.matruColor,
            )
          : biomedicalModel == null || biomedicalModel == null
              ? Container(
                  child: Center(
                    child: Text(
                      MyLocalizations.of(context).text("NO_DATA_FOUND"),
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                )
              :*/
          Container(
        child: SingleChildScrollView(
            child: /*(biomedicalModel != null)
                        ? */
                ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            /* apnt.Body appointmentlist =
            appointmentlistModel.body[i];*/
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: size.width*0.20,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    side: BorderSide(width: 1, color: AppData.kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/images/govtschemes.jpg",
                              // width: size.width,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height*0.20,
                              width: double.maxFinite,
                            ),
                          ),
                          SizedBox(height: 15,),

                          Row(
                            children: [
                              Text("Document Name:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold)),
                              Text(" Name ",style: TextStyle(fontSize: 13,fontWeight:FontWeight.normal)),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text("View Upload",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                          SizedBox(height: 10,),



                        ]),
                  ),
                ),
              ),
            );
          },
          itemCount: 2,
        )
            //: Container(),
            ),
        /* ): Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: (isDataNoFound) ? Text("Data Not Found"):callApi(),
*/
      ),
    );
  }

  displayTextInputDialog(BuildContext context) {
    _date.text = "";
    _reason.text = "";
    showDialog(
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            insetPadding: EdgeInsets.only(left: 5, right: 5, top: 30),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Add Document",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // DropDown.networkDropdownGet(
                        //     "Name", ApiFactory.ADM_EQUIPMENT_API, "admequipment",
                        //     (KeyvalueModel model) {
                        //   setState(() {
                        //     print(ApiFactory.ADM_EQUIPMENT_API);
                        //     BiomediImplants.admequipmentmodel = model;
                        //   });
                        // }),

                        DropDown.networkDropdownGetpartUser1(
                            "Document Category",
                            ApiFactory.ADM_EQUIPMENT_API,
                            "typelist",
                            Icons.location_on_rounded,
                            23.0, (KeyvalueModel data) {
                          setState(() {
                            print(ApiFactory.ADM_EQUIPMENT_API);
                            UploadDocument.admequipmentmodel = data;
                          });
                        }),
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            getPdfAndUpload();
                          },
                          child: Material(
                            elevation: 5,
                            color: AppData.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              minWidth: 100,
                              height: 40.0,
                              child: Text(
                                /*'Confirmed'*/
                                "Upload Document",
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        //  formField(1,MyLocalizations.of(context).text("REASON")),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              SizedBox(
                height: 15,
              ),
              FlatButton(
                textColor: Colors.grey,
                child: Text(MyLocalizations.of(context).text("CANCEL"),
                    style: TextStyle(color: AppData.kPrimaryRedColor)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                //textColor: Colors.grey,
                child: Text(
                  "Upload",
                  //style: TextStyle(color: Colors.grey),
                  style: TextStyle(color: AppData.matruColor),
                ),
                onPressed: () {
                  if (UploadDocument.admequipmentmodel == null ||
                      UploadDocument.admequipmentmodel == "") {
                    AppData.showInSnackBar(
                        context, "Please select Document Category ");
                  } else if (idproof == "" || idproof == null) {
                    AppData.showInSnackBar(
                        context, "Please Upload daDocumentte");
                  } else {
                    MyWidgets.showLoading(context);
                    AddBioMedicalModel biomedicalModel = AddBioMedicalModel();
                    biomedicalModel.userid = loginResponse1.body.user;
                    biomedicalModel.bioMName =
                        UploadDocument.admequipmentmodel.key;
                    biomedicalModel.bioMReason = idproof.toString();

                    widget.model.POSTMETHOD2(
                      api: ApiFactory.ADD_BIOMEDICAL_IMPLANTS,
                      json: biomedicalModel.toJson(),
                      token: widget.model.token,
                      fun: (Map<String, dynamic> map) {
                        Navigator.pop(context);
                        setState(() {
                          if (map[Const.STATUS1] == Const.SUCCESS) {
                            Navigator.pop(context);
                            callApi();
                            AppData.showInSnackDone(
                                context, map[Const.MESSAGE]);
                          } else {
                            AppData.showInSnackBar(context, map[Const.MESSAGE]);
                          }
                        });
                      },
                    );
                  }
                },
              ),
            ],
          );
        },
        context: context);
  }

  Widget dob() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context),
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
                hintText: (MyLocalizations.of(context).text("DOB1")),
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
          controller: _reason,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }

  Future getPdfAndUpload() async {
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
        idproof = file.path;
        //userModel. = base64Encode(enc);
        //file1 = file; //file1 is a global variable which i created
      });
    }
  }
}
