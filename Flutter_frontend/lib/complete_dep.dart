import 'package:em_ma/post_dept.dart';
import 'package:flutter/material.dart';

class Add_dep_com extends StatelessWidget {
   Add_dep_com({Key? key}) : super(key: key);
  final add_dept dept=add_dept();
  final _deptname=TextEditingController();
  @override
  Widget build(BuildContext context) {


    void submit(){
      dept.dept_add(dept: _deptname.text, context: context);
    }
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

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
                    height: 450,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: h*0.15,
                            width: double.infinity,
                            color: Colors.green,
                            child: Center(
                              
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle,
                                  color: Colors.white,size: 30,),
                                  Text(
                                    "Success!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Text("Add another Department",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green
                                  ),
                                  onPressed: (){
                                    submit();
                                  }, child: Text("Submit"))),
                              Center(child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red
                                  ),
                                  onPressed: (){
                                    Navigator.pushNamed(context, '/home');
                                  }, child: Text("Return home"))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
