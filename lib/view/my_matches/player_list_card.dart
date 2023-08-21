import 'package:elevens_organizer/models/match_team_player_list_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/player_image.dart';
import '../widgets/player_name.dart';
import '../widgets/player_style.dart';
import '../widgets/role_circle.dart';

class PlayerListCard extends StatelessWidget {
  final String playerName, style, playerImage, id, teamId, role;
  final bool showChangeRoleOption;
  final MatchTeamPlayerList player;
  const PlayerListCard(this.playerName, this.style, this.playerImage, this.showChangeRoleOption, this.id, this.teamId, this.role, this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PlayerImage(playerImage, 7.h, 14.w),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PlayerName(playerName),
                  SizedBox(width: 2.w),
                  if(style == "Captain")...[
                    const RoleCircle("C"),
                  ] else if(style == "Vice Captain")...[
                    const RoleCircle("VC"),
                  ] else if(style == "Admin")...[
                    const RoleCircle("Admin"),
                  ],
                ],
              ),
              SizedBox(height: 1.h),
              if(player.wicketKeeper == 1)...[
                PlayerStyle(player.battingStyle),
              ] else if(player.battingRole == 1)...[
                PlayerStyle(player.battingStyle),
              ] else if(player.bowlingRole == 1)...[
                PlayerStyle(player.bowlingStyle),
              ] else if(player.allRounder == 1)...[
                PlayerStyle(player.allRounderType),
              ] else ...[
                const PlayerStyle("Player"),
              ],
            ],
          ),
        ),
        SizedBox(width: 3.w),
      ],
    );
  }
}
