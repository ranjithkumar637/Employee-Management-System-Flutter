
import 'package:em_ma/http_error.dart';
import 'package:em_ma/main.dart';

import 'package:em_ma/salary_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class salary{
  void salary_add( {required String staff,
    required String basicSalary,
    required String allowance,
    required String total,
    required BuildContext context})async{
  Salary salary=Salary(staff: staff, basicSalary: basicSalary, allowance: allowance, total: total);
    Response res=await http.post(Uri.parse("http://$ip:3000/add-salary"),body: salary.toJson(),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8'
        }
    );
    print(res.statusCode);
    print(salary);
    http_errors(context: context, res: res, Validation:(){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Salary added")));
      Navigator.pushNamed(context, '/staff_success');


    } );

  }
}