import 'dart:convert';
import 'dart:developer';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/InsuranceDetailsModel.dart' as insurancedetails;
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/OrganlistModel.dart' as organ;
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class Organlist extends StatefulWidget {
  MainModel model;

  Organlist({Key key, this.model}) : super(key: key);

  @override
  _OrganlistState createState() => _OrganlistState();
}

class _OrganlistState extends State<Organlist> {
  var selectedMinValue;
  String insuranceid;
  organ.OrganlistModel organlistModel;
  bool isdata = true;
  LoginResponse1 loginResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse = widget.model.loginResponse1;
    insuranceid = widget.model.insuranceid;
    callApi();
  }

  callApi() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.ORGAN_LIST + loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                organlistModel = organ.OrganlistModel.fromJson(map);
              });
            } else {
              setState(() {
                // isDataNoFound = true;
              });
              //AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          /* leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
              InkWell(
                onTap: () {
                  //_cropImage();
                },
                child: Center(
                  child: Text(MyLocalizations.of(context).text("ORGAN_LIST"),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              //Spacer(),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/organPriviewPage");
                    },
                    child: Text(MyLocalizations.of(context).text("PREVIEW"),style: TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
              /*Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/organcardPage");
                    },
                    child: Text("Card",style: TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),*/
              /*Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/idCard");
                  },
                  child: Text(
                    "ID CARD",
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),*/
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
              )
            ],
          ),
          backgroundColor: AppData.kPrimaryColor,
          //centerTitle: true,
          // iconTheme: IconThemeData(color: AppData.kPrimaryColor,),
        ),
        /*appBar: AppBar(
          backgroundColor: AppData.kPrimaryColor,
          title: Text("Organ List"),
          centerTitle: true,
        ),*/
        body: (organlistModel != null)
            ? Container(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Colors.blueGrey[50],
                            Colors.blue[50]
                          ])),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 5),
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Donor Name :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          organlistModel.body.donorName ??
                                              "N/A",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          organlistModel.body.donorType +
                                                  " :" ??
                                              "N/A",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          organlistModel.body.typeUserName ??
                                              "N/A",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Doneted Organ List : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: organlistModel
                                              .body.donatedOrganList.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 6 / 1.5,
                                                  mainAxisSpacing: 0,
                                                  crossAxisCount:
                                                      (orientation ==
                                                              Orientation
                                                                  .portrait)
                                                          ? 3
                                                          : 3),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      organlistModel
                                                              .body
                                                              .donatedOrganList[
                                                                  index]
                                                              .name ??
                                                          "N/A",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              )
            : Container());
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }
}
