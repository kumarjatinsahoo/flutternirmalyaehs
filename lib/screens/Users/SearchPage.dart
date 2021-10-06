import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:user/models/AutocompleteDTO.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';

class SearchPage extends StatefulWidget {
  final MainModel model;

  const SearchPage({Key key, this.model}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  void Function(AnimationStatus) _statusListener;

  CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  AutoCompleteDTO courcesDto;
  bool isAnySearchFail = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _statusListener = (AnimationStatus status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _suggestionsBoxController.resize();
      }
    };
  }

  @override
  void dispose() {
    //widget.model.searchFilter = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back)),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5.0,
                      color: Colors.black87.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        style: TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          alignLabelWithHint: true,
                          hintStyle: TextStyle(
                              fontFamily: "Monte",
                              fontSize: 17,
                              color: Colors.grey),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        ),
                        onSubmitted: (String value) {
                          if (value != "") {
                            /*widget.model.searchFilter = value;
                            Navigator.pushNamed(context, "/searchResult");*/
                            //fetchSearchResult(value);
                          }
                          //AppData.showInSnackDone(context, value);
                        },
                      ),
                      getImmediateSuggestions: true,
                      suggestionsCallback: (pattern) async {
                        return (pattern != null)
                            ? await fetchSearchAutoComplete(pattern)
                            : null;
                      },
                      hideOnLoading: true,
                      itemBuilder: (context, Predictions suggestion) {
                        return ListTile(
                          leading: Icon(Icons.search),
                          title: Text(suggestion.description),
                        );
                      },
                      onSuggestionSelected: (Predictions suggestion) {
                        //widget.model.courceName = suggestion.courseSlug;
                        //Navigator.pushNamed(context, "/courceDetail1");
                        Navigator.pop(context);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.search,
                          size: 27,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }

  fetchSearchResult(search) async {
    Map<String, dynamic> postMap;
    postMap = {"course_name": search};
    widget.model.POSTMETHOD(
        api: ApiFactory.AUTO_COMPLETE,
        json: postMap,
        fun: (Map<String, dynamic> map) {
          if (map["success"] == true) {
            setState(() {
              courcesDto = AutoCompleteDTO.fromJson(map);
            });
          } else {
            isAnySearchFail = true;
            AppData.showInSnackBar(context, "No Data Found");
          }
        });
  }

  Future<List<Predictions>> fetchSearchAutoComplete(
      String course_name) async {
    var dio = Dio();
    //Map<String, dynamic> postMap = {"course_name": course_name};
    final response =
        await dio.get(ApiFactory.AUTO_COMPLETE+course_name,);

    if (response.statusCode == 200) {
      AutoCompleteDTO model = AutoCompleteDTO.fromJson(response.data);
      setState(() {
        this.courcesDto = model;
      });
      return model.predictions;
    } else {
      setState(() {
        isAnySearchFail = true;
      });
      throw Exception('Failed to load album');
    }
  }
}
