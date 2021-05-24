import 'dart:convert';
import 'package:e_billing/module/login-page/model/ModelLogin.dart';
import 'package:e_billing/module/widget/Function.dart';
import 'package:e_billing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:e_billing/module/widget/Api.dart';

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    String rtn = "Cannot Connect To Server";
    await API().postData(
      url: UrlApi().login,
      data: {"username": data.name, "password": data.password},
      onComplete: (data, statusCode) {
        if (statusCode == 200) {
          modelLogin = ModelLogin.fromJson(jsonDecode(data));
          rtn = "";
        } else {
          try {
            rtn = jsonDecode(data)['message'];
          } catch (e) {}
        }
      },
    );
    return rtn;
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'E-Billing',
      logo: 'assets/images/logo.png',
      theme: LoginTheme(pageColorLight: Colors.green),
      onLogin: _authUser,
      hideSignUpButton: true,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context)
            .pushReplacementNamed(getRoutesName(RoutesName.homePage));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
