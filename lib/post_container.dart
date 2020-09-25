import 'package:flutter/material.dart';
import 'post-photo.dart';
class PostContainer extends StatefulWidget {
  final String picAddress;
  PostContainer(this.picAddress);
  @override
  _PostContainerState createState() => _PostContainerState();
}
class _PostContainerState extends State<PostContainer> {
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
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Card(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.lightBlueAccent[600],
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.account_circle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text("Name of the User"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
               PostContainerBody(widget.picAddress),
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: IconButton(
                        icon: PostInteraction(
                            state ? Icons.favorite : Icons.favorite_border,
                            state ? Color(0xffec0101) : Colors.lightBlueAccent[700]),
                        onPressed: () {
                          changeState();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        icon: PostInteraction(
                            Icons.chat_bubble_outline, Colors.lightBlueAccent[700]),
                        onPressed: () {
                          print('comments');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: PostInteraction(Icons.near_me, Colors.lightBlueAccent[700]),
                        onPressed: () {
                          print('comments');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PostInteraction extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  PostInteraction(this.icon, this.iconColor);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: iconColor,
    );
  }
}
class PostBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: PostInteraction(Icons.chat_bubble, Colors.lightBlueAccent[700]),
        onPressed: () {
          print('comments');
        },
      ),
    );
  }
}
