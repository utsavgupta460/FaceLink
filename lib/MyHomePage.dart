import 'package:flutter/material.dart';
import 'post_container.dart';
import 'NavigationsButton.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationButton(),
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.lightBlueAccent[700],
        leading: Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "obligatory appbar title",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  print('working');
                },
              ),
            ],
          )
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(15.0),
          children: [
            PostContainer("images/avatar.png"),
            PostContainer("images/avatar-1.png"),
            PostContainer("images/avatar.png"),
            PostContainer("images/avatar-1.png"),
          ],
        ),
      ),
    );
  }
}
