import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/MadicationlistModel.dart';
import 'package:user/models/madicationlistModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';

class TabMedication extends StatefulWidget {
  MainModel model;


  @override
  State<StatefulWidget> createState() => _TabMedication();
}

class _TabMedication extends State<TabMedication> {
  final _titleController = TextEditingController();
  String _ratingController;
  final myController = TextEditingController();
  String eHealthCardno;
  MadicationlistModel medicationlistmodel=MadicationlistModel();
  bool isDataNotAvail = false;

  @override
  void initState() {
    super.initState();
    eHealthCardno=widget.model.patientseHealthCard;
    callMEDICATIONAPI(eHealthCardno);

  }
  callMEDICATIONAPI(String eHealthCardno) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.PERSONAL_DETAILS + eHealthCardno,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              medicationlistmodel = MadicationlistModel.fromJson(map);
            } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });

  }

  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
      appBar: AppBar(
        backgroundColor: Color(0xFF0F6CE1),
        centerTitle: true,
        title: Text('Medication '),
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(children: [
              SizedBox(height: 5),
              Center(
                child: Text(
                  "CURRENT MEDICINES",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: medicationlistmodel.body.length,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        Card(
                          color: Color(0xFFD2E4FC),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              side: BorderSide(width: 1, color: Color(0xFFD2E4FC))),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Name",
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      "   :   ",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      medicationlistmodel.body[index].medname,
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Type",
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      "   :   ",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      medicationlistmodel.body[index].medtype,
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Dosage",
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      "   :   ",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      medicationlistmodel.body[index].dosage,
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Morning",
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      "   :   ",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      medicationlistmodel.body[index].morning,
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Afternoon",
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      "   :   ",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      medicationlistmodel.body[index].afternoon,
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),

                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Evening",
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      "   :   ",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      medicationlistmodel.body[index].evening,
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),

                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Doctor",
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      "   :   ",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      medicationlistmodel.body[index].doctor,
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),

                              ],
                            ),
                          ),
                        );

                    },
                  ),
                ),
              ),

            ]),
          ),
        ),
      ),
    );
  }
}
