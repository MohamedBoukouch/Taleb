import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/themes/app_theme.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';
import 'package:taleb/app/modules/setting/pages/cnc_pages/authers.dart';
import 'package:taleb/app/modules/setting/pages/cnc_pages/bac+2.dart';
import 'package:taleb/app/modules/setting/pages/cnc_pages/bac+3.dart';
import 'package:taleb/app/modules/setting/pages/cnc_pages/bac.dart';

class Councoures extends StatefulWidget {
  const Councoures({Key? key}) : super(key: key);

  @override
  State<Councoures> createState() => _CouncouresState();
}

class _CouncouresState extends State<Councoures> {
  int ctr = 0;

  Widget container() {
    return Container(
        // Your container content goes here
        );
  }

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 0,
      appbar: AppBar(
        title: Text(
          'councoures'.tr,
          style: TextStyle(fontFamily: 'Bitter'),
        ),
        // centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: AppConstant.screenWidth * .05),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          ctr = 0;
                        });
                      },
                      child: Container(
                        width: 10,
                        height: 40,
                        decoration: BoxDecoration(
                            color: ctr == 0 ? AppTheme.reed_color : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Bac",
                            style: TextStyle(
                                fontSize: 17,
                                color: ctr == 0 ? Colors.white : Colors.black,
                                fontFamily: 'Bitter'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          ctr = 1;
                        });
                      },
                      child: Container(
                        width: 10,
                        height: 40,
                        decoration: BoxDecoration(
                            color: ctr == 1 ? AppTheme.reed_color : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "BAC+2",
                            style: TextStyle(
                                fontSize: 17,
                                color: ctr == 1 ? Colors.white : Colors.black,
                                fontFamily: 'Bitter'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          ctr = 2;
                        });
                      },
                      child: Container(
                        width: 10,
                        height: 40,
                        decoration: BoxDecoration(
                            color: ctr == 2 ? AppTheme.reed_color : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "BAC+3",
                            style: TextStyle(
                                fontSize: 17,
                                color: ctr == 2 ? Colors.white : Colors.black,
                                fontFamily: 'Bitter'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          ctr = 3;
                        });
                      },
                      child: Container(
                        width: 10,
                        height: 40,
                        decoration: BoxDecoration(
                            color: ctr == 3 ? AppTheme.reed_color : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Autre",
                            style: TextStyle(
                                fontSize: 17,
                                color: ctr == 3 ? Colors.white : Colors.black,
                                fontFamily: 'Bitter'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ctr == 0
                ? Bac()
                : ctr == 1
                    ? Bac2()
                    : ctr == 2
                        ? Bac3()
                        : Authers()
          ],
        ),
      ),
    );
  }
}
