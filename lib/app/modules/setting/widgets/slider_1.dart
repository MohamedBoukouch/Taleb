import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';

class Slider_1 extends StatefulWidget {
  final String nom;
  final String email;
  const Slider_1({Key? key, required this.nom, required this.email})
      : super(key: key);

  @override
  State<Slider_1> createState() => _Slider_1State();
}

class _Slider_1State extends State<Slider_1> {
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(47, 255, 153, 0),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              "https://th.bing.com/th/id/OIP.6nsKk7mIkSKvYZD_APa8-AHaFk?pid=ImgDet&rs=1"),
        ),
        title: Text(
          "${widget.nom}",
          style: TextStyle(
              fontFamily: 'Bitter', fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          "${widget.email}",
          style: TextStyle(fontFamily: 'Bitter'),
        ),
      ),
    );
  }
}
