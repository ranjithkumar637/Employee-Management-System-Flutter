
import 'package:em_ma/add_dep.dart';
import 'package:em_ma/add_staff.dart';
import 'package:em_ma/admin_pg.dart';
import 'package:em_ma/complete_dep.dart';
import 'package:em_ma/leave/leave_history.dart';
import 'package:em_ma/leave/leave_page.dart';
import 'package:em_ma/login_page.dart';
import 'package:em_ma/manage_staff.dart';
import 'package:em_ma/salary_add.dart';

import 'package:em_ma/salary_success.dart';

import 'package:em_ma/staff_add_success.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case '/complete':
      return  MaterialPageRoute(
        builder: (_)=> Add_dep_com(),
      );
    case '/home':
      return MaterialPageRoute(builder: (_)=>admin());
    case '/login':
      return MaterialPageRoute(builder: (_)=>login());

    case '/staff':
      return MaterialPageRoute(builder: (_)=>emp_add());

    case '/staff_success':
      return MaterialPageRoute(builder: (_)=>staff_success());
    case '/add_dep':
      return MaterialPageRoute(builder: (_)=>Add_dep());
    case '/leave_req':
      return MaterialPageRoute(builder: (_)=>leave());
    case '/staff_managment':
      return MaterialPageRoute(builder: (_)=>managestaff());
    case '/leave_staff':
      return MaterialPageRoute(builder: (_)=>leave());

    case '/salary_paid':
      return MaterialPageRoute(builder: (_)=>MyTable());

    case '/salary_success':
      return MaterialPageRoute(builder: (_)=>staff_success1());
    case '/leave_hi':
      return MaterialPageRoute(builder: (_)=>leave_history ());



    default:
      return MaterialPageRoute(
          builder: (_)=>Scaffold(
            body:Text("Error happen"),
          )
      );


  }

}
