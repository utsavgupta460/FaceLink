import 'package:flutter/material.dart';
import 'package:facelink/home.dart';
import 'package:facelink/post.dart';
import 'package:facelink/progress.dart';

class PostScreen extends StatelessWidget {
  String userId;
  String postId;

  PostScreen({this.userId, this.postId});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: postsRef
          .doc(userId)
          .collection('userPosts')
          .doc(postId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Post post = Post.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.blue,
              title: Text(
                "Post",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
