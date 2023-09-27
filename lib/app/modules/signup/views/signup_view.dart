import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/messages/app_message.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:taleb/app/modules/signup/controllers/signup_controller.dart';
import 'package:taleb/app/modules/signup/views/signup_view.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  // final TextEditingController _confirmpasswordController =
  // TextEditingController();

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Form(
              key: _signupKey,
              child: Container(
                margin: EdgeInsets.only(top: AppConstant.screenHeight * .17),
                padding: EdgeInsets.all(AppConstant.screenHeight * .035),
                child: Column(
                  children: [
                    Edittext(
                      hint: "Nom",
                      icon: Icon(Icons.person_2_outlined),
                      Controller: _nomController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Vide";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppConstant.screenHeight * .03,
                    ),
                    Edittext(
                      hint: "Prenom",
                      isemail: true,
                      icon: Icon(Icons.person_2_outlined),
                      Controller: _prenomController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Vide";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppConstant.screenHeight * .03,
                    ),
                    Edittext(
                      hint: "Adress Email",
                      isemail: true,
                      ispassword: false,
                      icon: Icon(Icons.email_outlined),
                      Controller: _emailController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Vide";
                        } else if (!value.contains("@") ||
                            !value.contains(".")) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppConstant.screenHeight * .03,
                    ),
                    Edittext(
                      hint: "password",
                      ispassword: true,
                      icon: const Icon(Icons.lock),
                      Controller: _passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Vide";
                        } else if (value.length < 6) {
                          return "Entrez un mot de passe supérieur à 6 caractères";
                        }

                        return null; // Input is valid
                      },
                    ),
                    SizedBox(
                      height: AppConstant.screenHeight * .03,
                    ),
                    // Edittext(
                    //   hint: "Confirme password",
                    //   icon: const Icon(Icons.lock),
                    //   Controller: _confirmpasswordController,
                    // ),
                    SizedBox(
                      height: AppConstant.screenHeight * .03,
                    ),
                    InkWell(
                      onTap: ()async {
                            if (_signupKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              try {
                                  await controller.signup(
                            _nomController.text,
                            _prenomController.text,
                            _emailController.text,
                            _passwordController.text);
                              }  catch (e) {
                               
                              }
                            }
                          },
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
                              "Je ai déjà un compte?  ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 158, 158, 158),
                                // fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () => Get.to(() => LoginView()),
                              child: Text(
                                "Se connecter.",
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
