import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/home/pages/see_all.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import '../../../config/constants/app_constant.dart';
import '../controllers/home_controller.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}
  final HomeController controller = Get.put(HomeController());

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Slidere(),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "APRÈS_BAC".tr,
                    style: const TextStyle(
                      fontFamily: 'Bitter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(), // Add Spacer widget to push the second Text widget to the right
                  InkWell(
                    onTap: () => Get.to(const SeeAll(type:'bac')),
                    child:  Text(
                      "See_all".tr,
                      style: const TextStyle(
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
      itemCount: 3, // Adjust itemCount as needed
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Get.to(SeeAll(type: "${snapshot.data[index]['id']}",));
          },
          child: Container(
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
          ? "${snapshot.data[index]['description']}".substring(0, 15) + '...'
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
                   Text(
                    "LICENCE".tr,
                    style: const TextStyle(
                      fontFamily: 'Bitter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(), // Add Spacer widget to push the second Text widget to the right
                  InkWell(
                    onTap: () => Get.to(const SeeAll(type:'licence')),
                    child:  Text(
                      "See_all".tr,
                      style: const TextStyle(
                          fontFamily: 'Bitter', fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: controller.Showpub("licence"),
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
      itemCount: 3, // Adjust itemCount as needed
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Get.to(SeeAll(type: "${snapshot.data[index]['id']}",));
          },
          child: Container(
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
          ? "${snapshot.data[index]['titel']}".substring(0, 15) + '...'
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
          ? "${snapshot.data[index]['description']}".substring(0, 15) + '...'
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
                   Text(
                    "MASTER".tr,
                    style: const TextStyle(
                      fontFamily: 'Bitter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(), // Add Spacer widget to push the second Text widget to the right
                  InkWell(
                    onTap: () => Get.to(const SeeAll(type:"master")),
                    child:  Text(
                      "See_all".tr,
                      style: const TextStyle(
                          fontFamily: 'Bitter', fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: controller.Showpub("master"),
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
      itemCount: 3, // Adjust itemCount as needed
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Get.to(SeeAll(type: "${snapshot.data[index]['id']}",));
          },
          child: Container(
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
          ? "${snapshot.data[index]['titel']}".substring(0, 15) + '...'
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
          ? "${snapshot.data[index]['description']}".substring(0, 15) + '...'
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
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(), // Add Spacer widget to push the second Text widget to the right
                  InkWell(
                    onTap: () => Get.to(const SeeAll(type:'ecole')),
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
                future: controller.Showpub("ecole"),
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
      itemCount: 3, // Adjust itemCount as needed
      itemBuilder: (context, index) {
        return InkWell(
          child: Container(
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
          ? "${snapshot.data[index]['titel']}".substring(0, 15) + '...'
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
                    onTap: () => Get.to(const SeeAll(type:'doctorat')),
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
                future: controller.Showpub("doctorat"),
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
      itemCount: 3, // Adjust itemCount as needed
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Get.to(SeeAll(type: "${snapshot.data[index]['id']}",));
          },
          child: Container(
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
          ? "${snapshot.data[index]['titel']}".substring(0, 15) + '...'
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
    );
  }
}