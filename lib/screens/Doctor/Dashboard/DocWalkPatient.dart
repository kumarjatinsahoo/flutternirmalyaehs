import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';

class DocWalkPatient extends StatefulWidget {
  MainModel model;

  DocWalkPatient({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalkPatient();
}

class _WalkPatient extends State<DocWalkPatient> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  String _ratingController;
  final myController = TextEditingController();
  final myControllerpass = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
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
        title: Text('Walk in Patient '),
      ),
      body: Container(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFFFEF7F8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                side: BorderSide(width: 1, color: Color(0xFFCF3564))),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                "Patient's eHealthCard No",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "   :   ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35),
                            child: TextField(
                              controller: myController,
                              maxLength: 16,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: ''),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            "Password",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          "  :  ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Expanded(
                          child: TextField(
                            controller: myControllerpass,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: ''),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //      SizedBox(height: 6),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            "Appointment",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          " : ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _ratingController,
                            items: ["Appointment", "Medication", "EMR"]
                                .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Text('Appointment'),
                            onChanged: (value) {
                              setState(() {
                                _ratingController = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Material(
                  elevation: 5,
                  color: const Color(0xFF0F6CE1),
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {
                      if (myController.text == "" ||
                          myController.text == null) {
                        AppData.showInSnackBar(context,
                            "Please enter patient's eHealthCard No");
                      } else if (myController.text.length <=
                          3) {
                        AppData.showInSnackBar(
                            context, "Please enter patient's eHealthCard No ");
                      } else {
                        widget.model.patientseHealthCard = myController.text;
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ShowEmr(model:widget.model)));
                      }
                    },
                    minWidth: 350,
                    height: 40.0,
                    child: Text(
                      "Show EMR",
                      style: TextStyle(
                          color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
