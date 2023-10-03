import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';

class GalleryImageView extends StatelessWidget {
  final dynamic galleryImage;
  const GalleryImageView(this.galleryImage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 2.h
      ),
      decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          )
      ),
      child: ListView.separated(
          separatorBuilder: (context, _){
            return SizedBox(width: 3.w);
          },
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: galleryImage.length,
          itemBuilder: (context, index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlGallery}${galleryImage[index].toString()}",
                fit: BoxFit.cover,
                width: 80.w,
                height: 40.0,
                errorWidget: (context, url, widget){
                  return Image.asset(Images.groundListImage1);
                },
              ),
            );
          }
      ),
    );
  }
}
