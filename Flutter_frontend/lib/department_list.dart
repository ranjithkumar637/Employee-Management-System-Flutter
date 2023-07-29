
import 'package:em_ma/fetch_dep.dart';
import 'package:em_ma/main.dart';
import 'package:em_ma/post_dept_factory.dart';


import 'package:em_ma/salary_add_2.dart';

import 'package:flutter/material.dart';
List<String> dropdownOptions = [];
var selectedOption;
class department_list extends StatefulWidget {
  const department_list({Key? key}) : super(key: key);



  @override
  State<department_list> createState() => _department_listState();
}

class _department_listState extends State<department_list> {
  List<Leave>? product=[];

  @override
  void initState() {
    dropdownOptions.clear();

    super.initState();
    fercher();
  }

  void fercher()async {
    product = await value();
    setState(() {
      for(int i=0;i<product!.length;i++){
        dropdownOptions.add(product![i].dept);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          width:90,
          child: Text("Department",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),),
        ),
        Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: ListTile(


              leading:DropdownButton<String>(

                value: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {

                    selectedOption = newValue!;
                    ranjith=selectedOption;
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>MyTable2()));
                  });
                },
                items: dropdownOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

            )
        )
      ],
    );
  }

}
