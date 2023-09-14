import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/messages/app_message.dart';
import 'package:taleb/app/shared/edittext.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Form(
            key: _loginKey,
            child: Container(
              margin: EdgeInsets.only(top: AppConstant.screenHeight * .35),
              padding: EdgeInsets.all(AppConstant.screenHeight * .035),
              child: Column(
                children: [
                  Edittext(
                    hint: "password",
                    ispassword: true,
                    icon: Icon(Icons.password_sharp),
                  ),
                  SizedBox(
                    height: AppConstant.screenHeight * .02,
                  ),
                  Edittext(
                    hint: "password",
                    ispassword: true,
                    icon: Icon(Icons.password_sharp),
                  ),
                  Container(
                    child: Text('mote de pass oublie'),
                  ),
                ],
              ),
            ))
      ],
    ));
  }
}
