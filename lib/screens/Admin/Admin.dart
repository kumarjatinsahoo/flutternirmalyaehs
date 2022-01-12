import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/AddBioMedicalModel.dart';
import 'package:user/models/BiomedicalModel.dart' as bio;
import 'package:user/models/DocumentListModel.dart' as document;
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Admin/Form.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/AddUploadDocument.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/DocumentImageView.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/VideoDetailsPage.dart';
import 'package:user/widgets/PdfViewPage.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    eHealthCardno = widget.model.patientseHealthCard;
    //loginResponse1=widget.eHealthCardno;

    doccategory = widget.model.documentcategories;
    rolee = widget.model.uploadbyrole;
    /*callAPI(currentMax);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (documentListModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });*/
  }

  callAPI(int i) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.UPLOAD_DOCUMENT +
            widget.model.patientseHealthCard +
            "&typeid=" +
            doccategory +
            "&page=" +
            i.toString(),
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              if (i == 1) {
                documentListModel = document.DocumentListModel.fromJson(map);

                //Navigator.pop(context);
              } else {
                //documentListModel.addMore(map);
              }
            } else {
              //if (i == 1) AppData.showInSnackBar(context, msg);
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
                    callAPI(currentMax);
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
     /* isdata == true
          ? Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            CircularProgressIndicator(),
          ],
        ),
      )
      *//* Center(
                child: CircularProgressIndicator(),
              )*//*
          : documentListModel == null || documentListModel.body == null
          ? Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              Text(MyLocalizations.of(context).text("NO_DATA_FOUND"),
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      )
          :*/
      Container(
        child: SingleChildScrollView(
          child:
         // (documentListModel != null && documentListModel.body!=null) ?
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
             // document.Body body = documentListModel.body[i];
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
                                /* Text(body.docName ?? "N/A",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight:
                                            FontWeight.normal)),*/
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
                                /* Text(body.docType ?? "N/A",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight:
                                            FontWeight.normal)),*/
                              ],
                            ),
                             SizedBox(height: 10,),
                             Container(
                              // height:100,
                               child: InkWell(
                                 onTap: (){
                                   AppData.launchURL(
                                       "https://www.youtube.com/watch?v=O8lZfZ1CTyA");
                                 },
                                 child: Image.asset(

                                  "assets/intro/banner1.jpg",
                            ),
                               ),
                             ),
//child:NetworkImage("https://pixabay.com/photos/tree-sunset-clouds-sky-silhouette-736885/"),
                          ]),
                    ),
                  ),
                ),
              );
            },
            itemCount: 4,
          )
             // : Container(),
        ),
      ),
    );
  }
}
