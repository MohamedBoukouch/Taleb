import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/themes/app_theme.dart';
import 'package:taleb/app/modules/splash/pages/splash2.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation<double> _animation;

  // @override
  // void initState() {
  //   super.initState();
  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 20), // Set the animation duration here
  //   );

  //   _animation =
  //       Tween<double>(begin: 0, end: 100).animate(_animationController);

  //   _animationController.forward().whenComplete(() {
  //     // Animation is complete, navigate to the other screen here
  //     Get.to(const Splash2());
  //   });
  // }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: AppConstant.screenHeight * .15),
              width: AppConstant.screenWidth * .9,
              child: Image.asset("assets/splash/SL1.jpg")),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(AppConstant.screenWidth * 0.01),
                margin: EdgeInsets.all(AppConstant.screenHeight * 0.033),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Découvrez",
                      style: TextStyle(
                        color: AppTheme.whit_color,
                        fontSize: 36,
                        fontFamily: 'Inspiration',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            bottom: AppConstant.screenHeight * 0.058),
                        child: const Text(
                          "Cette application aide un groupe d'étudiants marocains dans leurs études post-bac dans tous leurs cours.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.whit_color,
                            fontSize: 15,
                            fontFamily: 'Inspiration',
                          ),
                        )),
                  ],
                ),
              ),
              Positioned(
                left: AppConstant.screenWidth * 0.4,
                bottom: AppConstant.screenHeight * 0,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: AppConstant.screenWidth * 0.17,
                        height: AppConstant.screenHeight * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                        right: AppConstant.screenWidth * 0.085,
                        bottom: AppConstant.screenHeight * 0.038,
                        child: CustomPaint(
                          foregroundPainter: CircleProgressPainter(
                            progress: 50,
                            color: Color.fromARGB(255, 241, 131, 53),
                          ),
                        )),
                    Positioned(
                      right: AppConstant.screenWidth * 0.027,
                      bottom: AppConstant.screenWidth * 0.02,
                      child: Container(
                        width: AppConstant.screenWidth * 0.116,
                        height: AppConstant.screenHeight * 0.055,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(58.41),
                          color: AppTheme.reed_color,
                        ),
                        child: InkWell(
                          onTap: () => Get.to(const SplashView2()),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppTheme.whit_color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  CircleProgressPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..strokeWidth = 3
      ..color = AppTheme.box_color
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 28;
    canvas.drawCircle(center, radius, circle);

    Paint animationArc = Paint()
      ..strokeWidth = 3
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double angle = -2 * pi * (progress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 2,
      angle,
      false,
      animationArc,
    );
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
