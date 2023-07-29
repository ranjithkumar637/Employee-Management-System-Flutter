import 'dart:convert';
import 'dart:async';
import 'dart:core';


import 'package:em_ma/leave/leave_factory.dart';

import '../main.dart';

import 'package:http/http.dart' as http;

Future<List<Staff>> leavefetch() async {
  List<Staff>arr=[];
  print('leave');
  http.Response response=await http.get(Uri.parse('http://$ip:3000/leaveget'));
  print(response.statusCode);
  if(response.statusCode==200){
    for(int i=0;i<jsonDecode(response.body).length;i++){
      arr.add(Staff.fromJson(jsonEncode(jsonDecode(response.body)[i])));
      print(arr);
    }}
  orange=arr.length;
  return arr;

}



