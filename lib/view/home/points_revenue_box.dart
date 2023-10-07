import 'package:elevens_organizer/view/refer_and_earn/refer_and_earn_screen.dart';
import 'package:elevens_organizer/view/revenue/revenue_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/navigation_provider.dart';
import '../../utils/colours.dart';
import '../../utils/styles.dart';

class PointsAndRevenueBox extends StatelessWidget {
  final String image, title, value;
  final int id;
  const PointsAndRevenueBox(this.image, this.title, this.value, this.id, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18.h,
      width: 42.w,
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: id == 1 ? Alignment.centerLeft : Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            id == 1 ? AppColor.primaryColor : AppColor.secondaryColor,
            id == 1 ? AppColor.secondaryColor : AppColor.primaryColor,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: fontMedium.copyWith(
                fontSize: 11.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 1.5.h),
          InkWell(
            onTap: (){
              if(id == 2){
                Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(3);
              } else if(id == 1){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ReferAndEarnScreen(value);
                  }),
                );
              }
            },
            child: Text(value,
              style: fontMedium.copyWith(
                  fontSize: 15.sp,
                  color: AppColor.textColor
              ),),
          ),
          SizedBox(height: 1.h),
          const Spacer(),
          InkWell(
            onTap: (){
              print(id);
              if(id == 2){
                Provider.of<NavigationProvider>(context, listen: false).setCurrentIndex(3);
              } else if(id == 1){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ReferAndEarnScreen(value);
                  }),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 2.4.w,
                vertical: 1.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.lightColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text("View Details",
              style: fontMedium.copyWith(
                color: AppColor.textColor,
                fontSize: 9.sp
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
