import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/snackbar.dart';


class RefCodeDialog extends StatefulWidget {
  final String refCode;
  const RefCodeDialog({Key? key, required this.refCode}) : super(key: key);

  @override
  State<RefCodeDialog> createState() => _RefCodeDialogState();
}

class _RefCodeDialogState extends State<RefCodeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 5.w
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context){
    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          Image.asset(Images.refDialogImage, width: 50.w,),
          SizedBox(height: 2.h),
          Text("Your Referral code",
            textAlign: TextAlign.center,
            style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 3.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 7.w,
              vertical: 1.h,
            ),
            decoration: BoxDecoration(
                color: const Color(0xffFAEDD0),
                border: RDottedLineBorder.all(color: AppColor.primaryColor)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.refCode,
                  textAlign: TextAlign.center,
                  style: fontMedium.copyWith(
                      fontSize: 18.sp,
                      color: AppColor.secondaryColor
                  ),),
                InkWell(
                    onTap: (){
                      FlutterClipboard.copy(widget.refCode).then(( value ){
                        print('copied');
                        Navigator.pop(context);
                        Dialogs.snackbar("Referral code ${widget.refCode} is copied", context, isError: false);
                      });

                    },
                    child: Icon(Icons.copy, color: const Color(0xff8E8E8E), size: 5.w,))
              ],
            ),
          ),
          SizedBox(height: 1.h),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Bounceable(
                onTap: (){
                  String url = "https://play.google.com/store/apps/details?id=com.eleven.captain";
                  Share.share('Hey fellow cricket captains! Enjoy the game even more by using our referral code ${widget.refCode}.'
                      ' It\'s your ticket to fantastic cricket experiences. Share the code and let\'s play together! 🏏🤝 \n $url');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 0.6.h,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColor.textColor
                  ),
                  child: Center(
                    child: Text("Share",
                      style: fontRegular.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.lightColor
                      ),),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
