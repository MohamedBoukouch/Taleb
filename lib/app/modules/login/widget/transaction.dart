// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taleb/app/config/function/functions.dart';
// import 'package:taleb/app/config/translations/localization/changelocal.dart';
// import 'package:taleb/app/modules/login/controllers/login_controller.dart';

// class Transaction extends GetView<localeController> {
//   Transaction({Key? key}) : super(key: key);

//   final localeController _controller = Get.put(localeController());
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                   backgroundColor: const Color.fromARGB(0, 0, 0, 0),
//                   // title: Image.asset(
//                   //   "assets/icons/wairning_icon.png",
//                   //   width: AppConstant.screenWidth * .04,
//                   // ),
//                   // content: const Text("This mail does not exist"),

//                   title: Text("1".tr),
//                   actions: [
//                     Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 248, 181, 81),
//                               borderRadius: BorderRadius.circular(20)),
//                           child: TextButton(
//                             child: const Center(
//                               child: Text(
//                                 "Ar",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Bitter_italic'),
//                               ),
//                             ),
//                             onPressed: () {
//                               _controller.changeLang("ar");
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 248, 181, 81),
//                               borderRadius: BorderRadius.circular(20)),
//                           child: TextButton(
//                             child: const Center(
//                               child: Text(
//                                 "En",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Bitter_italic'),
//                               ),
//                             ),
//                             onPressed: () {
//                               _controller.changeLang("en");
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   ]);
//             });
//       },
//       icon: Icon(
//         Icons.language,
//         size: 30,
//       ),
//     );
//   }
// }
