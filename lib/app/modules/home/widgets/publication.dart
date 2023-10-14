import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/pages/commentaires.dart';
import 'package:taleb/app/modules/home/pages/test.dart';

class PostCard extends StatefulWidget {
  final String localisation;
  final String timeAgo;
  final String titel;
  final String description;
  final String postImage;
  final String id_publication;
  bool? forcomment = false;
  final int numberlike;
  final int numbercomment;
  PostCard({
    Key? key,
    required this.localisation,
    required this.timeAgo,
    required this.titel,
    required this.description,
    required this.postImage,
    required this.id_publication,
    required this.numberlike,
    required this.numbercomment,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isExpanded = false;
  bool _isfavorit = false;
  int _like = 0;
  int comment = 0;
  var nbr_cmt;
  late int nbr_like = widget.numberlike;
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: widget.forcomment == false ? 10 : 0,
      // elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                  color: Colors.red,
                  size: 20,
                ),
                Text(widget.localisation),
              ],
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.blue,
                  size: 19,
                ),
                Text(widget.timeAgo),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isExpanded
                    ? Text(
                        widget.titel,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        widget.titel,
                        maxLines: 2, // Change the number of lines to display
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded ? "" : "  Read More...",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          _isExpanded
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.description,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : SizedBox.shrink(),
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? "Read Less" : "",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image.network(widget.postImage), // Display the post image
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: AppConstant.screenWidth * .29,
                  height: AppConstant.screenHeight * .06,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(64, 158, 158, 158),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: AppConstant.screenWidth * .055),
                        child: IconButton(
                          icon: _isfavorit == false
                              ? const Icon(
                                  Icons.favorite_border,
                                  size: 25,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                ),
                          onPressed: () async {
                            setState(() {
                              _isfavorit = !_isfavorit;
                              _isfavorit == false ? nbr_like-- : nbr_like++;
                              // nbr_like++;
                            });
                            try {
                              await controller.Likepublication(
                                  widget.id_publication, "$nbr_like");
                            } catch (e) {
                              print("saba hhh");
                            }
                          },
                        ),
                      ),
                      Text(
                        "$nbr_like",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: AppConstant.screenWidth * .29,
                    height: AppConstant.screenHeight * .06,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(64, 158, 158, 158),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: AppConstant.screenWidth * .055),
                          child: IconButton(
                            icon: const Icon(
                              Icons.chat_bubble_outline,
                              size: 25,
                            ),
                            onPressed: () {
                              Get.to(() => Commentaire(
                                    id_publication: "${widget.id_publication}",
                                    number_comment: widget.numbercomment,
                                  ));
                            },
                          ),
                        ),
                        Text(
                          "${widget.numbercomment}",
                          style: TextStyle(),
                        ),
                      ],
                    )),
                Container(
                  width: AppConstant.screenWidth * .29,
                  height: AppConstant.screenHeight * .06,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(64, 158, 158, 158),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    icon: const Icon(
                      Icons.share,
                      size: 25,
                    ),
                    onPressed: () {
                      // Add share functionality here
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
