import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';


class FilePickDialog extends StatefulWidget {
  final VoidCallback camera, gallery;
  const FilePickDialog({Key? key, required this.camera, required this.gallery}) : super(key: key);

  @override
  State<FilePickDialog> createState() => _FilePickDialogState();
}

class _FilePickDialogState extends State<FilePickDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context){
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Text("Pick from",
            style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.textColor
            ),),
          SizedBox(height: 2.h),
          const Divider(),
          SizedBox(height: 2.h),
          GestureDetector(
            onTap: (){
              widget.camera();
              Navigator.pop(context);
            },
            child: Text("Camera",
              textAlign: TextAlign.center,
              style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.textMildColor
              ),),
          ),
          SizedBox(height: 3.h),
          GestureDetector(
            onTap: (){
              widget.gallery();
              Navigator.pop(context);
            },
            child: Text("Gallery",
              textAlign: TextAlign.center,
              style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.textMildColor
              ),),
          ),
          SizedBox(height: 12.sp),
        ],
      ),
    );
  }

}
