import "package:flutter/material.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:get/get.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";
import "package:taleb/app/config/constants/app_constant.dart";

import "../controllers/home_controller.dart";

class Slidere extends StatefulWidget {
  // const Slider({Key? key}) : super(key: key);

  @override
  State<Slidere> createState() => _SlidereState();
}

class _SlidereState extends State<Slidere> {
  final HomeController controllers = Get.put(HomeController());
  int activeIndex = 0;
  final CarouselController controller = CarouselController();
  final List<String> urlImages = <String>[
    "https://media.istockphoto.com/id/1318291081/fr/photo/tour-eiffel-en-m%C3%A9tal.jpg?b=1&s=170667a&w=0&k=20&c=glQNxEe4MJYaCOzIFPyOxbUrHBvv818Aq6HGCqHh1D0=",
    "https://www.visitmorocco.com/sites/default/files/styles/thumbnail_destination_background_top5/public/thumbnails/image/tour-hassan-rabat-morocco-by-migel.jpg?itok=YP8GLwSi",
    "https://itourisme.net/wp-content/uploads/2016/09/visit-marrakesh-morocco.jpg",
  ];
  final List<String> villes = <String>["Paris", "Rabat", "Marakech"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CarouselSlider.builder(
            carouselController: controller,
            itemCount: urlImages.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final String urlImage = urlImages[index];
              return SingleChildScrollView(
                child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 2,
                    child: Column(children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Image.network(
                              urlImage,
                              fit: BoxFit.cover,
                              width: AppConstant.screenWidth * 0.8,
                              height: AppConstant.screenHeight * 0.28,
                            ),
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Container(
                              width: AppConstant.screenWidth * 0.8,
                              height: AppConstant.screenHeight * 0.28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
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
                            child: const Text(
                              "Bonjour",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.70,
                              ),
                            ),
                          ),
                          // FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          //     future: controllers.getCities(),
                          //     builder: (context,
                          //         AsyncSnapshot<
                          //                 QuerySnapshot<Map<String, dynamic>>>
                          //             snapshot) {
                          //       if (snapshot.hasError) return SizedBox();
                          //       if (!snapshot.hasData ||
                          //           snapshot.data == null) {
                          //         // Handle the case when snapshot.data is null or not yet available
                          //         return const Center(
                          //             child:
                          //                 CircularProgressIndicator()); // or any other widget indicating loading state
                          //       }
                          //       final List<
                          //               QueryDocumentSnapshot<
                          //                   Map<String, dynamic>>> response =
                          //           snapshot.data!.docs;
                          //       Cities cities = Cities.fromMap(
                          //           snapshot.data!.docs[index].data());
                          //       print(cities.name);
                          //       return
                          Positioned(
                            left: AppConstant.screenWidth * 0.077,
                            top: AppConstant.screenHeight * 0.09,
                            child: Text(
                              "Explorez ${villes[index]}",
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
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: AppConstant.screenWidth * 0.08,
                                  top: AppConstant.screenHeight * 0.14),
                              width: AppConstant.screenWidth * 0.3,
                              height: AppConstant.screenHeight * 0.035,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.36),
                                color: const Color(0xfffebd2a),
                              ),
                              child: const Center(
                                child: Text(
                                  "Decouvrir la visite",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.25,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                    setState(() => activeIndex = index))),
        const SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.only(right: AppConstant.screenWidth * 0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.only(left: AppConstant.screenWidth * 0.01),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 13,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: AppConstant.screenWidth * 0.02,
              ),
              InkWell(
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.only(left: AppConstant.screenWidth * 0.002),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotHeight: AppConstant.screenHeight * 0.01,
            dotWidth: AppConstant.screenWidth * 0.019,
            dotColor: Colors.white,
            activeDotColor: const Color.fromARGB(255, 243, 212, 33)),
        activeIndex: activeIndex,
        count: urlImages.length,
      );
  void animateToSlide(int index) => controller.animateToPage(index);
}
