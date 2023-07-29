import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void http_errors({
  required BuildContext context,
required Response res,
  required VoidCallback Validation
}){
  switch(res.statusCode){
    case 200:
      if(jsonDecode(res.body)['msg'] == "Check Email and Password")
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(res.body)['msg'])));
        else
        Validation();

      break;
    case 400:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(res.body)['msg'])));
      break;
      case 500:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(res.body))));
      break;
  }
}

