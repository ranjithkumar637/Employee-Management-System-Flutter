class SlotsListModel {
  bool? status;
  String? message;
  List<SlotTimeList>? slotTimeList;

  SlotsListModel({status, message, slotTimeList});

  SlotsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['slot_list'] != null) {
      slotTimeList = <SlotTimeList>[];
      json['slot_list'].forEach((v) {
        slotTimeList!.add(SlotTimeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (slotTimeList != null) {
      data['slot_list'] =
          slotTimeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SlotTimeList {
  int? booked;
  int? left;
  int? matchId;
  int? teamAId;
  int? block;
  String? blockReason;
  String? start;
  String? end;

  SlotTimeList(
      {booked,
        left,
        matchId,
        teamAId,
        block,
        blockReason,
        start,
        end});

  SlotTimeList.fromJson(Map<String, dynamic> json) {
    booked = json['booked'];
    left = json['left'];
    matchId = json['match_id'];
    teamAId = json['team_a_id'];
    block = json['block'];
    blockReason = json['block_reason'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booked'] = booked;
    data['left'] = left;
    data['match_id'] = matchId;
    data['team_a_id'] = teamAId;
    data['block'] = block;
    data['block_reason'] = blockReason;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
