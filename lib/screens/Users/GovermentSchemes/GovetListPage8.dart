
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';

class GovetListPage8 extends StatefulWidget {
  MainModel model;
  static KeyvalueModel labModel = null;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;

  GovetListPage8({Key key, this.model, this.isConfirmPage}) : super(key: key);

  @override
  _AboutUs createState() => _AboutUs();
}

List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _AboutUs extends State<GovetListPage8> {
  void initState() {
    // TODO: implement initState
    super.initState();
    GovetListPage8.labModel = null;
    setState(() {});
  }

  Widget showText(msg){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("- ",style: TextStyle(color: Colors.black, fontSize: 16),),Expanded(child: Text(msg,style: TextStyle(color: Colors.black, fontSize: 16),))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Schemes List'),
        backgroundColor: AppData.kPrimaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  "Urban Reproductive and Child Health Programme",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  "Objective: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Text(
                    AppData.govtschem8,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5),
                child: Text(
                  "Applicable to:  ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Text(
                    AppData.govtschem81,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5),
                child: Text(
                  "Benefits Provided: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5),
                child: Text(
                  AppData.govtschem82,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5),
                child: Text(
                  "Required Documents:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Text(
                    AppData.govtschem22,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5),
                child: Text(
                  "Contact Details:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Text(
                    AppData.govtschem83,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.justify,
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
