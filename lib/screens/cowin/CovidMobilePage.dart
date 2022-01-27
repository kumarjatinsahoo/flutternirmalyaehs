import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

class CovidMobilePage extends StatefulWidget {
  final MainModel model;

  const CovidMobilePage({Key key, this.model}) : super(key: key);

  @override
  _CovidMobilePageState createState() => _CovidMobilePageState();
}

class _CovidMobilePageState extends State<CovidMobilePage> {
  List<TextEditingController> controller = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  String txnId;

  callApi() {
    Map<String,dynamic> postData = {"mobile": controller[1].text};
    widget.model.POSTMETHOD(
        api: ApiFactory.GENERATE_OTP,
        json: postData,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map.containsKey("txnId")) {
            setState(() {
              txnId = map["txnId"];
              widget.model.txnId = txnId;
              Navigator.pushNamed(context, "/covidOtp");
            });
          } else {
            AppData.showInSnackBar(context, "Something went wrong");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mobile No',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [mobileNumber("Mobile No", 1)],
      ),
    );
  }

  Widget mobileNumber(String hint, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            hint,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "DINReg",
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 15, right: 15, top: 6.0, bottom: 15.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[400], width: 1)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: AppData.currentSelectedValue,
                    isDense: true,
                    onChanged: (newValue) {
                      setState(() {
                        AppData.currentSelectedValue = newValue;
                      });
                      print(AppData.currentSelectedValue);
                    },
                    items: AppData.phoneFormat.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                height: 35.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              new Expanded(
                child: TextFormField(
                  // enabled: widget.isConfirmPage ? false : true,
                  controller: controller[index],
                  //cursorColor: Const.primaryColor,
                  textInputAction: TextInputAction.done,
                  maxLength: 10,
                  style: TextStyle(fontSize: 13),
                  keyboardType: TextInputType.number,
                  //textAlignVertical: TextAlignVertical.center,
                  onFieldSubmitted: (value){
                    MyWidgets.showLoading(context);
                    callApi();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    //hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey),
                    /*suffixIcon: Icon(
                      Icons.phone,
                      size: 19,
                      color: Colors.grey,
                    ),*/
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
