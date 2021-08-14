import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/MyWidget.dart';
import '../models/KeyvalueModel.dart';
import 'app_data.dart';

class DropDown {
  static KeyvalueModel selectedKey;
  static KeyvalueModel selectedKey1;
  static KeyvalueModel gender;
  static KeyvalueModel ageProof;
  static KeyvalueModel marital;
  static KeyvalueModel job;

  static KeyvalueModel educatqualfication;

  static Widget inputFieldContainer(child) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15,),
      // padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0, bottom: 0.0),
      // decoration: BoxDecoration(
      //     color: AppData.kPrimaryLightColor,
      //     borderRadius: BorderRadius.circular(29),
      //     border: Border.all(color: Colors.black, width: 0.3)),
      child: child,
    );
  }

  static Widget romFieldNew(child) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: AppData.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }

  static Widget fromFieldNew(child) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 7.0),
      child: TextFormField(
        autofocus: false,
        //controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.insert_drive_file_outlined),
          floatingLabelBehavior: FloatingLabelBehavior.always,
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
    );
  }

  static Widget inputFieldSmall(child) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 3.0, left: 3.0, right: 3.0, bottom: 3.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: AppData.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }

  static Widget inputFieldContainerNoBorder(child) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppData.kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
          /*border: Border.all(color: Colors.black, width: 0.3)*/
        ),
        child: child,
      ),
    );
  }

  static Widget inputFieldContainerDisable(child) {
    return AbsorbPointer(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
        child: Container(

          padding: EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), //shadow direction: bottom right
              )
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  static networkDropdown(String label, final String API, String callFrom,Function fun) {
    return inputFieldContainer(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),

      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        var response = await Dio().get(
          //"http://5d85ccfb1e61af001471bf60.mockapi.io/user",
          API,
          //queryParameters: {"filter": filter},
        );
        //var models = response.data;
        final statejsonResponse = response.data;
        var list;
        // var list = List<KeyvalueModel>.from(jsonResponse.map((i) => KeyvalueModel.fromsJson(i)));
        switch (callFrom) {
          case "district":
            list = KeyvalueModel.fromJsonList(response.data);
            break;
            case "country":
            list = KeyvalueModel.fromJsonList(response.data);
            break;
            case "state":
            list = KeyvalueModel.fromJsonList(response.data);
            break;
          case "block":
            list = KeyvalueModel.fromJsonList(response.data["districtList"]);
            break;
          case "relation":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
            case "title":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
            case "bloodgroup":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "gender":
            List<KeyvalueModel> listS = [];
            listS.add(KeyvalueModel(name: "MALE", key: "1"));
            listS.add(KeyvalueModel(name: "FEMALE", key: "2"));
            listS.add(KeyvalueModel(name: "TRANSGENDER", key: "3"));
            list = listS;
            break;
          case "ageproof":
            list = KeyvalueModel.fromJsonList(response.data["districtList"]);
            break;
        }
        return list;
      },
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
        switch (callFrom) {

          case "district":
            selectedKey = data;
            break;
          case "block":
            selectedKey1 = data;
            break;
          case "gender":
            gender = data;
            break;
          case "ageproof":
            ageProof = data;
            break;
        }
        //selectedKey = data;
      },
    ));
  }

  static networkDropdownPost(
      String label, final String API, String callFrom, Function fun) {
    return inputFieldContainer(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),

      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        var response = await Dio().post(
          //"http://5d85ccfb1e61af001471bf60.mockapi.io/user",
          API,
          //queryParameters: {"filter": filter},
        );

        //var models = response.data;
        final jsonResponse = response.data;
        print(jsonResponse);
        var list;
        // var list = List<KeyvalueModel>.from(jsonResponse.map((i) => KeyvalueModel.fromsJson(i)));
        switch (callFrom) {
          case "district":
            list = KeyvalueModel.fromJsonList(response.data);
            break;
          case "block":
            list = KeyvalueModel.fromJsonList(response.data["districtList"]);
            break;
          case "ageproof":
            list = KeyvalueModel.fromJsonList(response.data["districtList"]);
            break;
          case "labourOfc":
            list = KeyvalueModel.fromJsonList(response.data["officeList"]);
            break;
          case "block1":
            list = KeyvalueModel.fromJsonList(response.data["blockList"]);
            break;
          case "panchayat1":
            list = KeyvalueModel.fromJsonList(response.data["panchayatList"]);
            break;
          case "village1":
            list = KeyvalueModel.fromJsonList(response.data["villageList"]);
            break;
          case "block2":
            list = KeyvalueModel.fromJsonList(response.data["blockList"]);
            break;
          case "panchayat2":
            list = KeyvalueModel.fromJsonList(response.data["panchayatList"]);
            break;
          case "village2":
            list = KeyvalueModel.fromJsonList(response.data["villageList"]);
            break;
          case "certifiedByCall":
            list = KeyvalueModel.fromJsonList(
                response.data["CertifyingAuthorityType"]);
            break;
          case "certifiedOfc":
            list = KeyvalueModel.fromJsonList(response.data["certifyOffice"]);
            break;
        }
        return list;
      },
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
        switch (callFrom) {
          case "district":
            selectedKey = data;
            break;
          case "block":
            selectedKey1 = data;
            break;
          case "gender":
            gender = data;
            break;
          case "ageproof":
            ageProof = data;
            break;
        }
        //selectedKey = data;
      },
    ));
  }

  static networkDropdownGet(
      String label, final String API, String callFrom, Function fun) {
    return inputFieldContainer(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),

      label: label,
      showSearchBox: true,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        var response = await Dio().get(
          API,
        );
        //var models = response.data;
        final jsonResponse = response.data;
        print(jsonResponse);
        var list;
        // var list = List<KeyvalueModel>.from(jsonResponse.map((i) => KeyvalueModel.fromsJson(i)));
        switch (callFrom) {
          case "state":
            list = KeyvalueModel.fromJsonList(response.data["districtList"]);
            break;
          case "city":
            list = KeyvalueModel.fromJsonList(response.data["districtList"]);
            break;
        }
        return list;
      },
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    ));
  }

  static staticDropdown(
      String label, String callFrom, List<KeyvalueModel> list) {
    return inputFieldContainer(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),
      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        switch (callFrom) {
          case "district":
            selectedKey = data;
            // NewUserRegister.regModel.permanentDistrict=data;
            break;
          case "block":
            selectedKey1 = data;
            //NewUserRegister.regModel.permanentBlock=data;
            break;
          case "gender":
            // PersonalForm.selectGender = data;
            //NewUserRegister.regModel.gender=data;
            gender = data;
            break;
        }
        //selectbank = data;
      },
    ));
  }

  static employeeInfo() {
    return inputFieldContainer(Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MyWidgets.smallheader(
              "Employee Info",
              Alignment.topLeft,
            ),
            SizedBox(
              width: 120.0,
            ),
            Expanded(
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 25,
              ),
            )
          ],
        )));
  }

  static Widget newContainer(child) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }
  static Widget newContainer1(child) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(1.0, 1.0), //shadow direction: bottom right
            )
          ],
        ),
       /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 0.3)),*/
        child: child,
      ),
    );
  }
  static staticDropdown2(
    String label,
    String callFrom,
    List<KeyvalueModel> list,
    Function fun,
  ) {
    return DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      /* dropdownSearchDecoration: InputDecoration(
          // filled: true,
          isDense: true,
          //disabledBorder: InputBorder.none,
          // border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
              borderRadius: BorderRadius.circular(29)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.all(0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29)),
            borderSide: BorderSide(width: 0, color: Colors.black),
          ),
        ),*/
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        // disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        // enabledBorder: const OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        // ),
        // border: OutlineInputBorder(
        //     borderSide:
        //     const BorderSide(color: Colors.transparent, width: 0.0),
        //     borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(29)),
        //   borderSide: BorderSide(width: 0, color: AppData.grey),
        // ),
      ),
      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    );
  }

  static staticDropdown3(
      String label, String callFrom, List<KeyvalueModel> list, Function fun) {
    return newContainer(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),
      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,

      onChanged: (KeyvalueModel data) {
        fun(data);
        switch (callFrom) {
          case "district":
            selectedKey = data;

            break;
          case "block":
            selectedKey1 = data;

            break;
          case "gender":
            gender = data;
            break;
            break;
          case "admissioncenter":
            gender = data;
            break;
          case "risk":
            gender = data;
            break;
        }
        //selectbank = data;
      },
    ));
  }

  static staticDropdownIcon(String label, String callFrom, IconData iconData,
      double iconSize, List<KeyvalueModel> list, Function fun) {
    return newContainer(
      DropdownSearch<KeyvalueModel>(
        mode: Mode.BOTTOM_SHEET,
        searchBoxDecoration: InputDecoration(
          hintText: "Search here",
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.only(left: 15),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 3.0),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3.0),
                bottomRight: Radius.circular(3.0),
                topRight: Radius.circular(3.0),
                topLeft: Radius.circular(3.0)),
          ),
        ),
        dropdownSearchDecoration: InputDecoration(
            // filled: true,
            icon: Icon(
              iconData,
              size: iconSize,
            ),
            isDense: true,
            disabledBorder: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0.0),
            ),
            border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
                borderRadius: BorderRadius.circular(29)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.all(0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(29)),
              borderSide:
                  BorderSide(width: 0, color: AppData.kPrimaryLightColor),
            ),
            labelStyle: TextStyle(fontSize: 17)),
        label: label,
        showSearchBox: true,
        selectedItem: getData(callFrom),
        items: list,
        onChanged: (KeyvalueModel data) {
          fun(data);
          switch (callFrom) {
            case "district":
              selectedKey = data;
              break;
            case "block":
              selectedKey1 = data;
              break;
            case "gender":
              gender = data;
              break;
              break;
            case "admissioncenter":
              gender = data;
              break;
            case "risk":
              gender = data;
              break;
          }
        },
      ),
    );
  }

  static staticDropdown7(
    String label,
    String callFrom,
    List<KeyvalueModel> list,
    Function fun,
  ) {
    return fromFieldNew(
      DropdownSearch<KeyvalueModel>(
        mode: Mode.BOTTOM_SHEET,
        searchBoxDecoration: InputDecoration(
          hintText: "Search here",
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.only(left: 15),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 3.0),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3.0),
                bottomRight: Radius.circular(3.0),
                topRight: Radius.circular(3.0),
                topLeft: Radius.circular(3.0)),
          ),
        ),
        dropdownSearchDecoration: InputDecoration(
          // filled: true,
          isDense: true,
          disabledBorder: InputBorder.none,
          // border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
          ),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0.0),
              borderRadius: BorderRadius.circular(29)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.all(0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29)),
            borderSide: BorderSide(width: 0, color: AppData.grey),
          ),
        ),
        label: label,
        showSearchBox: true,
        //items: maritalStatus,
        selectedItem: getData(callFrom),
        items: list,
        //itemAsString: (KeyvalueModel u) => u.userAsString(),
        onChanged: (KeyvalueModel data) {
          fun(data);
        },
      ),
    );
  }

  static staticDropdown6(
      String label, String callFrom, List<KeyvalueModel> list, Function fun) {
    return DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        //focusColor: Colors.red,
        hoverColor: Colors.red,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppData.kPrimaryColor, width: 5.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppData.kPrimaryColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppData.kPrimaryLightColor),
          ),
          contentPadding: EdgeInsets.only(left: 10, right: 10),
          floatingLabelBehavior: FloatingLabelBehavior.never),
      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    );
  }

  static searchDropdown(
      String label, String callFrom, List<KeyvalueModel> list, Function fun) {
    return DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      dropdownSearchDecoration: InputDecoration(
          hintText: label,
          alignLabelWithHint: true,
          contentPadding:
              EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 7),
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        //focusColor: Colors.red,
        hoverColor: Colors.red,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppData.kPrimaryColor, width: 5.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    );
  }

  static searchDropdowntyp(
      String label, String callFrom, List<KeyvalueModel> list, Function fun) {
    return DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      dropdownSearchDecoration: InputDecoration(
          hintText: label,
          alignLabelWithHint: true,
          contentPadding:
              EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 7),
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),

      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    );
  }

  static networkDropdownGetpart(
      String label, final String API, String callFrom, Function fun) {
    return DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
          hintText: label,
          labelText: label,
          contentPadding:
              EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 7),
          floatingLabelBehavior: FloatingLabelBehavior.always),
      label: label,
      showSearchBox: true,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "state":
            list = KeyvalueModel.fromJsonList(response.data["pdata"]);
            break;
          case "city":
            list = KeyvalueModel.fromJsonList(response.data["city_arr"]);
            break;
          case "skill":
            list = KeyvalueModel.fromJsonList(response.data["skill_arr"]);
            break;
          case "relation":
            list = KeyvalueModel.fromJsonList(response.data["relation"]);
            break;
          case "service":
            list = KeyvalueModel.fromJsonList(response.data["service"]);
            break;
          case "subservice":
            list = KeyvalueModel.fromJsonList(response.data["sub_srvc"]);
            break;
          case "shift":
            list = KeyvalueModel.fromJsonList(response.data["shifts"]);
            break;
          case "item_no":
            list = KeyvalueModel.fromJsonList(response.data["itemlist"]);
        }

        return list;
      },
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    );
  }

  static networkDropdownGetpart1(
      String label, final String API, String callFrom, Function fun) {
    return DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
          hintText: label,
          //labelText: label,
          contentPadding:
              EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 7),
          floatingLabelBehavior: FloatingLabelBehavior.always),
      //label: label,
      showSearchBox: true,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "item_no":
            list = KeyvalueModel.fromJsonList(response.data["itemlist"]);
        }

        return list;
      },
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    );
  }

  static networkDropdownGetvenderpart(
      String label, final String API, String callFrom, Function fun) {
    return DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
          hintText: label,
          labelText: label,
          contentPadding:
              EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 7),
          floatingLabelBehavior: FloatingLabelBehavior.always),

      label: label,
      showSearchBox: true,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        var response = await Dio().get(
          API,
        );

        var list;
        // var list = List<KeyvalueModel>.from(jsonResponse.map((i) => KeyvalueModel.fromsJson(i)));
        switch (callFrom) {
          case "vendor":
            list = KeyvalueModel.fromJsonList(response.data["vendorlst"]);
            break;
          case "vendorAddGrn":
            list = KeyvalueModel.fromJsonList(response.data["vendorlst"]);
            list.add(KeyvalueModel(name: "Not Available", key: "N/A"));
            break;
        }
        return list;
      },
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    );
  }

  static searchDropdown1(
      String label, String callFrom, List<KeyvalueModel> list, Function fun) {
    return DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      dropdownSearchDecoration: InputDecoration(
          hintText: label,
          //alignLabelWithHint: true,
          contentPadding:
              EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 7),
          //labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never),
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        //focusColor: Colors.red,
        hoverColor: Colors.red,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppData.kPrimaryColor, width: 5.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    );
  }

  static staticDropdownUnchangeble(
      String label, String callFrom, List<KeyvalueModel> list, Function fun) {
    return inputFieldContainerDisable(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),
      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,
      //itemAsString: (KeyvalueModel u) => u.userAsString(),
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    ));
  }

  static KeyvalueModel getData(String callFor) {
    switch (callFor) {
      case "district":
        return selectedKey;
        break;
      case "block":
        return selectedKey1;
        break;
    }
  }

  static networkDropdownGetpartUser(
      String label, final String API, String callFrom,IconData iconData,
      double iconSize, Function fun) {
    return  newContainer(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      hint: label,
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        icon: Icon(
          iconData,
          size: iconSize,
        ),
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),
      /* dropdownSearchDecoration: InputDecoration(
          hintText: label, *//*labelText: label,*//*
          disabledBorder: InputBorder.none,
          contentPadding:
          EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 7),
        floatingLabelBehavior: FloatingLabelBehavior.never),*/

      //label: label,
      showSearchBox: true,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        print("DROP DOWN API?????"+API);
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "title":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "gender":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
            case "bloodgroup":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "hospital":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "speciality":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "doctor":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "city":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "district":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "state":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "country":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
            case "organisation":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
            case "bloodgroup":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
        }


        return list;
      },
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    )
    );

  }
  static networkDropdownGetpartUser1(
      String label, final String API, String callFrom,IconData iconData,
      double iconSize, Function fun) {
    return  newContainer(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      hint: label,
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
     /*   icon: Icon(
          iconData,
          size: iconSize,
        ),*/
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),
      /* dropdownSearchDecoration: InputDecoration(
          hintText: label, *//*labelText: label,*//*
          disabledBorder: InputBorder.none,
          contentPadding:
          EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 7),
        floatingLabelBehavior: FloatingLabelBehavior.never),*/

      //label: label,
      showSearchBox: true,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        print("DROP DOWN API?????"+API);
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "title":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "gender":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
            case "bloodgroup":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "hospital":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "speciality":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "doctor":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "city":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "district":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "state":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "country":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "organization":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
        }


        return list;
      },
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    )
    );

  }
  static staticDropdown5(String label, String callFrom,
      List<KeyvalueModel> list,Function fun) {
    return newContainer(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),
      label: label,
      showSearchBox: true,
      //items: maritalStatus,
      selectedItem: getData(callFrom),
      items: list,

      onChanged: (KeyvalueModel data) {
        fun(data);
        switch (callFrom) {
          case "district":
            selectedKey = data;

            break;
          case "block":
            selectedKey1 = data;

            break;
          case "gender":
            gender = data;
            break;
            break;
          case "admissioncenter":
            gender = data;
            break;
          case "risk":
            gender = data;
            break;


        }
        //selectbank = data;

      },
    ));
  }

  static networkDropdownGetpart4(
      String label, final String API, String callFrom, Function fun) {
    return newContainer1(DropdownSearch<KeyvalueModel>(
      mode: Mode.BOTTOM_SHEET,
      searchBoxDecoration: InputDecoration(
        hintText: "Search here",
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
              topRight: Radius.circular(3.0),
              topLeft: Radius.circular(3.0)),
        ),
      ),
      hint: label,
      dropdownSearchDecoration: InputDecoration(
        // filled: true,
        isDense: true,
        disabledBorder: InputBorder.none,
        // border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(29)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
          borderSide: BorderSide(width: 0, color: AppData.kPrimaryLightColor),
        ),
      ),
     /* dropdownSearchDecoration: InputDecoration(
          hintText: label, *//*labelText: label,*//*
          disabledBorder: InputBorder.none,
          contentPadding:
          EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 7),
        floatingLabelBehavior: FloatingLabelBehavior.never),*/

      //label: label,
      showSearchBox: true,
      selectedItem: getData(callFrom),
      onFind: (String filter) async {
        print("DROP DOWN API?????"+API);
        var response = await Dio().get(
          API,
        );
        var list;
        switch (callFrom) {
          case "country":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
          case "state":
            list = KeyvalueModel.fromJsonList(response.data["body"]);
            break;
        }

        return list;
      },
      onChanged: (KeyvalueModel data) {
        fun(data);
      },
    )
    );

  }

}
