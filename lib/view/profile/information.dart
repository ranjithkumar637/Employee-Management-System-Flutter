import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/providers/team_provider.dart';
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
                  // const YourSlots(),
                  //ground information
                  GroundInformation(widget.ground),
                  //location
                  Consumer<ProfileProvider>(
                    builder: (context, profile, child) {
                      return LocationData(widget.ground.groundDetails, profile.organizerDetails, false);
                    }
                  ),
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
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    List<String> gallery = [];
    List<String> mainImg = [];
    String stateId = "", cityId = "";
    String address = "", houseNo = "", pinCode = "", street = "", latitude = "", longitude = "";
    String description = Provider.of<ProfileProvider>(context, listen: false).description;
    String pitch = Provider.of<ProfileProvider>(context, listen: false).pitch;
    String boundaryLine = Provider.of<ProfileProvider>(context, listen: false).boundaryLine;
    if(profile.groundAddress != ""){
      address = Provider.of<ProfileProvider>(context, listen: false).groundAddress;
      houseNo = Provider.of<ProfileProvider>(context, listen: false).groundHouseNo;
      pinCode = Provider.of<ProfileProvider>(context, listen: false).groundPinCode;
      street = Provider.of<ProfileProvider>(context, listen: false).groundStreet;
      latitude = Provider.of<ProfileProvider>(context, listen: false).groundLatitude;
      longitude = Provider.of<ProfileProvider>(context, listen: false).groundLongitude;
    } else {
      address = Provider.of<ProfileProvider>(context, listen: false).address;
      houseNo = Provider.of<ProfileProvider>(context, listen: false).houseNo;
      pinCode = Provider.of<ProfileProvider>(context, listen: false).pinCode;
      street = Provider.of<ProfileProvider>(context, listen: false).street;
      latitude = Provider.of<ProfileProvider>(context, listen: false).latitude;
      longitude = Provider.of<ProfileProvider>(context, listen: false).longitude;
    }
    if(profile.stateId == "" && profile.cityId == ""){
      stateId = Provider.of<TeamProvider>(context, listen: false).stateId;
      cityId = Provider.of<TeamProvider>(context, listen: false).stateBasedCityId;
    } else {
      stateId = profile.stateId;
      cityId = profile.cityId;
    }
    print("house no $houseNo street name $street");
    int floodLight = Provider.of<ProfileProvider>(context, listen: false).floodLight;
    // if(profile.newGroundImages.isEmpty){
    //   gallery = Provider.of<ProfileProvider>(context, listen: false).groundImages;
    // } else {
      gallery = Provider.of<ProfileProvider>(context, listen: false).newGroundImages;
    // }
    // if(profile.mainImage.isEmpty){
    //   mainImg.add(Provider.of<ProfileProvider>(context, listen: false).mainImg);
    // } else {
      mainImg = Provider.of<ProfileProvider>(context, listen: false).mainImage;
    // }
    print(gallery);
    if(profile.mainImg == "" && mainImg.isEmpty){
      Dialogs.snackbar("Upload main ground image", context, isError: true);
    }
    else if(gallery.isEmpty && profile.groundImages.isEmpty){
      Dialogs.snackbar("Upload gallery images", context, isError: true);
    } else if(pitch == ""){
      Dialogs.snackbar("Set pitch data", context, isError: true);
    } else if(boundaryLine == ""){
      Dialogs.snackbar("Set boundary line", context, isError: true);
    } else if(pinCode == ""){
      Dialogs.snackbar("Provide ground address details", context, isError: true);
    } else if(stateId == "" || cityId == ""){
      Dialogs.snackbar("Select ground state & city", context, isError: true);
    } else{
      setState(() {
        loading = true;
      });
      ProfileProvider().updateGroundDetails(description, mainImg, gallery, houseNo, floodLight.toString(),
          address, pinCode, latitude, longitude, pitch, boundaryLine, street, stateId, cityId)
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
}
