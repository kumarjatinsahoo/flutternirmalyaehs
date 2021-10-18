import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/GooglePlaceSearchModell.dart';
import 'package:user/scoped-models/MainModel.dart';

class GovernmentSchemesList extends StatefulWidget {
  MainModel model;

  GovernmentSchemesList({Key key, this.model}) : super(key: key);

  @override
  _GovernmentSchemesListState createState() => _GovernmentSchemesListState();
}

class _GovernmentSchemesListState extends State<GovernmentSchemesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Government Schemes List"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/govetschem1");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/govetSchemes1.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/govetschem2");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/GovetSchemes2.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/govetschem3");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/GovetSchemes3.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/govetschem4");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/GovetSchemes4.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/govetschem5");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/Govetschemes5.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/govetschem6");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/GovetSchemes6.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/govetschem7");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/GovetSchemes7.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/govetschem8");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/GovetSchemes8.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
