import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/link.dart';

import '../../../config/constants/app_constant.dart';
import '../../../data/const_link.dart';
import '../controllers/home_controller.dart';

class Slidere extends StatefulWidget {
  @override
  State<Slidere> createState() => _SlidereState();
}

class _SlidereState extends State<Slidere> {
  final HomeController controllers = Get.put(HomeController());
  int activeIndex = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controllers.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: controllers.ListSliders.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final String urlImage = "${controllers.ListSliders[index]['image']}";
            return SingleChildScrollView(
              child: Card( 
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 2,
                  child: Column(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          // child: Image.network(
                          //   urlImage,
                          //   fit: BoxFit.cover,
                          //   height: AppConstant.screenHeight * 0.28,
                          // ),
                          child:  Image.network(
                              "$linkservername/slider/upload/$urlImage",
                              fit: BoxFit.cover,
                              height: AppConstant.screenHeight * 0.28,
                            ),
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: Container(
                            width: AppConstant.screenWidth * 0.8,
                            height: AppConstant.screenHeight * 0.28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 14, 13, 13),
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: AppConstant.screenHeight * 0.26),
                            child: buildIndicator()),
                        Positioned(
                          left: AppConstant.screenWidth * 0.077,
                          top: AppConstant.screenHeight * 0.06,
                          child: Text(
                            "${controllers.ListSliders[index]['titel1']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.70,
                            ),
                          ),
                        ),
                        Positioned(
                          left: AppConstant.screenWidth * 0.077,
                          top: AppConstant.screenHeight * 0.09,
                          child: Text(
                            "${controllers.ListSliders[index]['titel2']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26.08,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // }),
                        Positioned(
                          child: Link(
                            uri: Uri.parse("www.facebook.com"),
                            builder: ((context, followLink) => TextButton(
                              onPressed: followLink,
                              child:  Container(
                              margin: EdgeInsets.only(
                                  left: AppConstant.screenWidth * 0.08,
                                  top: AppConstant.screenHeight * 0.14),
                              width: AppConstant.screenWidth * 0.3,
                              height: AppConstant.screenHeight * 0.035,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.36),
                                color: const Color(0xfffebd2a),
                              ),
                              child:  Center(
                                child: Text(
                                  "${controllers.ListSliders[index]['titel_link']}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.25,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            )
                          ),
                        ),),
                      ],
                    ),
                  ])),
            );
          },
          options: CarouselOptions(
            height: AppConstant.screenHeight * 0.3,
            /////
            autoPlay: true,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            enlargeCenterPage: false,
            onPageChanged: (int index, CarouselPageChangedReason reason) =>
                setState(() => activeIndex = index),
          ),
        ),
        Positioned(
          top: AppConstant.screenHeight * .1,
          left: AppConstant.screenWidth * .05,
          child: InkWell(
            onTap: () => controller.previousPage(),
            child: Container(
              width: AppConstant.screenWidth * 0.09,
              height: AppConstant.screenHeight * 0.045,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),

                    spreadRadius: 0.2,

                    blurRadius: 11,

                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(left: AppConstant.screenWidth * 0.01),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 13,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: AppConstant.screenHeight * .1,
          right: AppConstant.screenWidth * .05,
          child: InkWell(
            onTap: () => controller.nextPage(),
            child: Container(
              width: AppConstant.screenWidth * 0.09,
              height: AppConstant.screenHeight * 0.045,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.2,
                    blurRadius: 11,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(left: AppConstant.screenWidth * 0.002),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                ),
              ),
            ),
          ),
        ),
      ],
    );
      }
    });
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
          dotHeight: 10, // Set your desired height
          dotWidth: 10, // Set your desired width
          dotColor: Colors.white,
          activeDotColor: const Color.fromARGB(255, 243, 212, 33),
        ),
        activeIndex: activeIndex,
        count: controllers.ListSliders.length,
      );
}
