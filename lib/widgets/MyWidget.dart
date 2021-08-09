import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/app_data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'avatar.dart';

class MyWidgets {
  static Widget rowNames(String name, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Row(
        children: <Widget>[
          Expanded(flex: 6, child: Text(name)),
          Expanded(flex: 1, child: Text(":")),
          Expanded(flex: 5, child: Text(value))
        ],
      ),
    );
  }
  static Widget toggleButton(name, fun) {
    return InkWell(
      onTap: fun,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 2, 9, 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              Text(
                "+",
                style: TextStyle(fontSize: 17, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget toggleButton1(name, fun) {
    return InkWell(
      onTap: fun,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 2, 9, 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
  static Widget search(fun) {
    return Container(
      height: 47.0,
      color: AppData.kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 7.0),
        child: InkWell(
          onTap: fun,
          /*onLongPress: () {
                      Navigator.pushNamed(context, "/offer");
                    },*/
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0))),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white38,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Search here for services",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget searchHint(fun, String hint) {
    return Container(
      height: 47.0,
      color: AppData.kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 7.0),
        child: InkWell(
          onTap: fun,
          /*onLongPress: () {
                      Navigator.pushNamed(context, "/offer");
                    },*/
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0))),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white38,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  hint,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      titleSpacing: 0,
      title: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 5.0,
          ),
          InkWell(
            onTap: () {
              /*Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ProfileImg(
                    img: "https://www.shorturl.at/ajnxF",
                  );
                }));*/
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      content: Hero(
                        tag: "profileImg",
                        child: Avatar(
                          image: NetworkImage(
                              "https://cdn.brandfolder.io/CBWQP80B/as/q4ttib-7tbf6w-ff6brz/1110x740-qa-AI.auto?width=1000"),
                          radius: 100,
                          borderColor: Colors.transparent,
                        ),
                      ),
                    );
                  });
            },
            child: Hero(
              tag: "profileImg",
              child: Avatar(
                image: NetworkImage(
                    "https://cdn.brandfolder.io/CBWQP80B/as/q4ttib-7tbf6w-ff6brz/1110x740-qa-AI.auto?width=1000"),
                radius: 25,
                borderColor: AppData.kPrimaryColor,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.0,
              ),
              Text(
                "GgroomdD Partner",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16.0),
              ),
              //Text("Your City",style: TextStyle(fontSize: 12.0),),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/searchPage");
                },
                child: FittedBox(
                  child: Row(
                    children: [
                      Text(
                        "Unknown",
                        style: TextStyle(fontSize: 14.5, letterSpacing: 0.4),
                      ),
                      /* Icon(
                        Icons.arrow_drop_down,
                        size: 19.0,
                      )*/
                    ],
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          /*Icon(Icons.logout),
          SizedBox(
            width: 10.0,
          )*/
        ],
      ),
    );
  }

  static appBar1(
      BuildContext context, Function fun) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      titleSpacing: 0,
      title: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 5.0,
          ),
          InkWell(
            onTap: () {
              /*Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ProfileImg(
                    img: "https://www.shorturl.at/ajnxF",
                  );
                }));*/
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      content: Hero(
                        tag: "profileImg",
                        child: Avatar(
                          image: NetworkImage(AppData.defaultImgUrl),
                          radius: 100,
                          borderColor: Colors.transparent,
                        ),
                      ),
                    );
                  });
            },
            child: Hero(
              tag: "profileImg",
              child: Avatar(
                image: NetworkImage(AppData.defaultImgUrl),
                radius: 25,
                borderColor: AppData.kPrimaryColor,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.0,
              ),
              Text(
                "GgroomdD Partner",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16.0),
              ),
              //Text("Your City",style: TextStyle(fontSize: 12.0),),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/searchPage");
                },
                child: FittedBox(
                  child: Row(
                    children: [
                      Text("Sanjaya Jena",
                        style: TextStyle(fontSize: 14.5, letterSpacing: 0.4),
                      ),
                      /* Icon(
                        Icons.arrow_drop_down,
                        size: 19.0,
                      )*/
                    ],
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          InkWell(onTap: fun, child: Icon(Icons.refresh)),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }

  static Widget outlinedButton({String text, context, Function fun}) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            // color: Colors.indigo[50],
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: AppData.kPrimaryColor, width: 0.5)    ,
           boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],                     
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],  
                ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 30.0, right: 30.0, top: 12.0, bottom: 12.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppData.kPrimaryColor, fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  static Widget nextButton({String text, context, Function fun}) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        /*decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.matruColor])),*/
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [AppData.kPrimaryColor, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(text,textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
  Widget nextButton1({String text, context, Function fun}) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.blue, AppData.kPrimaryColor])),
        child: Padding(
          padding:
          EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  static Widget header2(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.grey),
      ),
      alignment: alignment,
    );
  } static Widget header3(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w300, fontSize: 16.0, color: Colors.grey),
      ),
      alignment: alignment,
    );
  }

  static Widget myCart(String cartCount) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Stack(
        children: [
          Center(
            child: Icon(
              CupertinoIcons.bag_fill,
              color: Colors.black45,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 9.0,
              right: 7.0,
              left: 3,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    //backgroundBlendMode: BlendMode.
                    shape: BoxShape.circle,
                    color: Colors.red),
                child: Center(
                  child: Text(
                    cartCount,
                    style: TextStyle(fontSize: 6),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget subHeader1(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w300, fontSize: 16.0, color: Colors.black),
      ),
      alignment: alignment,
    );
  }

  static Widget subHeader2(String text, Alignment alignment) {
    return Expanded(
      child: Align(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 16.0, color: Colors.black),
        ),
        alignment: alignment,
      ),
    );
  }

  static dateUI(String name, TextEditingController controller, fun) {
    return InkWell(
      onTap: () => fun,
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.only(left: 17.0, right: 17.0),
          child: TextFormField(
            autofocus: false,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: name,
              //labelText: 'Booking Date',
              alignLabelWithHint: false,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppData.grey,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget submitButton(fun, String name) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 10.0, bottom: 10.0),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  static Widget addNewSymBol(fun) {
    return InkWell(
      onTap: fun,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(7, 1, 6, 1),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                "NEW",
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              Text(
                "+",
                style: TextStyle(fontSize: 17, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget addNewSymBolWithLogo({fun, String name}) {
    return InkWell(
      onTap: fun,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(7, 3, 7, 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              /*Text(
                "+",
                style: TextStyle(fontSize: 17, color: Colors.black),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  static anotherUI(String name, TextEditingController controller, fun) {
    return InkWell(
      onTap: () => fun,
      child: AbsorbPointer(
        absorbing: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 13.0, right: 13.0),
          child: TextFormField(
            autofocus: false,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.confirmation_number),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: name,
              //labelText: 'Booking Date',
              alignLabelWithHint: false,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppData.kPrimaryColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget rowSmallNames(String name, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Text(
                name,
                style: TextStyle(fontSize: 14.0),
              )),
          Expanded(
              flex: 1,
              child: Text(
                ":",
                style: TextStyle(fontSize: 14.0),
              )),
          Expanded(
              flex: 5,
              child: Text(
                value,
                style: TextStyle(fontSize: 14.0),
              ))
        ],
      ),
    );
  }

  static Widget rowNames1(String name, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Text(
                name,
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              )),
          Expanded(flex: 1, child: Text(":")),
          Expanded(flex: 5, child: Text(value))
        ],
      ),
    );
  }

  static Widget header(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.black),
      ),
      alignment: alignment,
    );
  }static Widget headerr(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      alignment: alignment,
    );
  }

  static Widget headerColor(String text, Alignment alignment, Color color) {
    return Align(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20.0, color: color),
      ),
      alignment: alignment,
    );
  }

  static Widget smallheader(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 15.0, color: Colors.black),
      ),
      alignment: alignment,
    );
  }
  static Widget midheader(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20.0, color: Colors.black),
      ),
      alignment: alignment,
    );
  }

  static Widget header1(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 23.0, color: Colors.black),
      ),
      alignment: alignment,
    );
  }

  static popup(String msg, BuildContext context) {
    return Alert(
        context: context,
        //title: "Success",
        title: "Success",
        //type: AlertType.info,
        onWillPopActive: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              size: 140,
              color: Colors.green,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              msg,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  static Widget subHeader(String text, Alignment alignment) {
    return Align(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.black),
      ),
      alignment: alignment,
    );
  }

  static Widget subHeaderColor(String text, Alignment alignment, Color color) {
    return Align(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w300, fontSize: 14.0, color: color),
      ),
      alignment: alignment,
    );
  }

  static Widget agreeCheck() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          /*Theme(
            data: ThemeData(unselectedWidgetColor: AppData.kPrimaryColor),
            child: Checkbox(
              value: DocumentForm.iAgree,
              checkColor: Colors.white,
              activeColor: AppData.kPrimaryColor,
              onChanged: (value) {
                DocumentForm.iAgree = value;
              },
            ),
          ),*/
          Text(
            'I accept',
            style: TextStyle(
              color: AppData.kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ],
      ),
    );
  }

  static Widget loading(BuildContext context) {
    return Container(
      height: AppData.properSafeArea(context) - 100,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget loading1(BuildContext context) {
    return Container(
      height: AppData.properSafeArea(context),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static Widget circleShape(child) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
      child: Container(
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: AppData.matruColor,
          borderRadius: BorderRadius.circular(24),
          /*border: Border.all(color: Colors.black, width: 0.3)*/
        ),
        child: child,
      ),
    );
  }
}
