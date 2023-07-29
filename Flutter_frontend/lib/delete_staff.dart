

import 'package:em_ma/admin_pg.dart';
import 'package:em_ma/http_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'main.dart';
void dele_staff({required String email,required BuildContext context})async {

      admin();
    Response res=await http.delete(Uri.parse("http://$ip:3000/delete?email=$email"));
    print(res.body);
    http_errors(context: context, res: res, Validation:(){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Delete successful")));
    });
  }
