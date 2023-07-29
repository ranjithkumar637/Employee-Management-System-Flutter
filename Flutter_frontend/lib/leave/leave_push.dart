
import 'package:em_ma/http_error.dart';
import 'package:em_ma/leave/leave_factory.dart';
import 'package:em_ma/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class leave_action{
  void action( {
    required String staff,
    required String photo,
    required String department,
    required String reason,
    required String from,
    required String to,
    required String description,
    required String appliedOn,
    required bool action,
    required BuildContext context

   })async{
    Staff leaver=Staff(staff: staff, photo: photo, department: department, reason: reason, from: from, to: to, description: description, appliedOn: appliedOn, action: action);
    Response res=await http.post(Uri.parse("http://$ip:3000/leave"),body: leaver.toJson(),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8'
        }
    );
    print(res.statusCode);
    print(action);
    http_errors(context: context, res: res, Validation:(){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Action success")));



    } );

  }
}