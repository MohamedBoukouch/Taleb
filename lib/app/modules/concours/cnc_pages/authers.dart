import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';
import 'package:taleb/app/modules/concours/pages/types_of_one_cnc.dart';
import 'package:taleb/app/modules/concours/widgets/type_concoure.dart';

class Authers extends StatefulWidget {
  const Authers({Key? key}) : super(key: key);

  @override
  State<Authers> createState() => _AuthersState();
}

class _AuthersState extends State<Authers> {
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: controller.selectecole("auther"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Color.fromARGB(255, 246, 154, 7),
                      size: 60,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Image.asset(
                      Appimages.error,
                      width: AppConstant.screenWidth * .8,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Center(child: Text("No data available")),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Get.to(() => TypeOfOneCnc(
                            ecole_id: snapshot.data[index]['name'],type: "auther",)),
                        child: TypeConcoure(
                          url_img:
                              "$linkservername/Admin/concoures/upload/${snapshot.data[index]['logo']}",
                          titel:
                              "${snapshot.data[index]['name']}".toUpperCase(),
                          type: 1,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
