import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/chat/views/chat_view.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/widgets/appbar.dart';
import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';
import 'package:taleb/app/shared/back.dart';
import 'package:taleb/app/shared/publication.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class SeeAll extends StatefulWidget {
  final String type;
  const SeeAll({Key? key,required this.type}) : super(key: key);

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  final HomeController controller = Get.put(HomeController());

  var notificationData;
  late String activemessages = ''; // Declare activemessages here
  late String activenotification = '';

  // final FavoriController favorit_controller = Get.put(FavoriController());

  var res;

  initialdata() async {
    res = await chekInternet();
    print(res);
  }

    @override
  void initState() {
    super.initState();
    initialdata();
    fetchActiveMessages();
    fetchActiveNotification(); // Call fetchActiveMessages in initState
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

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 3,
      appbar: AppBar(
         backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Taleb'),
        leading: ButtonBack(),
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
              print("taille is ${controller.listdata.length}");
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
                if (activenotification=="1")
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
          InkWell(
            onTap: () async{
              try {
                await controller.update_message_status();
              } catch (e) {
                print(e);
              } finally {
                setState(() {
                  notificationData = controller.activenotification();
                });
              }
              // print(activemessages);
              Get.to(const ChatView());
            },
            child: Stack(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    "assets/icons/message.png",
                    color: Colors.grey,
                  ),
                ),
                if (activemessages=="1") // Check if activemessages is not empty
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
          SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          // Slidere(),
          FutureBuilder(
            future: controller.Showpub("${widget.type}"),
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
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      link: "${snapshot.data[index]['link']}",
                      is_liked: snapshot.data[index]['liked'],
                      is_favorit: snapshot.data[index]['favorite'],
                      numberlike: snapshot.data[index]['numberlike'],
                      numbercomment: snapshot.data[index]['numbercomment'],
                      id_publication: "${snapshot.data[index]['id']}",
                      // forcomment: false,
                      localisation: " ${snapshot.data[index]['localisation']}",
                      timeAgo: "  ${snapshot.data[index]['date']}",
                      titel: "${snapshot.data[index]['titel']}",
                      description: "${snapshot.data[index]['description']}",
                      postImage: "${snapshot.data[index]['file']}",
                      link_titel: "${snapshot.data[index]['link_titel']}",
                      // postImage:
                      //     "$linkservername/publication/upload/${snapshot.data[index]['file']}",
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
