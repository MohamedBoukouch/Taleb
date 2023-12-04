import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/shared/back.dart';
import 'package:taleb/app/shared/edittext.dart';

class ContactezNous extends StatefulWidget {
  const ContactezNous({Key? key}) : super(key: key);

  @override
  State<ContactezNous> createState() => _ContactezNousState();
}

class _ContactezNousState extends State<ContactezNous> {
  TextEditingController nom_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              left: AppConstant.screenWidth * .05,
              right: AppConstant.screenWidth * .05),
          child: Column(
            children: [
              ButtonBack(),
              Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 15, top: 15),
                      child: Text("Nom et Prénom")),
                  Edittext(
                    Controller: nom_controller,
                    hint: "Nom Complete",
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    child: Text("Address e-mail"),
                  ),
                  Edittext(
                    Controller: email_controller,
                    hint: "Address Email",
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    child: Text("Message"),
                  ),
                  Edittext(
                    Controller: password_controller,
                    hint: "Message",
                  )
                ],
              ),
              SizedBox(
                width: 240, // <-- TextField width
                height: 120, // <-- TextField height
                child: TextField(
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1, //<-- SEE HERE
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      hintText: 'Enter a message'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
