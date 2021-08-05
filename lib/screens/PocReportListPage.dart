import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/PocReportModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class PocReportListPage extends StatefulWidget {
  MainModel model;
      PocReportListPage({Key key, this.model}) : super(key: key);
  @override
  _PocReportListPageState createState() => _PocReportListPageState();
}

class _PocReportListPageState extends State<PocReportListPage> {
 PocReportModel pocReportModel;
 bool isDataNotAvail = false;
  @override
  void initState(){
 super.initState();

 widget.model.GETMETHODCALL_TOKEN(api: ApiFactory.POC_REPORT_LIST,
     token: widget.model.token,
     fun: (Map<String,dynamic> map){
   setState(() {
     String msg= map[Const.MESSAGE];
     if (map [Const.CODE] == Const.SUCCESS ){
       pocReportModel= PocReportModel.fromJson(map);
     }
     else {
       isDataNotAvail = true;
       AppData.showInSnackBar(context, msg);
     }
   });
 });
  }
 

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "POC Report List",style: TextStyle(color: Colors.white),
        ),
      ),

      // body: ListTile(
      //   onTap: () {
      //   },
      //   title: Text(
      //     (i + 1).toString() +
      //         ". " +
      //         patient.firstName +
      //         " " +
      //         patient.midName ??
      //         "" + patient.lastName,
      //     style: TextStyle(
      //         color: Colors.black, fontWeight: FontWeight.bold),
      //   ),
      //   subtitle: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(
      //         height: 4,
      //       ),
      //       Text(
      //         patient.sector,
      //         style: TextStyle(color: Colors.grey),
      //         textAlign: TextAlign.start,
      //       ),
      //       Text(
      //         patient.pregnancyRegDt,
      //         style: TextStyle(color: Colors.grey),
      //         textAlign: TextAlign.end,
      //       ),
      //       Text(
      //         patient.husbandFatherNm,
      //         style: TextStyle(color: Colors.grey),
      //         textAlign: TextAlign.end,
      //       ),
      //     ],
      //   ),
      //   //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
      //   trailing: Icon(Icons.arrow_right_outlined),
      // ),
      //

    );
  }
}
