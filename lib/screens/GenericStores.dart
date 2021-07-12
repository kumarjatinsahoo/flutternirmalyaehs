import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/GenericStoresList.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class GenericStores extends StatefulWidget {
  MainModel model;
  GenericStores({Key key, this.model}) : super(key: key);
  @override
  _GenericStoresState createState() => _GenericStoresState();
}

class _GenericStoresState extends State<GenericStores> {
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
            'Generic Medical Stores',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
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
                                  SizedBox(height: 10,), 
                                   Text('Find Generic Medical Store', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),  
                                    SizedBox(height: 10,), 
                                     Text('Request your doctor to prescribe Generic Medicine.', 
                                     overflow: TextOverflow.clip,
                                     style: TextStyle(fontWeight: FontWeight.w600,),),
                                     SizedBox(height: 30),
                                      DropDown.staticDropdown2(
                                  'India',
                                  "country",
                                  countryList, (KeyvalueModel data) {
                                setState(() {
                                  
                                });
                              }),
                               SizedBox(height: 10,),
                                DropDown.staticDropdown2(
                                  MyLocalizations.of(context).text("SELECT_STATE"),
                                  "state",
                                  stateList, (KeyvalueModel data) {
                                setState(() {
                                  
                                });
                              }),
                                 
                             SizedBox(height: 10,),
                                 DropDown.staticDropdown2(
                                  MyLocalizations.of(context).text("SELECT_CITY"),
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
      
        Navigator.pushNamed(context, "/genericstoreslist");
        //}
        
      },
    );
  }

  
}