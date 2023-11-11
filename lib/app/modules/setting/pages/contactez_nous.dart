import 'package:flutter/material.dart';
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
        child: Column(
          children: [
            ButtonBack(),
            Column(
              children: [
                Text("Nom et Prénom"),
                Edittext(
                  Controller: nom_controller,
                )
              ],
            ),
            Column(
              children: [
                Text("Nom et Prénom"),
                Edittext(
                  Controller: email_controller,
                )
              ],
            ),
            Column(
              children: [
                Text("Nom et Prénom"),
                Edittext(
                  Controller: password_controller,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
