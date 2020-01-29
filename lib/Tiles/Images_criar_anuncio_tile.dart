import 'dart:io';
import 'package:flutter/material.dart';

class ImagesAnunTile extends StatelessWidget {

  final File imagefile;


  ImagesAnunTile(this.imagefile);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        margin: EdgeInsets.all(2.5),
        child: Image(
          image:FileImage(imagefile),
        ),
      ),
    );
  }
}
