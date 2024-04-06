import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/login/controllers/login_controller.dart';
import 'package:taleb/app/modules/login/pages/checkemail.dart';
import 'package:taleb/app/modules/setting/pages/language.dart';
import 'package:taleb/app/modules/signup/views/signup_view.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';
import '../../../config/translations/localization/changelocal.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController controller = Get.put(LoginController());
  final localeController _controller = Get.put(localeController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                
                Form(
                  key: _loginKey,
                  child: Container(
                    margin:
                        EdgeInsets.only(top: AppConstant.screenHeight * .2),
                    padding: EdgeInsets.only(
                        right: AppConstant.screenHeight * .02,
                        left: AppConstant.screenHeight * .02),
                    child: Column(
                      children: [
                         SvgPicture.asset(
          'assets/icons/shape.svg', // Path to your SVG image
          width: AppConstant.screenWidth*.3,
          height: AppConstant.screenHeight*.17,
          color: Colors.red,
        ),
        SizedBox(height: 50,),
                        Edittext(
                          readonly: false,
                          hint: "Address".tr,
                          isemail: true,
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
                          readonly: false,
                          hint: "Mote_de_pass".tr,
                          ispassword: true,
                          icon: const Icon(Icons.lock),
                          Controller: _passwordController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Vide";
                            } else if (value.length < 6) {
                              return "Voter mot de passe est incorrect";
                            }
                            return null; // Input is valid
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: AppConstant.screenHeight * .015, left: 10),
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Get.to(() => CheckEmail()),
                            child: Text(
                              'Forget_Password'.tr,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 158, 158, 158),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inspiration',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_loginKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                await controller.login(_emailController.text,
                                    _passwordController.text);
                              } catch (e) {
                                // Handle errors here
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: Button(
                            txt: "Connexion".tr,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: AppConstant.screenHeight * .07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "creet_compte".tr,
                                  style: const TextStyle(
                                    fontFamily: 'Inspiration',
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 158, 158, 158),
                                    // fontSize: 16,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.to(() => const SignupView()),
                                child: Text(
                                  "Sinscrire".tr,
                                  style: const TextStyle(
                                      fontFamily: 'Inspiration',
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 132, 0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(() => Language());
                          },
                          icon: Icon(
                            Icons.language,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                  // strokeWidth: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
