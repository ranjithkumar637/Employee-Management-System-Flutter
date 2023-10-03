import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class Loader extends StatefulWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {

  final List<String> stringList = [
    "Cricket balls are hand-stitched.",
    "World's oldest cricket club: Marylebone Cricket Club (MCC).",
    "Cricket's first written rules date back to 1744.",
    "Sachin Tendulkar's 100 international centuries record.",
    "The term 'hat-trick' originates from cricket.",
    "Cricket's first Test match: England vs. Australia (1877).",
    "Cricket's spirit embodied in 'The Spirit of Cricket' document.",
    "Cricket in pop culture: The Beatles played cricket.",
    "First Women's World Cup in 1973.",
    "Cricket's fastest delivery: Shoaib Akhtar's 161.3 km/h.",
    "Cricket's World Cup anthem: 'Cricket World Cup Fever.'",
    "Cricket's longest six: Shahid Afridi's 158 meters.",
    "Cricket's highest team score: 481/6 by England.",
    "Cricket's longest partnership: 624 runs by two.",
    "Cricket's oldest international rivalry: England vs. Australia.",
    "Cricket's first recorded century: John Minshull (1769).",
    "Cricket's superstitious number: 111 known as 'Nelson.'",
    "Cricket's famous 'Doosra' delivery by Saqlain Mushtaq.",
    "Cricket's first-ever test wicket: Allan Steel (1877).",
    "Cricket's highest Test total: 952/6 declared by Sri Lanka.",
    "Cricket's first-ever T20 International: Australia vs. New Zealand.",
    "Cricket's famous reverse sweep shot by Kevin Pietersen.",
    "Cricket's highest T20 score: 263/3 by Royal Challengers Bangalore.",
    "Cricket's inaugural ICC World Twenty20 in 2007.",
    "Cricket's longest ODI match: South Africa vs. Zimbabwe (2006).",
    "Cricket's first Day-Night Test match: Australia vs. New Zealand (2015).",
    "Cricket's first Women's T20 International: England vs. New Zealand.",
    "Cricket's famous underarm incident: Australia vs. New Zealand (1981).",
    "Cricket's first-ever Women's Test match: England vs. Australia (1934).",
    "Cricket's shortest Test match: England vs. Australia (1902)."
  ];

  Random random = Random();
  String selectedString = "";

  void generateRandomString() {
    final randomIndex = random.nextInt(stringList.length);
    setState(() {
      selectedString = stringList[randomIndex];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateRandomString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/wicket.json", width: 100.w),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Text(
              selectedString,
              textAlign: TextAlign.center,
              style: fontRegular.copyWith(
                  fontSize: 11.sp,
                  color: AppColor.textMildColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}