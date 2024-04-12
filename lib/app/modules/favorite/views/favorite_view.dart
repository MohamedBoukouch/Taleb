import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:taleb/app/shared/publication.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final FavoriteController controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 2,
      appbar: AppBar(
        title: Text(
          'Favorite'.tr,
          style: TextStyle(fontFamily: 'Bitter'),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
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
              } else if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(top: AppConstant.screenHeight*.2,right: 20,left: 20),
                  child: Image.asset(
                    Appimages.data_empty,
                    width: AppConstant.screenWidth * .8,
                  ),
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
                      numberlike: snapshot.data[index]['numberlike'] ?? 0,
                      numbercomment: snapshot.data[index]['numbercomment'] ?? 0,
                      id_publication: "${snapshot.data[index]['id']}",
                      localisation: " ${snapshot.data[index]['localisation']}",
                      timeAgo: "  ${snapshot.data[index]['date']}",
                      titel: "${snapshot.data[index]['titel']}",
                      description: "${snapshot.data[index]['description']}",
                      postImage: "${snapshot.data[index]['file']}",
                      link_titel: "${snapshot.data[index]['link_titel']}",
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
