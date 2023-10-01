import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String localisation;
  final String timeAgo;
  final String titel;
  final String description;
  final String postImage;
  

  PostCard({
    required this.localisation,
    required this.timeAgo,
    required this.titel,
    required this.description,
    required this.postImage,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isExpanded = false;

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
                Text(widget.localisation),
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
                  child: Text(widget.description,
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
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image.network(widget.postImage), // Display the post image
          Padding(
            padding: const EdgeInsets.all(0),
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
