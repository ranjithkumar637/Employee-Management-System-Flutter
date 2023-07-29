import 'package:em_ma/department_list.dart';
import 'package:flutter/material.dart';


class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}
class _MyTableState extends State<MyTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Container(

          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add Salary",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),),
                Divider(
                  color: Colors.blue,
                  thickness: 3,
                ),
                SizedBox(
                  height: 20,
                ),
                department_list(),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,


                ),
              ],
            ),
          ),
        ),
      )


      );

  }
}
