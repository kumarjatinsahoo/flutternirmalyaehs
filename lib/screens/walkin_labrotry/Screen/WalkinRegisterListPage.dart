import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:user/localization/localizations.dart';

//import 'package:user/models/LoginResponse.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/PatientListModel.dart' as patientSuf;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class WalkinRegisterListPage extends StatefulWidget {
  MainModel model;

  WalkinRegisterListPage({Key key, this.model}) : super(key: key);

  @override
  _WalkinRegisterListPageState createState() => _WalkinRegisterListPageState();
}

class _WalkinRegisterListPageState extends State<WalkinRegisterListPage> {
  patientSuf.PatientListModel regDataModel;
  LoginResponse1 loginResponse;
  bool isdata = true;

  //ScrollController _scrollController = ScrollController();
  int currentMax = 1;
  String sector;

  @override
  void initState() {
    loginResponse = widget.model.loginResponse1;
    super.initState();
    // MyWidgets.loading(context);
    callApi();
    /* _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        callApi(++currentMax);
      }
    });*/
  }

  bool isDataNotFound = false;

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        token: widget.model.loginResponse1.body.token,
        api: ApiFactory.WALK_IN_REG_LIST + loginResponse.body.user,
        fun: (Map<String, dynamic> map) {
          setState(() {
            if (map[Const.STATUS] == Const.SUCCESS) {
              isdata = false;
              regDataModel = patientSuf.PatientListModel.fromJson(map);
            } else {
              isdata = false;
             // AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          children: [
            Text(MyLocalizations.of(context).text("BENEFICIARY_LIST"),
              style: TextStyle(color: Colors.white),
            ),
           //Spacer(),
            IconButton(
                icon: Icon(Icons.add_box_rounded),
                onPressed: () {
                  Navigator.pushNamed(context, "/patientRegistration")
                      .then((value) {
                    setState(() {
                      if (value != null) callApi();
                    });
                  });
                }),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),
      body:
      isdata == true
          ? Center(
            child: CircularProgressIndicator(
        //backgroundColor: AppData.matruColor,
      ),
          )
          : regDataModel == null || regDataModel == null
          ? Container(
        child: Center(
          child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
        ),
      ) :

      (regDataModel != null)
          ? ListView.builder(
              // controller: _scrollController,
              itemBuilder: (context, i) {
                patientSuf.Body patient = regDataModel.body[i];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      widget.model.model = patient;
                      Navigator.pushNamed(context, "/walkInProfile");
                    },
                    title: Text(
                      (i + 1).toString() + ". " + patient.fName + " ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          patient.mobile ?? "N/A",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          patient.stateName ??"N/A",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_right_outlined),
                  ),
                );
              },
              itemCount: regDataModel.body.length,
            )
          : (isDataNotFound)
              ? Container(
                  height: size.height - 100,
                  child: Center(
                    child: Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            )
                  ),
                )
              : MyWidgets.loading(context),
    );
  }
}
