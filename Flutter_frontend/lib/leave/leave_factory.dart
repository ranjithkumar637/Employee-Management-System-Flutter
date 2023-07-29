import 'dart:convert';
class Staff {
  String staff;
  String  photo;
  String department;
  String  reason;
  String  from;
  String to;
  String description;
  String appliedOn;
  bool action;
  Staff({
    required this.staff,
    required this.photo,
    required this.department,
    required this.reason,
    required this.from,
    required this.to,
    required this.description,
    required this.appliedOn,
    required this.action,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'staff': staff,
      'photo': photo,
      'department': department,
      'reason': reason,
      'from': from,
      'to': to,
      'description': description,
      'appliedOn': appliedOn,
      'action': action,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      staff: map['staff'] as String,
      photo: map['photo'] as String,
      department: map['department'] as String,
      reason: map['reason'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      description: map['description'] as String,
      appliedOn: map['appliedOn'] as String,
      action: map['action'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source) as Map<String, dynamic>);
}
