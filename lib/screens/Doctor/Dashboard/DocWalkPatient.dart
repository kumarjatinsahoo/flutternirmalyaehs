import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';
import 'package:user/widgets/MyWidget.dart';

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
  LoginResponse1 loginResponse;

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
        height: 450,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 120,
                                child: Text(
                                  "UHID No",
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                controller: myController,
                                maxLength: 16,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                    border: InputBorder.none, hintText: ' '),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Center(
                        child: Text(
                          '- OR -',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 15,),
                      _scanButton(),
                      SizedBox(height: 10,),
                      Row(
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
                    ],
                  ),
                ),


                //      SizedBox(height: 6),
                Padding(
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
                SizedBox(height: 20),
                Material(
                  elevation: 5,
                  color: const Color(0xFF0F6CE1),
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {
                      if (myController.text == "" ||
                          myController.text == null) {
                        AppData.showInSnackBar(context,
                            "Please enter  UHID No");
                      } else if (myController.text.length != 16 ||
                          myController.text == null) {
                        AppData.showInSnackBar(context, "Please enter Valid UHID Number");
                      }

                      else {
                        widget.model.patientseHealthCard = myController.text;
                        Navigator.pushNamed(context, "/showemr");


                        /* Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ShowEmr(model:widget.model)));*/
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

  Widget _scanButton() {
    return MyWidgets.outlinedButton(
      text: "SCAN",
      context: context,
      fun: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/qrViewExample1");
      },
    );
  }
}
