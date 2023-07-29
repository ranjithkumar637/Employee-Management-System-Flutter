import 'dart:convert';

import 'package:em_ma/factory_staff.dart';
import 'package:em_ma/http_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'main.dart';
class post{
void post_staff(
{
  required String name,
required  String dep,
required  String gen,
required  String email,
required  String mobile,
required  String photo,
required String  dob,
required String  doj,
required  String city,
required  String state,
required  String country,
required String  address,
  required BuildContext context
})async {
  Staff staff = Staff(name: name, department: dep, gender: gen, email: email, mobile: mobile, photo: photo, dateOfBirth: dob, dateOfJoining: doj, city: city, state: state, country: country, address: address);

  Response res=await http.post(Uri.parse("http://$ip:3000/staff"),body: staff.toJson(),
  headers: <String,String>{
  'Content-Type':'application/json; charset=UTF-8'}
  );
  print(res.body);
  http_errors(context: context, res: res, Validation:(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully uploaded")));
    Navigator.pushNamed(context, '/staff_success');
  });
}
}