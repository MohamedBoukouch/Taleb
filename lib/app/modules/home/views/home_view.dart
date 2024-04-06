import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/chat/views/chat_view.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/pages/filter.dart';
import 'package:taleb/app/modules/home/pages/see_all.dart';
import 'package:taleb/app/modules/home/widgets/appbar.dart';
import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';
import 'package:taleb/app/shared/publication.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

import '../../../config/translations/localization/changelocal.dart';
import '../../../shared/edittext.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());

  var notificationData;
  final TextEditingController _emailController = TextEditingController();

  // final FavoriController favorit_controller = Get.put(FavoriController());

  final TextEditingController _searchController = TextEditingController();
  // final HomeController _controller = Get.find<HomeController>();
  final HomeController _controller = Get.put(HomeController());

  final List<String> suggestions = [];
  var res;

  // List<String> charArray = [];

  // void splitString() {
  //   charArray = inputImage.split(',')[0];
  // }

  initialdata() async {
    res = await chekInternet();
    print(res);
  }

  @override
  void initState() {
    initialdata();
    setState(() {
      // splitString();
    });
    // controller.Showpub();
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
    // Perform any action when a suggestion is selected here.
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
  String vile = "Agadir";
  List lisdata = [];

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
      appbar:AppBar(
  backgroundColor: Colors.white,
  automaticallyImplyLeading: false,
  title: const Text(
    'Taleb',
    style: TextStyle(
      color: Colors.black, // Text color
    ),
  ),
  actions: [
    Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications, size: 30),
          onPressed: () async {
            notificationData = await controller.activenotification();
            print(notificationData);

            try {
              await controller.update_notification_status();
            } catch (e) {
              print(e);
            } finally {
              setState(() {});
            }
            Get.to(() => NotificationView());
          },
          color: const Color.fromARGB(214, 112, 111, 111),
        ),
        notificationData == "1"
            ? Positioned(
                bottom: 5,
                right: 18,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            : Positioned(
                child: Container(),
              )
      ],
    ),
    IconButton(
      icon: const Icon(Icons.chat_bubble_outline_outlined, size: 30),
      onPressed: () async {
        Get.to(const ChatView());
      },
      color: const Color.fromARGB(214, 112, 111, 111),
    ),
  ],
),

      body: Container(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: ListView(
          shrinkWrap: true,
          children: [
Container(
  margin: EdgeInsets.all(10),
  // padding: EdgeInsets.only(left: 15),
  height: 60,
  decoration: BoxDecoration(
    // color: Colors.grey[300], // Changed the color to a lighter grey
    borderRadius: BorderRadius.circular(20),
    border: Border.all(width: 1, color: Color.fromARGB(185, 199, 198, 198)),
  ),
  child: Row(
    children: [
      IconButton(
        onPressed: () async {
          if (_searchController.text.isNotEmpty) {
            if (!suggestions.contains(_searchController.text)) {
              suggestions.add(_searchController.text);
              saveSuggestions();
            }
            onsearchitem();
            try {
              await _controller.Search(_searchController.text);
              setState(() {});
            } catch (e) {
              print("ddd");
            }
            _searchController.clear();
          }
        },
        icon: Icon(Icons.search),
      ),
      Expanded(
        child: TextField(
          controller: _searchController,
          style: TextStyle(
          color: Colors.black, // Set the text color to red
        ),
          onChanged: (value) {
            handleSearch(value);
            checksearch(value);
          },
          decoration: InputDecoration(
            hintText: 'Recherche',
            border: InputBorder.none,
            
          ),
        ),
      ),
      !isSearchEmpty?// Added condition to only show the close button when search is not empty
        IconButton(
          onPressed: cancelSearch,
          icon: Icon(Icons.close),
        ):Container(padding: EdgeInsets.only(right: 9), child: Image.asset("assets/icons/Filter.png")),
        
    ],
  ),
),

            isSearching==false ?
            Filter():
            _controller.listdata.length > 0
                    ? Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _controller.listdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PostCard(
                              link: "${_controller.listdata[index]['link']}",
                              is_liked: _controller.listdata[index]['liked'],
                              is_favorit: _controller.listdata[index]
                                  ['favorite'],
                              numberlike: _controller.listdata[index]
                                  ['numberlike'],
                              numbercomment: _controller.listdata[index]
                                  ['numbercomment'],
                              id_publication:
                                  "${_controller.listdata[index]['id']}",
                              localisation:
                                  " ${_controller.listdata[index]['localisation']}",
                              timeAgo:
                                  "  ${_controller.listdata[index]['date']}",
                              titel: "${_controller.listdata[index]['titel']}",
                              description:
                                  "${_controller.listdata[index]['description']}",
                              postImage:
                                  "${_controller.listdata[index]['file']}",
                            );
                          },
                        ),
                      )
                    : Center(
                      child: Container(
                        margin: EdgeInsets.only(top: AppConstant.screenHeight*.06),
                        child: Column(
                          children: [
                            Image.asset("assets/icons/Not_Found.png"),
                            SizedBox(height: AppConstant.screenHeight*.06,),
                            Text("Désolé, la publication que vous recherchez n'existe pas.",style: TextStyle(fontSize: 12,fontFamily: 'Bitter',),)
                          ],),
                      ),),
          ],
        ),
      ),
    );
  }
}





