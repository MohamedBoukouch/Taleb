import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/setting/pages/types_of_one_cnc.dart';
import 'package:taleb/app/modules/setting/widgets/type_concoure.dart';

class Bac extends StatefulWidget {
  const Bac({Key? key}) : super(key: key);

  @override
  State<Bac> createState() => _BacState();
}

class _BacState extends State<Bac> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () => Get.to(() => TypeOfOneCnc()),
              child: TypeConcoure(
                url_img: "assets/concoures/ENSA.png",
                titel: "ENSA",
                type: 1,
              ),
            ),
            // TypeConcoure(
            //   url_img: "assets/concoures/ENSA.png",
            //   titel: "ENSAM",
            // ),
            // TypeConcoure(
            //   url_img: "assets/concoures/ENSA.png",
            //   titel: "ENA",
            // ),
            // TypeConcoure(
            //   url_img: "assets/concoures/ENSA.png",
            //   titel: "FAT",
            // ),
          ],
        ),
      ),
    );
  }
}
