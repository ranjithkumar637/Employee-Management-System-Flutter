
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevens_organizer/view/my_matches/profile_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/colours.dart';
import '../../../utils/styles.dart';
import '../../models/player_info_model.dart';
import '../../providers/profile_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/images.dart';
import '../widgets/loader.dart';
import 'matches_profile.dart';

class PlayerProfile extends StatefulWidget {
  final String playerId;
  const PlayerProfile(this.playerId, {Key? key}) : super(key: key);

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> with SingleTickerProviderStateMixin{

  late TabController tabController;
  bool loading = false;
  PlayerInfo playerInfo = PlayerInfo();

  setDelay() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    getPlayerInfo();
  }

  getPlayerInfo(){
    ProfileProvider().getPlayerInfo(widget.playerId)
    .then((value){
      if(value.status == true){
        setState(() {
          loading = false;
          playerInfo = value.playerInfo;
        });
      } else if(value.status == false){
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    });}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    bool isIOS = platform == TargetPlatform.iOS;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: loading
      ? const Loader()
      : Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(Images.profileBg, fit: BoxFit.cover, width: double.infinity, height: 30.h,),
              Positioned(
                child: Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff333334),
                        const Color(0xff333334).withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: isIOS ? statusBarHeight : 2.h + statusBarHeight,
                left: 3.w,
                child: Bounceable(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_outlined, color: AppColor.lightColor, size: 5.w,),
                      SizedBox(width: 3.w),
                      Text("Back",
                        style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.lightColor
                        ),),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 7.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: '${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlProfile}${playerInfo.profilePhoto.toString()}',
                        fit: BoxFit.cover,
                        height: 14.h,
                        width: 28.w,
                        errorWidget: (context, url, error) => Image.network("https://cdn-icons-png.flaticon.com/256/4389/4389644.png"),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(playerInfo.name.toString(),
                      style: fontMedium.copyWith(
                          fontSize: 16.sp,
                          color: AppColor.lightColor
                      ),),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          TabBar(
              isScrollable: true,
              indicatorColor: AppColor.secondaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: fontMedium.copyWith(
                  fontSize: 12.sp
              ),
              unselectedLabelColor: AppColor.unselectedTabColor,
              labelColor: AppColor.secondaryColor,
              controller: tabController,
              tabs: const [
                Tab(
                  text: "Information",
                ),
                Tab(
                  text: "Matches",
                ),
              ]),
          Theme(
              data: ThemeData(
                dividerTheme: const DividerThemeData(
                  space: 0, // Set space to 0 to remove top and bottom padding
                  thickness: 0.5, // Set thickness to desired value
                  indent: 0, // Set indent to desired value
                  endIndent: 0, // Set endIndent to desired value
                ),
              ),
              child: const Divider()),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: [
                  ProfileInformation(playerInfo),
                  ProfileMatches(widget.playerId),
                ]),
          ),
        ],
      ),
    );
  }
}
