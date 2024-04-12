
import 'package:flutter/material.dart';
import 'package:keyrack/Firebase_Model.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return PasswordReset();
  }
}

class PasswordReset extends StatefulWidget {

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {

  FirebaseModel f1= FirebaseModel();

  TextEditingController email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children : [
            Container(
            child: Center(
              child: Column(
                children: [

                  Container(
                    margin: EdgeInsets.only(top: 50),
                      child: const Text("Forgotten Password?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
                  Container(
                    width: 200,
                      height: 200,
                      child: Image.asset("assets/images/resetPass.png")),
                  Container(
                    width: 300,
                    child: Text("Dont worry we will send you password reset link on your registered email."),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 30),
                    child: TextField(
                      controller: email,

                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email,color: Colors.greenAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.greenAccent)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.greenAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.greenAccent ),
                        ),

                      ),
                  )
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    margin: EdgeInsets.only(top: 30,bottom: 20),
                    child: ElevatedButton( onPressed:() {
                          f1.resetPass(email.text);
                    } , child: Text("Reset"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black,
                          shadowColor: Colors.black
                      ),),
                  ),
                ],
              ),
            ),
          )
          ]
        ),
      ),
    );
  }

}

