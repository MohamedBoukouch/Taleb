import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/data/const_lik.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/widgets/publication.dart';
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
    // controller.Showpub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 3,
      body: Column(
        children: [
          // Slidere(),
          Expanded(
            child: FutureBuilder(
              future: controller.Showpub(),
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
                      "assets/icons/error.png",
                      width: AppConstant.screenWidth * .8,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No data available"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      // return Center(child: Text("${snapshot.data[index]['id']}"));
                      return PostCard(
                        numberlike: snapshot.data[index]['numberlike'],
                        numbercomment: snapshot.data[index]['numbercomment'],
                        id_publication: snapshot.data[index]['id'],
                        forcomment: false,
                        localisation:
                            " ${snapshot.data[index]['localisation']}",
                        timeAgo: "  ${snapshot.data[index]['date']}",
                        titel: "${snapshot.data[index]['titel']}",
                        description: "${snapshot.data[index]['description']}",
                        postImage:
                            "$linkservername/publication/upload/${snapshot.data[index]['file']}",
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
