import 'package:em_ma/dep_fetch.dart';
import 'package:em_ma/main.dart';
import 'package:flutter/material.dart';


class admin extends StatefulWidget {
  const admin({Key? key}) : super(key: key);
  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  @override
  void initState() {
    super.initState();
    feting();

  }
  void feting ()async{
    value();
  }

  late bool k=false;

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff04356d),
        actions: [
          GestureDetector(
            onTap: (){
setState(() {
  k=!k;
});
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
      drawer: Drawer(
        backgroundColor:Color(0xff222b30),
        child: ListView(
          children: [
            Row(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 100,
                  width: 100,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("  Administrator",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/home');
                },
                child: ListTile(
                  leading: Icon(Icons.home_filled,
                    color: Colors.white,
                  ),
                  title: Text("Dashboard",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ),
              ),
            ),
            ExpansionTile(
              iconColor: Colors.white,
              children: [

                Divider(

                  color: Colors.white,
                  thickness: 1,
                  indent : 10,
                  endIndent : 20,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,'/add_dep');
                  },
                  child: ListTile(
                    title: Text("Add Department",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),),
                  ),
                ),
              ],

              title: ListTile(

                leading: Icon(Icons.grid_view_rounded,
                  color: Colors.white,
                ),
                title: Text("Department",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),),
              ),
            ),
            ExpansionTile(
              iconColor: Colors.white,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,'/staff_managment');
                  },
                  child: ListTile(

                    title: Text("Manage staff",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),),
                  ),
                ),
                Divider(

                  color: Colors.white,
                  thickness: 1,
                  indent : 10,
                  endIndent : 20,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/staff');
                  },
                  child: ListTile(
                    title: Text("Add staff",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),),
                  ),
                ),

              ],
              title: ListTile(
                leading: Icon(Icons.handshake,
                  color: Colors.white,
                ),
                title: Text("Staff",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),),
              ),
            ),
            ExpansionTile(
              iconColor: Colors.white,
              children: [

                Divider(

                  color: Colors.white,
                  thickness: 1,
                  indent : 10,
                  endIndent : 20,
                ),
                GestureDetector(
                  onTap: (){
      Navigator.pushNamed(context, '/salary_paid');},
                  child: ListTile(

                    title: Text("Add salary",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),),
                  ),
                ),

              ],
              title: ListTile(

                leading: Icon(Icons.currency_rupee,
                  color: Colors.white,
                ),
                title: Text("Salary",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),),
              ),
            ),
            ExpansionTile(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/leave_staff');
                  },
                  child: ListTile(
                    title: Text("Manage staff's leave",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),),
                  ),
                ),
                Divider(

                  color: Colors.white,
                  thickness: 1,
                  indent : 10,
                  endIndent : 20,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/leave_hi');
                  },
                  child: ListTile(
                    title: Text("Leave History",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),),
                  ),
                ),

              ],
              iconColor: Colors.white,
              title: ListTile(
                leading: Icon(Icons.exit_to_app_rounded,
                  color: Colors.white,
                ),
                title: Text("leave",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),),

              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(

          ),

          Container(
              width: w,
              height: h*0.30,
              decoration: BoxDecoration(


                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:[
                      Color(0xff04356d),Color(0xff055590)],
                  ),
                boxShadow: [
                BoxShadow(
                blurRadius: 30.0,
              ),

        ],
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [


                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text("Welcome",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),),
                          Text("Administrator",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,

                            ),),

                        ],
                      ),
                    )
                  ],
                ),
              )
          ),
          if(k==true)
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/login');
              },
              child: Container(
                child: Center(child: Text("LOGOUT",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)),

                height: 30,
                width: 100,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
              top: 200,
              left: 30,
              right: 30,
              bottom: 30,
              child: Container(
                child: GridView.count(crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/add_dep');
                      },
                      child: Container(
                        decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
    blurRadius: 10.0,
    ),

    ],
                          borderRadius: BorderRadius.circular(30),

                          color:  Color(0xff00a75a),

                        ),
                        height: 120,
                        width: 120,

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("$green",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50
                                  ),),
                                Icon(Icons.layers,
                                  color: Colors.black.withOpacity(0.5),
                                  size: 100,),
                              ],
                            ),
                            Text("Departments",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),),
                            Padding(
                              padding: EdgeInsets.only(right: 10,top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("More Info",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  Icon(Icons.arrow_circle_right,
                                    size: 20,
                                    color: Colors.white,)
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/staff');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                            ),

                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffd81b5d),
                        ),
                        height: 120,
                        width: 120,

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("$rose",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50
                                  ),),
                                Icon(Icons.people_alt_outlined,
                                  color: Colors.black.withOpacity(0.5),
                                  size: 100,),
                              ],
                            ),
                            Text("Staff",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),),
                            Padding(
                              padding: EdgeInsets.only(right: 10,top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("More Info",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  Icon(Icons.arrow_circle_right,
                                    size: 20,
                                    color: Colors.white,)
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/leave_req');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                            ),

                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffdd4a36),
                        ),
                        height: 120,
                        width: 120,

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("$orange",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50
                                  ),),
                                Icon(Icons.exit_to_app,
                                  color: Colors.black.withOpacity(0.5),
                                  size: 100,),
                              ],
                            ),
                            Text("Leave Requests",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),),
                            Padding(
                              padding: EdgeInsets.only(right: 10,top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("More Info",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  Icon(Icons.arrow_circle_right,
                                    size: 20,
                                    color: Colors.white,)
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/salary_paid');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                            ),

                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff317cb6),
                        ),
                        height: 120,
                        width: 120,

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Column(
                                  children: [
                                    Text("\n Salary",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27
                                      ),),
                                    Text("Paid",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27
                                      ),),

                                  ],
                                ),
                                Icon(Icons.currency_rupee,
                                  color: Colors.black.withOpacity(0.5),
                                  size: 80,),
                              ],
                            ),
                            Text("\$$blue",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),),
                            Padding(
                              padding: EdgeInsets.only(right: 10,top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("More Info",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  Icon(Icons.arrow_circle_right,
                                    size: 20,
                                    color: Colors.white,)
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                    ),

                  ],),

              ))
        ],
      ),
    );
  }
}
