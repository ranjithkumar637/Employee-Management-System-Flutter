import 'package:em_ma/leave/leave_factory.dart';
import 'package:em_ma/leave/leave_get.dart';
import 'package:em_ma/leave/leave_update.dart';
import 'package:flutter/material.dart';

class leave_history extends StatefulWidget {
  @override
  State<leave_history> createState() => _leave_historyState();
}
List<Staff>? leavedetail=[];
int k=0;
class _leave_historyState extends State<leave_history> {


  update_leave l=update_leave();
  @override
  void initState() {
    super.initState();
    fercher();
  }

  void fercher()async {
    leavedetail = await leavefetch();
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

                  DataColumn(label: Text('Department')),
                  DataColumn(label: Text('Reason')),
                  DataColumn(label: Text('From')),
                  DataColumn(label: Text('To')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Applied On')),
                  DataColumn(label: Text('Action')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(leavedetail![index].staff)),

                    DataCell(Text(leavedetail![index].department)),
                    DataCell(Text(leavedetail![index].reason)),
                    DataCell(Text(leavedetail![index].from)),
                    DataCell(Text(leavedetail![index].to)),
                    DataCell(Text(leavedetail![index].description)),
                    DataCell(Text(leavedetail![index].appliedOn)),
                    DataCell(
                        Container(


                          child: Row(

                            children: [
                              leavedetail![index].action==true?
                              ElevatedButton(onPressed: (){
                              }, child:Text("Accept"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:Colors.green,
                                  ))
                                  :ElevatedButton(onPressed: (){
                              }, child:Text("Rejected"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:Colors.red)),
                            ],
                          ),
                        )
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