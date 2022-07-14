import 'package:flutter/material.dart';

import 'package:eshamba_updated/Widget/PostWidget.dart';


class PostTile extends StatelessWidget{

  final Post post;

  PostTile(this.post);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(


      child: Image.network(post.url),
    );
  }
}