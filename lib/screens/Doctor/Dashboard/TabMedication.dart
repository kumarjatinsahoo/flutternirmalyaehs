import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

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
                    itemCount: 2,
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
                                      "Paracetmol",
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
                                      "Tablet",
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
                                      "5 Days From 12-08-2021",
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
                                      "1",
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
                                      "1",
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
                                      "1",
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
                                      "Mr.Neraj Desai",
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
