import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/config/themes/app_theme.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:taleb/app/modules/setting/pages/contactez_nous.dart';
import 'package:taleb/app/modules/setting/pages/edit_profile.dart';
import 'package:taleb/app/modules/setting/widgets/delet_compte.dart';
import 'package:taleb/app/modules/setting/widgets/slider_1.dart';
import 'package:taleb/app/modules/setting/widgets/slider_2.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';
import 'package:taleb/main.dart';

import '../controllers/setting_controller.dart';

// class SettingView extends GetView<SettingController> {

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final SettingController controller = Get.put(SettingController());
  TextEditingController _nom = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 0,
      body: ListView(
        children: [
          FutureBuilder(
            future: controller.profil(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    color: Color.fromARGB(255, 246, 154, 7),
                    size: 60,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Error"));
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
                    return Column(
                      children: [
                        SizedBox(
                          height: AppConstant.screenHeight * .05,
                        ),
                        const Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(
                                    "https://th.bing.com/th/id/OIP.6nsKk7mIkSKvYZD_APa8-AHaFk?pid=ImgDet&rs=1"),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 10,
                                child: CircleAvatar(
                                  backgroundColor: Colors.orangeAccent,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${snapshot.data[index]['firstname']} ${snapshot.data[index]['lastname']}",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Bitter',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${snapshot.data[index]['email']}",
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'Bitter_italic'),
                        ),
                        SizedBox(
                          height: AppConstant.screenHeight * .02,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(EditProfile(
                              nom: "${snapshot.data[index]['firstname']}",
                              prenom: "${snapshot.data[index]['lastname']}",
                              email: "${snapshot.data[index]['email']}",
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                right: AppConstant.screenWidth * .15,
                                left: AppConstant.screenWidth * .15,
                                top: AppConstant.screenHeight * .015,
                                bottom: AppConstant.screenHeight * .015),
                            decoration: BoxDecoration(
                                color: AppTheme.main_color_1,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Edit profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Bitter',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppConstant.screenHeight * .03,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(() => EditProfile());
                          },
                          child: InkWell(
                            onTap: () {
                              // Get.to(EditProfile());
                            },
                            child: InkWell(
                              onTap: () {
                                Get.to(ContactezNous());
                              },
                              child: Slider_2(
                                titel: "Contactez-nous",
                                icon: Icon(
                                  Icons.support_agent,
                                  color: AppTheme.main_color_2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Slider_2(
                          titel: "Payement Options",
                          icon: Icon(
                            Icons.monetization_on_outlined,
                            color: AppTheme.main_color_2,
                          ),
                        ),
                        Slider_2(
                            titel: "Laungage",
                            icon: Icon(
                              Icons.language,
                              color: AppTheme.main_color_2,
                            )),
                        //Slider_2(),

                        Slider_2(
                          titel: "Supporte",
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: AppTheme.main_color_2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            sharedpref.clear();
                            Get.to(() => LoginView());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                            ),
                            margin: EdgeInsets.only(
                                right: AppConstant.screenWidth * .1,
                                left: AppConstant.screenWidth * .1,
                                top: 10),
                            decoration: BoxDecoration(
                                color: AppTheme.main_color_1,
                                borderRadius: BorderRadius.circular(40)),
                            child: const Center(
                              child: Text(
                                "Log Out",
                                style: TextStyle(
                                    fontFamily: 'Bitter',
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                            //in this link i can find all type of quiqkalert ->  https://pub.dev/packages/quickalert
                            onTap: () {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  text: 'Do you want to Delet your compte',
                                  confirmBtnText: 'Yes',
                                  cancelBtnText: 'No',
                                  confirmBtnColor: Colors.green,
                                  onConfirmBtnTap: () async {
                                    await controller.deletcompte(context);
                                  });
                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return AlertDialog(
                              //           title: Image.asset(
                              //             "assets/icons/succefully.png",
                              //             width: AppConstant.screenWidth * .02,
                              //           ),
                              //           content: const Text(
                              //               "Really do you want to delet your compte"),
                              //           actions: [
                              //             AppFunction.cancel(),
                              //             AppFunction.delet_compte(context),
                              //           ]);
                              //     });
                            },
                            child: const DeletCompte()),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}


// Column(
//         children: [
//           Stack(
//             children: [
//               Center(
//                 child: Container(
//                   padding: EdgeInsets.only(top: 40),
//                   decoration: BoxDecoration(),
//                   child: CircleAvatar(
//                     radius: 70,
//                     backgroundImage: NetworkImage(
//                         "https://th.bing.com/th/id/OIP.6nsKk7mIkSKvYZD_APa8-AHaFk?pid=ImgDet&rs=1"),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: AppConstant.screenHeight * .025,
//                 right: AppConstant.screenWidth * .32,
//                 child: Icon(
//                   Icons.camera_alt_rounded,
//                   size: 30,
//                 ),
//               ),
//             ],
//           ),
//           Edittext(
//             Controller: _nom,
//             hint: "Nom",
//           ),
//           Edittext(
//             Controller: _nom,
//             hint: "Prenom",
//           ),
//           Edittext(
//             Controller: _nom,
//             hint: "Email",
//           ),
//           Edittext(
//             Controller: _nom,
//             hint: "Password",
//           ),
//         ],
//       ),
