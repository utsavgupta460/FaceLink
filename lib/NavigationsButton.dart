import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {
  @override
  _NavigationButtonState createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  int selectedIndex = 0;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightBlueAccent[100],
//        type: BottomNavigationBarType.fixed,

      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          title: Text("Find"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: Text("New"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          title: Text("Notification"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile"),
        ),
      ],
      selectedItemColor: Colors.lightBlueAccent[700],
      unselectedItemColor: Colors.lightBlueAccent[100],
      currentIndex: selectedIndex,
      onTap: changeIndex,
    );
  }
}
