import 'package:flutter/material.dart';
import 'post_container.dart';
import 'NavigationsButton.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 0;
  Expanded profile_button(String button_name) {
    return Expanded(
      child: FlatButton(
        onPressed: () {},
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                button_name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.white,
              size: 5,
            ),
            Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  bool state = false;
  void changeState() {
    setState(() {
      if (state) {
        state = false;
      } else {
        state = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      bottomNavigationBar: NavigationButton(),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: ListView(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              IconButton(
                icon: PostInteraction(
                  Icons.format_list_bulleted,
                  Colors.white,
                ),
                onPressed: () {},
              ),
            ]),
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: RawMaterialButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.account_circle,
                        size: 80,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(3.0),
                      shape: CircleBorder(),
                    ),
                    // child: SvgPicture.asset(
                    //   'icons/avtar.svg',
                    //   width: 80,
                    //   height: 80,
                    // ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'User_Name',
                style: TextStyle(
                  //fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  // margin: EdgeInsets.symmetric(
                  //     vertical: 20.0, horizontal: 10.0),

                  onPressed: () {},
                  color: Colors.lightBlueAccent[700],
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Friends',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  // margin: EdgeInsets.symmetric(
                  //     vertical: 20.0, horizontal: 10.0),
                  onPressed: () {},
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 5),
                        Text('Message'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                profile_button('Posts'),
                profile_button('Videos'),
                profile_button('Tags'),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListBody(
              children: [
                PostContainer("images/avatar.png"),
                PostContainer("images/avatar-1.png"),
                PostContainer("images/avatar.png"),
                PostContainer("images/avatar-1.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
