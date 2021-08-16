import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/Doctor/Dashboard/show_emr.dart';

class MobileUpload extends StatefulWidget {
  MainModel model;

  MobileUpload({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MobileUpload();
}

class _MobileUpload extends State<MobileUpload> {
  FocusNode _descriptionFocus, _focusNode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue[400], Colors.blue[200]]),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(55),
                                child: Container(
                                    height: size.height * 0.12,
                                    width: size.width * 0.22,
                                    child: Image.asset(
                                        'assets/images/appointment.png',
                                        fit: BoxFit.cover))
                                // height: 95,

                                )),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Text(
                          "Ipsita Sahoo",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                      ],
                    ),
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
