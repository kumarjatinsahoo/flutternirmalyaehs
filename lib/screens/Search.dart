import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/GenericStoresList.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  MainModel model;
  SearchScreen({Key key, this.model}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var selectedMinValue;
  List<KeyvalueModel> countryList = [
    KeyvalueModel(name: "India", key: "1"),
    // KeyvalueModel(name: "Bhubaneswar", key: "2"),
    // KeyvalueModel(name: "Puri", key: "3"),
  ];
  List<KeyvalueModel> stateList = [
    KeyvalueModel(name: "Odisha", key: "1"),
    KeyvalueModel(name: "UP", key: "2"),
    KeyvalueModel(name: "AP", key: "3"),
  ];
  List<KeyvalueModel> cityList = [
    KeyvalueModel(name: "Cuttack", key: "1"),
     KeyvalueModel(name: "Bhubaneswar", key: "2"),
    KeyvalueModel(name: "Puri", key: "3"),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
             appBar: AppBar(
          title: Text(
            'Search',
            style: TextStyle(color: Colors.white,),
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
           body: SingleChildScrollView(
             child: Container(
               child: Column(
                 children: [                   
                Padding(
                              padding: const EdgeInsets.only(left:20.0, right: 20.0,),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [    
                                  /*SizedBox(height: 10,),
                                   Text('', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),
                                    SizedBox(height: 10,),*/

                                  /*Text('Request your doctor to prescribe Generic Medicine.',
                                     overflow: TextOverflow.clip,
                                     style: TextStyle(fontWeight: FontWeight.w600,),),*/
                                     SizedBox(height: 30),
                                      DropDown.staticDropdown2(
                                  'Country',
                                  "country",
                                  countryList, (KeyvalueModel data) {
                                setState(() {
                                  
                                });
                              }),
                               SizedBox(height: 5,),
                                DropDown.staticDropdown2(
                                 "State",
                                  "state",
                                  stateList, (KeyvalueModel data) {
                                setState(() {
                                  
                                });
                              }),
                                 
                             SizedBox(height: 5,),
                                 DropDown.staticDropdown2(
                                  "District",
                                  "state",
                                  cityList, (KeyvalueModel data) {
                                setState(() {
                                  
                                });
                              }),
                                  SizedBox(height: 5,),
                                  DropDown.staticDropdown2(
                                      "City",
                                      "state",
                                      cityList, (KeyvalueModel data) {
                                    setState(() {

                                    });
                                  }),
                                  SizedBox(height: 60,),
                                  _submitButton(),
                                  SizedBox(height: 10,),
              
                                ],),
                            ),
                 ],
               ),
             ),
           ),
                      
                      
          )  
    );
  }

 /* Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        *//*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*//*
      
        Navigator.pushNamed(context, "genericstoreslist");
        //}
        
      },
    );
  }*/

  Widget _submitButton() {
  return MyWidgets.nextButton(
    text: "search".toUpperCase(),
    context: context,
    fun: () {
      //Navigator.pushNamed(context, "/navigation");
      /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

      Navigator.pushNamed(context, "/geneicstoreslist");
      //}

    },
  );
}

}