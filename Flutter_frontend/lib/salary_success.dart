import 'package:flutter/material.dart';

class staff_success1 extends StatelessWidget {
  const staff_success1({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            child:Container(
              height: h*0.5,
              width: w-50,
              color: Colors.green,
              child: Center(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
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
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple
                            )
                            ,onPressed: (){
                          Navigator.pushNamed(context, '/salary_paid');


                        }, child: Text("Add another salary")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red
                            )
                            ,onPressed: (){
                          Navigator.pushNamed(context, '/home');

                        }, child: Text("Dashboard")
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
