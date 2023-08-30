import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/offing_list_model.dart';
import '../../models/total_revenue-model.dart';
import '../../providers/profile_provider.dart';
import '../../providers/team_provider.dart';
import '../../utils/app_constants.dart';
import '../../utils/colours.dart';
import '../../utils/connectivity_status.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/loader.dart';
import '../widgets/no_internet_view.dart';
import 'offing_match_info.dart';
import 'offing_opponent_team.dart';
import 'offing_your_team.dart';

class OffingDetailScreen extends StatefulWidget {
  final String matchId;
  final OffingsList offing;
  const OffingDetailScreen(this.matchId, this.offing, {Key? key}) : super(key: key);

  @override
  State<OffingDetailScreen> createState() => _OffingDetailScreenState();
}

class _OffingDetailScreenState extends State<OffingDetailScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;
  bool loading = false;

  getMatchDetails(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getMatchDetails(widget.matchId);
     });
  }

  setDelay() async {
    setState(() {
      loading = true;
    });
    getMatchDetails();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    setDelay();
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return const NoInternetView();
    }
    return Scaffold(
      body: loading
        ? const Loader()
      : Consumer<ProfileProvider>(
        builder: (context, match, child) {
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 28.h,
                    child: Image.asset(Images.pitchImage, fit: BoxFit.cover,),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    right: 5.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Bounceable(
                            onTap:(){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back, color: AppColor.lightColor, size: 7.w,)),
                        SizedBox(width: 7.w,),
                        SizedBox(width: 7.w,),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 5.w,
                    right: 5.w,
                    top: 12.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 11.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColor.imageBorderColor, width: 3.0)
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${widget.offing.teamALogo}",
                                height: 11.h,
                                width: 24.w,
                                fit: BoxFit.cover,
                                errorWidget:(context, url, error) =>
                                    ClipOval(
                                        child: Image.asset(Images.createTeamBg, fit: BoxFit.cover,)),
                              ),
                            )),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(widget.offing.teamAName,
                                overflow: TextOverflow.ellipsis,
                                style: fontMedium.copyWith(
                                    fontSize: 13.sp,
                                    color: AppColor.lightColor
                                ),),
                              SizedBox(height: 0.5.h),
                              Text('vs',
                                style: fontMedium.copyWith(
                                    fontSize: 13.sp,
                                    color: AppColor.lightColor
                                ),),
                              SizedBox(height: 0.5.h),
                              Text(widget.offing.teamBName == "" ? "TBA" : widget.offing.teamBName,
                                overflow: TextOverflow.ellipsis,
                                style: fontMedium.copyWith(
                                    fontSize: 13.sp,
                                    color: AppColor.lightColor
                                ),),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Container(
                            height: 11.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColor.imageBorderColor, width: 3.0)
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: "${AppConstants.imageBaseUrl}${AppConstants.imageBaseUrlTeam}${widget.offing.teamBLogo}",
                                height: 11.h,
                                width: 24.w,
                                fit: BoxFit.cover,
                                errorWidget:(context, url, error) =>
                                    ClipOval(
                                        child: Image.asset(Images.createTeamBg, fit: BoxFit.cover,)),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              TabBar(
                  indicatorColor: AppColor.secondaryColor,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: fontMedium.copyWith(
                      fontSize: 12.sp
                  ),
                  unselectedLabelColor: AppColor.unselectedTabColor,
                  labelColor: AppColor.secondaryColor,
                  controller: tabController,
                  tabs: [
                    Tab(
                      text: '${widget.offing.teamAName}',
                    ),
                    Tab(
                      text: "${widget.offing.teamBName== "" ? "TBA" : widget.offing.teamBName}",
                    ),
                    const Tab(
                      text: "Match Info",
                    ),
                  ]),
              Theme(
                  data: ThemeData(
                    dividerTheme: const DividerThemeData(
                      space: 0,
                      thickness: 0.5,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  child: const Divider()),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [
                      OffingYourTeam(widget.offing.matchId.toString(), match.matchDetails.teamAId.toString()),
                      OffingOpponentTeam(widget.offing.matchId.toString(), match.matchDetails.teamBId.toString(), widget.offing.teamBName== "" ? "TBA" : widget.offing.teamBName),
                      const OffingMatchInfo(),
                    ]),
              ),
            ],
          );
        }
      ),
    );
  }
}
