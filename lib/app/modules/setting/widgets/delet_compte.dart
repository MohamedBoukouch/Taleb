import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';

class DeletCompte extends StatefulWidget {
  const DeletCompte({Key? key}) : super(key: key);

  @override
  State<DeletCompte> createState() => _DeletCompteState();
}

class _DeletCompteState extends State<DeletCompte> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: AppConstant.screenHeight * .014),
          width: AppConstant.screenWidth * .8,
          height: AppConstant.screenHeight * .064,
          decoration: BoxDecoration(
            color: Color.fromARGB(68, 255, 81, 0),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Text(
              "Supprimer mon compte",
              style: TextStyle(
                  fontFamily: 'Inspiration',
                  color: Colors.red,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: AppConstant.screenWidth * .14,
              height: AppConstant.screenHeight * .07,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(28)),
              child: Image(
                image: AssetImage("assets/icons/delet_icon.png"),
                color: Colors.red,
              ),
            )),
      ],
    );
  }
}
