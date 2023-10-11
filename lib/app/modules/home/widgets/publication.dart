import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/home/pages/commentaires.dart';

class PostCard extends StatefulWidget {
  final String localisation;
  final String timeAgo;
  final String titel;
  final String description;
  final String postImage;
  final int? id_publication;
  bool? forcomment = false;

  PostCard({
    required this.localisation,
    required this.timeAgo,
    required this.titel,
    required this.description,
    required this.postImage,
    this.id_publication,
    this.forcomment,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isExpanded = false;
  bool _isfavorit = false;
  int _like = 0;
  int comment = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: widget.forcomment == false ? 10 : 0,
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
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        widget.titel,
                        maxLines: 2, // Change the number of lines to display
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
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
                    style: TextStyle(
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
                          onPressed: () {
                            setState(() {
                              _isfavorit = !_isfavorit;
                            });
                          },
                        ),
                      ),
                      Text(
                        "$_like",
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
                                    localisation: widget.localisation,
                                    timeAgo: widget.timeAgo,
                                    description: widget.description,
                                    titel: widget.titel,
                                    postImage: widget.postImage,
                                  ));
                            },
                          ),
                        ),
                        Text(
                          "$_like",
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
  }
}
