import 'package:flutter/material.dart';

class ImageFormSearch extends StatefulWidget {
  const ImageFormSearch({Key? key}) : super(key: key);

  @override
  State<ImageFormSearch> createState() => _ImageFormSearchState();
}

class _ImageFormSearchState extends State<ImageFormSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: ,
      child: Image.network(
          "https://th.bing.com/th/id/R.7ca3681c4fb0c8adcc1ab9bdd4572655?rik=2Gru%2fWwVxbLLdA&pid=ImgRaw&r=0"),
    );
  }
}
