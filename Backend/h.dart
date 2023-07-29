// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sign {
  String username;
  String password;
  Sign({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory Sign.fromMap(Map<String, dynamic> map) {
    return Sign(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sign.fromJson(String source) => Sign.fromMap(json.decode(source) as Map<String, dynamic>);
}
