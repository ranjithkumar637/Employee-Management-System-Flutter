
import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class UpdateAboutDialog extends StatefulWidget {
  final String description;
  const UpdateAboutDialog(this.description, {Key? key}) : super(key: key);

  @override
  State<UpdateAboutDialog> createState() => _UpdateAboutDialogState();
}

class _UpdateAboutDialogState extends State<UpdateAboutDialog> {

  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  setData(){
    descriptionController.text = widget.description;
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
            Text("Description",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.textColor
              ),),
            SizedBox(height: 2.h),
            TextFormField(
              autofocus: true,
              controller: descriptionController,
              cursorColor: AppColor.secondaryColor,
              maxLines: 15,
              style: fontRegular.copyWith(
                  fontSize: 10.sp,
                  color: AppColor.textColor
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter description';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Ex: Good ground",
                hintStyle: fontRegular.copyWith(
                    fontSize: 10.sp,
                    color: AppColor.hintColour
                ),),
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
      Provider.of<ProfileProvider>(context, listen: false).saveDescriptionInfo(descriptionController.text);
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    }
  }

}
