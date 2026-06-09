import 'package:flutter/material.dart';

class AlbumProgressIndicator extends CircularProgressIndicator {

  AlbumProgressIndicator({
    super.padding,
    super.strokeAlign
  });

  @override
  // TODO: implement color
  Color? get color => Colors.green;
}