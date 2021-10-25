import 'package:flutter/cupertino.dart';
import 'package:user/models/ChemistsLocationwiseModel.dart';

import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart' as session;

class ChemistsPage extends StatefulWidget {
  MainModel model;

  ChemistsPage({Key key, this.model}) : super(key: key);

  @override
  _ChemistsPageState createState() => _ChemistsPageState();
}

class _ChemistsPageState extends State<ChemistsPage> {
  var selectedMinValue;
  ChemistsLocationWise chemistsLocationWise;
  bool isDataNotAvail = false;
  //ScrollController _scrollController = ScrollController();

  static const platform = AppData.channel;
  session.LoginResponse1 loginResponse1;
  String longi,lati,city,addr,healthpro,type,healthproname;

  bool isDataNoFound = false;


  @override
  void initState() {
    super.initState();
    loginResponse1=widget.model.loginResponse1;
    longi = widget.model.longi;
    lati = widget.model.lati;
    city = widget.model.city;
    addr = widget.model.addr;
    healthpro = widget.model.healthpro;
    healthproname = widget.model.healthproname;
    type=widget.model.type;

    callAPI();
  }
  callAPI() {
   // MyWidgets.showLoading(context);
      Map<String, dynamic> postData = {
        "longi": longi,
        "lati": lati,
        "addr": addr,
        "city": city,
        "healthpro": healthpro,
        "type": type
      };
      //
     // print("POST DATA>>>MEDTEL" + jsonEncode(postData).toString());
      widget.model.POSTMETHOD2(

        api: ApiFactory.FIND_HEALTH_PROVIDER1,
        token: widget.model.token,
        json: postData,
        fun: (Map<String, dynamic> map) {
          String msg = map[Const.MESSAGE];
          //String msg = map[Const.MESSAGE];
          if (map[Const.CODE] == Const.SUCCESS) {
          setState(() {
            //AppData.showInSnackBar(context, msg);
            chemistsLocationWise = ChemistsLocationWise.fromJson(map);
          });

            //foundUser = appointModel.body;
          } else {
            setState(() {
              isDataNoFound = true;
            });
            //isDataNotAvail = true;
            //AppData.showInSnackBar(context, msg);
          }
        },
      );
   /* widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.FIND_HEALTH_PROVIDER(longi,lati,addr,city,healthpro,type),
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              chemistsLocationWise = ChemistsLocationWise.fromJson(map);
              //foundUser = appointModel.body;
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });*/
  }
 /* callAPI() {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.FIND_HEALTH_PROVIDER(),
        fun: (Map<String, dynamic> map)  {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              chemistsLocationWise = ChemistsLocationWise.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }
*/
  @override
  Widget build(BuildContext context) {
    double tileSize = 100;
    double spaceTab = 20;
    double edgeInsets = 3;

    return Scaffold(
      body:
      (chemistsLocationWise!=null)?
      Container(
    child: Padding(
      padding: const EdgeInsets.all(13.0),
      child: SingleChildScrollView(
          child: Column(
            children: [

              (chemistsLocationWise != null)
                  ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // controller: _scrollController,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  if (i == chemistsLocationWise.body.length) {
                    return (chemistsLocationWise.body.length % 10 == 0)
                        ? CupertinoActivityIndicator()
                        : Container();
                  }
                  Body patient = chemistsLocationWise.body[i];
                  return Container(
                    child:GestureDetector(
                      // onTap: () =>   Navigator.pushNamed(context, "/immunizationlist"),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 5,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Container(
                             /* height: tileSize,
                              width: double.maxFinite,*/
                             /* if (position % 2 == 0) {  //  is even
                            convertView = LayoutInflater.from(getContext()).inflate(R.layout.even_layout, parent, false);

                        } else {    //  is odd
                    convertView = LayoutInflater.from(getContext()).inflate(R.layout.odd_layout, parent, false);
                    }*/
                              decoration:( i % 2 == 0)?BoxDecoration(
                                  border: Border(left: BorderSide(color: AppData.kPrimaryRedColor, width: 5))):BoxDecoration(
                                  border: Border(left: BorderSide(color: AppData.kPrimaryColor, width: 5))),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    (patient.image!= null)
                                        ? Material(
                                      elevation: 5.0,
                                      shape: CircleBorder(),
                                      child: CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: NetworkImage(
                                            (/*"https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png"*/patient.image)),
                                      ),
                                    )
                                        : SizedBox(
                                      height: 85,
                                      child: Image.asset(
                                        "assets/images/sanja.png",
                                      ),
                                    ),
                                   /* Image.asset(
                                      "assets/medicine_reminder.png",
                                      height: 40,
                                    ),*/
                                    SizedBox(
                                      width: spaceTab,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              patient.name ??"N/A",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                 /* "No 43,CF Block,Sector III,Bidhannagar\n"
                                                      "Kolkata,West Bengal 700091,India",*/
                                                  patient.address+  patient.pin??"N/A",
                                                  style: TextStyle(
                                                      fontSize: 13),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    //Image.asset("assets/Forwordarrow.png",height: 25,)
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: chemistsLocationWise.body.length,
              ): Container(),
            ],
          ),
      ),
    ),
      ): Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: (isDataNoFound) ? Text("Data Not Found"):callAPI(),


      ),

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

