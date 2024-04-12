import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';
import 'package:taleb/app/modules/login/controllers/login_controller.dart';
import 'package:taleb/app/modules/login/pages/verifycompte.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';

import '../../../shared/back.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _resetpasswordlKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final LoginController controller = Get.put(LoginController());
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ButtonBack(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16), // Add left padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text("Reset_Password".tr,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Bitter',fontSize: 20),),
              Text("Reset_Password_info".tr,style: TextStyle(fontFamily: 'Bitter'),),
              SizedBox(
                height: AppConstant.screenHeight * .05,
              ),
              Form(
                key: _resetpasswordlKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Mote_de_pass".tr,
                        style: TextStyle(color: Colors.grey),
                      ),
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
                            return "Entrez un mot de passe supérieur à 6 caractères";
                          }
          
                          return null; // Input is valid
                        },
                        onSaved: (value) {
                          _password = value;
                        },
                      ),
                      SizedBox(height: 15),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Repeat_New_Password".tr,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Edittext(
                        hint: "Repeat_New_Password".tr,
                        readonly: false,
                        ispassword: true,
                        icon: const Icon(Icons.lock),
                        Controller: _confirmpasswordController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Vide";
                          } else if (value.length < 6) {
                            return "Entrez un mot de passe supérieur à 6 caractères";
                          } else {
                            return null;
                          }
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () async {
                  if (_resetpasswordlKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    try {
                      await controller.resetpassword(
                          widget.email, _passwordController.text, context);
                    } catch (e) {}
                  }
                },
                child: Button(
                  txt: "Envoyer".tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
