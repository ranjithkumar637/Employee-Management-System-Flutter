import 'package:em_ma/loginpusher.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
class login extends StatefulWidget {

  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _loginFormKey=GlobalKey<FormState>();
  final _username=TextEditingController();
  final _password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;




    return WillPopScope(
        onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.black26,
          child: Column(
            children: [
              Container(
                width:w ,
                height: h*0.3,
                child: RiveAnimation.asset('animation/backgorund3.riv',
                    fit: BoxFit.cover),
              ),
              SizedBox(
                height: h*0.1,
              ),
              Container(
                height: h*0.5,
                width: w*0.8,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                          Form(
                            key: _loginFormKey,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Employee ",
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold
                                  ),),
                                Text("Management",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),)
                              ],
                            ),),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Please Login To Continue.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.6)
                            ),),
                          SizedBox(
                            height:30 ,
                          ),
                          TextFormField(

                            controller: _username,
                            decoration: InputDecoration(
                              label: Text("Username"),
                              border: OutlineInputBorder(
                                borderRadius:  BorderRadius.all(
                                  Radius.circular(0.0),
                                ),),
                              focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(
                                    width: 1, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:30 ,
                          ),
                          TextFormField(
                            controller: _password,
                            decoration: InputDecoration(
                              label: Text("Password"),
                              border: OutlineInputBorder(
                                borderRadius:  BorderRadius.all(
                                  Radius.circular(0.0),
                                ),),
                              focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                borderSide: BorderSide(
                                    width: 1, color: Colors.blueAccent),
                              ),
                            ),

                          ),
                          SizedBox(
                            height:30 ,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                child:  ElevatedButton(
                                  onPressed: () {
                                    loginer(_username.text,context);
                                  },
                                  child: Text('LOG IN'),
                                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                                ),
                              )
                            ],
                          ),





                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
