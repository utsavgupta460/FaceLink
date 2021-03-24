// import 'package:facelink/Location.dart';
// import 'Location.dart';
// import 'Notification.dart';
// import 'AddPost.dart';
// import 'package:flutter/material.dart';
// import 'MyHomePage.dart';
// import 'Profile.dart';
//
// class NavigationButton extends StatefulWidget {
//   @override
//   _NavigationButtonState createState() => _NavigationButtonState();
// }
//
// class _NavigationButtonState extends State<NavigationButton> {
//   int selectedIndex = 0;
//   void  _onPageChanged(int index){
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//   void changeIndex(int index) {
//     _pagecontroller.jumpToPage(index);
//
//   }
//   PageController _pagecontroller=PageController();
//   List<Widget> _screens=[
//     MyHomePage(),User_Location(),AddPost(),Notifications(),Profile()
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pagecontroller,
//         children: _screens,
//         onPageChanged: _onPageChanged,
//
//       ),
//       bottomNavigationBar: BottomNavigationBar(
// //        type: BottomNavigationBarType.fixed,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//             ),
//             title: Text("Home"),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_on),
//             title: Text("Find"),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             title: Text("New"),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_none),
//             title: Text("Notification"),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             title: Text("Profile"),
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.black,
//         currentIndex: selectedIndex,
//         onTap: changeIndex,
//       ),
//     );
//   }
// }
