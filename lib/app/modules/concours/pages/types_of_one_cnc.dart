import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';
import 'package:taleb/app/modules/concours/content/concoures_content.dart';
import 'package:taleb/app/modules/concours/widgets/type_concoure.dart';

import '../../../shared/back.dart';

class TypeOfOneCnc extends StatefulWidget {
  String type;
  String ecole;
  TypeOfOneCnc({Key? key, required this.type,required this.ecole}) : super(key: key);

  @override
  State<TypeOfOneCnc> createState() => _TypeOfOneCncState();
}

class _TypeOfOneCncState extends State<TypeOfOneCnc> {
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 1,
      appbar: AppBar(
        title: Text(
          'councoures'.tr,
          style: TextStyle(fontFamily: 'Bitter'),
        ),
        leading: ButtonBack(),
        // centerTitle: true,
      ),
          body: Column(
            children: [
              InkWell(
                // onTap: () => Get.to(ConcoureContent(niveaux:widget.type , ville: "${snapshot.data[index]['ville']}",ecole: widget.ecole)),
                child: FutureBuilder(
                  future: controller.selectvilleecole("${widget.ecole}","${widget.type}"),
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
                            onTap: () => Get.to(() => ConcoureContent(niveaux:widget.type , ville: "${snapshot.data[index]['ville']}",ecole: widget.ecole)),
                            child: TypeConcoure(
                              url_img:
                                  "$linkservername/Admin/concoures/Villes/upload/${snapshot.data[index]['logo']}",
                              titel: "${snapshot.data[index]['ville']}"
                                  .toUpperCase(),
                              type: 2,
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                // TypeConcoure(
                //   url_img: "assets/concoures/ENSA.png",
                //   titel: "Agadir",
                //   type: 2,
                // ),
              ),
            ],
          ),
    );
  }
}
