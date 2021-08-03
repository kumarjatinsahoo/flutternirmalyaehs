import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/Const.dart';
import 'package:flutter/material.dart';

//import 'package:matrujyoti/models/LoginResponse.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:user/providers/api_factory.dart';

class RestAPI extends Model {
  var dio = Dio();
  SharedPref sharedPref = SharedPref();
  LoginResponse1 loginData1;

  Map<String, dynamic> failedMap = {
    Const.STATUS: Const.FAILED,
    Const.MESSAGE: Const.NETWORK_ISSUE,
  };

  GETMETHODCALL({@required String api, @required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      Response response = await dio.get(api);
      if (response.statusCode == 200) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.DEFAULT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.RESPONSE) {
        fun(failedMap);
      }
    }
  }

  postSignUp(String token, Map<String, dynamic> json, Function fun) async {
    print(ApiFactory.POST_SIGNUP);
    try {
      //Response response = await dio.post(ApiFactory.POST_SIGNUP+token,data: FormData.fromMap(json));
      Response response = await dio.post(ApiFactory.POST_SIGNUP,
          options: Options(
            headers: {
              "Authorization": token,
            },
          ),
          data: jsonEncode(json));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("api call>>>>");
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(Const.TIMEOUT);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        fun(Const.TIMEOUT);
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        fun(Const.TIMEOUT);
      }
      if (e.type == DioErrorType.DEFAULT) {
        fun(Const.TIMEOUT);
      }
      if (e.type == DioErrorType.RESPONSE) {
        fun(Const.TIMEOUT);
      }
    }
  }

  POSTMETHOD(
      {@required String api,
      @required Map<String, dynamic> json,
      @required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    print("<<>>>>>DATA SEND>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" +
        JsonEncoder().convert(json).toString());
    try {
      Response response = await dio.post(api, data: FormData.fromMap(json));
      if (response.statusCode == 200) {
        try {
          print("RESPONSE CALL>>>>" +
              JsonEncoder().convert(response.data).toString());
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.DEFAULT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.RESPONSE) {
        fun(failedMap);
      }
    }
  }

  setLoginData1(LoginResponse1 loginData) {
    this.loginData1 = loginData;
  }

  Future<bool> POST_METHOD_TRUE(
      {@required String api, @required Map<String, dynamic> json}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      Response response = await dio.post(api, data: FormData.fromMap(json));
      if (response.statusCode == 200) {
        try {
          print("RESPONSE CALL>>>>" +
              JsonEncoder().convert(response.data).toString());
          String status = response.data[Const.STATUS];
          String msg = response.data[Const.MESSAGE];
          print("\n\n\n\n\n\n\n\n\n\n\n\n Hidiiid" + msg.toString());
          if (status == Const.SUCCESS)
            return true;
          else if (status == Const.ALREADY_REG_STATUS)
            return true;
          else
            return false;
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return false;
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        return false;
      }
      if (e.type == DioErrorType.DEFAULT) {
        //fun(failedMap);
        //fun(false);
        return false;
      }
      if (e.type == DioErrorType.RESPONSE) {
        //fun(failedMap);
        //fun(false);
        return false;
      }
    }
  }
}
