import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';

class EmergencyAccess extends StatefulWidget {

  MainModel model;

  EmergencyAccess({Key key, this.model}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _EmergencyAccess();
}

class _EmergencyAccess extends State<EmergencyAccess> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f4f4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF0F6CE1),
        title: Text('eHealthCardDoctor '),
      ),
      body: Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFFD2E4FC),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                ),
                side: BorderSide(width: 1, color: Color(0xFF2372B6))),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                              width: 100.0,
                              child: Text(
                                "eHealthCard No",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )),
                        ],
                      ),
                      Text(
                        " : ",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: ''),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                    width: 100,
                          child: Text(
                            "Doctor's Mobile No",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Text(
                          " : ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          " 91-8249514637 ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
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
                    onPressed: () async {},
                    minWidth: 350,
                    height: 40.0,
                    child: Text(
                      "Generate OTP",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
