import 'dart:convert';
import 'package:e_billing/module/login/model/ModelLogin.dart';
import 'package:e_billing/module/provider/ProviderPublic.dart';
import 'package:e_billing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:e_billing/module/widget/Api.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<String> _authUser(BuildContext context, LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    String rtn = "Cannot Connect To Server";
    await API().postData(
      url: UrlApi().login,
      data: {"username": data.name, "password": data.password},
      onComplete: (data, statusCode) {
        if (statusCode == 200) {
          Provider.of<ProviderPublic>(context, listen: false)
              .setModelLogin(ModelLogin.fromJson(jsonDecode(data)));

          Navigator.of(context)
              .pushReplacementNamed(getRoutesName(RoutesName.homePage));
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
    return Future.delayed(Duration(seconds: 1)).then((_) {
      return "";
    });
  }

  @override
  void initState() {
    super.initState();
    // _authUser(
    //     context, LoginData(name: "sales1@ebilling.com", password: "password"));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'E-Billing',
      logo: 'assets/images/logo.png',
      theme: LoginTheme(pageColorLight: Colors.green),
      onLogin: (logindata) {
        _authUser(context, logindata);
      },
      hideSignUpButton: true,
      onSignup: (logindata) {
        _authUser(context, logindata);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context)
            .pushReplacementNamed(getRoutesName(RoutesName.homePage));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
