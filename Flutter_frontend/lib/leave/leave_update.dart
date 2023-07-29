import 'package:em_ma/leave/leave_update_factory.dart';
import 'package:flutter/material.dart';

import 'package:em_ma/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../http_error.dart';


class update_leave{
void leave_update({
  required String staff,
required bool action,
required BuildContext context
})async{
  Leaveupdate l=Leaveupdate( action: action);
  Response res=await http.put(Uri.parse("http://$ip:3000/update/$staff"),body: l.toJson(),
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8'
      }
  );
  if(res.statusCode==200)
    http_errors(context: context, res: res, Validation:(){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Action success")));
    } );



}
}