import 'package:flutter/gestures.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/DocumentList.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/RecentDocument.dart';
class UploadDocumentTab extends StatefulWidget {
  final MainModel model;

  UploadDocumentTab({Key key, this.model}) : super(key: key);
  @override
  _BookAppointmentTab createState() => _BookAppointmentTab();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _BookAppointmentTab extends State<UploadDocumentTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(MyLocalizations.of(context).text("MEDICAL_DATA_UPLOAD")),
          backgroundColor: AppData.kPrimaryColor,
          actions: <Widget>[
          ],
          bottom: TabBar(
            //indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppData.white,
            //isScrollable: true,
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Tab(
                text:MyLocalizations.of(context).text("RECENT"),
              ),
              Tab(
                text:MyLocalizations.of(context).text("CATEGORIES")
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),
        body: TabBarView(
          children: [
            RecentDocument(model:widget.model,),
            DocumentList(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
