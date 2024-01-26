import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';
import 'package:taleb/app/modules/setting/widgets/type_concoure.dart';

class TypeOfOneCnc extends StatefulWidget {
  const TypeOfOneCnc({Key? key}) : super(key: key);

  @override
  State<TypeOfOneCnc> createState() => _TypeOfOneCncState();
}

class _TypeOfOneCncState extends State<TypeOfOneCnc> {
  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 0,
      body: Scaffold(
          appBar: AppBar(
            title: Text(
              'councoures'.tr,
              style: TextStyle(fontFamily: 'Bitter'),
            ),
            // centerTitle: true,
          ),
          body: Column(
            children: [
              TypeConcoure(
                url_img: "assets/concoures/ENSA.png",
                titel: "Agadir",
                type: 2,
              ),
            ],
          )),
    );
  }
}
