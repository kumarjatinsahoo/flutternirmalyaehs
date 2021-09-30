import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ScrollController _scrollController = ScrollController();

  int currentMax = 1;
  static const platform = AppData.channel;

  @override
  void initState() {
    super.initState();
    callAPI(currentMax);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (pocReportModel.body.length % 20 == 0) callAPI(++currentMax);
      }
    });
  }

/*
  Future<void> callUrl(String data) async {
    try {
      final int result = await platform.invokeMethod('callUrl', data);
    } on PlatformException catch (e) {}
  }*/

  callAPI(int i) {
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.POC_REPORT_LIST + "?page=" + i.toString()+"&search=",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              if (i == 1) {
                pocReportModel = PocReportModel.fromJson(map);
                //Navigator.pop(context);
              } else {
                pocReportModel.addMore(map);
              }
            } else {
              isDataNotAvail = true;
              if (i == 1) AppData.showInSnackBar(context, msg);
            }
          });
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "POC Report List",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, "/searchPoc");
              },
                child: Icon(
              Icons.search,
              color: Colors.white,
            )),
            SizedBox(
              width: 15,
            )
          ],
        ),
        centerTitle: true,
        titleSpacing: 5,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppData.kPrimaryColor,
        elevation: 0,
      ),
      body: (pocReportModel != null)
          ? ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, i) {
                if (i == pocReportModel.body.length) {
                  return (pocReportModel.body.length % 20 == 0)
                      ? CupertinoActivityIndicator()
                      : Container();
                }
                Body patient = pocReportModel.body[i];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      if (patient.reportUrl != null) {
                        /*widget.model.pdfUrl = patient.reportUrl;
                        print("URL IMAGE?>>>>>"+patient.reportUrl);
                        Navigator.pushNamed(context, "/testReport");*/
                        print(">>>>>>PDF URL TEST REPORT????>>" +
                            patient.reportUrl);
                        /*AppData.launchURL(
                            "https://docs.google.com/gview?embedded=true&url=" +
                                patient.reportUrl);*/
                        AppData.launchURL(patient.reportUrl);
                      } else {
                        AppData.showInSnackBar(context, "Data Not Available");
                      }
                      //AppData.launchURL(patient.reportUrl);
                      //callUrl("");
                    },

                    title: Text(
                      (i + 1).toString() + ". " + patient.name + " ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        (patient.thpId == "")
                            ? Container()
                            : Text(
                                patient.thpName ?? "",
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.start,
                              ),
                        Text(
                          patient.patientUniqueid,
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          patient.mobile ?? "",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          patient.gender ?? "",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          patient.age ?? "",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          patient.screeningDate ?? "",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
                    trailing: Icon(Icons.arrow_right_outlined),
                  ),
                );
              },
              itemCount: pocReportModel.body.length + 1,
            )
          : Container(),
    );
    /*body: ListTile(
        onTap: () {
        },
        title: Text(
          (i + 1).toString() +
              ". " +
              patient.firstName +
              " " +
              patient.midName ??
              "" + patient.lastName,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              patient.sector,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            Text(
              patient.pregnancyRegDt,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
            Text(
              patient.husbandFatherNm,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        //leading: SizedBox(width:20,child: Text((i+1).toString(),style: TextStyle(color: Colors.black),)),
        trailing: Icon(Icons.arrow_right_outlined),
      ),*/
  }
}
