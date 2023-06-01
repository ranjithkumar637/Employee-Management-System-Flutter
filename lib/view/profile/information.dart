import 'package:elevens_organizer/view/profile/your_slots.dart';
import 'package:flutter/material.dart';

import '../../utils/colours.dart';
import 'about.dart';
import 'ground_information.dart';
import 'location_data.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            //your slots
            YourSlots(),
            //ground information
            GroundInformation(),
            //location
            LocationData(),
            //about
            About(),
          ],
        ),
      ),
    );
  }
}
