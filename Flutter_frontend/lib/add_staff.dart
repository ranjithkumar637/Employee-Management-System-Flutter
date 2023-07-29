import 'package:em_ma/dep_lister.dart';
import 'package:em_ma/main.dart';
import 'package:em_ma/post_add_staff.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
List<String> dropdownOptions = ['Option 1', 'Option 2', 'Option 3'];
List<String> gender = ["male",'female','other'];
var selectedOption;
var selectedOption1;
var dep,gen,county;
DateTime? selectedDate;
DateTime? selectedDate1;
String saver='Country';
String du='';
String du1='';
class emp_add extends StatefulWidget {
  const emp_add({Key? key}) : super(key: key);

  @override
  State<emp_add> createState() => _emp_addState();

}

class _emp_addState extends State<emp_add> {
  @override
  void initState() {


    super.initState();

  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;

        du+=selectedDate!.year.toString() ;
        du+="-";
        du+=selectedDate!.month.toString() ;
        du+='-';
        du+=selectedDate!.day.toString();
        print(du);


      });
    }
  }
  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? pickedDate1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate1 != null && pickedDate1 != selectedDate1) {
      setState(() {
        selectedDate1 = pickedDate1;
        du1+=selectedDate1!.year.toString() ;
        du1+="-";
        du1+=selectedDate1!.month.toString() ;
        du1+='-';
        du1+=selectedDate1!.day.toString();

      });
    }
  }
  post Post=post();
  void upload(){
    rose++;
    Post.post_staff(name: _name.text, dep: vikas, gen: gen, email: _email.text, mobile: _mobile.text, photo: " ", dob:du, doj: du1 ,city: _city.text, state: _state.text, country: saver, address: _address.text, context: context);
  }

  final _addstaff=GlobalKey<FormState>();
  final _name=TextEditingController();
  final _email=TextEditingController();
  final _mobile=TextEditingController();
  final _city=TextEditingController();
  final _state=TextEditingController();
  final _address=TextEditingController();
  @override
  Widget build(BuildContext context) {


    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;




    return Scaffold(

      body: SafeArea(
        child: Container(
          height: h,
          width: w,
          child: SingleChildScrollView(
            child: Form(
              key: _addstaff,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add Staff",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          child: Text("Full Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: TextField(
                            controller: _name,

                            decoration: InputDecoration(
                              hintText: "Name",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),


                        department_list2(),



                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("Gender",
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
                              leading: DropdownButton<String>(
                                    value: selectedOption1,
                                    onChanged: (String? newValue) {
                                      setState(() {

                                        selectedOption1 = newValue!;
                                        gen=selectedOption1.toString();
                                      });
                                    },
                                    items: gender.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),


                            )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              hintText: "Email",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("Mobile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: TextFormField(
                            controller: _mobile,
                            decoration: InputDecoration(

                              hintText: "mobile",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("Date of Birth",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                            selectedDate == null
                                ? 'Select Date of Birth'
                                : ' ${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color:selectedDate == null?Colors.grey: Colors.black
                            ),),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("Date of Joining",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              border: Border.all()
                          ),
                          child: TextButton(
                            onPressed: () => _selectDate1(context),
                            child: Text(
                              selectedDate1 == null
                                  ? 'Select Date of Joining'
                                  : ' ${selectedDate1!.year}-${selectedDate1!.month.toString().padLeft(2, '0')}-${selectedDate1!.day.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  color:selectedDate1 == null?Colors.grey: Colors.black
                              ),),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("City",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: TextFormField(
                            controller: _city,
                            decoration: InputDecoration(
                              hintText: "City ",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("State",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: TextFormField(
                            controller: _state,
                            decoration: InputDecoration(
                              hintText: "State",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("Country",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(onPressed: (){

                                showCountryPicker(
                                  context: context,
                                  exclude: <String>['KN', 'MF'], //It takes a list of country code(iso2).
                                  onSelect: (Country country) =>
                                  setState(() {
                                    saver=country.name as String;
                                  })

                                );
                              }, child: Text(saver,
                              style: TextStyle(
                                color:saver=='Country'?Colors.grey: Colors.black,
                              ),)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width:90,

                          child: Text("Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),
                        ),
                        Container(
                          height: 70,
                          width: 250,
                          child: TextFormField(
                            controller: _address,
                            decoration: InputDecoration(
                              hintText: "Address",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black), //<-- SEE H//<-- SEE HERE
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    Center(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green
                      )

                      ,onPressed: (){
                        upload();
                    }, child: Text("Submit details"),
                    ),)



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
