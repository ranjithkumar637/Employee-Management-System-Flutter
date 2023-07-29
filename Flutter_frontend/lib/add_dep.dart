import 'package:em_ma/post_dept.dart';
import 'package:flutter/material.dart';

class Add_dep extends StatelessWidget {
 Add_dep({Key? key}) : super(key: key);

  final _deptname=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final add_dept dept=add_dept();


    void submit(){
      dept.dept_add(dept: _deptname.text, context: context);
    }
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;

    return Scaffold(

      body: SafeArea(
        child: Container(
          height: h,
          width: w,
          color: Colors.grey.withOpacity(0.3),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(

                  color: Colors.white,
                  height: 300,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Add Department",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                          ),),
                        SizedBox(
                          height: 60,
                        ),
                        Text("Department Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(
                          height: 10,
                        ),


                        TextField(
                          controller: _deptname,
                          decoration: InputDecoration(

                            hintText: "Department",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.black), //<-- SEE HERE
                            ),
                            focusedBorder:  OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.5, color: Colors.black), //<-- SEE HERE
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green
                            ),
                            onPressed: (){
                              submit();
                            }, child: Text("Submit")))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
