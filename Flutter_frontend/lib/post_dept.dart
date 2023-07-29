

import 'package:em_ma/http_error.dart';
import 'package:em_ma/main.dart';
import 'package:em_ma/post_dept_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class add_dept{
  void dept_add( {required String dept,
  required BuildContext context})async{
    Leave Dept=Leave(dept: dept);
    Response res=await http.post(Uri.parse("http://$ip:3000/dep"),body: Dept.toJson(),
    headers: <String,String>{
      'Content-Type':'application/json; charset=UTF-8'
    }
    );
    print(res.statusCode);
    print(dept);
    http_errors(context: context, res: res, Validation:(){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Department Added")));
      Navigator.pushNamed(context,'/complete' );

    } );

  }
}