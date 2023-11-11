import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
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
  TextEditingController old_password_controller = TextEditingController();

  TextEditingController new_password_controller = TextEditingController();

  TextEditingController confirme_new_password_controller =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    nom_controller.text = "${widget.nom}";
    prenom_controller.text = "${widget.prenom}";
    email_controller.text = "${widget.email}";
    password_controller.text = "*********";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                right: AppConstant.screenWidth * .05,
                left: AppConstant.screenWidth * .05),
            child: Column(
              children: [
                ButtonBack(),
                SizedBox(
                  height: AppConstant.screenHeight * .05,
                ),
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(24, 255, 153, 0),
                      radius: 25,
                      child: Image(
                        image: AssetImage("assets/icons/compte.png"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Mon Compte",
                      style: TextStyle(
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
                  icon: Icon(Icons.person_2_outlined),
                  Controller: nom_controller,
                  hint: "Nom",
                ),
                SizedBox(
                  height: 10,
                ),
                Edittext(
                  icon: Icon(Icons.person_2_outlined),
                  Controller: prenom_controller,
                  hint: "Prenom",
                ),
                SizedBox(
                  height: 10,
                ),
                Edittext(
                  icon: Icon(Icons.email_outlined),
                  Controller: email_controller,
                  hint: "Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                top: 20, bottom: 20),
                                            child: Text(
                                              "Password Change",
                                              style: TextStyle(
                                                  fontFamily: 'Bitter',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                        Edittext(
                                          ispassword: true,
                                          hint: "Old Password",
                                          Controller: old_password_controller,
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
                                          Controller: old_password_controller,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Edittext(
                                          ispassword: true,
                                          hint: "Repeat New Password",
                                          Controller: old_password_controller,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Button(txt: "Save Password"),
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
                    Edittext(
                      icon: Icon(Icons.lock),
                      ispassword: true,
                      Controller: password_controller,
                      hint: "Nouveau mot de passe",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Edittext(
                //   icon: Icon(Icons.lock),
                //   ispassword: true,
                //   Controller: password_controller,
                //   hint: "Confirmation mot de passe",
                // ),
                SizedBox(
                  height: AppConstant.screenHeight * .07,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: AppConstant.screenWidth * .15,
                      right: AppConstant.screenWidth * .15),
                  child: const Button(
                    txt: "Enreristrer",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
