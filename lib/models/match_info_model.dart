class MatchInfoModel {
  bool? status;
  dynamic message;
  MatchInfo? matchInfo;

  MatchInfoModel({status, message, matchInfo});

  MatchInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    matchInfo = json['match_info'] != null
        ? MatchInfo.fromJson(json['match_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (matchInfo != null) {
      data['match_info'] = matchInfo!.toJson();
    }
    return data;
  }
}

class MatchInfo {
  dynamic id;
  dynamic groundId;
  dynamic teamAId;
  dynamic teamBId;
  Ground? ground;
  TeamAData? teamAData;
  TeamBData? teamBData;

  MatchInfo(
      {id,
        groundId,
        teamAId,
        teamBId,
        ground,
        teamAData,
        teamBData});

  MatchInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groundId = json['ground_id'];
    teamAId = json['team_a_id'];
    teamBId = json['team_b_id'];
    ground =
    json['ground'] != null ? Ground.fromJson(json['ground']) : null;
    teamAData = json['team_a_data'] != null
        ? TeamAData.fromJson(json['team_a_data'])
        : null;
    teamBData = json['team_b_data'] != null
        ? TeamBData.fromJson(json['team_b_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ground_id'] = groundId;
    data['team_a_id'] = teamAId;
    data['team_b_id'] = teamBId;
    if (ground != null) {
      data['ground'] = ground!.toJson();
    }
    if (teamAData != null) {
      data['team_a_data'] = teamAData!.toJson();
    }
    if (teamBData != null) {
      data['team_b_data'] = teamBData!.toJson();
    }
    return data;
  }
}

class Ground {
  dynamic id;
  dynamic groundName;
  dynamic mainImage;
  dynamic galleryImage;
  dynamic cityId;
  dynamic stateId;
  City? city;
  State? state;

  Ground(
      {id,
        groundName,
        mainImage,
        galleryImage,
        cityId,
        stateId,
        city,
        state});

  Ground.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groundName = json['ground_name'];
    mainImage = json['main_image'];
    galleryImage = json['gallery_image'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    state = json['state'] != null ? State.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ground_name'] = groundName;
    data['main_image'] = mainImage;
    data['gallery_image'] = galleryImage;
    data['city_id'] = cityId;
    data['state_id'] = stateId;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    return data;
  }
}

class City {
  dynamic id;
  dynamic cityName;

  City({id, cityName});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_name'] = cityName;
    return data;
  }
}

class State {
  dynamic id;
  dynamic name;

  State({id, name});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class TeamAData {
  dynamic id;
  dynamic teamName;
  dynamic logo;

  TeamAData({id, teamName, logo});

  TeamAData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['team_name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_name'] = teamName;
    data['logo'] = logo;
    return data;
  }
}

class TeamBData {
  dynamic id;
  dynamic teamName;
  dynamic logo;

  TeamBData({id, teamName, logo});

  TeamBData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['team_name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_name'] = teamName;
    data['logo'] = logo;
    return data;
  }
}
