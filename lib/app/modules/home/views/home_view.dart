import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/modules/chat/views/chat_view.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/pages/filter.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';
import 'package:taleb/app/shared/publication.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());
  late String activemessages = ''; // Declare activemessages here
  late String activenotification = ''; // Declare activemessages here
  final List<String> suggestions = [];
  bool isSearchEmpty = true;
  bool isSearching = false;
  var notificationData;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialData();
    loadSuggestions();
    fetchActiveMessages();
    fetchActiveNotification(); // Call fetchActiveMessages in initState
  }

  void initialData() async {
    var res = await chekInternet();
    print(res);
  }

  void loadSuggestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedSuggestions = prefs.getStringList('suggestions');

    if (savedSuggestions != null) {
      setState(() {
        suggestions.addAll(savedSuggestions);
      });
    }
  }

  void fetchActiveMessages() async {
    String activeMessages = await controller.activemessages();
    setState(() {
      activemessages = activeMessages;
    });
  }

  void fetchActiveNotification() async {
    String activeNotification = await controller.activenotification();
    setState(() {
      activenotification = activeNotification;
    });
  }

  void handleSearch(String value) {
    setState(() {
      isSearchEmpty = value.isEmpty;
    });
  }

  void onSearchItem() {
    setState(() {
      isSearching = true;
    });
  }

  void checkSearch(val) {
    if (val == "") {
      setState(() {
        isSearching = false;
      });
    }
  }

  void cancelSearch() {
    FocusScope.of(context).requestFocus(FocusNode());
    _searchController.clear();
    setState(() {
      isSearchEmpty = true;
    });
  }

  void saveSuggestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('suggestions', suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 3,
      appbar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Taleb',
          style: TextStyle(
            color: Colors.black, // Text color
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              setState(() {
                notificationData = controller.activenotification();
              });

              print(notificationData);

              try {
                await controller.update_notification_status();
              } catch (e) {
                print(e);
              } finally {
                setState(() {
                  notificationData = controller.activenotification();
                });
              }
              // print("taille is ${controller.listdata.length}");
              Get.to(() => NotificationView());
            },
            child: Stack(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    "assets/icons/notification.png",
                    color: Colors.grey,
                  ),
                ),
                if (notificationData == "1")
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 15),
          // InkWell(
          //   onTap: () async {
          //     try {
          //       await controller.update_message_status();
          //     } catch (e) {
          //       print(e);
          //     } finally {
          //       setState(() {
          //         notificationData = controller.activenotification();
          //       });
          //     }
          //     // print(activemessages);
          //     Get.to(const ChatView());
          //   },
          //   child: Stack(
          //     children: [
          //       Container(
          //         width: 25,
          //         height: 25,
          //         child: Image.asset(
          //           "assets/icons/message.png",
          //           color: Colors.grey,
          //         ),
          //       ),
          //       if (activemessages == "1") // Check if activemessages is not empty
          //         Positioned(
          //           right: 0,
          //           top: 0,
          //           child: Container(
          //             width: 10,
          //             height: 10,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: Colors.red,
          //             ),
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(185, 199, 198, 198),
                ),
              ),
              child: Row(
                children: [
                  !isSearchEmpty
                      ? IconButton(
                          onPressed: () async {
                            if (_searchController.text.isNotEmpty) {
                              if (!suggestions.contains(_searchController.text)) {
                                suggestions.add(_searchController.text);
                                saveSuggestions();
                              }
                              onSearchItem();
                              try {
                                await controller.Search("fes");
                                setState(() {});
                                print("la taile is ${controller.listdata.length}");
                              } catch (e) {
                                print("ddd");
                              }
                              _searchController.clear();
                            }
                          },
                          icon: Icon(Icons.search, size: 25),
                        )
                      : Container(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          handleSearch(value);
                          checkSearch(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'recherche'.tr,
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  !isSearchEmpty
                      ? IconButton(
                          onPressed: cancelSearch,
                          icon: Icon(Icons.close),
                        )
                      : Container(
                          padding: EdgeInsets.only(right: 9),
                          child: Icon(
                            Icons.search,
                            size: 25,
                          ),
                        ),
                ],
              ),
            ),
            isSearching == false
                ? Filter()
                : controller.listdata.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.listdata.length,
                          itemBuilder: (context, index) {
                            // return PostCard(
                            //   link: "${controller.listdata[index]['link']}",
                            //   is_liked: controller.listdata[index]['liked'] ?? false,
                            //   is_favorit: controller.listdata[index]['favorite'] ?? false,
                            //   numberlike: controller.listdata[index]['numberlike'] ?? 0,
                            //   numbercomment: controller.listdata[index]['numbercomment'] ?? 0,
                            //   id_publication: "${controller.listdata[index]['id']}",
                            //   localisation: " ${controller.listdata[index]['localisation']}",
                            //   timeAgo: "  ${controller.listdata[index]['date']}",
                            //   titel: "${controller.listdata[index]['titel']}",
                            //   description: "${controller.listdata[index]['description']}",
                            //   postImage: "${controller.listdata[index]['file']}",
                            //   link_titel: "${controller.listdata[index]['link_titel']}",
                            // );

                    //         PostCard(
                    //   link: "${controller.listdata[index]['link']}",
                    //   is_liked: controller.listdata[index]['liked'],
                    //   is_favorit: controller.listdata[index]['favorite'],
                    //   numberlike: controller.listdata[index]['numberlike'],
                    //   numbercomment: controller.listdata[index]['numbercomment'],
                    //   id_publication: "${controller.listdata[index]['id']}",
                    //   localisation: " ${controller.listdata[index]['localisation']}",
                    //   timeAgo: "  ${controller.listdata[index]['date']}",
                    //   titel: "${controller.listdata[index]['titel']}",
                    //   description: "${controller.listdata[index]['description']}",
                    //   postImage: "${controller.listdata[index]['file']}",
                    //   link_titel: "${controller.listdata[index]['link_titel']}",
                    // );
                    return Text("AAAA");
                    

                          },
                        ),
                      )
                    : Center(
                        child: Container(
                          margin: EdgeInsets.only(top: AppConstant.screenHeight * .06),
                          child: Column(
                            children: [
                              Image.asset("assets/icons/Not_Found.png"),
                              SizedBox(
                                height: AppConstant.screenHeight * .06,
                              ),
                              Text(
                                "Désolé, la publication que vous recherchez n'existe pas.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Bitter',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
