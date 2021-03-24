import 'package:facelink/progress.dart';
import 'package:flutter/material.dart';
class User_Location extends StatefulWidget {
  @override
  _User_LocationState createState() => _User_LocationState();
}

class _User_LocationState extends State<User_Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: circularProgress(),
    );
  }
}
