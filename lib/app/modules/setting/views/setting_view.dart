import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';
import 'package:taleb/app/shared/edittext.dart';

import '../controllers/setting_controller.dart';

// class SettingView extends GetView<SettingController> {

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  TextEditingController _nom = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 0,
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        "https://th.bing.com/th/id/OIP.6nsKk7mIkSKvYZD_APa8-AHaFk?pid=ImgDet&rs=1"),
                  ),
                ),
              ),
              Positioned(
                bottom: AppConstant.screenHeight * .025,
                right: AppConstant.screenWidth * .32,
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
          Edittext(
            Controller: _nom,
            hint: "Nom",
          ),
          Edittext(
            Controller: _nom,
            hint: "Prenom",
          ),
          Edittext(
            Controller: _nom,
            hint: "Email",
          ),
          Edittext(
            Controller: _nom,
            hint: "Password",
          ),
        ],
      ),
    );
  }
}
