import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

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
    return Column(
      children: [
        Form(
          key: _edit_passwordKey,
          child: Container(
            child: ListTile(
              trailing: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: AppConstant.screenWidth * .07,
                              left: AppConstant.screenWidth * .07),
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
                                  "Password Change",
                                  style: TextStyle(
                                      fontFamily: 'Bitter',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Edittext(
                                ispassword: true,
                                hint: "Old Password",
                                Controller: old_password_controller,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Vide";
                                  } else if (value.length < 6) {
                                    return "Voter mot de passe est incorrect";
                                  }

                                  return null; // Input is valid
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text("Forget Password ?")),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Edittext(
                                ispassword: true,
                                hint: "New Password",
                                Controller: new_password_controller,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Vide";
                                  } else if (value.length < 6) {
                                    return "Voter mot de passe est incorrect";
                                  }

                                  return null; // Input is valid
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Edittext(
                                ispassword: true,
                                hint: "Repeat New Password",
                                Controller: confirme_new_password_controller,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Vide";
                                  } else if (value.length < 6) {
                                    return "Voter mot de passe est incorrect";
                                  }

                                  return null; // Input is valid
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  onTap: () async {
                                    if (_edit_passwordKey.currentState!
                                        .validate()) {
                                      FocusScope.of(context).unfocus();
                                      try {
                                        await controller.changepassword(
                                            old_password_controller.text,
                                            new_password_controller.text,
                                            context);
                                        old_password_controller.text = "";
                                        new_password_controller.text = "";
                                        confirme_new_password_controller.text =
                                            "";
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                  child: Button(txt: "Save Password")),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Change",
                  style: TextStyle(
                    fontFamily: 'Bitter',
                  ),
                ),
              ),
              leading: Text(
                "Mote de pass",
                style: TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
