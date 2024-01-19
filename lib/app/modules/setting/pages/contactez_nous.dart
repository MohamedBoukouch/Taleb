import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/shared/back.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';

class ContactezNous extends StatefulWidget {
  const ContactezNous({Key? key}) : super(key: key);

  @override
  State<ContactezNous> createState() => _ContactezNousState();
}

class _ContactezNousState extends State<ContactezNous> {
  TextEditingController _nom_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _message = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize your controller here
    // For example, if you're using a TextEditingController:
    _email_controller.text = "Taleb@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the default back button
        title: ButtonBack(), // Your back button widget
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
                left: AppConstant.screenWidth * .05,
                right: AppConstant.screenWidth * .05),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 15, top: 15),
                        child: Text("Nom_Prenom".tr)),
                    Edittext(
                      Controller: _nom_controller,
                      hint: "Nom_Complete".tr,
                      readonly: false,
                      icon: Icon(
                        Icons.person,
                        color: Colors.orange,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 15, top: 15),
                      child: Text("Address".tr),
                    ),
                    Edittext(
                      Controller: _email_controller,
                      hint: "Address Email",
                      readonly: true,
                      icon: Icon(
                        Icons.mail,
                        color: Colors.orange,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 15, top: 15),
                      child: Text(
                        "Message".tr,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  height: AppConstant.screenHeight * .23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.orange,

                      width: 2, // Adjust the width as needed
                    ),
                  ),
                  child: TextFormField(
                    maxLines: 5,
                    controller: _message,
                    style: TextStyle(
                      color: Colors.black, // Set the text color to red
                    ),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.abc,
                          color: Colors.white,
                        ),
                        hintText: "Message".tr,
                        hintStyle: const TextStyle(color: Color(0xFF555353)),
                        alignLabelWithHint: true),
                  ),
                ),
                SizedBox(
                  height: AppConstant.screenHeight * .05,
                ),
                Button(
                  txt: "Envoyer".tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
