import 'dart:convert';
import 'dart:async';
import 'dart:core';

import 'factory_staff.dart';

import 'main.dart';
import 'package:http/http.dart' as http;

Future<List<Staff>> printer(String dept) async {

  List<Staff>arr=[];
  print('do');
  http.Response response=await http.get(Uri.parse('http://$ip:3000/depsp?department=$dept'));

  if(response.statusCode==200){
    for(int i=0;i<jsonDecode(response.body).length;i++){
      arr.add(Staff.fromJson(jsonEncode(jsonDecode(response.body)[i])));
    }}
  return arr;





}
