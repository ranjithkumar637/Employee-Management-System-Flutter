import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_constants.dart';
import '../../utils/colours.dart';

class PlayerImage extends StatelessWidget {
  final String imageUrl;
  final double imageHeight, imageWidth;
  const PlayerImage(this.imageUrl, this.imageHeight, this.imageWidth, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: '${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlProfile}$imageUrl', height: imageHeight,
        width: imageWidth, fit: BoxFit.cover,
        errorWidget: (context, url, error) =>  Image.network("https://cdn-icons-png.flaticon.com/256/4389/4389644.png", height: imageHeight,
          width: imageWidth,),
      ),
    );
  }
}
