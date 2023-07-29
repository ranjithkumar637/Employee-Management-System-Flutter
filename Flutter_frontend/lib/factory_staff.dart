
import 'dart:convert';

class Staff {
  String name;
  String department;
  String gender;
  String email;
  String mobile;
  String photo;
  String dateOfBirth;
  String dateOfJoining;
  String city;
  String state;
  String country;
  String address;
  Staff({
    required this.name,
    required this.department,
    required this.gender,
    required this.email,
    required this.mobile,
    required this.photo,
    required this.dateOfBirth,
    required this.dateOfJoining,
    required this.city,
    required this.state,
    required this.country,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'department': department,
      'gender': gender,
      'email': email,
      'mobile': mobile,
      'photo': photo,
      'dateOfBirth': dateOfBirth,
      'dateOfJoining': dateOfJoining,
      'city': city,
      'state': state,
      'country': country,
      'address': address,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'] as String,
      department: map['department'] as String,
      gender: map['gender'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      photo: map['photo'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      dateOfJoining: map['dateOfJoining'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source) as Map<String, dynamic>);
}
