import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/models/GooglePlaceSearchModell.dart';
import 'package:user/models/LoginResponse1.dart' as session;
import 'package:user/models/PocReportModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class GoogleSearchDetails extends StatefulWidget {
  MainModel model;

  GoogleSearchDetails({Key key, this.model}) : super(key: key);

  @override
  _GoogleSearchDetailsState createState() => _GoogleSearchDetailsState();
}

class _GoogleSearchDetailsState extends State<GoogleSearchDetails> {
  PocReportModel pocReportModel;
  bool isDataNotAvail = false;
  GooglePlacesSearchModel googlePlacesSearch;
  String placeId;

  //ScrollController _scrollController = ScrollController();
  Result result;

  //String reviews;
  int count = 0;
  List<Reviews> reviews;
  OpeningHours openingHours;
  static const platform = AppData.channel;
  session.LoginResponse1 loginResponse1;

  //Completer<WebViewController> _controller = Completer<WebViewController>();
  String phoneno;

  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    placeId = widget.model.placeId;
    callAPI();
  }

/*
  Future<void> callUrl(String data) async {
    try {
      final int result = await platform.invokeMethod('callUrl', data);
    } on PlatformException catch (e) {}
  }*/

  /* callAPI() {
    widget.model.GETMETHODCALL_TOKEN_FORM(
        api: ApiFactory.TEST_REPORT_USER,
        userId: loginResponse1.body.user,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              pocReportModel = PocReportModel.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }*/
  callAPI() {
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_SEARCH(
            place_id: placeId /*"ChIJ9UsgSdYJGToRiGHjtrS-JNc"*/),
        fun: (Map<String, dynamic> map) {
          print("Value is>>>>" + JsonEncoder().convert(map));
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.STATUS1] == Const.RESULT_OK) {
              googlePlacesSearch = GooglePlacesSearchModel.fromJson(map);
              log(">>>>>>>GGGGG<<<<<<<" + jsonEncode(map));
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }

            /* } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, "Google api doesn't work");
            }*/
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Search",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          titleSpacing: 5,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppData.kPrimaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: (googlePlacesSearch != null /*&&
            googlePlacesSearch.results != null*/
              /*googlePlacesSearch.results .length > 0*/)
              ? Column(
                  children: <Widget>[
                    /*Container(
                height: 400,
               // child:
                // WebView(
                //   initialUrl:googlePlacesSearch.result.url,
                //   onWebViewCreated: (WebViewController webViewController) {
                //     _controller.complete(webViewController);
                //   },
                // ),
                //color: AppData.kPrimaryColor,
               // width: double.infinity,
               */ /* decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"
                        ),
                        fit: BoxFit.cover
                    )
                ),*/ /*
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("assets/images/testbackgroundimg2.jpg"), fit: BoxFit.cover)),
                child: Container(

                  child: WebView(
                    initialUrl: googlePlacesSearch.result.url.trim(),
                    javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        webViewController.evaluateJavascript('alert("hello")');
                      }
                  ),
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/images/testbackgroundimg2.jpg"), fit: BoxFit.cover ,
                  //       )),
                  */ /*decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(55),
                      border: Border.all(color: Colors.white, width: 0.5),
                      color: Colors.white),*/ /*
                 */ /* child: ClipRRect(
                      borderRadius: BorderRadius.circular(55),
                      child: Image.asset(
                        'assets/images/user.png',
                        height: size.height * 0.07,
                        width: size.width * 0.13,
                        //fit: BoxFit.cover,
                      )),*/ /*
                ),
              ),*/
                    Container(
                      height: 270,
                      child: Image.network(
                        ApiFactory.GOOGLE_MAP_IMG(
                            lat: googlePlacesSearch.result.geometry.location.lat
                                .toString(),
                            long: googlePlacesSearch
                                .result.geometry.location.lng
                                .toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          color: AppData.kPrimaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 15.0, right: 15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          googlePlacesSearch.result.name,
                                          //googlePlacesSearch.results[0].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        /*googlePlacesSearch.results[0].name??"N/A"*/
                                        "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    (googlePlacesSearch?.result?.rating
                                                .toString() ==
                                            "null")
                                        ? "0" + " Ratings"
                                        : googlePlacesSearch?.result?.rating
                                                .toString() +
                                            " Ratings",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    (googlePlacesSearch?.result?.reviews?.length
                                                .toString() ==
                                            "null")
                                        ? "0".toString() + " Reviews "
                                        : googlePlacesSearch
                                                ?.result?.reviews?.length
                                                .toString() +
                                            " Reviews",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          width: double.infinity,
                          /*height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,*/
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, bottom: 10.0, left: 10.0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (googlePlacesSearch
                                            ?.result?.formattedPhoneNumber !=
                                        null)
                                    ? Expanded(
                                        child: InkWell(
                                          child: Container(
                                            width: 100,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: 25,
                                                    height: 25,
                                                    child: Image.asset(
                                                        'assets/images/googlecall.png',
                                                        fit: BoxFit.cover,
                                                        color: Color(0xFFCF3564)
                                                    )),
                                                // child: Icon(Icons.phone_outlined,color: AppData.kPrimaryRedColor)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Call",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Color(0xFFCF3564),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            //Navigator.pop(context);
                                            /*phoneno = googlePlacesSearch
                                          .result.formattedPhoneNumber;
                                      _makingPhoneCall();*/
                                            AppData.launchURL("tel://" +
                                                googlePlacesSearch.result
                                                    .formattedPhoneNumber);
                                          },
                                        ),
                                      )
                                    : Container(),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      log("Value>>>" +
                                          googlePlacesSearch.result.url);
                                      AppData.launchURL(
                                          googlePlacesSearch.result.url);
                                    },
                                    child: Container(
                                      width: 100,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 25,
                                              height: 25,
                                              child: Image.asset(
                                                  'assets/images/googledirection.png',
                                                  fit: BoxFit.cover,
                                                  color: Color(0xFF2372B6)
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Direction",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFF2372B6)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                       Share.share("Here is the location details\n\n"+googlePlacesSearch.result.url,);
                                    },
                                    child: Container(
                                      width: 100,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 25,
                                              height: 25,
                                              child: Image.asset(
                                                  'assets/images/share.png',
                                                  fit: BoxFit.cover,
                                              color:Color(0xFFCF3564)
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Share",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFFCF3564)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                (googlePlacesSearch?.result?.website != null)
                                    ? Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            AppData.launchURL(googlePlacesSearch
                                                .result.website);
                                          },
                                          child: Container(
                                            width: 100,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: 25,
                                                    height: 25,
                                                    child: Image.asset(
                                                        'assets/images/googlewebsite.png',
                                                        fit: BoxFit.cover,
                                                        color: Color(0xFF2372B6)

                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Website",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Color(0xFF2372B6)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          // width: double.infinity,
                          /*height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,*/
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.black,
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0,bottom: 10,top: 10),
                            child: Column(
                              children: [
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          //Navigator.pop(context);
                                        },
                                        child: Icon(Icons.location_on_rounded,
                                            color: AppData.kPrimaryRedColor)),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            googlePlacesSearch
                                                .result.formattedAddress,
                                            /*googlePlacesSearch.results[0].formattedAddress??"n/a",*/
                                            // "No 43,CF Block,Sector III,BidhannagarKolkata,"
                                            //     "West Bengal 700091,India",
                                            /*patient.formattedAddress*/
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          width: double.infinity,
                        ),
                        (googlePlacesSearch?.result?.openingHours?.weekdayText
                                    ?.length !=
                                null)
                            ? Column(
                                children: [
                                  Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                    height: 1,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                              children: [
                                            InkWell(
                                                onTap: () {
                                                  //Navigator.pop(context);
                                                },
                                                child: Container(
                                                    child: Column(
                                                  children: [
                                                    Icon(Icons.access_time,
                                                        color: AppData
                                                            .kPrimaryRedColor),
                                                    SizedBox(
                                                      height: 200,
                                                    )
                                                  ],
                                                ))),
                                            SizedBox(width: 5),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: googlePlacesSearch
                                                          ?.result
                                                          ?.openingHours
                                                          ?.weekdayText
                                                          ?.length ??
                                                      0,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  googlePlacesSearch
                                                                      .result
                                                                      .openingHours
                                                                      .weekdayText[index],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            )),
                                          ]),
                                        ],
                                      ),
                                    ),
                                    // height: MediaQuery.of(context).size.height * 0.1,
                                    // width: MediaQuery.of(context).size.width,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ],
                )
              : MyWidgets.loading(context),
        ));
  }

  _makingPhoneCall() async {
    phoneno = googlePlacesSearch.result.formattedPhoneNumber;
    if (await canLaunch(phoneno)) {
      await launch(phoneno);
    } else {
      throw 'Could not launch $phoneno';
    }
  }
}
