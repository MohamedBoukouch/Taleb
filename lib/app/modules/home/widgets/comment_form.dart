import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/main.dart';

class CommentForm extends StatefulWidget {
  final String text;
  final String firstname;
  final String lastname;
  final String id_user;
  final String id_comment;
  final int id_publication;
  const CommentForm({
    Key? key,
    required this.text,
    required this.firstname,
    required this.lastname,
    required this.id_user,
    required this.id_comment,
    required this.id_publication,
  }) : super(key: key);

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(29, 190, 188, 188),
          borderRadius: BorderRadius.circular(15)),
      child: ListTile(
          title: Text("${widget.firstname}_${widget.lastname}"),
          titleTextStyle:
              const TextStyle(color: Color.fromARGB(255, 82, 80, 80)),
          subtitle: Align(
            alignment: Alignment.centerRight,
            child: Text('${widget.text}'),
          ),
          subtitleTextStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://th.bing.com/th/id/OIP.ysdd9pBlwnNdnxQoC8y4KQHaHa?pid=ImgDet&rs=1",
            ),
          ),
          trailing: Column(
            children: [
              InkWell(
                onTap: () {
                  try {
                    setState(() async {
                      await controller.Deletcomment(
                          widget.id_comment, widget.id_publication, context);
                    });
                  } catch (e) {
                    print("eroor to delet");
                  }
                  // setState(() {});
                },
                child: Icon(
                  widget.id_user == "${sharedpref.getString("id")}"
                      ? Icons.delete
                      : null,
                  color: Colors.red,
                  size: 19,
                ),
              ),
              SizedBox(
                height: AppConstant.screenHeight * .02,
              ),
              Icon(
                Icons.favorite_border,
                size: 19,
              ),
            ],
          )),
    );
  }
}
