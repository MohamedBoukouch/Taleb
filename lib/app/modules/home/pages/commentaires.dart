import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';
import 'package:taleb/app/modules/home/widgets/comment_form.dart';
import 'package:taleb/app/shared/publication.dart';
import 'package:taleb/app/shared/edittext.dart';
import 'package:taleb/main.dart';

class Commentaire extends StatefulWidget {
  final String id_publication;
  final int number_comment;

  const Commentaire({
    Key? key,
    required this.id_publication,
    required this.number_comment,
  }) : super(key: key);

  @override
  State<Commentaire> createState() => _CommentaireState();
}

class _CommentaireState extends State<Commentaire> {
  final TextEditingController _commentController = TextEditingController();
  final HomeController controller = Get.put(HomeController());
  final formKey = GlobalKey<FormState>();
  late int _nbr_comment = widget.number_comment;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        leading: IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () => Navigator.pop(context, true)),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
        ),
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath:
                  "https://th.bing.com/th/id/OIP.ysdd9pBlwnNdnxQoC8y4KQHaHa?pid=ImgDet&rs=1"),

          // ignore: sort_child_properties_last
          child: FutureBuilder(
            future: controller.Showcomment("${widget.id_publication}"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    color: Color.fromARGB(255, 246, 154, 7),
                    size: 40,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Image.asset(
                    "assets/icons/error.png",
                    width: AppConstant.screenWidth * .8,
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("No data available"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    // return Center(child: Text("${snapshot.data[index]['id']}"));
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: CommentForm(
                        id_publication: "${widget.id_publication}",
                        numbercomment: snapshot.data[index]['numbercomment'],
                        firstname: "${snapshot.data[index]['firstname']}",
                        lastname: "${snapshot.data[index]['lastname']}",
                        text: " ${snapshot.data[index]['text']}",
                        id_user: "${snapshot.data[index]['id_user']}",
                        id_comment: "${snapshot.data[index]['id_comment']}",
                      ),
                    );
                  },
                );
              }
            },
          ),

          labelText:
              _commentController.text.length > 0 ? "" : 'Write a comment...',
          withBorder: false,
          sendButtonMethod: () async {
            if (formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              setState(() {
                _nbr_comment++;
              });
              try {
                await controller.Addcommentaire(
                    "${sharedpref.getString('id')}",
                    "${widget.id_publication}",
                    _commentController.text,
                    "$_nbr_comment");
              } catch (e) {
                print(e);
              }
              _commentController.clear();
              FocusScope.of(context).unfocus();
              setState(() {});
            } else {
              print("Not validat:ed");
            }
          },
          formKey: formKey,
          commentController: _commentController,
          backgroundColor: Color.fromARGB(148, 158, 158, 158),
          textColor: Colors.black,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
