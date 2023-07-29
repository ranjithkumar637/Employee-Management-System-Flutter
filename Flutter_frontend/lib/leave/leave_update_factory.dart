
import 'dart:convert';

class Leaveupdate {

  bool action;
  Leaveupdate({
    required this.action,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'action': action,
    };
  }

  factory Leaveupdate.fromMap(Map<String, dynamic> map) {
    return Leaveupdate(
      action: map['action'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Leaveupdate.fromJson(String source) => Leaveupdate.fromMap(json.decode(source) as Map<String, dynamic>);
}
