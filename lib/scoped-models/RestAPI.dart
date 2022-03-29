import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:user/localization/application.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/models/HealthChartResponse.dart';
import 'package:user/models/MasterLoginResponse.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/Const.dart';
import 'package:flutter/material.dart';

//import 'package:matrujyoti/models/LoginResponse.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';

import 'PassData.dart';
class RestAPI extends Model with PassData{
  var dio = Dio();
  SharedPref sharedPref = SharedPref();
  LoginResponse1 loginData1;
  MasterLoginResponse loginData;
  HealthChartResponse healthChartData;
  Map<String, dynamic> failedMap = {
    Const.STATUS: Const.FAILED,
    Const.MESSAGE: Const.NETWORK_ISSUE,
  };
  GETMETHODCAL({@required String api, @required Function fun}) async {
    // print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
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
      /*if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.SEND_TIMEOUT) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.DEFAULT) {
        fun(failedMap);
      }*/
      fun(failedMap);
    }
  }

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
     /* if (e.type == DioErrorType.CONNECT_TIMEOUT) {
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
      }*/
      fun(failedMap);
    }
  }



  GETMETHODCALL_TOKEN(
      {@required String api, @required Function fun, String token}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      Response response = await dio.get(
        api,
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
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
     /* if (e.type == DioErrorType.CONNECT_TIMEOUT) {
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
      }*/
      log("Token EXpire>>>"+jsonEncode(e.response.data)+"Status code>>>"+e.response.statusCode.toString());
      if(e.response.statusCode==401 && e.response.data.containsKey("error") && e.response.data["error"]=="Unauthorized"){
        log("Token EXpire Inner>>>"+jsonEncode(e.response.data)+"Status code>>>"+e.response.statusCode.toString());
        // application.logoutCallBack();
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.user);
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.userMobile);
        sharedPref.save(Const.IS_LOGIN, false.toString());
        sharedPref.save(Const.IS_REGISTRATION, false.toString());
        sharedPref.remove(Const.IS_REGISTRATION);
        sharedPref.remove(Const.IS_LOGIN);
        sharedPref.remove(Const.LOGIN_DATA);
        sharedPref.remove(Const.IS_REG_SERVER);
        sharedPref.remove(Const.MASTER_RESPONSE);
        AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
        Navigator.of(Const.navigatorKey.currentContext)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        // AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
      }else {
        fun(failedMap);
      }
    }
  }
  DELETEMETHODCALL_TOKEN(
      {@required String api, @required Function fun, String token}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      Response response = await dio.delete(
        api,
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
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
     /* if (e.type == DioErrorType.CONNECT_TIMEOUT) {
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
      }*/
      if(e.response.statusCode==401 && e.response.data.containsKey("error") && e.response.data["error"]=="Unauthorized"){
        // application.logoutCallBack;
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.user);
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.userMobile);
        sharedPref.save(Const.IS_LOGIN, false.toString());
        sharedPref.save(Const.IS_REGISTRATION, false.toString());
        sharedPref.remove(Const.IS_REGISTRATION);
        sharedPref.remove(Const.IS_LOGIN);
        sharedPref.remove(Const.LOGIN_DATA);
        sharedPref.remove(Const.IS_REG_SERVER);
        sharedPref.remove(Const.MASTER_RESPONSE);
        AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
        Navigator.of(Const.navigatorKey.currentContext)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        // AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
      }else {
        fun(failedMap);
      }
    }
  }

  GETMETHODCALL_TOKEN_FORM(
      {@required String api, @required Function fun, String token,@required String userId}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      Map<String,dynamic> mapData={"id":userId};
      Response response = await dio.get(api,
        queryParameters: mapData,
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );
      if (response.statusCode == 200) {
        try {
          fun(response.data);
          print("Message is: " + response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
        //print("Message is: " + response.data);
      }
    } on DioError catch (e) {
      /*if (e.type == DioErrorType.CONNECT_TIMEOUT) {
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
      }*/
      if(e.response.statusCode==401 && e.response.data.containsKey("error") && e.response.data["error"]=="Unauthorized"){
        // application.logoutCallBack;
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.user);
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.userMobile);
        sharedPref.save(Const.IS_LOGIN, false.toString());
        sharedPref.save(Const.IS_REGISTRATION, false.toString());
        sharedPref.remove(Const.IS_REGISTRATION);
        sharedPref.remove(Const.IS_LOGIN);
        sharedPref.remove(Const.LOGIN_DATA);
        sharedPref.remove(Const.IS_REG_SERVER);
        sharedPref.remove(Const.MASTER_RESPONSE);
        AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
        Navigator.of(Const.navigatorKey.currentContext)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        // AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
      }else {
        fun(failedMap);
      }
      // fun(failedMap);
    }
  }

  postSignUp(String token, Map<String, dynamic> json, Function fun) async {
    print(ApiFactory.POST_SIGNUP);
    print("TOKEN>>>>Authorization>" + token);
    try {
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
      /*if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        fun(Const.TIMEOUT);
      }
      if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        fun(Const.TIMEOUT);
      }
      if (e.type == DioErrorType.DEFAULT) {
        fun(Const.TIMEOUT);
      }
      if (e.type == DioErrorType.RESPONSE) {*/
        //fun(Const.TIMEOUT);
      //}
      if(e.response.statusCode==401 && e.response.data.containsKey("error") && e.response.data["error"]=="Unauthorized"){
        // application.logoutCallBack;
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.user);
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.userMobile);
        sharedPref.save(Const.IS_LOGIN, false.toString());
        sharedPref.save(Const.IS_REGISTRATION, false.toString());
        sharedPref.remove(Const.IS_REGISTRATION);
        sharedPref.remove(Const.IS_LOGIN);
        sharedPref.remove(Const.LOGIN_DATA);
        sharedPref.remove(Const.IS_REG_SERVER);
        sharedPref.remove(Const.MASTER_RESPONSE);
        AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
        Navigator.of(Const.navigatorKey.currentContext)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

      }else {
        fun(failedMap);
      }
       // fun(failedMap);
    }
  }

  // postSignUp1(String token, Map<String, dynamic> json, Function fun) async {
  //   print(ApiFactory.LAB_SIGNUP);
  //   try {
  //     //Response response = await dio.post(ApiFactory.POST_SIGNUP+token,data: FormData.fromMap(json));
  //
  //     print(jsonEncode(json));
  //     Response response = await dio.post(ApiFactory.POST_SIGNUP,
  //         options: Options(
  //           headers: {
  //             "Authorization": token,
  //           },
  //         ),
  //         data: jsonEncode(json));
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print("api call>>>>");
  //       try {
  //         fun(response.data);
  //       } catch (e) {
  //         print("Message is: " + e.toString());
  //       }
  //     } else {
  //       fun(Const.TIMEOUT);
  //     }
  //   } on DioError catch (e) {
  //     if (e.type == DioErrorType.CONNECT_TIMEOUT) {
  //       fun(Const.TIMEOUT);
  //     }
  //     if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
  //       fun(Const.TIMEOUT);
  //     }
  //     if (e.type == DioErrorType.DEFAULT) {
  //       fun(Const.TIMEOUT);
  //     }
  //     if (e.type == DioErrorType.RESPONSE) {
  //       fun(Const.TIMEOUT);
  //     }
  //   }
  // }
  POSTMETHODFROMDATA(
      {@required String api, @required Map<String, dynamic> json, @required Function fun}) async {
    print(json.toString());
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    print("<<>>>>>DATA SEND>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + JsonEncoder().convert(json).toString());
    try {
      Response response = await dio.post(api, data: FormData.fromMap(json));
      if (response.statusCode == 200||response.statusCode == 201 ) {
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

  POSTMETHOD(
      {@required String api,
      @required Map<String, dynamic> json,
      @required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    print("<<>>>>>DATA SEND>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" +
        JsonEncoder().convert(json).toString());
    try {
      Response response = await dio.post(api, data: jsonEncode(json));
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
       /*if (e.type == DioErrorType.connectTimeout) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.receiveTimeout) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.cancel) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.response) {
        fun(failedMap);
      }*/
      fun(failedMap);
      /*fun(failedMap);*/
      //fun(failedMap);
    }
  }

  PUSH_NOTIFICATION(
      {@required Map<String, dynamic> json,
      @required Function fun}) async {
    print("<<>>>>>DATA SEND>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" +
        JsonEncoder().convert(json).toString());
    try {
      Response response = await dio.post("https://fcm.googleapis.com/fcm/send",options: Options(
        headers: {
          "Authorization": "key=AAAAES5j-YA:APA91bGiyZ3MUS9BEt2y6om5T8e_kStvlV9JD2YZ20uDFOT_z4NWqs6wplhMpyBmxSycIKCa3ifAb8qTZOT0jIG9GLIT6heXKFg156eIN_c-fsHg7KZHLYYQgKAfcdT9grq6pJFmzw7r",
        },
      ), data: jsonEncode(json));
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
      /* if (e.type == DioErrorType.connectTimeout) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.receiveTimeout) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.cancel) {
        fun(failedMap);
      }
      if (e.type == DioErrorType.response) {
        fun(failedMap);
      }*/
      fun(failedMap);
      //fun(failedMap);
      //fun(failedMap);
    }
  }
  POSTMETHOD2(
      {@required String api,
        String token,
        @required Map<String, dynamic> json,
        @required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    print("<<>>>>>DATA SEND>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" +
        JsonEncoder().convert(json).toString());
    try {
      Response response = await dio.post(api,
          options: Options(
            headers: {
              "Authorization": token,
            },
          ),
          data: jsonEncode(json));
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
      /*if (e.type == DioErrorType.CONNECT_TIMEOUT) {
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
      }*/
      // fun(failedMap);
      if(e.response.statusCode==401 && e.response.data.containsKey("error") && e.response.data["error"]=="Unauthorized"){
        // application.logoutCallBack;
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.user);
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.userMobile);
        sharedPref.save(Const.IS_LOGIN, false.toString());
        sharedPref.save(Const.IS_REGISTRATION, false.toString());
        sharedPref.remove(Const.IS_REGISTRATION);
        sharedPref.remove(Const.IS_LOGIN);
        sharedPref.remove(Const.LOGIN_DATA);
        sharedPref.remove(Const.IS_REG_SERVER);
        sharedPref.remove(Const.MASTER_RESPONSE);
        AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
        Navigator.of(Const.navigatorKey.currentContext)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }else {
        fun(failedMap);
      }
    }
  }
  POSTMETHOD1(
      {@required String api,
      String token,
      @required Map<String, dynamic> json,
      @required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    print("<<>>>>>DATA SEND>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" +
        JsonEncoder().convert(json).toString());
    try {
      Response response = await dio.post(api,
          options: Options(
            headers: {
              "Authorization": token,
            },
          ),
          data: jsonEncode(json));
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
      /*if (e.type == DioErrorType.CONNECT_TIMEOUT) {
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
      }*/
      // fun(failedMap);
      if(e.response.statusCode==401 && e.response.data.containsKey("error") && e.response.data["error"]=="Unauthorized"){
        // application.logoutCallBack;
        FirebaseMessaging.instance.unsubscribeFromTopic(loginResponse1.body.user);
        FirebaseMessaging.instance.unsubscribeFromTopic(loginResponse1.body.userMobile);
        sharedPref.save(Const.IS_LOGIN, false.toString());
        sharedPref.save(Const.IS_REGISTRATION, false.toString());
        sharedPref.remove(Const.IS_REGISTRATION);
        sharedPref.remove(Const.IS_LOGIN);
        sharedPref.remove(Const.LOGIN_DATA);
        sharedPref.remove(Const.IS_REG_SERVER);
        sharedPref.remove(Const.MASTER_RESPONSE);
        AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
        Navigator.of(Const.navigatorKey.currentContext).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }else {
        fun(failedMap);
      }
    }
  }

  POSTMETHOD_TOKEN(
      {@required String api,
      json,
      @required Function fun,
      String token}) async {
     print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    // print("<<>>>>>JSON CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + json);
    try {
      Response response = await dio.post(api,
          options: Options(
            headers: {
              "Authorization": token,
            },
          ),
          data: jsonEncode(json));
      if (response.statusCode == 200) {
        try {
          print("RESPONSE CALL>>>>" + JsonEncoder().convert(response.data).toString());
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      /*if (e.type == DioErrorType.CONNECT_TIMEOUT) {
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
      }*/
      // fun(failedMap);

      if (e.type == DioErrorType.RESPONSE) {
       log("RESPONSE FROM SERVER"+jsonEncode(e.response.data));
       fun(e.response.data);
      }

      if(e.response.statusCode==401 && e.response.data.containsKey("error") && e.response.data["error"]=="Unauthorized"){
        // application.logoutCallBack;
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.user);
        FirebaseMessaging.instance
            .unsubscribeFromTopic(loginResponse1.body.userMobile);
        sharedPref.save(Const.IS_LOGIN, false.toString());
        sharedPref.save(Const.IS_REGISTRATION, false.toString());
        sharedPref.remove(Const.IS_REGISTRATION);
        sharedPref.remove(Const.IS_LOGIN);
        sharedPref.remove(Const.LOGIN_DATA);
        sharedPref.remove(Const.IS_REG_SERVER);
        sharedPref.remove(Const.MASTER_RESPONSE);
        AppData.showInSnackDone(Const.navigatorKey.currentContext, "Session Logged out");
        Navigator.of(Const.navigatorKey.currentContext)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }else {
        log("");
        // fun(failedMap);
      }
    }
  }

  setLoginData1(LoginResponse1 loginData) {
    this.loginData1 = loginData;
  }

  LoginResponse1 get loginResponse1 {
    return loginData1;
  }
  MasterLoginResponse get loginResponse {
    return loginData;
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
      /*if (e.type == DioErrorType.CONNECT_TIMEOUT) {
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
      }*/
      return false;
    }
  }
  HealthChartResponse get healthChartResponse {
    return healthChartData;
  }
}
