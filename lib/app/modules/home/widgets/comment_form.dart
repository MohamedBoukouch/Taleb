import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/main.dart';

class CommentForm extends StatefulWidget {
  final String text;
  final String firstname;
  final String lastname;
  final String id_user;
  final String id_comment;
  final String id_publication;
  final String profile;
  final int numbercomment;
  final String haveprofile;

  const CommentForm({
    Key? key,
    required this.text,
    required this.firstname,
    required this.lastname,
    required this.id_user,
    required this.id_comment,
    required this.id_publication,
    required this.profile,
    required this.haveprofile,
    required this.numbercomment,
  }) : super(key: key);

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final HomeController controller = Get.put(HomeController());
  late int _nbr_comment;

  @override
  void initState() {
    super.initState();
    _nbr_comment = widget.numbercomment;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(29, 190, 188, 188),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text("${widget.firstname} ${widget.lastname}"),
        titleTextStyle: const TextStyle(color: Color.fromARGB(255, 82, 80, 80)),
        subtitle: Align(
          alignment: Alignment.centerRight,
          child: Text('${widget.text}'),
        ),
        subtitleTextStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        leading: CircleAvatar(
          radius: 27,
          backgroundImage: (widget.haveprofile == "0"
              ? AssetImage("assets/profile/Profile_2.png")
              : NetworkImage("${widget.profile}") as ImageProvider<Object>),
        ),
        trailing: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _nbr_comment--;
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Delete Comment"),
                      content: const Text(
                          "Do you really want to delete this comment?"),
                      actions: [
                        AppFunction.cancel(),
                        AppFunction.deletcomment(
                          widget.id_comment,
                          widget.id_publication,
                          "$_nbr_comment",
                          context,
                        ),
                      ],
                    );
                  },
                );
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
          ],
        ),
      ),
    );
  }
}
