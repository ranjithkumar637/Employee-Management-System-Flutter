import 'dart:convert';
import 'package:em_ma/factory_staff.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

Future<List<Staff>> staff_fetch() async {
  List<Staff>arr=[];
  print('helo');
  http.Response response=await http.get(Uri.parse('http://$ip:3000/staff'));
  print(response.statusCode);
  if(response.statusCode==200){
    for(int i=0;i<jsonDecode(response.body).length;i++){
      arr.add(Staff.fromJson(jsonEncode(jsonDecode(response.body)[i])));
      print(arr);
    }}
  rose=arr.length;
  return arr;
}