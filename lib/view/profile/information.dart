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
                  // Consumer<ProfileProvider>(
                  //   builder: (context, profile, child) {
                  //     return LocationData(widget.ground.groundDetails, profile.organizerDetails, false);
                  //   }
                  // ),
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
    String address = Provider.of<ProfileProvider>(context, listen: false).address;
    String houseNo = Provider.of<ProfileProvider>(context, listen: false).houseNo;
    String pinCode = Provider.of<ProfileProvider>(context, listen: false).pinCode;
    String street = Provider.of<ProfileProvider>(context, listen: false).street;
    String latitude = Provider.of<ProfileProvider>(context, listen: false).latitude;
    String longitude = Provider.of<ProfileProvider>(context, listen: false).longitude;
    int floodLight = Provider.of<ProfileProvider>(context, listen: false).floodLight;
    List<String> gallery = Provider.of<ProfileProvider>(context, listen: false).newGroundImages;
    List<String> mainImg = Provider.of<ProfileProvider>(context, listen: false).mainImage;
    int i = 0;
    print(mainImg[i].toString());
    setState(() {
      loading = true;
    });

    ProfileProvider().updateGroundDetails(description, mainImg, gallery, houseNo, floodLight.toString(), address, pinCode, latitude, longitude, pitch, boundaryLine, street)
        .then((value){
          if(value.status == true){
            Dialogs.snackbar(value.message.toString(), context, isError: false);
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
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
