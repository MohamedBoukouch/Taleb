import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taleb/app/modules/home/widgets/publication.dart';
import 'package:taleb/app/shared/edittext.dart';

class Commentaire extends StatefulWidget {
  // final int? id_publication;
  final String localisation;
  final String timeAgo;
  final String titel;
  final String description;
  final String postImage;
  const Commentaire({
    Key? key,
    // this.id_publication,
    required this.localisation,
    required this.timeAgo,
    required this.titel,
    required this.description,
    required this.postImage,
  }) : super(key: key);

  @override
  State<Commentaire> createState() => _CommentaireState();
}

class _CommentaireState extends State<Commentaire> {
  final TextEditingController _commentController = TextEditingController();
  List _messages = ['fff', 'gggg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       PostCard(
      //         forcomment: true,
      //         localisation: widget.localisation,
      //         timeAgo: widget.timeAgo,
      //         titel: widget.titel,
      //         description: widget.description,
      //         postImage: widget.postImage,
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(15),
      //         child: Row(
      //           children: [
      //             const CircleAvatar(
      //               backgroundImage: NetworkImage(
      //                 "https://th.bing.com/th/id/OIP.ysdd9pBlwnNdnxQoC8y4KQHaHa?pid=ImgDet&rs=1",
      //               ),
      //               radius: 30,
      //             ),
      //             const SizedBox(
      //               width: 8,
      //             ),
      //             Container(
      //               padding: const EdgeInsets.all(15),
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(20),
      //                   color: const Color.fromARGB(139, 158, 158, 158)),
      //               child: Text("ffffff"),
      //             )
      //           ],
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: TextField(
      //           controller: _commentController,
      //           decoration: InputDecoration(
      //             hintText: 'Write a comment',
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PostCard(
              forcomment: true,
              localisation: widget.localisation,
              timeAgo: widget.timeAgo,
              titel: widget.titel,
              description: widget.description,
              postImage: widget.postImage,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://th.bing.com/th/id/OIP.ysdd9pBlwnNdnxQoC8y4KQHaHa?pid=ImgDet&rs=1",
                    ),
                    radius: 30,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(139, 158, 158, 158)),
                    child: Text("ffffff"),
                  )
                ],
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      // onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(hintText: 'Type a message'),
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.send),
                  //   onPressed: () => _handleSubmitted(_textController.text),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
