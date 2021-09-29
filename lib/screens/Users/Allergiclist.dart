import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';

class AllergicListList extends StatefulWidget {
  MainModel model;
  AllergicListList({Key key, this.model}) : super(key: key);
  @override
  _AllergicListListState createState() => _AllergicListListState();
}

class _AllergicListListState extends State<AllergicListList> {
  var selectedMinValue;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppData.kPrimaryColor,
            title: Text( 'Allergic'),
            /* leading: Icon(
            Icons.menu,
          ),*/
            actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 26.0,
                    ),
                  )
              ),
              /*Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                      Icons.more_vert
                  ),
                )
            ),*/
            ],
          ),
      body: Container(
        child: Column(
          children: [

          /*  Container(
              color: AppData.kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppData.white,)),
                    Text(
                      'Insurance ',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: AppData.white),
                    ),
                    Icon(
                      Icons.search,color: AppData.white
                    ),
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
            ),*/
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            GestureDetector(
                              /*onTap: () => Navigator.pushNamed(
                                  context, "/insuranceDetalis"),*/
                              child:  Card(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        ),
                      shadowColor: Colors.grey,
                               elevation: 10,
                        child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: Container(
                      /*height: 100,*/
                      decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: AppData.matruColor, width: 5))),
                            width: double.maxFinite,
                                    /*  margin: const EdgeInsets.only(top: 6.0),*/
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width:100,
                                                      child: Text(
                                                        "Name",
                                                        style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Grains",
                                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                                    ),

                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width:100,
                                                      child: Text(

                                                        "Allergen",
                                                        style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                                                      ),
                                                    ),

                                                    Text(
                                                      "Alternaria",
                                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width:100,
                                                      child: Text(
                                                        "Severity",
                                                        style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Low",
                                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width:100,
                                                      child: Text(
                                                        "Updated by",
                                                        style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Dr.Aman",
                                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                      ],
                                    )),

                            ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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

        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }
}
