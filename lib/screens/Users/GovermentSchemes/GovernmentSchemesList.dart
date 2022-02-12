import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/GovtSchemeListModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'GovtSchemes.dart';

class GovernmentSchemesList extends StatefulWidget {
  MainModel model;

  GovernmentSchemesList({Key key, this.model}) : super(key: key);

  @override
  _GovernmentSchemesListState createState() => _GovernmentSchemesListState();
}

class _GovernmentSchemesListState extends State<GovernmentSchemesList> {
  LoginResponse1 loginResponse1;

  //insurance.InsuranceModel insuranceModel;
  GovtSchemeListModel govetSchemeListModel;
  bool isDataNotFound=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.GOVET_SCHEMES_LIST(
                GovtSchemes.countryModel?.key??"",
                GovtSchemes.stateModel?.key??""
               /* GovtSchemes?.districtModel?.key??null,
                GovtSchemes?.cityModel?.key??null*/), /*+
            loginResponse1.body.user,*/
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                // govetschemelistModel = govetscheme.GovetSchemeListModel.fromJson(map);
                govetSchemeListModel = GovtSchemeListModel.fromJson(map);
              });
            } else {
              setState(() {
                isDataNotFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
        title: Text(MyLocalizations.of(context).text("GOVT_SCHEME_LIST")),
      ),
      body: Container(
        child: (govetSchemeListModel !=null && govetSchemeListModel?.body!= null && govetSchemeListModel?.body.isNotEmpty)
            ? ListView.builder(
                itemCount: govetSchemeListModel?.body?.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      widget.model.pdfurl = govetSchemeListModel.body[i].code;
                      Navigator.pushNamed(context, "/govermentSchemesDitelsPage");
                     //Navigator.pushNamed(context, "/govetschem1");
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(govetSchemeListModel?.body[i].name,
                          fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(govetSchemeListModel.body[i].key,
                                 //"Bal Thackeray Upgath Vima Yojana",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                )
            : Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [(isDataNotFound)?Image.asset("assets/NoRecordFound.png",
                                              // height: 25,
                                            ):CircularProgressIndicator()],
                ),
              ),
      ),
    );
  }
}
