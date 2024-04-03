import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/chat/views/chat_view.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/pages/bac.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 3,
      appbar: AppBar(
        backgroundColor: Colors.white,
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
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 60, // Specify the desired height here
              child: TextFormField(
                enabled: true,
                // controller:
                // validator: widget.validator,
                style: const TextStyle(
                  color: Colors.black, // Set the text color to red
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10), // Adjust vertical padding
                  hintStyle: const TextStyle(
                    color: Color(0xFF555353),
                  ),
                  labelStyle: const TextStyle(color: Colors.black),
                  errorStyle: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    //letterSpacing: .5,
                  ),
                  hintText: "Search",
                  prefixIcon: Image.asset("assets/icons/Search.png"),
                  suffixIcon: Image.asset("assets/icons/Filter.png"),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 3, //<-- SEE HERE
                      color: Color.fromARGB(132, 255, 153, 0),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.orange,
                      width: 1, //<-- SEE HERE
                      //color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 3, //<-- SEE HERE
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Colors.orange,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Après Bac",
                  style: TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(), // Add Spacer widget to push the second Text widget to the right
                InkWell(
                  onTap: () => Get.to(const Bac()),
                  child: const Text(
                    "See all",
                    style: TextStyle(
                        fontFamily: 'Bitter', fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: controller.Showpub("bac"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
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
                  return Center(
                    child: Text("No data available"),
                  );
                } else {
                  return Container(
  height: AppConstant.screenHeight * 0.4, // Adjust height as needed
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4, // Adjust itemCount as needed
    itemBuilder: (context, index) {
      return Container(
        width: AppConstant.screenWidth * 0.6,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey, // Border color
            width: 0.5, // Border width
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              Expanded(
                flex: 7,
                child: Image.network(
                  "$linkservername/Admin/publication/upload/${snapshot.data[index]['file'].split(',')[0]}",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
  flex: 3,
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Text(
  "${snapshot.data[index]['titel']}".length > 15
      ? "${snapshot.data[index]['titel']}".substring(0, 20) + '...'
      : "${snapshot.data[index]['titel']}",
  style: TextStyle(
    fontFamily: 'Bitter',
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 20,),
                SizedBox(width: 8),
                Text(
                  "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['numberlike'] : ''}",
                  style: const TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "${snapshot.data[index]['description']}".length > 24
      ? "${snapshot.data[index]['description']}".substring(0, 23) + '...'
      : "${snapshot.data[index]['description']}",
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['date'] : ''}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  ),
),

            ],
          ),
        ),
      );
    },
  ),
);


                }
              },
            ),



            //////////////////////////////////LP///////////
            const SizedBox(
              height: 20,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Licence professionnelle",
                  style: TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(), // Add Spacer widget to push the second Text widget to the right
                InkWell(
                  onTap: () => Get.to(const Bac()),
                  child: const Text(
                    "See all",
                    style: TextStyle(
                        fontFamily: 'Bitter', fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: controller.Showpub("lp"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
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
                  return Center(
                    child: Text("No data available"),
                  );
                } else {
                  return Container(
  height: AppConstant.screenHeight * 0.4, // Adjust height as needed
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4, // Adjust itemCount as needed
    itemBuilder: (context, index) {
      return Container(
        width: AppConstant.screenWidth * 0.6,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey, // Border color
            width: 0.5, // Border width
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              Expanded(
                flex: 7,
                child: Image.network(
                  "$linkservername/Admin/publication/upload/${snapshot.data[index]['file'].split(',')[0]}",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
  flex: 3,
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Text(
  "${snapshot.data[index]['titel']}".length > 15
      ? "${snapshot.data[index]['titel']}".substring(0, 20) + '...'
      : "${snapshot.data[index]['titel']}",
  style: TextStyle(
    fontFamily: 'Bitter',
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 20,),
                SizedBox(width: 8),
                Text(
                  "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['numberlike'] : ''}",
                  style: const TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
        "${snapshot.data[index]['description']}".length > 15
      ? "${snapshot.data[index]['description']}".substring(0, 23) + '...'
      : "${snapshot.data[index]['description']}",  
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8),
        Text(
          "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['date'] : ''}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  ),
),




            ],
          ),
        ),
      );
    },
  ),
);


                }
              },
            ),

///////////////////////////////MASTER//////////////////////////////////

const SizedBox(
              height: 20,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Master",
                  style: TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(), // Add Spacer widget to push the second Text widget to the right
                InkWell(
                  onTap: () => Get.to(const Bac()),
                  child: const Text(
                    "See all",
                    style: TextStyle(
                        fontFamily: 'Bitter', fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: controller.Showpub("lp"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
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
                  return Center(
                    child: Text("No data available"),
                  );
                } else {
                  return Container(
  height: AppConstant.screenHeight * 0.4, // Adjust height as needed
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4, // Adjust itemCount as needed
    itemBuilder: (context, index) {
      return Container(
        width: AppConstant.screenWidth * 0.6,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey, // Border color
            width: 0.5, // Border width
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              Expanded(
                flex: 7,
                child: Image.network(
                  "$linkservername/Admin/publication/upload/${snapshot.data[index]['file'].split(',')[0]}",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
  flex: 3,
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Text(
  "${snapshot.data[index]['titel']}".length > 15
      ? "${snapshot.data[index]['titel']}".substring(0, 20) + '...'
      : "${snapshot.data[index]['titel']}",
  style: TextStyle(
    fontFamily: 'Bitter',
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 20,),
                SizedBox(width: 8),
                Text(
                  "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['numberlike'] : ''}",
                  style: const TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
        "${snapshot.data[index]['description']}".length > 15
      ? "${snapshot.data[index]['description']}".substring(0, 23) + '...'
      : "${snapshot.data[index]['description']}",  
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8),
        Text(
          "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['date'] : ''}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  ),
),




            ],
          ),
        ),
      );
    },
  ),
);


                }
              },
            ),

    /////////////////////////////////ECOLE//////////////////////////////
    const SizedBox(
              height: 20,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  " ÉCOLES ",
                  style: TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(), // Add Spacer widget to push the second Text widget to the right
                InkWell(
                  onTap: () => Get.to(const Bac()),
                  child: const Text(
                    "See all",
                    style: TextStyle(
                        fontFamily: 'Bitter', fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: controller.Showpub("lp"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
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
                  return Center(
                    child: Text("No data available"),
                  );
                } else {
                  return Container(
  height: AppConstant.screenHeight * 0.4, // Adjust height as needed
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4, // Adjust itemCount as needed
    itemBuilder: (context, index) {
      return Container(
        width: AppConstant.screenWidth * 0.6,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey, // Border color
            width: 0.5, // Border width
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              Expanded(
                flex: 7,
                child: Image.network(
                  "$linkservername/Admin/publication/upload/${snapshot.data[index]['file'].split(',')[0]}",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
  flex: 3,
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Text(
  "${snapshot.data[index]['titel']}".length > 15
      ? "${snapshot.data[index]['titel']}".substring(0, 20) + '...'
      : "${snapshot.data[index]['titel']}",
  style: TextStyle(
    fontFamily: 'Bitter',
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 20,),
                SizedBox(width: 8),
                Text(
                  "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['numberlike'] : ''}",
                  style: const TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
        "${snapshot.data[index]['description']}".length > 15
      ? "${snapshot.data[index]['description']}".substring(0, 23) + '...'
      : "${snapshot.data[index]['description']}",  
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8),
        Text(
          "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['date'] : ''}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  ),
),




            ],
          ),
        ),
      );
    },
  ),
);


                }
              },
            ),

    /////////////////////////////////////// DOCTORATS ///////////////////////
    const SizedBox(
              height: 20,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  " DOCTORATS ",
                  style: TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(), // Add Spacer widget to push the second Text widget to the right
                InkWell(
                  onTap: () => Get.to(const Bac()),
                  child: const Text(
                    "See all",
                    style: TextStyle(
                        fontFamily: 'Bitter', fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: controller.Showpub("lp"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
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
                  return Center(
                    child: Text("No data available"),
                  );
                } else {
                  return Container(
  height: AppConstant.screenHeight * 0.4, // Adjust height as needed
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4, // Adjust itemCount as needed
    itemBuilder: (context, index) {
      return Container(
        width: AppConstant.screenWidth * 0.6,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey, // Border color
            width: 0.5, // Border width
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              Expanded(
                flex: 7,
                child: Image.network(
                  "$linkservername/Admin/publication/upload/${snapshot.data[index]['file'].split(',')[0]}",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
  flex: 3,
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Text(
  "${snapshot.data[index]['titel']}".length > 15
      ? "${snapshot.data[index]['titel']}".substring(0, 20) + '...'
      : "${snapshot.data[index]['titel']}",
  style: TextStyle(
    fontFamily: 'Bitter',
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 20,),
                SizedBox(width: 8),
                Text(
                  "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['numberlike'] : ''}",
                  style: const TextStyle(
                    fontFamily: 'Bitter',
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
        "${snapshot.data[index]['description']}".length > 15
      ? "${snapshot.data[index]['description']}".substring(0, 23) + '...'
      : "${snapshot.data[index]['description']}",  
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8),
        Text(
          "${snapshot.data != null && snapshot.data.length > index ? snapshot.data[index]['date'] : ''}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  ),
),




            ],
          ),
        ),
      );
    },
  ),
);


                }
              },
            ),
          ],
        ),
      ),
    );
  }
}





