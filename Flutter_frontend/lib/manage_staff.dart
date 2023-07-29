

import 'package:em_ma/delete_staff.dart';
import 'package:em_ma/fetch_staff.dart';
import 'package:em_ma/leave/leave_update.dart';
import 'package:flutter/material.dart';

import 'factory_staff.dart';

class managestaff extends StatefulWidget {
  @override
  State<managestaff> createState() => _managestaffState();
}


class _managestaffState extends State<managestaff> {
  List<Staff>? leavedetail=[];
  int k=0;

  update_leave l=update_leave();
  @override
  void initState() {
    leavedetail?.clear();
    fercher();
    super.initState();

  }

  void fercher()async {
    leavedetail = await staff_fetch();
    setState(() {
      k=leavedetail!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Details'),
      ),
      body: ListView.builder(
        itemCount: k,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Staff')),

                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Department')),
                  DataColumn(label: Text('City')),
                  DataColumn(label: Text('Country')),
                  DataColumn(label: Text('DateOfJoining')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('State')),
                  DataColumn(label: Text('Action')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(leavedetail![index].name)),

                    DataCell(Text(leavedetail![index].gender)),
                    DataCell(Text(leavedetail![index].department)),
                    DataCell(Text(leavedetail![index].city)),
                    DataCell(Text(leavedetail![index].country)),
                    DataCell(Text(leavedetail![index].dateOfJoining)),
                    DataCell(Text(leavedetail![index].email)),
                    DataCell(Text(leavedetail![index].state)),
                    DataCell(
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                        )
                          ,onPressed: (){
                          dele_staff(email: leavedetail![index].email, context: context);
                          setState(() {

                            fercher();

                          });

                      }, child: Text("Delete"))
                    ),

                  ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}