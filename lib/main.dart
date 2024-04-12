import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keyrack/RestPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'KeyVerification.dart';
import 'Login.dart';
import 'firebase_options.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {

  SplashScreen() {
    init();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashView(),
    );
  }

  void init() async{
    WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
     );
  }
}


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance!.addPostFrameCallback((_) async{

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? key = prefs.getString('userKey');
      await Future.delayed(Duration(seconds: 2));
      if(key!= null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  KeyVerification(key)));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Login()));
      }


    });

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              width: 200,
              height: 300,
              child: Image.asset("assets/images/splash_icon.jpg"),
            ),
            Container(
              child: Text("Key Rack",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.greenAccent)),
            ),
            Container(
              child: Text("get all your keys at one place"),
            ),

          ],
        ),

      ),
    );
  }
}

