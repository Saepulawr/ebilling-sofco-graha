class ModelLogin {
  bool? status;
  String? message;
  Data? data;
  String? token;

  ModelLogin({this.status, this.message, this.data, this.token});

  ModelLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? oauthUid;
  String? oauthProvider;
  String? username;
  String? fullName;
  String? avatar;
  String? banned;
  String? lastLogin;
  String? lastActivity;
  String? dateCreated;
  String? forgotExp;
  String? rememberTime;
  String? rememberExp;
  String? verificationCode;
  String? topSecret;
  String? ipAddress;
  String? telp;
  String? jabatan;

  Data(
      {this.id,
      this.email,
      this.oauthUid,
      this.oauthProvider,
      this.username,
      this.fullName,
      this.avatar,
      this.banned,
      this.lastLogin,
      this.lastActivity,
      this.dateCreated,
      this.forgotExp,
      this.rememberTime,
      this.rememberExp,
      this.verificationCode,
      this.topSecret,
      this.ipAddress,
      this.telp,
      this.jabatan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    oauthUid = json['oauth_uid'];
    oauthProvider = json['oauth_provider'];
    username = json['username'];
    fullName = json['full_name'];
    avatar = json['avatar'];
    banned = json['banned'];
    lastLogin = json['last_login'];
    lastActivity = json['last_activity'];
    dateCreated = json['date_created'];
    forgotExp = json['forgot_exp'];
    rememberTime = json['remember_time'];
    rememberExp = json['remember_exp'];
    verificationCode = json['verification_code'];
    topSecret = json['top_secret'];
    ipAddress = json['ip_address'];
    telp = json['telp'];
    jabatan = json['jabatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['oauth_uid'] = this.oauthUid;
    data['oauth_provider'] = this.oauthProvider;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['avatar'] = this.avatar;
    data['banned'] = this.banned;
    data['last_login'] = this.lastLogin;
    data['last_activity'] = this.lastActivity;
    data['date_created'] = this.dateCreated;
    data['forgot_exp'] = this.forgotExp;
    data['remember_time'] = this.rememberTime;
    data['remember_exp'] = this.rememberExp;
    data['verification_code'] = this.verificationCode;
    data['top_secret'] = this.topSecret;
    data['ip_address'] = this.ipAddress;
    data['telp'] = this.telp;
    data['jabatan'] = this.jabatan;
    return data;
  }
}
