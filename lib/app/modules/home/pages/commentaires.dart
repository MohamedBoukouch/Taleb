import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/widgets/comment_form.dart';
import 'package:taleb/app/shared/back.dart';
import 'package:taleb/main.dart';
import 'package:taleb/main.dart';
import 'package:taleb/main.dart';
import 'package:taleb/main.dart';

class Commentaire extends StatefulWidget {
  final String id_publication;

  const Commentaire({
    Key? key,
    required this.id_publication,
  }) : super(key: key);

  @override
  State<Commentaire> createState() => _CommentaireState();
}

class _CommentaireState extends State<Commentaire> {
  final TextEditingController _commentController = TextEditingController();
  final HomeController controller = Get.put(HomeController());
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.Showcomment("${widget.id_publication}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commentaires".tr),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: ButtonBack(),
      ),
      body: Column(
        children: [
          Expanded(
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
                    child: Text("No comments available"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      // return Text("${widget.id_publication}");
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: CommentForm(
                          haveprofile: snapshot.data[index]['profile'],
                          profile:
                              "$linkserverimages/profile/${snapshot.data[index]['profile']}",
                          id_publication: "${widget.id_publication}",
                          numbercomment: snapshot.data[index]['number_comment'],
                          firstname: "${snapshot.data[index]['firstname']}",
                          lastname: "${snapshot.data[index]['lastname']}",
                          text: "${snapshot.data[index]['text']}",
                          id_user: "${snapshot.data[index]['id_user']}",
                          id_comment: "${snapshot.data[index]['id']}",
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    style: TextStyle(
                      color: Colors.black, // Set the text color to red
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write_comment'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a comment';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                    onTap: () async {
                      setState(() {
                        // isLoading = true;
                      });

                      try {
                        await controller.Addcommentaire(
                            "${sharedpref.getString('id')}",
                            "${widget.id_publication}",
                            "${_commentController.text}");
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() {
                          _commentController.clear();
                        });
                      }
                    },
                    child: Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
