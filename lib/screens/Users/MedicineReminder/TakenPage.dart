import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/models/TakeMedModel.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class TakenPage extends StatefulWidget {
  MainModel model;
    TakenPage({Key key , this.model}) : super(key: key);

  @override
  _TakenPageState createState() => _TakenPageState();
}

class _TakenPageState extends State<TakenPage> {


  TakeMedModel takeMedModel;
  List<String> listMed=[];
  List<String> listId=[];
  List<bool> boolCheck=[];
  List<String> filterYes=[];
  List<String> filterNo=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    takeMedModel=widget.model.medicineData;
    listMed=takeMedModel.medName.split(",");
    listId=takeMedModel.id.split(",");
    boolCheck=new List<bool>.generate(listMed.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppData.kPrimaryColor,
      title: Text("Treatment Tracker"),
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 50,),
            Text("Have you taken these medicine ?",textAlign:TextAlign.center,
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
            Expanded(
              child: ListView.builder(
                itemBuilder: (c,i){
                  return CheckboxListTile(value: boolCheck[i], onChanged: (v){
                    setState(() {
                      boolCheck[i]=v;
                    });
                  },
                    title: Text(listMed[i],style: TextStyle(color: Colors.black,fontSize: 19),),);
                },
                itemCount: listMed.length,
              ),
            ),
            MyWidgets.nextButton(text: "Taken",context: context,fun: (){
              // log(listMed.join(","));

              filterYes=[];
              filterNo=[];
             /* boolCheck.forEach((element) {
                int index=boolCheck.indexOf(element);
                if(element){
                  filterYes.add(listId[index]);
                }else{
                  filterNo.add(listId[index]);
                }
              });*/
              for(int i=0;i<boolCheck.length;i++){
                bool val=boolCheck[i];
                if(val){
                  filterYes.add(listId[i]);
                }else{
                  filterNo.add(listId[i]);
                }
              }

              var postMap={
                "userId": widget.model.loginResponse1.body.user,
                "yesId": filterYes.join(","),
                "noId": filterNo.join(","),
                "dosageDate": "03-03-2022",
                "dosageTime": "12:57:00"
              };

              log("<<<<<<<<<>>>>>>>>>" +widget.model.token+"\n\n\n?????PostMap"+jsonEncode(postMap));
              MyWidgets.showLoading(context);
              widget.model.POSTMETHOD_TOKEN(
                  api: ApiFactory.POST_ADD_TRACKER,
                  json: postMap,
                  fun: (Map<String,dynamic> map){
                Navigator.pop(context);
                if(map["code"]=="success"){
                  Navigator.pop(context);
                  AppData.showInSnackDone(context, "Added Successfully");
                }else{
                  AppData.showInSnackBar(context, "Something went wrong");
                }
              }, token: widget.model.token);
              log(">>>>>>>>>"+jsonEncode(postMap));
            }),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
