import 'package:facial_social_media1/MyHomePage.dart';
import 'package:facial_social_media1/Profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primaryColor: Color(0xff80d8ff),
      //   primarySwatch: Colors.blue,
      // ),
        home: MyHomePage(),
    //   initialRoute:'Profile',
    //     routes:{
    //       'myHomePage':(context)=>MyHomePage(),
    //       'Profile':(context)=>Profile(),
    // },
    );
  }
}
