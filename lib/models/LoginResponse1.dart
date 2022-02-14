class LoginResponse1 {
  Body body;
  String message;
  String code;
  String total;

  // LoginResponse1({this.body, this.message, this.code, this.total});

  LoginResponse1();

  LoginResponse1.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    message = json['message'];
    code = json['code'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }

  acceptValue(body){
    // this.body=body;
  }
}

class Body {
  String user;
  String profile;
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
  List<String> roles;
  String roleDashboard;
  String userType;
  String dateFormat;
  String dateFormatId;
  String dateFormatJS;
  String vendorId;
  String otp;
  String token;
  String userPic;
  String calenderId;

  Body(
      {this.user,
      this.userName,
      this.userPassword,
      this.userMobile,
      this.userEmail,
      this.userParent,
      this.userAddress,
      this.userState,
      this.userStateId,
      this.userCountry,
      this.userCountryId,
      this.userDist,
      this.userPin,
      this.userStatus,
      this.userCreatedOn,
      this.userUpdatedOn,
      this.roles,
      this.roleDashboard,
      this.userType,
      this.dateFormat,
      this.dateFormatId,
      this.dateFormatJS,
      this.vendorId,
      this.otp,
      this.token,
      this.userPic,
      });

  Body.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userMobile = json['userMobile'];
    userEmail = json['userEmail'];
    userParent = json['userParent'];
    userAddress = json['userAddress'];
    userState = json['userState'];
    userState = json['userState'];
    userStateId = json['userStateId'];
    userCountryId = json['userCountryId'];
    userDist = json['userDist'];
    userPin = json['userPin'];
    userStatus = json['userStatus'];
    userCreatedOn = json['userCreatedOn'];
    userUpdatedOn = json['userUpdatedOn'];
    roles = json['roles'].cast<String>();
    roleDashboard = json['roleDashboard'];
    userType = json['userType'];
    dateFormat = json['dateFormat'];
    dateFormatId = json['dateFormatId'];
    dateFormatJS = json['dateFormatJS'];
    vendorId = json['vendorId'];
    otp = json['otp'];
    token = json['token'];
    userPic = json['userPic'];
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
    data['userCountryId'] = this.userCountryId;
    data['userCountry'] = this.userCountry;
    data['userStateId'] = this.userStateId;
    data['userDist'] = this.userDist;
    data['userPin'] = this.userPin;
    data['userStatus'] = this.userStatus;
    data['userCreatedOn'] = this.userCreatedOn;
    data['userUpdatedOn'] = this.userUpdatedOn;
    data['roles'] = this.roles;
    data['roleDashboard'] = this.roleDashboard;
    data['userType'] = this.userType;
    data['dateFormat'] = this.dateFormat;
    data['dateFormatId'] = this.dateFormatId;
    data['dateFormatJS'] = this.dateFormatJS;
    data['vendorId'] = this.vendorId;
    data['otp'] = this.otp;
    data['token'] = this.token;
    data['userPic'] = this.userPic;
    return data;
  }
}
