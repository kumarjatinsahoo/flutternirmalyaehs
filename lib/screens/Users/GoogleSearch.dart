import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/GooglePlaceSearchModell.dart';
import 'package:user/models/LoginResponse1.dart' as session;
import 'package:user/models/PocReportModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleSearch extends StatefulWidget {
  MainModel model;

  GoogleSearch({Key key, this.model}) : super(key: key);

  @override
  _GoogleSearchState createState() => _GoogleSearchState();
}

class _GoogleSearchState extends State<GoogleSearch> {
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
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    loginResponse1=widget.model.loginResponse1;
    placeId =widget.model.placeId;
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
    print("VALUEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee>>" + ApiFactory.GOOGLE_SEARCH(
        place_id: /*placeId*/"ChIJ9UsgSdYJGToRiGHjtrS-JNc"));
        widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_SEARCH(
            place_id: /*placeId*/"ChIJ9UsgSdYJGToRiGHjtrS-JNc"),
        fun: (Map<String, dynamic> map) {
          print("Value is>>>>" + JsonEncoder().convert(map));
            setState(() {
              String msg = map[Const.MESSAGE];
              if (map[Const.STATUS1] == Const.RESULT_OK) {
                googlePlacesSearch = GooglePlacesSearchModel.fromJson(map);

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
  Widget build(BuildContext context,) {
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
        child:(googlePlacesSearch != null /*&&
            googlePlacesSearch.results != null*/
            /*googlePlacesSearch.results .length > 0*/)
            ? Column(
          children: <Widget>[
              Container(
                height: 300,
                child:
                WebView(
                  initialUrl:googlePlacesSearch.result.url,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
                //color: AppData.kPrimaryColor,
                width: double.infinity,
               /* decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"
                        ),
                        fit: BoxFit.cover
                    )
                ),*/
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("assets/images/testbackgroundimg2.jpg"), fit: BoxFit.cover)),
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20.0, top: 40.0,),
//                   child: Column(
//                     children: [
//                       /*Text(
//                          "Visit Summary",
//                         style:
//                         TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w600),
//                       ),*/
//                       SizedBox(
//                         height: size.height * 0.04,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: size.height * 0.07,
//                             width: size.width * 0.13,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage("assets/images/testbackgroundimg2.jpg"), fit: BoxFit.cover ,
//                                   )),
//                             /*decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(55),
//                                 border: Border.all(color: Colors.white, width: 0.5),
//                                 color: Colors.white),*/
//                            /* child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(55),
//                                 child: Image.asset(
//                                   'assets/images/user.png',
//                                   height: size.height * 0.07,
//                                   width: size.width * 0.13,
//                                   //fit: BoxFit.cover,
//                                 )),*/
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           /*Expanded(
//                             child: Text(
//                               loginResponse1.body.userName ?? "N/A",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   ),
//                             ),
//                           ),
// */
//                         ],
//                       ),
//                       SizedBox(height: 18,)
//                     ],
//                   ),
//                 ),
              ),
         /*Align(
          widthFactor: double.infinity,
          heightFactor: double.infinity,
          alignment: Alignment.bottomRight,*/
          //  Spacer(),
            Column(
          //verticalDirection: VerticalDirection.down,
        /* mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.end,*/
              children: [
                Container(

                  color: AppData.kPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only( top:10,bottom:10,left:15.0,right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(googlePlacesSearch.result.name,
                              //googlePlacesSearch.results[0].name,
                              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15,color: Colors.white),),
                            Text(/*googlePlacesSearch.results[0].name??"N/A"*/"",
                              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15,color: Colors.white),),
                          ],
                        ),
                        Text(googlePlacesSearch.result.rating.toString()+" Ratings",
                          style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15,color: Colors.white),),
                        Text(googlePlacesSearch.result.reviews.length.toString()+" Reviews ",
                          style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15,color: Colors.white),),
                      ],
                    ),
                  ),
                  width: double.infinity,
                  /*height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,*/
                ),

            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only( top:15.0,bottom:10.0,left:15.0,right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                            onTap: (){
                              //Navigator.pop(context);
                            },
                child: Container(
                    width: 24,
                    height: 24,
                  child: Image.asset('assets/images/phonegoogle.png',fit: BoxFit.cover))),
                           // child: Icon(Icons.phone_outlined,color: AppData.kPrimaryRedColor)),
                        SizedBox(height: 10,),
                        Text("Call",
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15,color: Colors.black),),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: (){
                             // Navigator.pop(context);
                            },
                          child: Container(
                              width: 24,
                              height: 24,
                              child: Image.asset('assets/images/directiongoogle.png',fit: BoxFit.cover))),
                        SizedBox(height: 10,),
                        Text("Direction",
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15,color: Colors.black),),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: (){
                              //Navigator.pop(context);
                            },
                          child: Container(
                              width: 24,
                              height: 24,
                            child: Image.asset('assets/images/sharegoogle.png',fit: BoxFit.cover))),
                        SizedBox(height: 10,),
                        Text("Share",
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15,color: Colors.black),),
                      ],
                    ),
              Column(
                      children: [
                        InkWell(
                            onTap: (){
                              //Navigator.pop(context);
                            },
                            child: Container(
                              width: 24,
                                height: 24,
                                child: Image.asset('assets/images/websitegoogle.png',fit: BoxFit.cover))),
                        SizedBox(height: 10,),
                        Text("Website",
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15,color: Colors.black),),
                      ],
                    ),

                  ],
                ),
              ),
              width: double.infinity,
              /*height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,*/
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only( left:15.0,right: 15.0),
                child: Column(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (){
                              //Navigator.pop(context);
                            },
                            child: Icon(Icons.location_on_rounded,color: AppData.kPrimaryRedColor)),
                        SizedBox(width:15),
                        Expanded(
                            child:Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(googlePlacesSearch.result.formattedAddress,
                            /*googlePlacesSearch.results[0].formattedAddress??"n/a",*/
                                    // "No 43,CF Block,Sector III,BidhannagarKolkata,"
                                    //     "West Bengal 700091,India",
                                    /*patient.formattedAddress*/
                                    style:TextStyle(fontSize: 15),
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              width: double.infinity,
              /*height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,*/
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only( left:15.0,right: 15.0),
                child: Column(
                  children: [
                    Row(

                      children: [
                        InkWell(
                            onTap: (){
                              //Navigator.pop(context);
                            }, child: Icon(Icons.access_time,color: AppData.kPrimaryRedColor)),
              SizedBox(width:15),
              Expanded(
                  child:Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount:googlePlacesSearch.result.openingHours.weekdayText.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      googlePlacesSearch.result.openingHours.weekdayText[index],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
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
                )
              ),
            ]),
                  ],
                ),
              ),
              // height: MediaQuery.of(context).size.height * 0.1,
              // width: MediaQuery.of(context).size.width,
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),

          ],
        ),


              ],
            ): MyWidgets.loading(context),
          )
    );
  }
}
