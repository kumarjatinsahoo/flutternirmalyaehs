import 'package:flutter/gestures.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/DocumentList.dart';
import 'package:user/screens/Users/MyMedicalRecord/UploadDocument/RecentDocument.dart';

import 'DoctorRecentDocument.dart';
import 'MobileUpload.dart';
class DocterUploadDocumentTab extends StatefulWidget {
  final MainModel model;

  DocterUploadDocumentTab({Key key, this.model}) : super(key: key);
  @override
  _BookAppointmentTab createState() => _BookAppointmentTab();
}

final List<Tab> myTabs = <Tab>[
  Tab(text: 'LEFT'),
  Tab(text: 'RIGHT'),
];

class _BookAppointmentTab extends State<DocterUploadDocumentTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: TabBar(//indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: AppData.kPrimaryColor,
          unselectedLabelColor: Colors.lightBlue[100],
          labelColor:AppData.kPrimaryColor,
          indicatorWeight: 2,
          //indicatorColor: Colors.blue[100],
          //isScrollable: true,
          dragStartBehavior: DragStartBehavior.down,
          tabs: [
            Tab(
              text:"Recent",
            ),
            Tab(
                text:"Categories"
            ),
          ],),
       /* appBar: AppBar(
          toolbarHeight:0,
          centerTitle: true,
          title:Text("Medical Data Upload"),
          backgroundColor: AppData.kPrimaryColor,
          *//*actions: <Widget>[
          ],*//*
          bottom: TabBar(
            //indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppData.white,
            //isScrollable: true,
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Tab(
                text:"Recent",
              ),
              Tab(
                text:"Categories"
              ),
            ],
          ),
          //title: Text(widget.model.saloonName),
        ),*/
        body: TabBarView(
          children: [
            DoctorRecentDocument(model:widget.model,),
            MobileUpload(model:widget.model,),
          ],
        ),
      ),
    );
  }
}
