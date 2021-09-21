import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/models/DocterAppointmentlistModel.dart';
import 'package:user/models/DocterMedicationModel.dart';
import 'package:user/models/DocterMedicationlistModel.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/models/MedicinModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:user/widgets/text_field_address.dart';
import 'package:user/widgets/text_field_container.dart';

class MedicineList extends StatefulWidget {
  MainModel model;
  final bool isConfirmPage;
  static KeyvalueModel medicinModel = null;
  MedicineList({Key key, this.model,this.isConfirmPage}) : super(key: key);
  @override
  _MedicineList createState() => _MedicineList();
}
List<TextEditingController> textEditingController = [
  new TextEditingController(),
  new TextEditingController(),
  new TextEditingController(),
];

/*List<MedicinlistModel> itemModel = [ ];*/
class _MedicineList extends State<MedicineList> {
  DateTime selectedDate = DateTime.now();
  DoctorAppointmment doctorAppointmment;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  DateTime date = DateTime.now();
  bool valuefirst = false;
  List<MedicinlistModel> medicinlist = [
  ];
  List<KeyvalueModel> stateList = [
    KeyvalueModel(name: "Nirmalya pharmacy", key: "1"),
    KeyvalueModel(name: "UP", key: "2"),
    KeyvalueModel(name: "AP", key: "3"),
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr = df.format(date).toString();
      //toThis_.text = df.format(date);
      //callAPI(selectedDatestr);
    });
  }

  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox = false;
  String _checkboxstr = "0";
  String _checkboxstr1 = "0";
  String _checkboxstr2 = "0";

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
      /*.add(Duration(days: 60))*/); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(selectedDate));
        selectedDatestr = df.format(selectedDate).toString();
        //callAPI(selectedDatestr);
      });
  }

  /*callAPI(String today) {
    *//*if (comeFrom == Const.HEALTH_SCREENING_APNT) {*//*
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.doctor_APPOINTMENT_LIST +
            widget.model.user +
            "&date=" +
            today +
            "&status=" +
            "7",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              doctorAppointmment = DoctorAppointmment.fromJson(map);
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              // isDataNotAvail = true;
              AppData.showInSnackBar(context, msg);
            }
          });
        });
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                    DropDown.staticDropdown2(
                        "State",
                        "state",
                        stateList, (KeyvalueModel data) {
                      setState(() {

                      });
                    }),
                  SizedBox(height:10,),
                  ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 0),
                            child:Row(
                                children: [
                                  Checkbox(
                                    value: this.valuefirst,
                                    onChanged: (bool value) {
                                      setState(() {
                                        this.valuefirst = value;

                                      });
                                    },
                                  ),
                                  Text(
                                    " PARACETOMOL",
                                    style: TextStyle(color: Colors.black,fontSize: 13),
                                  )
                                ],
                              ),
                      );
                    },
                  ),
                  SizedBox(height: 10,),
              Material(
                elevation: 5,
                color: const Color(0xFF0F6CE1),
                borderRadius: BorderRadius.circular(10.0),
                child: MaterialButton(
                  onPressed: () {

                  },
                  minWidth: 350,
                  height: 40.0,
                  child: Text(
                    " SUBMIT ",
                    style: TextStyle(
                        color: Colors.white, fontSize: 17.0),
                  ),
                ),
              ),
                ],
              ),
            ),
          ),
        ));
  }

}
