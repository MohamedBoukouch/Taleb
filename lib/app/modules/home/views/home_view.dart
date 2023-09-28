import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:get/get.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/data/statusRequest.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());

  var res;
  initialdata() async {
    res = await chekInternet();
    print(res);
  }

  @override
  void initState() {
    initialdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 3,
      // body: ListView(
      //   children: <Widget>[
      //     Slidere(),
          body:GetBuilder<HomeController>(builder: (controller) {
            if (controller.statusRequest == StatusRequest.loading) {
              return const Center(
                child: Text("Loading"),
              );
            } else if (controller.statusRequest ==
                StatusRequest.offlinefailure) {
              return const Center(child: Text("offline failler"));
            } else if (controller.statusRequest ==
                StatusRequest.serverfailure) {
              return const Center(child: Text("servece failler"));
            } else {
              return ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    return Text("${controller.data}");
                  });
            }
          })

          // FutureBuilder(
          //   future: controller.getpublication(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       // Display a loading indicator while fetching data
          //       return Center(child: CircularProgressIndicator());
          //     } else if (snapshot.hasError) {
          //       // Handle any errors that occur during data fetching
          //       return Center(child: Text("Error: ${snapshot.error}"));
          //     } else if (!snapshot.hasData ||
          //         snapshot.data['status'] == 'fail') {
          //       // Handle the case where there is no data or the status is 'fail'
          //       return Center(child: Text("No data"));
          //     } else {
          //       return ListView.builder(
          //         itemCount: snapshot.data.length,
          //         shrinkWrap: true,
          //         itemBuilder: (context, i) {
          //           return PostCard(
          //             userName: "snapshot.data[i]['localisation'].toString()",
          //             userImage:
          //                 "https://images.squarespace-cdn.com/content/v1/59a07205579fb3e4063ee6b8/1545009531137-P2KPWGLV8TQM2W0BG5L0/MattFraddHeadshot-2.jpg?format=2500w",
          //             postText: "snapshot.data[i]['description'].toString(),",
          //             postImage: "snapshot.data[i]['file'].toString()",
          //             timeAgo: "snapshot.data[i]['date'].toString()",
          //           );
          //         },
          //       );
          //     }
          //   },
          // ),
      //   ],
      // ),
    );
  }
}
