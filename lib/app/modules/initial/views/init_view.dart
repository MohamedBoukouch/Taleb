import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:taleb/app/modules/Favorite/views/favorite_view.dart";
import "package:taleb/app/modules/chat/views/chat_view.dart";
import "package:taleb/app/modules/favorite/controllers/favorite_controller.dart";
import "package:taleb/app/modules/home/controllers/home_controller.dart";
import "package:taleb/app/modules/home/views/home_view.dart";
import "package:taleb/app/modules/initial/controllers/init_controller.dart";
import "package:taleb/app/modules/initial/widgets/notifications.dart";
import "package:taleb/app/modules/notification/controllers/notification_controller.dart";
import "package:taleb/app/modules/notification/views/notification_view.dart";

import "package:taleb/app/modules/search/views/search_view.dart";
import "package:taleb/app/modules/setting/views/setting_view.dart";
import "package:taleb/main.dart";

class InitialView extends StatefulWidget {
  final int selectedindex;
  final Widget? body;
  const InitialView({Key? key, this.selectedindex = 0, this.body})
      : super(key: key);

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  final NotificationController controller = Get.put(NotificationController());
  late int not = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            print(controller.ListNotification.length);
          },
          child: Text(
            'Taleb',
            style: TextStyle(
              color: Colors.black, // Text color
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, size: 30),
                onPressed: () async {
                  print("${await controller.ListNotification.length}");

                  try {
                    await controller.update_notification_status();
                  } catch (e) {
                    print(e);
                  }
                  Get.to(NotificationView());
                },
                color: Color.fromARGB(214, 112, 111, 111),
              ),

              Positioned(
                bottom: 31,
                right: 13,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text("${controller.ListNotification.length}"),
                  ),
                ),
              )
              // : Positioned(child: Text("")),
            ],
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline_outlined, size: 30),
            onPressed: () async {
              Get.to(ChatView());
            },
            color: Color.fromARGB(214, 112, 111, 111),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        currentIndex: widget.selectedindex,
        onTap: (int index) {
          switch (index) {
            case 0:
              Get.off(() => const SettingView());
              break;
            case 1:
              Get.off(() => SearchView());
              break;

            case 2:
              Get.off(() => const FavoriteView());
              break;
            case 3:
              Get.off(() => const HomeView());
              break;
            default:
              Get.off(() => const HomeView());
          }
        },
        selectedItemColor: const Color.fromARGB(255, 247, 134, 6),
        unselectedItemColor: Color.fromARGB(255, 227, 65, 65),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedLabelStyle: const TextStyle(color: Colors.transparent),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: Colors.orange,
            ),
            icon: Icon(
              Icons.person,
            ),
            label: "●",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.search,
              color: Colors.orange,
            ),
            icon: Icon(Icons.search),
            label: "●",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.star_rate,
              color: Colors.orange,
            ),
            icon: Icon(Icons.star_rate),
            label: "●",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.orange,
            ),
            icon: Icon(Icons.home),
            label: "●",
          ),
        ],
      ),
    );
  }
}
