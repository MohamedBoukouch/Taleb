import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';
import 'package:taleb/app/shared/publication.dart';

class ShowPublication extends StatefulWidget {
  final String publication_id;
  ShowPublication({Key? key, required this.publication_id}) : super(key: key);

  @override
  State<ShowPublication> createState() => _ShowPublicationState();
}

class _ShowPublicationState extends State<ShowPublication> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.Showpub(
          "${widget.publication_id}"), // Ensure widget.publication_id is not null
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
                // postImage:
                //     "$linkservername/publication/upload/${snapshot.data[index]['file']}",
              );
            },
          );
        }
      },
    );
  }
}
