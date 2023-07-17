import 'dart:async';
import 'package:elevens_organizer/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../models/ground_details_model.dart';
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
                    Navigator.pushNamed(context, "add_address");
                  },
                  child: SvgPicture.asset(Images.editIcon, color: AppColor.iconColour, width: 4.w,)),
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
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: latLng!,
                        zoom: 17.0,
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
        ],
      ),
    );
  }
}
