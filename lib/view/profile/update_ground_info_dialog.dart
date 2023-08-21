
import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';


class UpdateGroundInfoDialog extends StatefulWidget {
  final String pitch, boundaryLine;
  final int? floodLight;
  const UpdateGroundInfoDialog(this.pitch, this.boundaryLine, this.floodLight, {Key? key}) : super(key: key);

  @override
  State<UpdateGroundInfoDialog> createState() => _UpdateGroundInfoDialogState();
}

class _UpdateGroundInfoDialogState extends State<UpdateGroundInfoDialog> {

  final TextEditingController pitchController = TextEditingController();
  final TextEditingController boundaryLineController = TextEditingController();
  bool floodLight = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  List<String> pitchTypes = ["Green", "Dry", "Hard"];
  String? dropDownValue;

  setData(){
    // pitchController.text = widget.pitch;
    boundaryLineController.text = widget.boundaryLine;
    floodLight = widget.floodLight == 1 ? true : false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

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
      height: 55.h,
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Ground Information",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.textColor
              ),),
            SizedBox(height: 3.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pitch",
                  style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(height:1.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffFBFAF7),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: DropdownButton<String>(
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: Text("Select Pitch type",
                      style: fontRegular.copyWith(
                          color: AppColor.textMildColor,
                          fontSize: 10.sp
                      ),),
                    value: dropDownValue,
                    items: pitchTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                            value,
                            style: fontMedium.copyWith(fontSize: 10.sp,color: AppColor.textColor)
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Boundary Line (meters)",
                  style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(height:1.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffFBFAF7),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: boundaryLineController,
                      cursorColor: AppColor.secondaryColor,
                      style: fontRegular.copyWith(
                          fontSize: 10.sp,
                          color: AppColor.textColor
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Boundary line';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Ex: 90",
                        hintStyle: fontRegular.copyWith(
                            fontSize: 10.sp,
                            color: AppColor.hintColour
                        ),),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Flood Light",
                  style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                  ),),
                SizedBox(width: 3.w),
                Switch(
                  activeColor: AppColor.primaryColor,
                  activeTrackColor: AppColor.textColor,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade300,
                  splashRadius: 50.0,
                  value: floodLight,
                  onChanged: (value) => setState(() => floodLight = value),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(height: 3.h),
            loading
            ? const CircularProgressIndicator()
            : Bounceable(
              onTap: (){
                validate();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 7.w,
                  vertical: 1.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.textColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text("Save",
                    style: fontRegular.copyWith(
                        color: AppColor.lightColor,
                        fontSize: 11.sp
                    ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validate(){
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      if(dropDownValue == null){
        setState(() {
          loading = false;
        });
      } else {
        Provider.of<ProfileProvider>(context, listen: false).saveGroundInfo(dropDownValue.toString(), boundaryLineController.text, floodLight == true ? 1 : 0);
        setState(() {
          loading = false;
        });
      }
      Navigator.pop(context);
    }
  }

}
