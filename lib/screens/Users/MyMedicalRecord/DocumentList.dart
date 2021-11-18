import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/DocumentListModel.dart'as document;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
class DocumentList extends StatefulWidget {
  final MainModel model;
  static KeyvalueModel admequipmentmodel = null;

  const DocumentList({Key key, this.model}) : super(key: key);

  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  LoginResponse1 loginResponse1;
  document.DocumentListModel documentListModel;
  bool isDataNoFound = false;
  String valueText = null;
  String selectDob;
  bool isdata = false;
  DateTime selectedDate = DateTime.now();
  final df = new DateFormat('dd/MM/yyyy');
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
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL(
        api: ApiFactory.GET_DOCUMENT_API,
       // token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                documentListModel = document.DocumentListModel.fromJson(map);
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
    double tileSize = 80;
    double spaceTab = 20;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          title: Text("Document List"),
      ),
      body:
      isdata == true
          ? CircularProgressIndicator(
        backgroundColor: AppData.matruColor,
      )
          : documentListModel == null || documentListModel == null
          ? Container(
        child: Center(
          child: Text(MyLocalizations.of(context).text("NO_DATA_FOUND"),
            style:
            TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ) : Container(
        child: SingleChildScrollView(
          child:
          (documentListModel != null)
              ? ListView.builder(
            itemCount: documentListModel.body.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              document.Body body = documentListModel.body[i];
              return    Card(
                elevation: 5,
                child: Container(
                    height: tileSize,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[300],
                        ),
                        borderRadius: BorderRadius.circular(
                            8)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Container(
                              color: AppData.kPrimaryBlueColor,
                              padding: EdgeInsets.all(3),
                              child: Image.asset(
                                "assets/images/Allergicimg.png",
                                height: 40,
                              )),
                          SizedBox(
                            width: spaceTab,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text("body.name",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            "assets/Forwordarrow.png",
                            height: 25,
                          )
                        ],
                      ),
                    )),
              );
            },
          ): Container(),
        ),
      ),
    );
  }


}
