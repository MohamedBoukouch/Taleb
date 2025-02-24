import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/login/pages/resetpassword.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';
import 'package:taleb/app/shared/CustomAlert.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';

class ChangePassword extends StatefulWidget {
  String email;
  ChangePassword({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final SettingController controller = Get.put(SettingController());
  TextEditingController old_password_controller = TextEditingController();

  TextEditingController new_password_controller = TextEditingController();

  TextEditingController confirme_new_password_controller =
      TextEditingController();

  final GlobalKey<FormState> _edit_passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _edit_passwordKey,
        child: Container(
          height: AppConstant.screenHeight * .9,
          padding: EdgeInsets.only(
            right: AppConstant.screenWidth * .07,
            left: AppConstant.screenWidth * .07,
            // bottom: AppConstant.screenHeight * .1
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                width: AppConstant.screenWidth * .2,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Password_Change".tr,
                  style: TextStyle(
                      fontFamily: 'Bitter',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Edittext(
                readonly: false,
                hint: "Old_Password".tr,
                ispassword: true,
                icon: const Icon(Icons.lock),
                Controller: old_password_controller,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vide";
                  } else if (value.length < 6) {
                    return "Voter mot de passe est inférieur de 6 caractére";
                  }
                  return null; // Input is valid
                },
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ResetPassword(
                        email: widget.email,
                      ));
                },
                child: Container(
                    alignment: Alignment.centerRight,
                    child: Text("Forget_Password".tr)),
              ),
              const SizedBox(
                height: 20,
              ),
              Edittext(
                readonly: false,
                hint: "New_Password".tr,
                ispassword: true,
                icon: const Icon(Icons.lock),
                Controller: new_password_controller,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vide";
                  } else if (value.length < 6) {
                    return "Voter mot de passe est inférieur de 6 caractére";
                  }
                  return null; // Input is valid
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Edittext(
                readonly: false,
                hint: "Repeat_New_Password".tr,
                ispassword: true,
                icon: const Icon(Icons.lock),
                Controller: confirme_new_password_controller,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Vide";
                  } else if (value.length < 6) {
                    return "Voter mot de passe est inférieur de 6 caractéreVoter mot de passe est incorrect";
                  } else if (value != confirme_new_password_controller.text) {
                    return "mot de passe et confirmation mot de pass doit etre meme";
                  }
                  return null; // Input is valid
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () async {
                    if (_edit_passwordKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      if(new_password_controller.text == confirme_new_password_controller.text){
                      try {
                        await controller.changepassword(
                            old_password_controller.text,
                            new_password_controller.text,
                            context);
                        old_password_controller.text = "";
                        new_password_controller.text = "";
                        confirme_new_password_controller.text = "";
                      } catch (e) {
                        print(e);
                      }
                      }else{
                        CustomAlert.show(
                        context: context,
                        type: AlertType.info,
                        desc: 'assword and confirm password do not match',
                        onPressed: () {
                        Navigator.pop(context);
                        });                       
                      }
                    
                    }
                  },
                  child: Button(txt: "Save_Password".tr)),
            ],
          ),
        ),
      ),
    );
  }
}
