import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:taleb/app/modules/Favorite/views/favorite_view.dart";
import "package:taleb/app/modules/home/views/home_view.dart";
import "package:taleb/app/modules/notification/views/notification_view.dart";

import "package:taleb/app/modules/search/views/search_view.dart";
import "package:taleb/app/modules/setting/views/setting_view.dart";
import "package:taleb/main.dart";

class InitialView extends StatelessWidget {
  final int selectedindex;
  final Widget? body;
  const InitialView({Key? key, this.selectedindex = 0, this.body})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Taleb',
          style: TextStyle(
            color: Colors.black, // Text color
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Get.to(NotificationView());
            },
            color: Colors.black,
          ),
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              print(sharedpref.getString("id"));
            },
            color: Colors.black,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        currentIndex: selectedindex,
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
              Icons.settings,
              color: Colors.orange,
            ),
            icon: Icon(
              Icons.settings,
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
