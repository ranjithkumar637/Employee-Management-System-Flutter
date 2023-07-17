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
      child: Container(
        height: imageHeight,
        width: imageWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        decoration: const BoxDecoration(
          color: AppColor.primaryColor,
        ),
        child: CachedNetworkImage(
          imageUrl: '${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlCaptain}$imageUrl', fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.person_outline_rounded),
        ),
      ),
    );
  }
}
