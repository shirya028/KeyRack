import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyrack/Firebase_Model.dart';
import 'package:keyrack/KeyVerification.dart';
import 'package:keyrack/RestPassword.dart';
import 'package:keyrack/SignUp_Page.dart';
import 'package:keyrack/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
   Login(){
     init();
   }
   void init() async{
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
   }


   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Key Rack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  FirebaseModel f= FirebaseModel();
  String key="";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ListView(
          children : [
            Column(

            children: [
              Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.only(top: 40),
                  child: Image.asset("assets/images/login_profile.png")
              ),
              Container(
                margin: EdgeInsets.only(top: 180),
                child: Text("WELCOME",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              ),
              Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: email_controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email,color: Colors.greenAccent),
                        hintText: "Email id",
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
                    controller: pass_controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password,color: Colors.greenAccent),
                        hintText: "Password",
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
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton( onPressed:() async{

                  final SharedPreferences prefs = await SharedPreferences.getInstance();

                  String email=email_controller.text;
                  String pass=pass_controller.text;
                  int response=await f.userLogin(email, pass);
                  if(response==1) {
                    User? user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      key=await f.getKey(user.uid) ;
                      await prefs.setString('userKey', key );

                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  KeyVerification(key)));
                    }

                  }
                  else
                    Fluttertoast.showToast(msg: "Invalid Credentials");

                } , child: Text("Log In"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.black
                  ),),
              ),
              Container(

                margin: EdgeInsets.only(top: 20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap:() {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignUp1()));
                        },
                        child: Text("Sign up")
                    ),
                    InkWell(

                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const ResetPassword()));
                        },
                        child: Text("Forget Password?"))
                  ],
                ),
              ),

            ],
          )
              ]
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
