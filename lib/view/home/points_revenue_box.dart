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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        print(id);
        if(id == 2){
          Navigator.pushNamed(context, "revenue_screen");
        } else if(id == 1){
          Navigator.pushNamed(context, "refer_and_earn_screen");
        }
      },
      child: Container(
        height: 20.h,
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
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 2.h, right: 2.w
              ),
              child: SvgPicture.asset(image, width: 23.w,),
            ),
            Positioned(
              top: 2.h,
              left: 4.w,
              bottom: 2.h,
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
                  SizedBox(height: 2.5.h),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      print(id);
                      if(id == 2){
                        Navigator.pushNamed(context, "revenue_screen");
                      } else if(id == 1){
                        Navigator.pushNamed(context, "refer_and_earn_screen");
                      }
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
