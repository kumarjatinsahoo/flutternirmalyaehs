import 'dart:io';


import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';


class PdfScreen extends StatefulWidget {
  final MainModel model;
  final String fileName;

  const PdfScreen({
    Key key,
    this.model,
    this.fileName,
  }) : super(key: key);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  bool _isLoading = true;
  //PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
   // File file = new File(widget.model.pdfName);
    //document = await PDFDocument.fromURL(file);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /* drawer: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(height: 36),
              ListTile(
                title: Text('Load from Assets'),
                onTap: () {
                  changePDF(1);
                },
              ),
              ListTile(
                title: Text('Load from URL'),
                onTap: () {
                  changePDF(2);
                },
              ),
              ListTile(
                title: Text('Restore default'),
                onTap: () {
                  changePDF(3);
                },
              ),
            ],
          ),
        ),*/
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: const Text(
            'Preview',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: _isLoading
              ?? Center(child: CircularProgressIndicator())
               /*PDFViewer(
                  document: document,
                  zoomSteps: 1,
                ),*/
        ),
      ),
    );
  }
}
