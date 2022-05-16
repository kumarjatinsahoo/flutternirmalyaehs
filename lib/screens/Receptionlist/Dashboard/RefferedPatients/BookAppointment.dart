import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/MonthlyoverviewModel.dart' as monthly;
import 'package:user/models/ShareApntModel.dart';
import 'package:user/models/ShareModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_address.dart';

class BookAppointment extends StatefulWidget {
  MainModel model;
  static ShareApntModel shareappontmentmodel = null;
  static KeyvalueModel doctorreceptionmodel = null;
  static KeyvalueModel timeModel = null;


  BookAppointment({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookAppointment();
}
enum RadioGroup { payonshop, home }
enum RadioGroup1 { payon_shop, online }
class _BookAppointment extends State<BookAppointment> {
  DateTime selectedDate = DateTime.now();
  String formattedDate;
  String receptionhospitalid;
  String receptionpatientid;

  // apnt.AppointmentlistModel appointmentlistModel;
  //LoginResponse1 loginResponse;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  TextEditingController _reason = TextEditingController();
  String selectedDatestr;
  bool isdata = false;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  monthly.MonthlyOverviewModel monthlyOverviewModel;
  LoginResponse1 loginResponse;
  RadioGroup radioGroup = RadioGroup.payonshop;
  RadioGroup1 radioGroup1 = RadioGroup1.payon_shop;
  String roleid = "2";
  TextEditingController appointmentdate = TextEditingController();
  final df1 = new DateFormat('dd-MMM-yyyy');
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  List<bool> error = [false, false, false, false, false, false];
  bool isValidtime=false;

  Future<Null> _selectDate(
      BuildContext context,
      ) async {
    // MyWidgets.showLoading(context);
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate:
        DateTime.now().add(Duration(days: 6570))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      /*selectedDatestr = df.format(selectedDate).toString();*/
      appointmentdate.text = df.format(picked);
      formattedDate = df1.format(picked);
      selectedDatestr = appointmentdate.text.toString();
    });
  }
  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
    receptionhospitalid=widget.model.receptionhospitalid;
    receptionpatientid=widget.model.receptionpatientid;
  }


  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:Text(MyLocalizations.of(context).text("BOOK_APPOINTMENT")),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              SizedBox(
                height: 20,
              ),
              DropDown.networkDropdownGetpartUser1(
                 MyLocalizations.of(context).text("DOCTOR"),
                  ApiFactory.RECEPTIONLIST_DOCTOR + loginResponse.body.user,
                  "doctorrecipt",
                  Icons.location_on_rounded,
                  23.0, (KeyvalueModel data) {
                setState(() {
                  print(ApiFactory.RECEPTIONLIST_DOCTOR);
                  BookAppointment.doctorreceptionmodel = data;
                });
              }),
              SizedBox(height: 8),
              appointdate(),
              (appointmentdate.text.toString() != null||appointmentdate.text.toString()  != "")&&( BookAppointment.doctorreceptionmodel!=null)
                  ? Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 0),
                child: SizedBox(
                  height: 58,
                  child: DropDown.networkDropdownGetpartUser11(
                      "Time",ApiFactory.DOCTER_AVAILABLE +BookAppointment.doctorreceptionmodel.key.toString() +
                      "&date=" + appointmentdate.text.toString(),
                      "time1",
                      widget.model.token, (KeyvalueModel data) {
                    setState(() {
                      print(ApiFactory.DOCTER_AVAILABLE);
                      BookAppointment.timeModel = data;
                      isValidtime=(data.key==1)?false:true;
                      if(!isValidtime)
                        AppData.showInSnackBar(context, "This time is already booked please select another time");
                    });
                    if(data.key==1){
                      AppData.showInSnackBar(context, "This time is already booked. Please choose another time.");
                    }
                  }, context),

                ),
              )
                  : Container(),
              SizedBox(height: 10,),
              fromAddress(
                  1,
                  MyLocalizations.of(context).text("REASON_FOR_CHOICE"),TextInputAction.next,
                  TextInputType.text,
                  "reasonforDr"),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                   if (BookAppointment.doctorreceptionmodel == null ||
                      BookAppointment.doctorreceptionmodel == "") {
                    AppData.showInSnackBar(context, "Please select doctor");
                  } else if (appointmentdate.text == "" || appointmentdate.text == null) {
                    AppData.showInSnackBar(context, "Please select your appointment date");
                  } else if (BookAppointment.timeModel == null) {
                    AppData.showInSnackBar(context, "Please select time");
                  } else if (!isValidtime) {
                    AppData.showInSnackBar(context, "Please select valid time");
                  } else {
                     saveDb();
                  }
                },
                child: Material(
                  elevation: 5,
                  color: AppData
                      .kPrimaryColor,
                  borderRadius:
                  BorderRadius
                      .circular(
                      3.0),
                  child:
                  MaterialButton(
                    minWidth: 200,
                    height: 50.0,
                    child: Text(MyLocalizations.of(context).text("SUBMIT"),
                      style: TextStyle(
                          fontWeight:
                          FontWeight
                              .bold,
                          fontSize:
                          17,
                          color: Colors
                              .white),
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget formField(int index,
      String hint,) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            /* prefixIcon:
            Icon(Icons.person_rounded),*/
            hintStyle: TextStyle(color: AppData.hintColor, fontSize: 15),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: _reason,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
          ],
        ),
      ),
    );
  }

  Widget appointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () =>
            _selectDate(
              context,
            ),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: TextFormField(
                //focusNode: fnode4,
                //enabled: !widget.isConfirmPage ? false : true,
                controller: appointmentdate,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                onSaved: (value) {
                  // registrationModel.dathOfBirth = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    error[3] = true;
                    return null;
                  }
                  error[3] = false;
                  return null;
                },
                onFieldSubmitted: (value) {
                  error[3] = false;
                  // print("error>>>" + error[2].toString());

                  setState(() {});
                  // AppData.fieldFocusChange(context, fnode4, fnode5);
                },
                decoration: InputDecoration(
                  hintText: //"Last Period Date",
                  MyLocalizations.of(context).text("APPOINTMENT_DATE"),
                  border: InputBorder.none,
                  //contentPadding: EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveDb() {
    Map<String, dynamic> map = {
      //"regNo": loginRes.ashadtls[0].id,
      "userid": receptionpatientid,
      "date": appointmentdate.text.toString(),
      "time": BookAppointment.timeModel.name ,
      "opdid": BookAppointment.timeModel.code,
      "doctor": BookAppointment.doctorreceptionmodel.key.toString(),
      "notes": textEditingController[1].text,
      "hospitalid": receptionhospitalid,
    };
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(
        api: ApiFactory.POST_APPOINTMENT,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map[Const.STATUS] == Const.SUCCESS) {
            popup(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });
  }
  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
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
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }

  Widget fromAddress(int index, String hint, inputAct, keyType, String type) {
    return TextFieldAddress(
      child: TextFormField(
        controller: textEditingController[index],
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (newValue) {},
        onFieldSubmitted: (value) {
          print("ValueValue" + error[index].toString());
          setState(() {
            error[index] = false;
          });
        },
      ),
    );
  }
}