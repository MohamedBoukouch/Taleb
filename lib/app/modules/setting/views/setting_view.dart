import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gallery_saver/files.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/config/themes/app_theme.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:taleb/app/modules/setting/pages/contactez_nous.dart';
import 'package:taleb/app/modules/setting/pages/edit_profile.dart';
import 'package:taleb/app/modules/setting/pages/language.dart';
import 'package:taleb/app/modules/setting/pages/supporte.dart';
import 'package:taleb/app/modules/setting/widgets/delet_compte.dart';
import 'package:taleb/app/modules/setting/widgets/slider_1.dart';
import 'package:taleb/app/modules/setting/widgets/slider_2.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';
import 'package:taleb/app/shared/fullscreen.dart';
import 'package:taleb/main.dart';

import '../../../shared/CustomAlert.dart';
import '../controllers/setting_controller.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final SettingController controller = Get.put(SettingController());
  TextEditingController _nom = TextEditingController();
  File? _selectedImage;
  final picker = ImagePicker();


  Future<void> _pickImage() async {
  try {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      
      // Show a custom alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Confirmation')),
            content: Text('Do you want to update your account?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  try {
                    await controller.add_pic_profile(_selectedImage);
                    CustomAlert.show(
      context: context,
      type: AlertType.success,
      desc: 'profile Update Sucssfull',
      onPressed: () {
      Navigator.pop(context);
      });
                  } catch (e) {
                    print("$e");
                  }
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print("Error picking image: $e");
  }
}


  Future<bool> _showVerificationSnackbar() async {
    Completer<bool> completer = Completer<bool>();

    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want to Delete your compte',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        completer.complete(true);
      },
      onCancelBtnTap: () {
        completer.complete(false);
      },
    );

    return completer.future;
  }

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
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: AppConstant.screenHeight * .05,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullScreenImage(
                                imageUrl:
                                    "$linkservername/Admin/publication/upload/${snapshot.data[index]['profile']}",
                              ),
                            ));
                          },
                          child: Center(
                            child: Stack(
                              children: [
                                Hero(
                                  tag:
                                      "profileImage_${index}", // Same unique tag as in onTap
                                  child: CircleAvatar(
                                    radius: 80,
                                    backgroundImage: _selectedImage != null
                                        ? FileImage(_selectedImage!)
                                        : (snapshot.data['profile'] ==
                                                "0"
                                            ? AssetImage(
                                                "assets/profile/Profile_2.png")
                                            : NetworkImage(
                                                    "$linkserverimages/${snapshot.data['profile']}")
                                                as ImageProvider<Object>),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: _pickImage,
                                    child:  CircleAvatar(
                                      backgroundColor: AppTheme.main_color_2,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${snapshot.data['firstname']} ${snapshot.data['lastname']}",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Bitter',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${snapshot.data['email']}",
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'Bitter_italic'),
                        ),
                        SizedBox(
                          height: AppConstant.screenHeight * .02,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(EditProfile(
                              nom: "${snapshot.data['firstname']}",
                              prenom: "${snapshot.data['lastname']}",
                              email: "${snapshot.data['email']}",
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
                              "edit_profile".tr,
                              style: const TextStyle(
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
                                titel: "Contactez-nous".tr,
                                icon: Icon(
                                  Icons.support_agent,
                                  color: AppTheme.main_color_2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(Language()),
                          child: Slider_2(
                              titel: "1".tr,
                              icon: Icon(
                                Icons.language,
                                color: AppTheme.main_color_2,
                              )),
                        ),
                        //Slider_2(),

                        InkWell(
                          onTap: () => Get.to(() => Supporte()),
                          child: Slider_2(
                            titel: "Supporte".tr,
                            icon: Icon(
                              Icons.info_outline_rounded,
                              color: AppTheme.main_color_2,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            sharedpref.clear();
                            Get.off(() => LoginView());
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
                            child: Center(
                              child: Text(
                                "Log_Out".tr,
                                style: const TextStyle(
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
                                  text: 'Message_delet_compte'.tr,
                                  confirmBtnText: 'Yes',
                                  cancelBtnText: 'No',
                                  confirmBtnColor: Colors.green,
                                  onConfirmBtnTap: () async {
                                    await controller.deletcompte(context);
                                  });
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
