import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:get/get.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/widgets/publication.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 3,
      body: ListView(
        children: <Widget>[
          Slidere(),
          FutureBuilder(
            future: controller.getpublication(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while fetching data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Handle any errors that occur during data fetching
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData ||
                  snapshot.data['status'] == 'fail') {
                // Handle the case where there is no data or the status is 'fail'
                return Center(child: Text("No data"));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return PostCard(
                      userName: snapshot.data['data'][i]['localisation'].toString(),
                      userImage: snapshot.data['data'][i]['type'].toString(),
                      postText: snapshot.data['data'][i]['description'].toString(),
                      postImage: snapshot.data['data'][i]['file'].toString(),
                      timeAgo: snapshot.data['data'][i]['data'].toString(),
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
