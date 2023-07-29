import 'dart:convert';
import 'dart:core';
import 'package:em_ma/admin_pg.dart';
import 'package:em_ma/http_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';
import 'package:http/http.dart' as http;

void loginer(String dept,BuildContext context) async {
  print(dept);
  http.Response response = await http.get(
      Uri.parse('http://$ip:3000/login?username=$dept'));
  print(jsonDecode(response.body)['msg']);
  http_errors(context: context, res: response, Validation: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => admin()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login success")));
  });
}


