import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/home/widgets/publication.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InitialView(
        selectedindex: 3,
        body: ListView(
          children: <Widget>[
            Slidere(),
            PostCard(
              userName:"Mohamed Boukouch",
              userImage: "https://media.istockphoto.com/id/1318291081/fr/photo/tour-eiffel-en-m%C3%A9tal.jpg?b=1&s=170667a&w=0&k=20&c=glQNxEe4MJYaCOzIFPyOxbUrHBvv818Aq6HGCqHh1D0=", 
              postText:"QS Qzefqnb jqBH sx bQBQqu",
              postImage:    "https://media.istockphoto.com/id/1318291081/fr/photo/tour-eiffel-en-m%C3%A9tal.jpg?b=1&s=170667a&w=0&k=20&c=glQNxEe4MJYaCOzIFPyOxbUrHBvv818Aq6HGCqHh1D0=",
              timeAgo:"12-2-2"
            ),
          ],
        ));
  }
}
