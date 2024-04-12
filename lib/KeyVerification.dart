import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyrack/Dashboard.dart';

class KeyVerification extends StatefulWidget {
  String truePin="";
   KeyVerification(String? pin) {
     if(pin != null)
       truePin=pin;
   }

  @override
  State<KeyVerification> createState() => _KeyVerificationState(truePin);
}

class _KeyVerificationState extends State<KeyVerification> {
  String truePin="";
  int count=0;
  List<String> list=[];
  bool one=false,two=false,three=false,four=false;
  _KeyVerificationState(String pin) {
    truePin=pin;
  }
  TextEditingController pinController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: ListView(
          children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 250,
                  child: Image.asset("assets/images/login.png"),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text("Enter Security Code",style: TextStyle(fontSize: 28,color: Colors.greenAccent),)
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(one ? Icons. circle: Icons.circle_outlined),
                      Icon(two ? Icons.circle : Icons.circle_outlined),
                      Icon(three ? Icons.circle : Icons.circle_outlined),
                      Icon(four ? Icons.circle : Icons.circle_outlined),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(onPressed: (){buttonClicked("1");}, child:Text("1")),
                          TextButton(onPressed: (){buttonClicked("2");}, child:Text("2")),
                          TextButton(onPressed: (){buttonClicked("3");}, child:Text("3")),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(onPressed: (){buttonClicked("4");}, child:Text("4")),
                          TextButton(onPressed: (){buttonClicked("5");}, child:Text("5")),
                          TextButton(onPressed: (){buttonClicked("6");}, child:Text("6")),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(onPressed: (){buttonClicked("7");}, child:Text("7")),
                          TextButton(onPressed: (){buttonClicked("8");}, child:Text("8")),
                          TextButton(onPressed: (){buttonClicked("9");}, child:Text("9")),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(onPressed: (){}, child:Text(""),isSemanticButton: false,),
                          TextButton(onPressed: (){buttonClicked("0");}, child:Text("0")),
                          IconButton(onPressed: (){buttonClicked("C");}, icon: Icon(Icons.backspace_rounded)),
                        ],
                      ),

                    ],
                  ),
                )
                // Container(
                //   width: 300,
                //   height: 50,
                //   margin: EdgeInsets.only(top: 20),
                //   child: ElevatedButton( onPressed:() //async{
                //   {
                //     String inputPin=pinController.text;
                //     if(inputPin==truePin) {
                //     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Dashboard()),
                //     );
                //     }
                //     else
                //       Fluttertoast.showToast(msg: "Invalid Pin");
                //
                //
                //   } , child: Text("Verify !"),
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.greenAccent,
                //         foregroundColor: Colors.black,
                //         shadowColor: Colors.black
                //     ),),
                // ),
              ],
            ),
          ),
      ]
        ),
      ),
    );
  }
  void buttonClicked(String s) {
    setState(() {
      if (s == "C") {
        if (list.isNotEmpty) {
          list.removeLast();
        }
      } else {
        list.add(s);
      }

      switch (list.length) {
        case 0:
          one = two = three = four = false;
          break;
        case 1:
          one = true;
          two = three = four = false;
          break;
        case 2:
          one = two = true;
          three = four = false;
          break;
        case 3:
          one = two = three = true;
          four = false;
          break;
        case 4:
          one = two = three = four = true;
          String currentPin = list.join('');
          if (currentPin != truePin) {
            Fluttertoast.showToast(
              msg: "Invalid Pin",
              toastLength: Toast.LENGTH_LONG,
            );
            list.clear();
            one = two = three = four = false;
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          }
          break;
      }
    });
  }

}

