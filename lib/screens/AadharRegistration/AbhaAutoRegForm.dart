import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/providers/text_field_container.dart';
import 'package:user/scoped-models/MainModel.dart';

class AbhaAutoRegForm extends StatefulWidget {
  final MainModel model;

  const AbhaAutoRegForm({Key key, this.model}) : super(key: key);

  @override
  _AbhaAutoRegFormState createState() => _AbhaAutoRegFormState();
}

class _AbhaAutoRegFormState extends State<AbhaAutoRegForm> {
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];

  //File pathUsr = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white24,
        child: Center(
          child: Text(
            "Close",
            style: TextStyle(fontSize: 16, color: Colors.blue,fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: Image.asset(
                      "assets/logo1.png",
                      fit: BoxFit.fitWidth,
                      //width: ,
                      height: 150.0,
                    ),
                  ),
                ),
              ),*/
              Container(
                  child: Image.asset("assets/congratulation.gif",fit: BoxFit.fill,)),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 83,
                  width: 83,
                  child: Stack(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /*
                      (pathUsr != null)
                          ? Material(
                        elevation: 5.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          radius: 40.0,
                         // backgroundImage: FileImage(pathUsr),
                        ),
                      ),
                          : (patientProfileModel?.body
                          ?.profileImage !=
                          null)
                          ?*/
                      Material(
                        elevation: 5.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          radius: 40.0,
                          child: Image.asset(
                            "assets/logo1.png",
                            fit: BoxFit.fitWidth,
                            //width: ,
                            height: 150.0,
                          ),
                          // backgroundImage: NetworkImage(
                          //     (patientProfileModel?.body
                          //         ?.profileImage !=
                          //         null)
                          //         ? patientProfileModel
                          //         ?.body?.profileImage
                          //         : AppData.defaultImgUrl),
                        ),
                      ), /*:Image.asset(
                        "assets/images/User5.png",
                      ),*/
                      /* Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            _settingModalBottomSheet(context);
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: AppData.kPrimaryColor,
                          ),
                        ),
                      )*/
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Suvam Nayak",
                    // patientProfileModel?.body?.fullName ?? "N/A",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "8953-64539274",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  //Icon(Icons.arrow_drop_down)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("First Name"),
                      subtitle: Text("First Name"),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("Middle Name"),
                      subtitle: Text("Middle Name"),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("Last Name"),
                      subtitle: Text("Last Name"),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("Date Of Birth"),
                      subtitle: Text("DOB"),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("Gender"),
                      subtitle: Text("Gender"),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("Aadhar No."),
                      subtitle: Text("Aadhar No."),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("Mobile No."),
                      subtitle: Text("Mobile No."),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("Country"),
                      subtitle: Text("Country"),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("State"),
                      subtitle: Text("State"),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("Dist"),
                      subtitle: Text("Dist"),
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      title: Text("City"),
                      subtitle: Text("City"),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
