import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/setting/controllers/setting_controller.dart';
import 'package:taleb/app/modules/concours/content/affichage.dart';
import 'package:taleb/app/modules/setting/widgets/apiservicesprovider.dart';
import 'package:taleb/app/modules/concours/widgets/pdf_form.dart';

import '../../../shared/back.dart';

class ConcoureContent extends StatefulWidget {
  @override
  _ConcoureContentState createState() => _ConcoureContentState();
}

class _ConcoureContentState extends State<ConcoureContent> {
  final SettingController controller = Get.put(SettingController());
  String? localPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiServiceProvider.loadPDF().then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'councoures'.tr,
          style: TextStyle(fontFamily: 'Bitter'),
        ),
        leading: ButtonBack(),
      ),
      body: FutureBuilder(
        future: controller.selectpdf("bac", "ENSA", "agadir"),
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
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 1),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Get.to(() => Affichage(
                          url:
                              "$linkservername/Admin/concoures/PDF/upload/${snapshot.data[index]['pdf']}",
                        )),
                    child: PdfForm(
                        annee_scolaire:
                            "${snapshot.data[index]['annee_scolaire']}"),
                  );
                });
          }
        },
      ),

      // Container(
      //   // margi:n: EdgeInsets.all(10),
      //   child: GridView.builder(
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 1),
      //       shrinkWrap: true,
      //       itemCount: 10,
      //       itemBuilder: (context, index) {
      //         return InkWell(
      //             onTap: () => Get.to(() => Affichage()), child: PdfForm());
      //       }),
      // ),
    );
  }
}
