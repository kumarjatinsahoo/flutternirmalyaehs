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

class VideosPage extends StatefulWidget {
  MainModel model;

  VideosPage({Key key, this.model}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  //LoginResponse1 loginResponse;

  List<MedipediaDTO> list = MedipediaData.list;
  List<String> urlList = [];
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
        /*title: Text(
          "Patient List",
          style: TextStyle(color: Colors.white),
        ),*/
        title: Text(MyLocalizations.of(context).text("VIDEOS"),
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
                  return InkWell(
                    onTap: () {
                      launchURL(list[i].informationUrl);
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset("assets/logo1.png",height: 40,),
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("eHealthSystem",style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xFF006CE2)),),
                                      //Text("5 days ago"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Image.network(
                                AppData.getYoutubeThumbnail(list[i].informationUrl),
                                fit: BoxFit.contain,
                                width: size.width,
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              list[i].nameOfData,
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(fontSize: 15,fontWeight: FontWeight.bold, fontFamily: "MonteMed"),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     children: [
                          //       Icon(Icons.visibility,color: Color(0xFF006CE2),size: 16,),
                          //       SizedBox(width: 5),
                          //       Text("250",style: TextStyle(fontSize: 12),),
                          //       SizedBox(width: 20),
                          //       Icon(Icons.thumb_up,color: Color(0xFF006CE2),size: 16),
                          //       SizedBox(width: 5),
                          //       Text("95",style: TextStyle(fontSize: 12),),
                          //       SizedBox(width: 20),
                          //       Icon(Icons.message,color: Color(0xFF006CE2),size: 16),
                          //       SizedBox(width: 5),
                          //       Text("45",style: TextStyle(fontSize: 12),),
                          //       SizedBox(width: 20),
                          //       Icon(Icons.share,color: Color(0xFF006CE2),size: 16),
                          //       SizedBox(width: 5),
                          //       Text("28",style: TextStyle(fontSize: 12),),
                          //     ],
                          //   ),
                          // ),
                          // Divider(),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Icon(Icons.thumb_up,color: Colors.red,size: 20,),
                          //     Icon(Icons.message,color: Colors.black,size: 20),
                          //     Icon(Icons.bookmark,color: Colors.black,size: 20),
                          //     Icon(Icons.share,color: Colors.black,size: 20),
                          //   ],
                          // ),SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (cnt, i) {
                  return Divider();
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length),
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
