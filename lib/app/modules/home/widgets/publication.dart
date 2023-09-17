import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String userName;
  final String userImage;
  final String postText;
  final String postImage;
  final String timeAgo;

  PostCard({
    required this.userName,
    required this.userImage,
    required this.postText,
    required this.postImage,
    required this.timeAgo,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _read = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.map_sharp,
                  color: Colors.red,
                ),
                Text(widget.userName),
              ],
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.timer,
                  color: Colors.blue,
                  size: 17,
                ),
                Text(widget.timeAgo),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(widget.postText),
                InkWell(
                  onTap: () {
                    setState(() {
                      _read = !_read;
                    });
                  },
                  child: _read == false
                      ? Text(
                          "  Read More...",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      : null,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _read == true ? Text('''fddggggggggggggggggggggggggg
            ggggggggggggggggg
            rrrrrrrrrrrrrrrr
            vvvvvvvvvvvvvvvvvvvvvvv
            ddddddddddddddddddv
            v''') : null,
          ),
          Image.network(widget.postImage), // Display the post image
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    // Add like functionality here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    // Add comment functionality here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Add share functionality here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
