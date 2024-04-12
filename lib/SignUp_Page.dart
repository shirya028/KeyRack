
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyrack/Firebase_Model.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController dobController =TextEditingController();
  TextEditingController passController =TextEditingController();
  TextEditingController cpassController =TextEditingController();
  TextEditingController pinController =TextEditingController();

  bool isEmailValid = false,isPhoneValid = false,isDobValid=false,isPassValid=false,isPinValid=false,isCPassValid=false;
  FirebaseModel f1= FirebaseModel();

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateInput);
    phoneController.addListener(_validateInput);
    dobController.addListener(dobSyntax);
    passController.addListener(_validateInput);
    cpassController.addListener(_validateInput);

    pinController.addListener(_validateInput);

  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      isEmailValid = emailController.text.contains('@gmail.com');
      isPhoneValid = phoneController.text.length==10;
      isPassValid = passController.text.length >8;
      isCPassValid = passController.text.length == cpassController.text.length;
      isPinValid = pinController.text.length==4;
    });
  }
  void dobSyntax() {
    setState(() {
      if(dobController.text.length==2)
        dobController.text=dobController.text+"/";
      else if(dobController.text.length==5)
        dobController.text=dobController.text+"/";

      isDobValid=dobController.text.length==10;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30,left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Register your \nAccount",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold ,color: Colors.greenAccent)),
                    ],
                  ),
                ),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,color: Colors.greenAccent),
                          hintText: "Name",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey)
                          ),

                        ))
                ),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: emailController,

                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email,color: Colors.greenAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.greenAccent)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: isEmailValid ? Colors.green : Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.greenAccent ),
                        ),

                        errorText: isEmailValid ? null : 'Please enter a valid Gmail address',
                      ),)
                ),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(

                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone,color: Colors.greenAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: isPhoneValid ? Colors.green : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.greenAccent ),
                          ),

                          errorText: isPhoneValid ? null : 'Please enter a valid Phone',
                        ),)
                ),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: dobController,
                        decoration: InputDecoration(
                          labelText: 'DOB(DD/MM/YYYY)',
                          prefixIcon: Icon(Icons.calendar_month,color: Colors.greenAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: isDobValid ? Colors.green : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.greenAccent ),
                          ),

                          errorText: isDobValid ? null : 'Please Valid DATE OF BIRTH',
                        ),)
                ),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password,color: Colors.greenAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: isPassValid ? Colors.green : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.greenAccent ),
                          ),

                          errorText: isPassValid ? null : 'Password length should be > 8',
                        ),)
                ),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: cpassController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.password,color: Colors.greenAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: isCPassValid ? Colors.green : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.greenAccent ),
                          ),

                          errorText: isCPassValid ? null : 'Password should match',
                        ))
                ),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                        controller: pinController,
                        decoration: InputDecoration(
                          labelText: 'Security Key',
                          prefixIcon: Icon(Icons.key,color: Colors.greenAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: isPinValid ? Colors.green : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.greenAccent ),
                          ),

                          errorText: isPinValid ? null : 'Security key should be of length 4',
                        ))
                ),

                Container(
                  width: 300,
                  height: 50,
                  margin: EdgeInsets.only(top: 20,bottom: 20),
                  child: ElevatedButton( onPressed:() {
                    signUp();
                  } , child: Text("Sign UP"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.black
                    ),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if (isEmailValid &&
        isPhoneValid &&
        isDobValid &&
        isPassValid &&
        isPinValid &&
        isCPassValid) {
      try {
        await f1.insertLoginCredentials(
            nameController.text,
            emailController.text,
            phoneController.text,
            dobController.text,
            passController.text,
            pinController.text);
        Navigator.of(context).pop();
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Error during signup: $e",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);

      }
    }
  }


}



