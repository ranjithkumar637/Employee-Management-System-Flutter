import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/view/profile/your_slots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../widgets/custom_button.dart';
import '../widgets/snackbar.dart';
import 'about.dart';
import 'ground_information.dart';
import 'location_data.dart';

class Information extends StatefulWidget {
  final ProfileProvider ground;
  const Information(this.ground, {Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      child: Column(
        children: [
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  //your slots
                  const YourSlots(),
                  //ground information
                  GroundInformation(widget.ground),
                  //location
                  LocationData(widget.ground),
                  //about
                  About(widget.ground),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            child: loading
                ? const Center(child: CircularProgressIndicator(),)
                : Bounceable(
                onTap: (){
                  validate();
                },
                child: const CustomButton(AppColor.textColor, "Update Ground Details", AppColor.lightColor)),
          ),
        ],
      ),
    );
  }

  validate(){
    String description = Provider.of<ProfileProvider>(context, listen: false).description;
    String pitch = Provider.of<ProfileProvider>(context, listen: false).pitch;
    String boundaryLine = Provider.of<ProfileProvider>(context, listen: false).boundaryLine;
    int floodLight = Provider.of<ProfileProvider>(context, listen: false).floodLight;
    List<String> gallery = Provider.of<ProfileProvider>(context, listen: false).newGroundImages;
    List<String> mainImg = Provider.of<ProfileProvider>(context, listen: false).mainImage;
    setState(() {
      loading = true;
    });

    ProfileProvider().updateGroundDetails(description, mainImg, gallery, "14/S1", floodLight.toString(), "Near saravana stores, Chrompet", "600044", "12.9516", "80.1462", pitch, boundaryLine)
        .then((value){
          if(value.status == true){
            Dialogs.snackbar(value.message.toString(), context, isError: false);
            setState(() {
              loading = false;
            });
          } else if(value.status == false){
            setState(() {
              loading = false;
            });
            Dialogs.snackbar(value.message.toString(), context, isError: true);
          } else{
            setState(() {
              loading = false;
            });
          }
    });
  }
}
