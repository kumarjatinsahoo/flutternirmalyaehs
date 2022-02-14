class MasterLoginResponse {
  List<Body> body;
  String message;
  String code;
  // String total;

  MasterLoginResponse({this.body, this.message, this.code,});

  MasterLoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['body'] != String) {
      body = new List<Body>();
      json['body'].forEach((v) {
        body.add(new Body.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
    // total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != String) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    // data['total'] = this.total;
    return data;
  }
}

class Body {
  String user;
  String userName;
  String userPassword;
  String userMobile;
  String userEmail;
  String userParent;
  String userAddress;
  String userState;
  String userStateId;
  String userCountry;
  String userCountryId;
  String userDist;
  String userPin;
  bool userStatus;
  String userCreatedOn;
  String userUpdatedOn;
  String roleDashboard;
  String userType;
  String dateFormat;
  String dateFormatId;
  String dateFormatJS;
  String vendorId;
  String otp;
  String token;
  String profilePic;

  Body(
      {this.user,
        this.userName,
        this.userPassword,
        this.userMobile,
        this.userEmail,
        this.userParent,
        this.userAddress,
        this.userState,
        this.userCountry,
        this.userStateId,
        this.userCountryId,
        this.userDist,
        this.userPin,
        this.userStatus,
        this.userCreatedOn,
        this.userUpdatedOn,
        this.roleDashboard,
        this.userType,
        this.dateFormat,
        this.dateFormatId,
        this.dateFormatJS,
        this.vendorId,
        this.otp,
        this.token});

  Body.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userMobile = json['userMobile'];
    userEmail = json['userEmail'];
    userParent = json['userParent'];
    userAddress = json['userAddress'];
    userState = json['userState'];
    userStateId = json['userStateId'];
    userCountry = json['userCountry'];
    userCountryId = json['userCountryId'];
    userStateId = json['userStateId'];
    userDist = json['userDist'];
    userPin = json['userPin'];
    userStatus = json['userStatus'];
    userCreatedOn = json['userCreatedOn'];
    userUpdatedOn = json['userUpdatedOn'];
    roleDashboard = json['roleDashboard'];
    userType = json['userType'];
    dateFormat = json['dateFormat'];
    dateFormatId = json['dateFormatId'];
    dateFormatJS = json['dateFormatJS'];
    vendorId = json['vendorId'];
    otp = json['otp'];
    token = json['token'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userMobile'] = this.userMobile;
    data['userEmail'] = this.userEmail;
    data['userParent'] = this.userParent;
    data['userAddress'] = this.userAddress;
    data['userState'] = this.userState;
    data['userStateId'] = this.userStateId;
    data['userCountry'] = this.userCountry;
    data['userCountryId'] = this.userCountryId;
    data['userDist'] = this.userDist;
    data['userPin'] = this.userPin;
    data['userStatus'] = this.userStatus;
    data['userCreatedOn'] = this.userCreatedOn;
    data['userUpdatedOn'] = this.userUpdatedOn;
    data['roleDashboard'] = this.roleDashboard;
    data['userType'] = this.userType;
    data['dateFormat'] = this.dateFormat;
    data['dateFormatId'] = this.dateFormatId;
    data['dateFormatJS'] = this.dateFormatJS;
    data['vendorId'] = this.vendorId;
    data['otp'] = this.otp;
    data['token'] = this.token;
    data['profilePic'] = this.profilePic;
    return data;
  }
}
