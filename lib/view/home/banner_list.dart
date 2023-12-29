import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/app_constants.dart';
import '../../models/profile/slide_show_model.dart';
import '../../utils/images.dart';
import 'banner_detail_screen.dart';

class BannerList extends StatefulWidget {
  final List<Slides> list;
  const BannerList({super.key, required this.list});

  @override
  BannerListState createState() => BannerListState();
}

class BannerListState extends State<BannerList> with TickerProviderStateMixin{
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return widget.list.isEmpty
        ? const SizedBox()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: 20.h,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.list.map((imageUrl) {
            return Builder(builder: (BuildContext context) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return BannerDetailScreen(imageUrl);
                          }),
                        );
                      },
                child: Container(
                  width: double.infinity,
                  height: 20.h,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlSlides}${imageUrl.image}",
                      errorWidget: (context, url, error) =>
                          Image.asset(Images.groundImage, fit: BoxFit.cover, height: 20.h,),
                    ),
                  ),
                ),
              );
            });
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.list.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 7.0,
                height: 7.0,
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness ==
                        Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
