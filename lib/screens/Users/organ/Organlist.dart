import 'dart:convert';
import 'dart:developer';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/InsuranceDetailsModel.dart' as insurancedetails;
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/OrganlistModel.dart'as organ;
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
        api: ApiFactory.ORGAN_LIST +loginResponse.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            log("Value>>>" + jsonEncode(map));
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              setState(() {
                organlistModel =
                    organ.OrganlistModel.fromJson(map);
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
          backgroundColor: AppData.kPrimaryColor,
          title: Text("Organ List"),
          centerTitle: true,
        ),
        body:
        (organlistModel != null)? Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    //height: height * 0.30,
                    // color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          /*decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blueGrey[50],
                                Colors.blue[50]
                              ])),*/
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 5),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(
                                'Doner Name',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                organlistModel.body.donorName??"N/A",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0, // Underline thickness
                                    ),
                                  ),
                                ),
                              ),
                              ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Type User Name',
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          organlistModel.body.typeUserName??"N/A",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0, // Underline thickness
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                              SizedBox(height: 10,),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(
                                'Doner Type',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                organlistModel.body.donorType??"N/A",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0, // Underline thickness
                                    ),
                                  ),
                                ),
                              ),
                            ]),

                                /*  SizedBox(height: 10,),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Blood Group',
                                        style: TextStyle(
                                            color: Colors.black54, fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        organlistModel.body.bldGr??"N/A",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0, // Underline thickness
                                            ),
                                          ),
                                        ),
                                      ),
                                  ]),*/
                                  SizedBox(height: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Doneted Organ List : ',
                                        style: TextStyle(
                                            color: Colors.black54, fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: organlistModel.body.donatedOrganList.length,
                                        gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 6/1.5,
                                            mainAxisSpacing:0,
                                            crossAxisCount: (orientation ==
                                                Orientation.portrait) ?3: 3),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    organlistModel.body.donatedOrganList[index].name??"N/A",
                                                    style: TextStyle(
                                                        color: Colors.black,fontSize: 13),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ):Container()
    );
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
