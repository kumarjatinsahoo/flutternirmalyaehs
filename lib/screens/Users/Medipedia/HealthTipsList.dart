//import 'package:better_player/better_player.dart';

//import 'package:add_thumbnail/thumbnail_list_vew.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MedipediaDTO.dart';
import 'package:user/providers/MedipediaData.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class HealthTipsList extends StatefulWidget {
  MainModel model;

  HealthTipsList({Key key, this.model}) : super(key: key);

  @override
  _HealthTipsListState createState() => _HealthTipsListState();
}

class _HealthTipsListState extends State<HealthTipsList> {

  List<String> imageList = [
    "assets/health_tips/HealthTips1.jpeg",
    "assets/health_tips/HealthTips2.jpeg",
    "assets/health_tips/HealthTips3.jpeg",
    "assets/health_tips/HealthTips4.jpeg",
    "assets/health_tips/HealthTips5.jpeg",
    "assets/health_tips/HealthTips6.jpeg",
    "assets/health_tips/HealthTips7.jpeg",
    "assets/health_tips/HealthTips8.jpeg",
    "assets/health_tips/HealthTips9.jpeg",
    "assets/health_tips/HealthTips10.jpeg",
    "assets/health_tips/HealthTips11.jpeg",
    "assets/health_tips/HealthTips12.jpeg",
    "assets/health_tips/HealthTips13.jpeg",
    "assets/health_tips/HealthTips14.jpeg",
    "assets/health_tips/HealthTips15.jpeg",
    "assets/health_tips/HealthTips16.jpeg",
    /*"assets/health_tips/HealthTips17.jpeg",
    "assets/health_tips/HealthTips18.jpeg",
    "assets/health_tips/HealthTips19.jpeg",
    "assets/health_tips/HealthTips20.jpeg",
    "assets/health_tips/HealthTips21.jpeg",
    "assets/health_tips/HealthTips22.jpeg",
    "assets/health_tips/HealthTips23.jpeg",*/
  ];
  List dataSourceList;

  @override
  void initState() {
    //loginResponse = widget.model.loginResponse1;
    super.initState();
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).text("HEALTH_TIPS_LIST"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.matruColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
                itemBuilder: (cnt, i) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset("assets/logo1.png",height: 40,color: Color(0xFF006CE2),),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("eHealthSystem",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF006CE2),),),
                                    Text("5 days ago"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          imageList[i],
                          fit: BoxFit.contain,
                          width: size.width,
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.visibility,color: Color(0xFF006CE2),size: 16,),
                              SizedBox(width: 5),
                              Text("250",style: TextStyle(fontSize: 12),),
                              SizedBox(width: 20),
                              Icon(Icons.thumb_up,color: Color(0xFF006CE2),size: 16),
                              SizedBox(width: 5),
                              Text("95",style: TextStyle(fontSize: 12),),
                              SizedBox(width: 20),
                              Icon(Icons.message,color: Color(0xFF006CE2),size: 16),
                              SizedBox(width: 5),
                              Text("45",style: TextStyle(fontSize: 12),),
                              SizedBox(width: 20),
                              Icon(Icons.share,color: Color(0xFF006CE2),size: 16),
                              SizedBox(width: 5),
                              Text("28",style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.thumb_up,color: Colors.red,size: 20,),
                            Icon(Icons.message,color: Colors.black,size: 20),
                            Icon(Icons.bookmark,color: Colors.black,size: 20),
                            Icon(Icons.share,color: Colors.black,size: 20),
                          ],
                        ),SizedBox(height: 10,)
                      ],
                    ),
                  );
                },
                separatorBuilder: (cnt, i) {
                  return Divider();
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imageList.length),
            /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Image.network(
                  "https://ptrip.in/wp-content/uploads/2021/02/health-and-fitness.jpg"),
            )*/
          ],
        ),
      ),
    );
  }

  Widget _buildTile({String icon, String title, double size, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        height: 90.0,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                icon,
                height: 45,
                width: 45,
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Monte",
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
