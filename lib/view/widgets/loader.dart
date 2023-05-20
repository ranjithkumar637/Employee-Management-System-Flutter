import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: Center(child: Lottie.asset("assets/wicket.json", width: 100.w)),
    );
  }
}