import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyrack/firebase_options.dart';

class FirebaseModel {

  FirebaseModel() {
    init();
  }

  // Initial firebase setup ,he compalsary ast
  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  //Login kelyvrch he code,(to verify)
  Future<int> userLogin(String em, String pa) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: em,
          password: pa
      );

      return 1;
    } on FirebaseAuthException catch (e) {
      return 0;
    }
  }

  //security key ithun get hota
  Future<String> getKey(String uid) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$uid/credentials').get();
    if (snapshot.exists) {
      Map<dynamic, dynamic>? hm = snapshot.value as Map<dynamic, dynamic>?;
      if (hm != null) {
        return hm['key  '] as String;
      }
    }
    else { //mhnjay ki db mdhe data present nayyy
      Fluttertoast.showToast(msg: "No snap");
    }

    return "";
  }

  //he signup code
  Future<void> insertLoginCredentials(String name, String email, String phone,
      String dob, String pass, String key) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    Map<String, String> data = {
      'name': name,
      'email': email,
      'phone': phone,
      'dob': dob,
      'key  ': key,
    };

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = credential.user;
      ref = FirebaseDatabase.instance.ref("users/" + user!.uid);
      await ref.child("credentials").set(data);
      data.clear();
      data['sample'] = 'sample';
      await ref.child("data").set(data);
      Fluttertoast.showToast(msg: "User registeration Complete.Please Login",
          toastLength: Toast.LENGTH_LONG);
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //main dashboard vrch data fetch krt
  Future<Map<String, String>> getDataMap() async {
    User? user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseDatabase.instance.ref();

    if (user != null) {
      final snapshot = await ref.child('users/${user.uid}/data').get();

      if (snapshot.exists && snapshot.value != null) {
        Map<dynamic, dynamic> dataMap = snapshot.value as Map<dynamic, dynamic>;
        Map<String, String> stringMap = dataMap.cast<String, String>();
        stringMap.remove("sample");
        return stringMap;
      } else {
        Fluttertoast.showToast(msg: "No data found");
      }
    }

    return {};
  }

  //jewh new entry hote
  void addDataMap(Map<String, String> mp) async {
    User? user = FirebaseAuth.instance.currentUser;
    final ref = FirebaseDatabase.instance.ref("users/" + user!.uid);
    await ref.child("data").set(mp);
  }

  //reset password link pathvto

  void resetPass(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      Fluttertoast.showToast(msg: "Email sent");
    }
    on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }



}