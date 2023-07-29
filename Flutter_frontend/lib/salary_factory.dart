
import 'dart:convert';

class Salary {
  String staff;
  String basicSalary;
  String allowance;
  String total;
  Salary({
    required this.staff,
    required this.basicSalary,
    required this.allowance,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'staff': staff,
      'basicSalary': basicSalary,
      'allowance': allowance,
      'total': total,
    };
  }

  factory Salary.fromMap(Map<String, dynamic> map) {
    return Salary(
      staff: map['staff'] as String,
      basicSalary: map['basicSalary'] as String,
      allowance: map['allowance'] as String,
      total: map['total'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Salary.fromJson(String source) => Salary.fromMap(json.decode(source) as Map<String, dynamic>);
}
