import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/config/themes/app_theme.dart';
import 'package:taleb/app/modules/chat/views/chat_view.dart';
import 'package:taleb/app/modules/favorite/controllers/favorite_controller.dart';
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

  var notificationData;
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();
  final HomeController _controller = Get.put(HomeController());

  final List<String> suggestions = [];
  var res;

  initialdata() async {
    res = await chekInternet();
    print(res);
  }

  @override
  void initState() {
    initialdata();
    super.initState();
    loadSuggestions();
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

  void saveSuggestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('suggestions', suggestions);
  }

  void _onSuggestionSelected(String suggestion) {
    _searchController.text = suggestion;
  }

  void handleSearch(String value) {
    setState(() {
      isSearchEmpty = value.isEmpty;
    });
  }

  void cancelSearch() {
    FocusScope.of(context).requestFocus(FocusNode());
    _searchController.clear();
    setState(() {
      isSearchEmpty = true;
    });
  }

  bool isSearchEmpty = true;
  bool isSearching = false;

  checksearch(val) {
    if (val == "") {
      isSearching = false;
    }
  }

  onsearchitem() {
    isSearching = true;
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
              notificationData = await controller.activenotification();
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
              print("taille is ${_controller.listdata.length}");
              Get.to(() => NotificationView());
            },
            child: Container(
              child: Image.asset(
                "assets/icons/notification.png",
                color: Colors.grey,
                width: 22,
              ),
            ),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap: () async {
              Get.to(const ChatView());
            },
            child: Container(
              child: Image.asset(
                "assets/icons/message.png",
                color: Colors.grey,
                width: 25,
              ),
            ),
          ),
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
                    color: Color.fromARGB(185, 199, 198, 198)),
              ),
              child: Row(
                children: [
                  !isSearchEmpty
                      ? IconButton(
                          onPressed: () async {
                            if (_searchController.text.isNotEmpty) {
                              if (!suggestions
                                  .contains(_searchController.text)) {
                                suggestions.add(_searchController.text);
                                saveSuggestions();
                              }
                              onsearchitem();
                              try {
                                await _controller
                                    .Search(_searchController.text);
                                setState(() {});
                                print("la taile is ${_controller.listdata.length}");
                              } catch (e) {
                                print("ddd");
                              }
                              _searchController.clear();
                            }
                          },
                          icon: Icon(Icons.search,size: 25,),
                        )
                      : Container(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Adjust the horizontal padding here
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          handleSearch(value);
                          checksearch(value);
                        },
                        decoration: InputDecoration(
                            hintText: 'recherche'.tr,
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey)),
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
                : _controller.listdata.length > 0
                    ? Expanded(child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _controller.listdata.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                              link:
                                  "${_controller.listdata[index]['link']}",
                              is_liked:
                                  _controller.listdata[index]['liked'] ?? false,
                              is_favorit: _controller.listdata[index]
                                      ['favorite'] ??
                                  false,
                              numberlike: _controller.listdata[index]
                                      ['numberlike'] ??
                                  0,
                              numbercomment: _controller.listdata[index]
                                      ['numbercomment'] ??
                                  0,
                              id_publication:
                                  "${_controller.listdata[index]['id']}",
                              localisation: " ${_controller.listdata[index]['localisation']}",
                              timeAgo: "  ${_controller.listdata[index]['date']}",
                              titel: "${_controller.listdata[index]['titel']}",
                              description:
                                  "${_controller.listdata[index]['description']}",
                              postImage:
                                  "${_controller.listdata[index]['file']}",
                              link_titel:
                                  "${_controller.listdata[index]['link_titel']}",
                            );
                  },
                ))
                    : Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: AppConstant.screenHeight * .06),
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



// PostCard(
//                               link:
//                                   "${_controller.listdata[index]['link']}",
//                               is_liked:
//                                   _controller.listdata[index]['liked'] ?? false,
//                               is_favorit: _controller.listdata[index]
//                                       ['favorite'] ??
//                                   false,
//                               numberlike: _controller.listdata[index]
//                                       ['numberlike'] ??
//                                   0,
//                               numbercomment: _controller.listdata[index]
//                                       ['numbercomment'] ??
//                                   0,
//                               id_publication:
//                                   "${_controller.listdata[index]['id']}",
//                               localisation: " ${_controller.listdata[index]['localisation']}",
//                               timeAgo: "  ${_controller.listdata[index]['date']}",
//                               titel: "${_controller.listdata[index]['titel']}",
//                               description:
//                                   "${_controller.listdata[index]['description']}",
//                               postImage:
//                                   "${_controller.listdata[index]['file']}",
//                               link_titel:
//                                   "${_controller.listdata[index]['link_titel']}",
//                             );

