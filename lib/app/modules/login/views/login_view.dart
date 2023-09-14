import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/messages/app_message.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';
import 'package:taleb/app/modules/signup/views/signup_view.dart';
import 'package:taleb/app/shared/bottun.dart';
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
        body: SingleChildScrollView(
      child: Column(
        children: [
          Form(
              key: _loginKey,
              child: Container(
                margin: EdgeInsets.only(top: AppConstant.screenHeight * .35),
                padding: EdgeInsets.all(AppConstant.screenHeight * .035),
                child: Column(
                  children: [
                    Edittext(
                      hint: "Adress Email",
                      isemail: true,
                      icon: Icon(Icons.email_outlined),
                      Controller: _emailController,
                    ),
                    SizedBox(
                      height: AppConstant.screenHeight * .03,
                    ),
                    Edittext(
                      hint: "password",
                      ispassword: true,
                      icon: const Icon(Icons.lock),
                      Controller: _passwordController,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: AppConstant.screenHeight * .015, left: 10),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'mote de pass oublie ?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 158, 158, 158),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => HomeView()),
                      child: Button(
                        txt: "Connexion",
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: AppConstant.screenHeight * .07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "je n'ai pas de compte ?  ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 158, 158, 158),
                                // fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () => Get.to(() => SignupView()),
                              child: Text(
                                "S'inscrire.",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 132, 0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
