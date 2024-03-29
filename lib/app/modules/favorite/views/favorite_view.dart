import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/Favorite/controllers/favorite_controller.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/shared/publication.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final FavoriteController controller = Get.put(FavoriteController());
  // final FavoriController favorit_controller = Get.put(FavoriController());

  var res;

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
  }

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 2,
      appbar: AppBar(
        title: Text(
          'Favorite'.tr,
          style: TextStyle(fontFamily: 'Bitter'),
        ),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          // Slidere(),
          Expanded(
            child: FutureBuilder(
              future: controller.SelectFavorit(),
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
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Image.asset(Appimages.data_empty);
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      // return Text("${snapshot.data[index]}");
                      return PostCard(
                        link: "${snapshot.data[index]['link']}",
                        is_liked: snapshot.data[index]['liked'],
                        is_favorit: snapshot.data[index]['favorite'],
                        numberlike: snapshot.data[index]['numberlike'],
                        numbercomment: snapshot.data[index]['numbercomment'],
                        id_publication: "${snapshot.data[index]['id']}",
                        // forcomment: false,
                        localisation:
                            " ${snapshot.data[index]['localisation']}",
                        timeAgo: "  ${snapshot.data[index]['date']}",
                        titel: "${snapshot.data[index]['titel']}",
                        description: "${snapshot.data[index]['description']}",
                        postImage: "${snapshot.data[index]['file']}",
                        // postImage:
                        //     "$linkservername/publication/upload/${snapshot.data[index]['file']}",
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
