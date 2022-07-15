import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleImage extends StatelessWidget {
  final dynamic image;
  final double height;
  final double width;
  final BoxFit fit;
  final bool darken;
  const SingleImage({
    Key key,
    @required this.image,
    this.height,
    this.darken = false,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      height: height,
      width: width,
      image: image is File
          ? FileImage(image)
          : image.toString().contains("assets/images")
              ? AssetImage(image.toString())
              : CachedNetworkImageProvider(
                  image.toString(),
                ),
      fit: fit,
      color: darken ? Colors.black.withOpacity(0.5) : Colors.transparent,
      colorBlendMode: BlendMode.darken,
    );
  }
}
