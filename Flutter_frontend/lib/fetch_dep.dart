import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:em_ma/post_dept_factory.dart';

import 'main.dart';
import 'package:http/http.dart' as http;

Future<List<Leave>> value() async {
  List<Leave>arr=[];
  print('helo');
  http.Response response=await http.get(Uri.parse('http://$ip:3000/depget'));
  print(response.statusCode);
  if(response.statusCode==200){
    for(int i=0;i<jsonDecode(response.body).length;i++){
      arr.add(Leave.fromJson(jsonEncode(jsonDecode(response.body)[i])));
      print(arr);
    }}
  green=arr.length;
  return arr;
}

  

