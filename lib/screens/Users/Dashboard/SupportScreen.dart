import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/map_launcher.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import '../../../providers/app_data.dart';

class SupportScreen extends StatefulWidget {
  MainModel model;

  SupportScreen({Key key, this.model}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  

  getGender(String gender) {
    switch (gender) {
      case "0":
        return "Male";
        break;
      case "1":
        return "Female";
        break;
      case "3":
        return "Transgender";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        //extendBody: true,
        appBar: AppBar(
          title: const Text('Support'),
          centerTitle: true,
          backgroundColor:  AppData.kPrimaryColor,
        ),
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.blueGrey,
                    child: Image.asset(
                      "assets/supportbanner.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Divider(
                    thickness: 3,
                    color: AppData.kPrimaryColor,
                  ),
                  //Icon(Icons.mobile_friendly),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: <Widget>[
                      buildTile(
                          name: "Contact Number".toUpperCase(),
                          value: " 20 2565 6552",
                          /*value1: "011-41182138",*/
                          fun: () {
                            AppData.launchURL("tel:+2025656552");
                          },
                          icon: CupertinoIcons.phone_fill),
                      SizedBox(
                        height: 5,
                      ),
                      buildTile(
                          name: "Address".toUpperCase(),
                          value: AppData.address,
                          fun: () {
                            MapsLauncher.launchQuery(
                                '1073, Bhosale Mystiqa,Gokhale,Road Model Colony,Pune - 411016, (MH) INDIA');
                          },
                          icon: Icons.location_on_rounded),
                      SizedBox(
                        height: 5,
                      ),
                      buildTile(
                          name: "Office hour".toUpperCase(),
                          value: "10.00AM to 7.00PM",

                          icon: Icons.timelapse_outlined),
                      SizedBox(
                        height: 5,
                      ),
                      /*buildTile(
                              name: "Chat with us".toUpperCase(),
                              //value: "9.00AM to 10.00PM",
                              fun: (){
                                AppData.showInSnackDone(context, "Comming soon");
                              },
                              icon: Icons.chat),
*/
                      //Text("Follow us",style: Text,),
                      MyWidgets.subHeader("Follow us", Alignment.center),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*IconButton(
                          icon: Image.asset(
                            "assets/fb_logo.png",
                            height: 120,
                            width: 120,
                          ),
                          iconSize: ,
                          onPressed: () {}),*/
                      InkWell(
                        onTap: () {
                          AppData.launchURL(
                              "https://www.facebook.com/eHealthSystemTechnologies");
                        },
                        child: Image.asset(
                          "assets/fb_logo.png",
                          height: 40,
                          width: 40,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          AppData.launchURL(
                              "https://twitter.com/ehealth_system");
                        },
                        child: Image.asset(
                          "assets/logo-rond-twitter.png",
                          height: 40,
                          width: 40,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  Widget buildTile(
      {String name, String value, String value1, IconData icon, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Column(
        children: [
          RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              icon,
              size: 35.0,
              color: AppData.matruColor,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            name,
            style: TextStyle(fontFamily: "MonteMed"),
          ),
          (value != null)
              ? SizedBox(
            height: 3,
          )
              : Container(),
          (value != null) ? Text(value) : Container(),
          (value1 != null)
              ? SizedBox(
            height: 3,
          )
              : Container(),
          (value1 != null) ? Text(value1) : Container(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
