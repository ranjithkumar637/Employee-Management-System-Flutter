import 'dart:convert';

class Leave {
  final String dept;

  Leave({
    required this.dept,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dept': dept,
    };
  }

  factory Leave.fromMap(Map<String, dynamic> map) {
    return Leave(
      dept: map['dept'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Leave.fromJson(String source) => Leave.fromMap(json.decode(source) as Map<String, dynamic>);
}
