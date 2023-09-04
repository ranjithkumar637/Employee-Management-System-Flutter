import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/utils/app_constants.dart';
import 'package:elevens_organizer/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class TossSummaryDialog extends StatefulWidget {
  final String result, logo;
  const TossSummaryDialog(this.result, this.logo, {Key? key}) : super(key: key);

  @override
  State<TossSummaryDialog> createState() => _TossSummaryDialogState();
}

class _TossSummaryDialogState extends State<TossSummaryDialog> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        Navigator.pop(context);
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: 5.w
        ),
        child: contentBox(context),
      ),
    );
  }

  contentBox(BuildContext context){
    return Container(
      height: 35.h,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          ClipOval(
              child: CachedNetworkImage(
                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${widget.logo}",
                width: 20.w, height: 10.h, fit: BoxFit.cover,
                errorWidget: (context, url, error){
                  return Image.asset(Images.groundListImage1, width: 20.w, height: 10.h, fit: BoxFit.cover,);
                },
              )
          ),
          SizedBox(height: 2.h),
          Text(widget.result,
            textAlign: TextAlign.center,
            style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.textColor
            ),),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Bounceable(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: AppColor.secondaryColor, size: 4.5.w,),
                      SizedBox(width: 2.w),
                      Text("Home",
                        style: fontMedium.copyWith(
                            fontSize: 11.sp,
                            color: AppColor.secondaryColor
                        ),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5.w),
            ],
          ),
        ],
      ),
    );
  }

}
