// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taleb/app/modules/chat/views/chat_view.dart';
// import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';
// import 'package:taleb/app/modules/notification/views/notification_view.dart';

// class Appbarr extends StatefulWidget {
//   const Appbarr({Key? key}) : super(key: key);

//   @override
//   State<Appbarr> createState() => _AppbarrState();
// }

// class _AppbarrState extends State<Appbarr> {
//   @override
//   Widget build(BuildContext context) {
//     final NotificationController controller = Get.put(NotificationController());

//     return AppBar(
//       backgroundColor: Colors.white,
//       title: InkWell(
//         onTap: () {
//           print(controller.ListNotification.length);
//         },
//         child: Text(
//           'Taleb',
//           style: TextStyle(
//             color: Colors.black, // Text color
//           ),
//         ),
//       ),
//       actions: [
//         Stack(
//           children: [
//             IconButton(
//               icon: Icon(Icons.notifications, size: 30),
//               onPressed: () async {
//                 print("${await controller.ListNotification.length}");

//                 try {
//                   // await controller.update_notification_status();
//                 } catch (e) {
//                   print(e);
//                 }
//                 Get.to(NotificationView());
//               },
//               color: Color.fromARGB(214, 112, 111, 111),
//             ),

//             Positioned(
//               bottom: 31,
//               right: 13,
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 decoration: BoxDecoration(
//                     color: Colors.red, borderRadius: BorderRadius.circular(50)),
//                 child: Center(
//                   child: Text("${controller.ListNotification.length}"),
//                 ),
//               ),
//             )
//             // : Positioned(child: Text("")),
//           ],
//         ),
//         IconButton(
//           icon: Icon(Icons.chat_bubble_outline_outlined, size: 30),
//           onPressed: () async {
//             Get.to(ChatView());
//           },
//           color: Color.fromARGB(214, 112, 111, 111),
//         ),
//       ],
//     );
//   }
// }
