


import 'package:em_ma/fetch_staff_name.dart';
import 'package:em_ma/main.dart';
import 'package:em_ma/salary_post.dart';

import 'package:flutter/material.dart';

import 'factory_staff.dart';

List<String> staffname = [];
class MyTable2 extends StatefulWidget {



  @override
  _MyTable2State createState() => _MyTable2State();
}

class _MyTable2State extends State<MyTable2> {
  List<Staff>? product=[];
  List<List<TextEditingController>> controllers = [];

  @override
  void initState() {
    staffname.clear();
    fercher();
    super.initState();

    // Create controllers for each cell in the DataTable
    for (var i = 0; i < 3; i++) {
      controllers.add(
        List.generate(5, (index) => TextEditingController()),
      );

    }
  }
  void fercher()async {
    product = await printer(ranjith);
    print(product!.length);
    setState(() {
      for(int i=0;i<product!.length;i++){
        staffname.add(product![i].name);
        print(product![i].name);
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed to free up resources
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }


  salary h=salary();
  void datapush(){
    for(int i=0;i<staffname.length;i++){
      blue+=int.parse(controllers[i][2].text);
      h.salary_add(staff:  staffname[i], basicSalary: controllers[i][0].text, allowance: controllers[i][1].text, total:controllers[i][2].text, context: context);
  }}

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

                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('S.no')),
                      DataColumn(label: Text("Staff")),
                      DataColumn(label: Text('Basic salary')),
                      DataColumn(label: Text('Allowance')),
                      DataColumn(label: Text('Total')),
                    ],
                    rows: List.generate(staffname.length, (rowIndex) {
                      int serialNumber = rowIndex + 1;
                      return DataRow(
                        cells: [
                          DataCell(Text('$serialNumber')),
                          DataCell(Text(staffname[rowIndex])),


                          ...List.generate(3, (colIndex) {
                            return DataCell(
                              Center(
                                child: Container(
                                  width: 150,
                                  height: 40,
                                  child: TextFormField(
                                    controller: controllers[rowIndex][colIndex],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),),
                                  ),
                                ),
                              ),
                            );
                          }),],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          datapush();
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
