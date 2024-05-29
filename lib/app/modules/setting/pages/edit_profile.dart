import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';
import 'package:taleb/app/modules/setting/widgets/password_change.dart';
import 'package:taleb/app/shared/back.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';

class EditProfile extends StatefulWidget {
  final String nom;
  final String prenom;
  final String email;
  const EditProfile({
    Key? key,
    required this.nom,
    required this.prenom,
    required this.email,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nom_controller = TextEditingController();
  TextEditingController prenom_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  final SettingController controller = Get.put(SettingController());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    nom_controller.text = widget.nom;
    prenom_controller.text = widget.prenom;
    email_controller.text = widget.email;
    password_controller.text = "*********";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the default back button
        leading: ButtonBack(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: AppConstant.screenWidth * .05,
                  left: AppConstant.screenWidth * .05),
              child: Column(
                children: [
                  SizedBox(
                    height: AppConstant.screenHeight * .05,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color.fromARGB(24, 255, 153, 0),
                        radius: 25,
                        child: Image(
                          image: AssetImage("assets/icons/compte.png"),
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Mon_Compte".tr,
                        style: const TextStyle(
                            fontFamily: 'Bitter',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppConstant.screenHeight * .06,
                  ),
                  Edittext(
                    readonly: false,
                    icon: Icon(Icons.person_2_outlined),
                    Controller: nom_controller,
                    hint: "Nom".tr,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Edittext(
                    readonly: false,
                    icon: Icon(Icons.person_2_outlined),
                    Controller: prenom_controller,
                    hint: "Prenom".tr,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Edittext(
                    readonly: false,
                    icon: Icon(Icons.email_outlined),
                    Controller: email_controller,
                    hint: "Email",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //ChangePassword(),
                  ListTile(
                    trailing: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ChangePassword(
                              email: widget.email,
                            );
                          },
                        );
                      },
                      child: Text(
                        "Change".tr,
                        style: TextStyle(
                          fontFamily: 'Bitter',
                        ),
                      ),
                    ),
                    leading: Text(
                      "Mote_de_pass".tr,
                      style: TextStyle(
                          fontFamily: 'Bitter',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  Edittext(
                    readonly: false,
                    icon: Icon(Icons.lock),
                    ispassword: true,
                    Controller: password_controller,
                    hint: "Nouveau mot de passe",
                  ),
                  SizedBox(
                    height: AppConstant.screenHeight * .08,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: AppConstant.screenWidth * .15,
                        right: AppConstant.screenWidth * .15),
                    child: InkWell(
                      onTap: () async {
                        try {
                          await controller.edit_compte(
                              "${nom_controller.text}",
                              "${prenom_controller.text}",
                              "${email_controller.text}",
                              context);
                        } catch (e) {
                          print("ggggg");
                        }
                      },
                      child: Button(
                        txt: "Enreristrer".tr,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
