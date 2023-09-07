import 'dart:async';
import 'package:elevens_organizer/models/profile_model.dart';
import 'package:elevens_organizer/providers/profile_provider.dart';
import 'package:elevens_organizer/view/address/add_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/ground_details_model.dart';
import '../../providers/team_provider.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class LocationData extends StatefulWidget {
  final GroundDetails ground;
  final OrganizerDetails organizerDetails;
  final bool profile;
  const LocationData(this.ground, this.organizerDetails, this.profile, {Key? key}) : super(key: key);

  @override
  State<LocationData> createState() => _LocationDataState();
}

class _LocationDataState extends State<LocationData> {

  final Completer<GoogleMapController> _controller = Completer();
  LatLng? latLng;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.profile){
      latLng = LatLng(
          widget.organizerDetails.latitude == null || widget.organizerDetails.latitude.toString() == "" ? 13.0827 : double.parse(widget.organizerDetails.latitude.toString()),
          widget.organizerDetails.longitude == null || widget.organizerDetails.longitude.toString() == "" ? 80.2707 : double.parse(widget.organizerDetails.longitude.toString()));
    } else{
      latLng = LatLng(
          widget.ground.latitude == null || widget.ground.latitude.toString() == "" ? 13.0827 : double.parse(widget.ground.latitude.toString()),
          widget.ground.longitude == null || widget.ground.longitude.toString() == "" ? 80.2707 : double.parse(widget.ground.longitude.toString()));
    }
    return Consumer<ProfileProvider>(
      builder: (context, profile, child) {
        print(profile.groundAddress);
        print(widget.ground.address.toString());
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 1.5.h,
          ),
          decoration: BoxDecoration(
            color: AppColor.lightColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Location",
                    style: fontMedium.copyWith(
                        color: AppColor.textColor,
                        fontSize: 12.sp
                    ),),
                  InkWell(
                      onTap: (){
                        Provider.of<TeamProvider>(context, listen: false).clearData();
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const AddAddress();
                        }),
                      );
                    },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                          vertical: 0.5.h
                        ),
                        child: SvgPicture.asset(Images.editIcon, color: AppColor.iconColour, width: 4.w,),
                      )),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                  width: double.maxFinite,
                  height: 14.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                      child: GoogleMap(
                          myLocationButtonEnabled: false,
                          myLocationEnabled: false,
                          zoomControlsEnabled: true,
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: latLng!,
                            zoom: 13.0,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Icon(
                          Icons.my_location, color: AppColor.redColor, size: 5.w,),
                      ),
                    ],
                  ),
              ),
              SizedBox(height: 1.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(profile.groundAddress != "" && widget.ground.address.toString() != "null")...[
                    Text("Currently set address",
                      style: fontMedium.copyWith(
                          color: AppColor.secondaryColor,
                          fontSize: 10.sp
                      ),),
                    Text(profile.groundAddress,
                      style: fontMedium.copyWith(
                          color: AppColor.textColor,
                          fontSize: 10.sp
                      ),),
                    SizedBox(height: 1.h),
                    Text("Your address",
                      style: fontMedium.copyWith(
                          color: AppColor.secondaryColor,
                          fontSize: 10.sp
                      ),),
                    Text(widget.ground.address.toString(),
                      style: fontMedium.copyWith(
                          color: AppColor.textColor,
                          fontSize: 10.sp
                      ),),
                  ] else if(profile.groundAddress != "" && widget.ground.address.toString() == "null")...[
                    Text(profile.groundAddress,
                      style: fontMedium.copyWith(
                          color: AppColor.textColor,
                          fontSize: 10.sp
                      ),)
                  ] else if(profile.groundAddress == "" && widget.ground.address.toString() != "null")...[
                    Text("Your address",
                      style: fontMedium.copyWith(
                          color: AppColor.secondaryColor,
                          fontSize: 10.sp
                      ),),
                    Text(widget.ground.address.toString() == "null" ? "" : widget.ground.address.toString(),
                      style: fontMedium.copyWith(
                          color: AppColor.textColor,
                          fontSize: 10.sp
                      ),)
                  ] else if(profile.groundAddress == "" && widget.ground.address.toString() == "null")...[
                    const SizedBox()
                  ] ,
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
