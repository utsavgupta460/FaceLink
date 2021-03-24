import 'package:facelink/search.dart';
import 'package:facelink/signIn.dart';
import 'package:facelink/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'NavigationsButton.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{

        'search': (BuildContext context) =>  Search(),
        'signIn': (BuildContext context) =>  SignIn(),
        'home':(BuildContext context) => Home()
      },
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.deepPurple, accentColor: Colors.teal),
      home: Home(),
    );
  }
}
