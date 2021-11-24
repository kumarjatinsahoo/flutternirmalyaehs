import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LifeStyleHistryModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class LifeStylehistory extends StatefulWidget {
  MainModel model;

  LifeStylehistory({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LifeStylehistory();
}

class _LifeStylehistory extends State<LifeStylehistory> {
  FocusNode _descriptionFocus, _focusNode;
  String eHealthCardno;
  LifeStyleHistryModel lifeStyleHistryModel;
  @override
  void initState() {
    super.initState();
    _descriptionFocus = FocusNode();
    _focusNode = FocusNode();
    eHealthCardno = widget.model.patientseHealthCard;
    callAPI(eHealthCardno);
  }
  callAPI(String eHealthCardno ) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.IIFESTYLE_DETAIS + eHealthCardno ,
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              lifeStyleHistryModel = LifeStyleHistryModel.fromJson(map);

              //appointModel = lab.LabBookModel.fromJson(map);
            } else {
              // isDataNotAvail = true;
              AppData.showInSnackBar(context, "Data Not Found");
            }
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff3f4f4),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(children: [
              SizedBox(height: 5),
              Center(
                child: Text(
                  "LIFE STYLE HISTORY",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Smoking",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            "   :   ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            /*"Very Frequently 25/day"*/ (lifeStyleHistryModel?.body == null || lifeStyleHistryModel.body.smokingName.toString()=="")
                              ?"N/A": lifeStyleHistryModel.body.smokingName.toString(),
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
                              "Alcohol",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            "   :   ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            /*"Very Frequently"*/(lifeStyleHistryModel?.body == null|| lifeStyleHistryModel.body.alcoholName.toString()=="0")
                              ? "N/A":lifeStyleHistryModel.body.alcoholName.toString(),
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
                              "Diet",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            "   :   ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            /*"veg"*/(lifeStyleHistryModel?.body == null || lifeStyleHistryModel.body.diet.toString()=="0")
                              ?"N/A" :lifeStyleHistryModel.body.diet.toString() ,
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
                              "Exercise",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            "   :   ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            /*"Twice a Day"*/(lifeStyleHistryModel?.body == null || lifeStyleHistryModel?.body.exercise.toString()=="0")
                              ?"N/A": lifeStyleHistryModel.body.exercise.toString()+" times",
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
                              "Occupation",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            "   :   ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            /*"Software Developer",*/ (lifeStyleHistryModel?.body == null || lifeStyleHistryModel.body.occupation.toString()=="0")
                              ?"N/A" :lifeStyleHistryModel.body.occupation.toString(),

                style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                      /*SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Height",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            "   :   ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            ,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),*/
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Pets",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Text(
                            "   :   ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                              (lifeStyleHistryModel?.body == null || lifeStyleHistryModel?.body.pets.toString()=="0")
                                  ?"N/A": lifeStyleHistryModel.body.pets.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
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
