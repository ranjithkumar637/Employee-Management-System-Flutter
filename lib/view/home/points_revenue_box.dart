import 'package:elevens_organizer/view/refer_and_earn/refer_and_earn_screen.dart';
import 'package:elevens_organizer/view/revenue/revenue_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

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
    return Bounceable(
      onTap: (){
        print(id);
        if(id == 2){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const RevenueScreen();
            }),
          );
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
        height: 20.h,
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
          image: DecorationImage(
            image: AssetImage(
                image
            ),)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.textColor
              ),),
            SizedBox(height: 1.5.h),
            Text(value,
              style: fontMedium.copyWith(
                  fontSize: 18.sp,
                  color: AppColor.textColor
              ),),
            SizedBox(height: 1.5.h),
            Container(
              width: 30.w,
              height: 4.h,
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 0.6.h,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: AppColor.lightColor
              ),
              child: Center(
                child: Text("View Details",
                  style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
