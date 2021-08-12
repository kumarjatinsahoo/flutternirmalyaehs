import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';

class DocAppointmentMangement extends StatefulWidget {

  MainModel model;

  DocAppointmentMangement({Key key, this.model}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Appointment();
}

class _Appointment extends State<DocAppointmentMangement> {
  FocusNode _descriptionFocus, _focusNode;
  final _titleController = TextEditingController();
  String _ratingController;
  int _radioSelected = 1;
  String _radioVal;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
      appBar: AppBar(
        backgroundColor:Color(0xFF0F6CE1),
        centerTitle: true,
        title: Text('Appointment '),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Today'),
                  Radio(
                    value: 1,
                    groupValue: _radioSelected,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        _radioSelected = value;
                        _radioVal = 'today';
                      });
                    },
                  ),
                  SizedBox(width: 10,),

Text("Mon,09\08\2021"),
                  SizedBox(width: 10,),
                  Text('Tomorrow'),
                  Radio(
                    value: 2,
                    groupValue: _radioSelected,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        _radioSelected = value;
                        _radioVal = 'tomorrow';
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
